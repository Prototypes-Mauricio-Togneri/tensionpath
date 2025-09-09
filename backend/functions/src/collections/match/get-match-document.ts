import {COLLECTIONS, Database} from '../../database/database'
import {FirebaseDocument} from '../../database/firebase-document'
import {Match} from '../../models/match'

export const getMatchDocument = async (params: {
  database: Database,
  matchId: string,
}) => {
  const docRef = params.database
      .collection(COLLECTIONS.MATCHES)
      .doc(params.matchId)

  const doc = await params.database.getDocument(docRef)

  return Match.parse(FirebaseDocument.fromRef(doc))
}
