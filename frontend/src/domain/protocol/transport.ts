import type {Command} from '@/domain/protocol/command'
import type {ServerMessage} from '@/domain/protocol/message'

/**
 * The client's entire view of the authority.
 * Input and Renderer hold one of these and never the engine itself, so the
 * same client code runs against a local engine today and a socket later.
 *
 * send is deliberately fire-and-forget and returns nothing: an authority
 * broadcasts state, it does not answer calls. The outcome of a command shows
 * up in a later snapshot, or as a rejected event.
 */
export interface Transport {
  send(command: Command): void

  /**
   * Registers the sole handler for messages from the authority.
   * Messages produced before a handler is attached are buffered and delivered
   * on registration, so the welcome and start handshake is never missed.
   * @param handler - Receives every message, in order
   */
  onMessage(handler: (message: ServerMessage) => void): void
}
