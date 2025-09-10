import axios from 'axios'
import {Database} from '../../../database/database'
import {Room} from '../../../models/room'
import {registerCallable} from '../../index'
import {RoomVisibility} from '../../../types/room-visibility'
import {getAvailableRoomDocument} from '../../../database/room/get-available-room-document'
import {updateRoomDocument} from '../../../database/room/update-room-document'
import {createRoomDocument} from '../../../database/room/create-room-document'

interface StartMatchmakingCallableParams {
  userId: string,
  name: string,
  version: number,
  matchType: string,
  numberOfPlayers: number,
  visibility: RoomVisibility,
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
        matchType: params.matchType,
        numberOfPlayers: params.numberOfPlayers,
        visibility: params.visibility,
      })
    }
  })
})

const joinExistingRoom = async (params: {
  database: Database,
  room: Room,
  userId: string,
  name: string,
}): Promise<Room> => {
  if (params.room.hasUser(params.userId)) {
    return params.room
  } else {
    const newRoom = params.room.join({
      userId: params.userId,
      name: params.name,
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
  matchType: string,
  numberOfPlayers: number,
  visibility: RoomVisibility,
}): Promise<Room> => {
  const newRoom = Room.create({
    userId: params.userId,
    name: params.name,
    version: params.version,
    matchType: params.matchType,
    numberOfPlayers: params.numberOfPlayers,
    visibility: params.visibility,
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
  const createBattleParams = {
    'battleId': '12345',
    'createdAt': '2025-09-10T19:12:47Z',
    'numberOfPlayers': 2,
    'matchType': 'pvp',
    'players': {
      'id1': 'Bob',
      'id2': 'Max',
    },
  }

  const headers = {
    'x-api-key': 'Bearer YOUR_TOKEN',
    'Content-Type': 'application/json',
  }

  const response = await axios.post(url, data, {headers, })


  const newRoom = params.room
  newRoom.matchId = new Date().getTime().toString()

  await updateRoomDocument({
    database: params.database,
    room: newRoom,
  })

  return newRoom
}
