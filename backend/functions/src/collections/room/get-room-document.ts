import {COLLECTIONS, Database} from '../../database/database'
import {FirebaseDocument} from '../../database/firebase-document'
import {Room} from '../../models/room'

export const getRoomDocument = async (params: {
  database: Database,
  roomId: string,
}) => {
  const docRef = params.database
      .collection(COLLECTIONS.ROOMS)
      .doc(params.roomId)

  const doc = await params.database.getDocument(docRef)

  return Room.parse(FirebaseDocument.fromRef(doc))
}
