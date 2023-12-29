import {argv} from 'process'
import {Environment} from './server/environment'
import {RoomsManager} from './rooms/rooms-manager'
import {Handler} from './server/handler'
import {Looper} from './server/looper'
import {Server} from './server/server'

export const environment = new Environment(
  argv[2],
  argv[3],
  argv[4],
  argv[5],
)

const roomsManager = new RoomsManager()
const handler = new Handler(roomsManager)
const looper = new Looper(roomsManager)

const server = new Server(roomsManager, handler)
server.start()

looper.start()