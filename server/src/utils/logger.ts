import {Socket} from '../server/socket'

export class Logger {
  public static log(data: string, socket: Socket | undefined = undefined) {
    if (socket) {
      console.log(`[${socket.id} ${new Date().toISOString()}] ${data}`)  
    } else {
      console.log(`[${new Date().toISOString()}] ${data}`)
    }
  }

  public static error(data: string, socket: Socket | undefined = undefined) {
    if (socket) {
      console.error(`[${socket.id} ${new Date().toISOString()}] Error: ${data}`)
    } else {
      console.error(`[${new Date().toISOString()}] Error: ${data}`)
    }
  }
}