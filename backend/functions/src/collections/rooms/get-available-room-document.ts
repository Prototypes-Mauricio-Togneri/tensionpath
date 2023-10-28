import {COLLECTIONS, Database} from '../../database/database'
import {FirebaseDocument} from '../../database/firebase-document'
import Room from '../../models/room'

export const getAvailableRoomDocument = async (params: {
  database: Database,
  numberOfPlayers: number,
}) => {
  const query = params.database
      .collection(COLLECTIONS.ROOMS)
      .where('status', '==', 'open')
      .where('numberOfPlayers', '==', params.numberOfPlayers)

  const snapshot = await params.database.query(query)

  if (snapshot.size > 0) {
    return Room.parse(FirebaseDocument.fromRef(snapshot.docs[0]))
  } else {
    return undefined
  }
}
