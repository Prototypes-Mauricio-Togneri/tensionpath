import {RoomsManager} from "../rooms/rooms-manager";

export class Looper {
  constructor(
    readonly roomsManager: RoomsManager,
  ) {}
  
  public start() {
    /*while (true) {
      final double current = currentTime;
      final double dt = current - previous;
      previous = current;

      roomsManager.update(dt);

      await Future.delayed(const Duration(milliseconds: 16));
    }*/
  }
}