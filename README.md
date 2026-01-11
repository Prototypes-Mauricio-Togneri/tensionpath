# Tension Path

## Setup

### Prerequisites

- [Node.js](https://nodejs.org/en/download) (v20+)
- [Firebase CLI](https://firebase.google.com/docs/cli) (v15+)
- [Flutter SDK](https://docs.flutter.dev/install) (v3.38+)

### Tiers

### Session server

Firebase app that manages authentication, lobbies, and matchmaking logic..

Install the dependencies:

```sh
cd functions
npm install
```

In the folder `functions`, create a file called `.env.local` with the following content:

```properties
MATCH_SERVER_HTTP=http://localhost:3000
MATCH_SERVER_WS=ws://localhost:3000
API_KEY=test-api-key
```

If you are using VS Code, there is a `launch.json` config file you can use. If not, manually run the command in a terminal.

### Match server

Dart app that runs the logic of each match and sends the state updates to the frontend (via websockets).

Install the dependencies:

```sh
dart pub get
```

If you are using VS Code, there is a `launch.json` config file you can use. There are 2 configurations:

* `Run (1P)`: Automatically creates a match and joins it with a dummy player.
* `Run (2P)`: Doesn't create a match upon start.

### Frontend

Flutter app that renders the game running on the server.

Install the dependencies:

```sh
flutter pub get
```

If you are using VS Code, there is a `launch.json` config file you can use. There are 3 configurations:

* `Run (1P)`: Automatically joins the test match created by the server upon start.
* `Run (2P)`: Doesn't join the test match upon start. You have to open another browser/tab to support the two players.
* `Run (REMOTE)`: Uses the remote server instead of the local one.

## Website

The live version is available at: https://tension-path.web.app