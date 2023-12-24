import {createServer} from 'https';
import {readFileSync} from 'fs';
import {WebSocket, WebSocketServer} from 'ws'

const server = createServer({
  cert: readFileSync('cert/fullchain.pem'),
  key: readFileSync('cert/privkey.pem'),
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

server.listen(7777, () => {
  console.log('Server running on port 7777');
});
