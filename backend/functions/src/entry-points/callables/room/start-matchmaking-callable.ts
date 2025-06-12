import {createRoomDocument} from '../../../collections/room/create-room-document'
import {getAvailableRoomDocument} from '../../../collections/room/get-available-room-document'
import {updateRoomDocument} from '../../../collections/room/update-room-document'
import {Database} from '../../../database/database'
import {Room} from '../../../models/room'
import {registerCallable} from '../../index'
import {RoomVisibility} from '../../../types/room-visibility'
import {Match} from '../../../models/match'
import {createMatchDocument} from '../../../collections/match/create-match-document'

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
  const newRoom = params.room
  let match = Match.create({
    mapId: 'w5h7',
    room: newRoom,
  })
  match = await createMatchDocument({
    database: params.database,
    match: match,
  })
  newRoom.matchId = match.id

  await updateRoomDocument({
    database: params.database,
    room: newRoom,
  })

  return newRoom
}
