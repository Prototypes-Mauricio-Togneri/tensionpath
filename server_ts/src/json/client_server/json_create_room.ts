export type JsonCreateRoom = {
  roomId: string,
  createdAt: string,
  numberOfPlayers: number,
  matchType: string,
  players: Record<string, string>,
}