import {COLLECTIONS, Database, WriteOptionMerge} from '../../database/database'
import {Match} from '../../models/match'

export const addMatchHistoryDocument = async (params: {
  database: Database,
  match: Match,
}) => {
  const reference = params.database
      .collection(COLLECTIONS.MATCHES)
      .doc(params.match.id)
      .collection(COLLECTIONS.HISTORY)
      .doc()

  await params.database.setDocument(reference, params.match, WriteOptionMerge)

  return params.match
}
