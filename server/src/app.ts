import {createServer} from 'https';
import {readFileSync} from 'fs';
import {WebSocket, WebSocketServer} from 'ws'
import {argv} from 'process';

// const API_KEY = argv[2]
const PORT = argv[3]
const FULLCHAIN = argv[4]
const PRIVKEY = argv[5]

const server = createServer({
  cert: readFileSync(FULLCHAIN),
  key: readFileSync(PRIVKEY),
});

const wss = new WebSocketServer({
  server: server,
})

const onMessage = (ws: WebSocket, message: string) => {
  console.log(`<<< ${message}`)
  ws.send(message)
}

wss.on('connection', (ws: WebSocket) => {
  console.log('New connection')

  ws.on('error', console.error)

  ws.on('message', (data: object) => {
    onMessage(ws, data.toString())
  })

  ws.send('welcome')
})

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
