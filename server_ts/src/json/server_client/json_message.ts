import {JsonError} from './json_error'
import {JsonStarted} from './json_started'
import {JsonWelcome} from './json_welcome'

export class JsonMessage {
  constructor(
    readonly error?: JsonError,
    readonly welcome?: JsonWelcome,
    readonly started?: JsonStarted,
  ) {}

  static error(message: string) {
    return new JsonMessage(
      new JsonError(message),
      undefined,
      undefined,
    )
  }

  static welcome() {
    return new JsonMessage(
      undefined,
      new JsonWelcome(),
      undefined,
    )
  }

  static started() {
    return new JsonMessage(
      undefined,
      undefined,
      new JsonStarted(),
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