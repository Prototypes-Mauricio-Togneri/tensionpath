import type {Transport} from '@/domain/protocol/transport'

/**
 * A live match from the client's point of view.
 * Whatever produced it — a local engine today, a socket to a server later —
 * the client only ever sees a Transport and a way to tear the match down.
 */
export type Session = {
  transport: Transport
  dispose: () => void
}
