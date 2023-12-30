import {JsonError} from './json_error'
import {JsonWelcome} from './json_welcome'

export class JsonMessage {
  constructor(
    readonly error?: JsonError,
    readonly welcome?: JsonWelcome,
  ) {}

  static error(message: string) {
    return new JsonMessage(
      new JsonError(message),
    )
  }

  static welcome() {
    return new JsonMessage(
      undefined,
      new JsonWelcome(),
    )
  }

  static unitCreated() {
    return new JsonMessage(
      undefined,
      new JsonWelcome(),
    )
  }

  static unitDestroyed() {
    return new JsonMessage(
      undefined,
      new JsonWelcome(),
    )
  }

  public toString() {
    return JSON.stringify(this)
  }
}