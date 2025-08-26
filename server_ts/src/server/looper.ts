import {RoomsManager} from '../rooms/rooms-manager'

export class Looper {
  initialTime = new Date()
  previous = 0
  running = true

  constructor(
    readonly roomsManager: RoomsManager,
  ) {
    this.previous = this.currentTime
  }
  
  private get currentTime(): number {
    return new Date().getTime() / 1000
  }
  
  public async start() {
    while (this.running) {
      const current = this.currentTime
      const dt = current - this.previous
      this.previous = current

      this.roomsManager.update(dt)

      await this.delay(16)
    }
  }

  private delay(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms))
  }
}