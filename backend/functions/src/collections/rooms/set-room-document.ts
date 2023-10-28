import {COLLECTIONS} from '../../commons'
import {Database, WriteOptionMerge} from '../../database/database'
import Room from '../../models/room'

export const setBankAccountDocument = async (params: {
  database: Database,
  room: Room,
}) => {
  const docRef = params.database
      .collection(COLLECTIONS.ROOMS)
      .doc(params.room.id)

  await params.database.setDocument(docRef, params.room, WriteOptionMerge)

  return docRef
}
