import {createRoomDocument} from '../../../collections/rooms/create-room-document'
import {getAvailableRoomDocument} from '../../../collections/rooms/get-available-room-document'
import {updateRoomDocument} from '../../../collections/rooms/update-room-document'
import {Database} from '../../../database/database'
import {Room} from '../../../models/room'
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
      const newRoom = room.join(params.playerId)

      await updateRoomDocument({
        database: database,
        room: newRoom,
      })

      return newRoom
    } else {
      const newRoom = Room.create({
        playerId: params.playerId,
        numberOfPlayers: params.numberOfPlayers,
      })

      const result = await createRoomDocument({
        database: database,
        room: newRoom,
      })

      return result
    }
  })
})
