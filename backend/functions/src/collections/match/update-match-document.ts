import {COLLECTIONS, Database, WriteOptionMerge} from '../../database/database'
import {Match} from '../../models/match'

export const updateMatchDocument = async (params: {
  database: Database,
  match: Match,
}) => {
  const docRef = params.database
      .collection(COLLECTIONS.MATCHES)
      .doc(params.match.id)

  await params.database.setDocument(docRef, params.match, WriteOptionMerge)

  return params.match
}
