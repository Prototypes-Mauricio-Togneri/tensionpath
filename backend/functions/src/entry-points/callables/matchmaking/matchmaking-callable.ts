import {createRoomDocument} from '../../../collections/rooms/create-room-document'
import {getAvailableRoomDocument} from '../../../collections/rooms/get-available-room-document'
import {updateRoomDocument} from '../../../collections/rooms/update-room-document'
import {Database} from '../../../database/database'
import Room from '../../../models/room'
import {RoomStatus} from '../../../types/room-status'
import {registerCallable} from '../../index'

interface matchmakingCallableParams {
  playerId: string
  numberOfPlayers: number
}

export const matchmakingCallable = registerCallable(async (params: matchmakingCallableParams) => {
  return Database.runTransaction(async (database) => {
    const room = await getAvailableRoomDocument({
      database: database,
      playerId: params.playerId,
      numberOfPlayers: params.numberOfPlayers,
    })

    if (room) {
      const roomFull = room.numberOfPlayers === (room.playerIds.length + 1)
      const newRoom = room.with({
        status: roomFull ? RoomStatus.closed : RoomStatus.open,
        playerIds: [...room.playerIds, params.playerId],
      })

      await updateRoomDocument({
        database: database,
        room: newRoom,
      })

      return newRoom
    } else {
      const newRoom = new Room({
        id: '',
        createdAt: new Date(),
        numberOfPlayers: params.numberOfPlayers,
        status: RoomStatus.open,
        playerIds: [params.playerId],
      })

      const result = await createRoomDocument({
        database: database,
        room: newRoom,
      })

      return result
    }
  })
})
