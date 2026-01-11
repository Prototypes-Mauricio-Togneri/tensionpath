# Tension Path

## Setup

### Prerequisites

- [Node.js](https://nodejs.org/en/download) (v20+)
- [Firebase CLI](https://firebase.google.com/docs/cli) (v15+)
- [Flutter SDK](https://docs.flutter.dev/install) (v3.38+)

### Modules

### Matchmaking backend

Firebase project that holds the lobbies and has the matchmaking logic.

Install the dependencies:

```sh
cd functions
npm install
```

If you are using VS Code, there is a `launch.json` you can use. If not, run manually the command inside that file.

### Match backend

Dart app that runs the logic of each match and sends the updates to the frontend.

### Frontend

Flutter app that renders the game that runs in the backend.

## Website

The game can be played at: https://tension-path.web.app