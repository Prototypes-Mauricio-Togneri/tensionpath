import {deleteRoomDocument} from '../../../collections/room/delete-room-document'
import {getRoomRoomDocument} from '../../../collections/room/get-room-document'
import {updateRoomDocument} from '../../../collections/room/update-room-document'
import {Database} from '../../../database/database'
import {RoomStatus} from '../../../types/room-status'
import {CustomInternalError} from '../../../utils/custom-internal-error'
import {registerCallable} from '../../index'

interface StopMatchmakingCallableParams {
  userId: string,
  roomId: string,
}

export const stopMatchmakingCallable = registerCallable(async (params: StopMatchmakingCallableParams) => {
  return Database.runTransaction(async (database) => {
    const room = await getRoomRoomDocument({
      database: database,
      roomId: params.roomId,
    })

    if (!room.hasUser(params.userId)) {
      throw new CustomInternalError({
        message: 'User not in room',
        data: {
          userId: params.userId,
          roomId: params.roomId,
        },
      })
    }

    if (room.status !== RoomStatus.open) {
      throw new CustomInternalError({
        message: 'Room is not open',
        data: {
          userId: params.userId,
          roomId: params.roomId,
        },
      })
    }

    if (room.userIds.length === 1) {
      await deleteRoomDocument({
        database: database,
        roomId: params.roomId,
      })
    } else {
      await updateRoomDocument({
        database: database,
        room: room.leave(params.userId),
      })
    }
  })
})
