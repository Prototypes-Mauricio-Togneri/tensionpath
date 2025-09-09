import {COLLECTIONS, Database, WriteOptionMerge} from '../../database/database'
import {Room} from '../../models/room'

export const createRoomDocument = async (params: {
  database: Database,
  room: Room,
}) => {
  const reference = params.database
      .collection(COLLECTIONS.ROOMS)
      .doc()

  const room = params.room
  room.id = reference.id

  await params.database.setDocument(reference, room, WriteOptionMerge)

  return room
}
