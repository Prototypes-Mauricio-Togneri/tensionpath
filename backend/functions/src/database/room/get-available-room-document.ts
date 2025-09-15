import {COLLECTIONS, Database} from '../../database/database'
import {FirebaseDocument} from '../../database/firebase-document'
import {Query} from 'firebase-admin/firestore'
import {Room} from '../../models/room'
import {RoomVisibility} from '../../types/room-visibility'

export const getAvailableRoomDocument = async (params: {
  database: Database,
  userId: string,
  version: number,
  matchType: string,
  numberOfPlayers: number,
  visibility: RoomVisibility,
}) => {
  const queryJoinedRoom = params.database
      .collection(COLLECTIONS.ROOMS)
      .where('status', '==', 'open')
      .where('version', '==', params.version)
      .where('matchType', '==', params.matchType)
      .where('visibility', '==', params.visibility)
      .where('numberOfPlayers', '==', params.numberOfPlayers)
      .where('userIds', 'array-contains', params.userId)
      .limit(1)

  const resultJoinedRoom = await executeQuery({
    database: params.database,
    query: queryJoinedRoom,
  })

  if (resultJoinedRoom) {
    return resultJoinedRoom
  } else {
    const queryAvailableRoom = params.database
        .collection(COLLECTIONS.ROOMS)
        .where('status', '==', 'open')
        .where('version', '==', params.version)
        .where('matchType', '==', params.matchType)
        .where('visibility', '==', params.visibility)
        .where('numberOfPlayers', '==', params.numberOfPlayers)
        .limit(1)

    const resultAvailableRoom = await executeQuery({
      database: params.database,
      query: queryAvailableRoom,
    })

    return resultAvailableRoom
  }
}

const executeQuery = async (params: {database: Database, query: Query}) => {
  const snapshot = await params.database.query(params.query)

  if (snapshot.size > 0) {
    return Room.parse(FirebaseDocument.fromRef(snapshot.docs[0]))
  } else {
    return undefined
  }
}
