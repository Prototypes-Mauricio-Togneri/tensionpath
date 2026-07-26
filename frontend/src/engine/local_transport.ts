import type {Command} from '@/domain/protocol/command'
import type {ServerMessage} from '@/domain/protocol/message'
import type {Transport} from '@/domain/protocol/transport'

/**
 * Deep-copies a payload the way a socket would.
 * JSON is deliberately narrower than structuredClone: a Map or Set collapses to
 * {}, a Date becomes a string, methods and undefined fields disappear. Nothing
 * that is not wire-safe survives the copy, so such a mistake breaks here and
 * now rather than on the day a real socket is introduced.
 */
function copy<Value>(value: Value): Value {
  return JSON.parse(JSON.stringify(value)) as Value
}

/**
 * Transport between a client and an engine running in the same tab.
 * Both directions are copied, so no object reference is ever shared across the
 * boundary — the guarantee a socket gives for free, enforced here at runtime
 * instead of by convention.
 */
export class LocalTransport implements Transport {
  private readonly dispatch: (command: Command) => void
  private readonly buffered: ServerMessage[] = []
  private handler: ((message: ServerMessage) => void) | null = null

  constructor(dispatch: (command: Command) => void) {
    this.dispatch = dispatch
  }

  send(command: Command): void {
    this.dispatch(copy(command))
  }

  onMessage(handler: (message: ServerMessage) => void): void {
    this.handler = handler

    const pending = this.buffered.splice(0, this.buffered.length)

    for (const message of pending) {
      handler(message)
    }
  }

  /**
   * Engine-side entry point. Absent from the Transport interface so a client
   * holding a Transport cannot inject messages into itself.
   * Buffers until the client attaches a handler, so the welcome and start
   * handshake sent during connect is never lost.
   * @param message - The message to hand to the client
   */
  deliver(message: ServerMessage): void {
    const delivered = copy(message)

    if (this.handler === null) {
      this.buffered.push(delivered)
    } else {
      this.handler(delivered)
    }
  }
}
