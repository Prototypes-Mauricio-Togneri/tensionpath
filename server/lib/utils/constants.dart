class Constants {
  static const bool LOGS_ENABLED = true;

  static const int DIRECTION_UP = 1;
  static const int DIRECTION_DOWN = -1;

  static const int LANES = 5;
  static const int WINNER_LIMIT = (LANES ~/ 2) + 1;
  static const int READY_TIMEOUT = 3; // in seconds
  static const int MATCH_TIMEOUT = 300; // in seconds

  static const int INITIAL_MONEY = 500;
  static const int MONEY_RATE = 20;
  static const int MINE_COST = 100;
  static const int ATTACK_COST = 100;

  static const int LOST_LANE_MONEY = 500;
  static const int LANE_REWARD_MONEY = 500;

  static const int UNIT_COST = 100;
  static const double UNIT_SPEED = 0.2;
  static const double UNIT_BASE_DAMAGE = 0.01;
  static const double BLOCK_MULTIPLIER = 50;
}
