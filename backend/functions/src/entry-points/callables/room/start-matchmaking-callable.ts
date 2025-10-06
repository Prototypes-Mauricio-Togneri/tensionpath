import axios from 'axios'
import {Database} from '../../../database/database'
import {Room} from '../../../models/room'
import {registerCallable} from '../../index'
import {RoomVisibility} from '../../../types/room-visibility'
import {getAvailableRoomDocument} from '../../../database/room/get-available-room-document'
import {updateRoomDocument} from '../../../database/room/update-room-document'
import {createRoomDocument} from '../../../database/room/create-room-document'
import {API_KEY, IS_EMULATOR, MATCH_SERVER_HTTP, MATCH_SERVER_WS} from '../../..'
import {getRandomMapId} from '../../../types/map.id'

interface StartMatchmakingCallableParams {
  userId: string,
  name: string,
  version: number,
  matchType: string,
  numberOfPlayers: number,
  visibility: RoomVisibility,
  deck: string[],
}

export const startMatchmakingCallable = registerCallable(async (params: StartMatchmakingCallableParams): Promise<Room> => {
  return Database.runTransaction(async (database) => {
    const room = await getAvailableRoomDocument({
      database: database,
      userId: params.userId,
      version: params.version,
      matchType: params.matchType,
      numberOfPlayers: params.numberOfPlayers,
      visibility: params.visibility,
    })

    if (room) {
      const joinedRoom = await joinExistingRoom({
        database: database,
        room: room,
        userId: params.userId,
        name: params.name,
        deck: params.deck,
      })

      if (joinedRoom.isFull) {
        return createMatch({
          database: database,
          room: joinedRoom,
        })
      } else {
        return joinedRoom
      }
    } else {
      return createNewRoom({
        database: database,
        userId: params.userId,
        name: params.name,
        version: params.version,
        mapId: getRandomMapId(),
        matchType: params.matchType,
        numberOfPlayers: params.numberOfPlayers,
        visibility: params.visibility,
        deck: params.deck,
      })
    }
  })
})

const joinExistingRoom = async (params: {
  database: Database,
  room: Room,
  userId: string,
  name: string,
  deck: string[],
}): Promise<Room> => {
  if (params.room.hasUser(params.userId)) {
    return params.room
  } else {
    const newRoom = params.room.join({
      userId: params.userId,
      name: params.name,
      deck: params.deck,
    })

    await updateRoomDocument({
      database: params.database,
      room: newRoom,
    })

    return newRoom
  }
}

const createNewRoom = async (params: {
  database: Database,
  userId: string,
  name: string,
  version: number,
  mapId: string,
  matchType: string,
  numberOfPlayers: number,
  visibility: RoomVisibility,
  deck: string[],
}): Promise<Room> => {
  const newRoom = Room.create({
    userId: params.userId,
    name: params.name,
    version: params.version,
    mapId: params.mapId,
    matchType: params.matchType,
    numberOfPlayers: params.numberOfPlayers,
    visibility: params.visibility,
    deck: params.deck,
  })

  const result = await createRoomDocument({
    database: params.database,
    room: newRoom,
  })

  return result
}

const createMatch = async (params: {
  database: Database,
  room: Room,
}): Promise<Room> => {
  const matchId = IS_EMULATOR ? 'test-match-id' : new Date().getTime().toString()

  const url = `${MATCH_SERVER_HTTP.value()}/matches`

  const data = {
    'matchId': matchId,
    'mapId': params.room.mapId,
    'createdAt': new Date().toISOString(),
    'numberOfPlayers': params.room.userIds.length,
    'matchType': 'pvp',
    'players': params.room.users,
  }

  if (IS_EMULATOR) {
    const sortedEntries = Object.entries(data.players).sort(([keyA], [keyB]) => keyA.localeCompare(keyB))
    data.players = Object.fromEntries(sortedEntries)
  }

  const config = {
    headers: {
      'x-api-key': API_KEY.value(),
      'Content-Type': 'application/json',
    },
  }

  const response = await axios.post(url, data, config)

  if (response.status === 201) {
    const newRoom = params.room
    newRoom.matchId = matchId
    newRoom.matchHost = MATCH_SERVER_WS.value()

    await updateRoomDocument({
      database: params.database,
      room: newRoom,
    })

    return newRoom
  } else {
    throw new Error(`Failed to create match, status code: ${response.status}`)
  }
}
