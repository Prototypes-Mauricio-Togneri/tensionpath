import {COLLECTIONS, Database, WriteOptionMerge} from '../../database/database'
import {Match} from '../../models/match'

export const createMatchDocument = async (params: {
  database: Database,
  match: Match,
}) => {
  const reference = params.database
      .collection(COLLECTIONS.MATCHES)
      .doc()

  const match = params.match
  match.id = reference.id

  await params.database.setDocument(reference, match, WriteOptionMerge)

  return match
}
