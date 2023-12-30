import {JsonError} from "./json_error"
import {JsonWelcome} from "./json_welcome"

export class JsonMessage {
  //final JsonUpdate? update
  //final JsonLaneRewardWon? laneRewardWon
  //final JsonLaneRewardLost? laneRewardLost
  //final JsonLaneWon? laneWon
  //final JsonLaneLost? laneLost
  //final JsonUnitsLaunched? unitsLaunched
  //final JsonJoinRoom? joinRoom
  //final JsonIncreaseMine? increaseMine
  //final JsonIncreaseAttack? increaseAttack
  //final JsonLaunchUnits? launchUnits

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

  public toString() {
    return JSON.stringify(this)
  }
}