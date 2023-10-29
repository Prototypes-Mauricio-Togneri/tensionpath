import {createRoomDocument} from '../../../collections/rooms/create-room-document'
import {getAvailableRoomDocument} from '../../../collections/rooms/get-available-room-document'
import {updateRoomDocument} from '../../../collections/rooms/update-room-document'
import {Database} from '../../../database/database'
import {Room} from '../../../models/room'
import {registerCallable} from '../../index'

interface StartMatchmakingCallableParams {
  playerId: string
  playerName: string
  matchType: string
  numberOfPlayers: number
}

export const startMatchmakingCallable = registerCallable(async (params: StartMatchmakingCallableParams) => {
  return Database.runTransaction(async (database) => {
    const room = await getAvailableRoomDocument({
      database: database,
      playerId: params.playerId,
      matchType: params.matchType,
      numberOfPlayers: params.numberOfPlayers,
    })

    if (room) {
      const newRoom = room.join({
        playerId: params.playerId,
        playerName: params.playerName,
      })

      await updateRoomDocument({
        database: database,
        room: newRoom,
      })

      return newRoom
    } else {
      const newRoom = Room.create({
        playerId: params.playerId,
        playerName: params.playerName,
        matchType: params.matchType,
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
