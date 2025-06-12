import {COLLECTIONS, Database, WriteOptionMerge} from '../../database/database'
import {Room} from '../../models/room'

export const createRoomDocument = async (params: {
  database: Database,
  room: Room,
}) => {
  const room = params.room
  room.id = params.database
      .collection(COLLECTIONS.ROOMS)
      .doc().id

  const docRef = params.database
      .collection(COLLECTIONS.ROOMS)
      .doc(room.id)

  await params.database.setDocument(docRef, room, WriteOptionMerge)

  return room
}
