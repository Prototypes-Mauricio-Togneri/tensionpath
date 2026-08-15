import {BotClient} from '@/bot/bot_client'
import {createDefaultBattlefield, createDefaultConfig} from '@/engine/constants'
import {MatchEngine} from '@/engine/match_engine'
import type {Session} from '@/session/session'

const PLAYER_ID = 'player'

const BOT_ID = 'bot'

/**
 * Builds a fully local match: an authoritative engine in this tab, a transport
 * for the human player, and a bot on a second transport.
 * This is the only module allowed to import both the engine and a client, which
 * is what confines the swap to one place — a createRemoteSession returning the
 * same Session would leave every client untouched.
 * @param randomSeed - Seed for the engine's deterministic generator
 * @returns The human player's session
 */
export function createLocalSession(randomSeed: number): Session {
  const engine = new MatchEngine({
    config: createDefaultConfig(),
    battlefield: createDefaultBattlefield(PLAYER_ID, BOT_ID),
    // Names are placeholders until there is a profile or lobby to supply them
    players: [
      {
        id: PLAYER_ID,
        name: 'Player',
      },
      {
        id: BOT_ID,
        name: 'Computer',
      },
    ],
    randomSeed: randomSeed,
  })

  const playerTransport = engine.connect(PLAYER_ID)

  // The bot needs no further reference: it drives itself from its transport
  new BotClient(engine.connect(BOT_ID))

  engine.start()

  return {
    transport: playerTransport,
    dispose: () => {
      engine.stop()
      engine.disconnect(BOT_ID)
      engine.disconnect(PLAYER_ID)
    },
  }
}
