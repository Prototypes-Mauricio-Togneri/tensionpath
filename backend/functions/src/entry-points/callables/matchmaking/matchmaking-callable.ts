import {createRoomDocument} from '../../../collections/rooms/create-room-document'
import {getAvailableRoomDocument} from '../../../collections/rooms/get-available-room-document'
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
      numberOfPlayers: params.numberOfPlayers,
    })

    if (room) {
      console.log()
    } else {
      const newRoom = new Room({
        id: '',
        createdAt: new Date(),
        numberOfPlayers: params.numberOfPlayers,
        status: RoomStatus.open,
        playerIds: [params.playerId],
      })

      await createRoomDocument({
        database: database,
        room: newRoom,
      })
    }
  })

  return {
    roomId: 'foo',
  }
})
