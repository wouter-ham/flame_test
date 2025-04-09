class Config {
  static const double radius = 4;
  static const int gridSize = 25;
  static const int particleDistance = 25;
  static const int maxGroupBoundary = 25;
}

enum TargetingStrategy {
  closest, // Closest to the tower
  weakest, // Lowest HP
  strongest, // Highest HP
  fastest, // Highest speed
  furthestOnPath, // Npc with the most distance travelled
  flying, // Flying NPC's
  ground, // Walking/driving NPC's
  groups, // NPC with the most enemies close to it
}

enum TravelType { ground, flying }
