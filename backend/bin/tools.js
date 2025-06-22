const fs = require("fs");
var parser = require("xml2json");

generateMap("maps/map1.svg", {
  popcap: 7,
  baseMaxHealth: 100,
  resourcesPerPatch: 5,
  resourcesPerTurn: 5,
  resourcesPerSecond: 1,
  defenseFactor: 1.1,
  typeFactor: 1.33,
  baseHealth: 100,
  resources: 10,
  id: "map1",
  width: 7,
  height: 11,
});

function generateMap(sourcePath, config) {
  const json = JSON.parse(parser.toJson(fs.readFileSync(sourcePath, "utf8")));
  const template = JSON.parse(
    parser.toJson(fs.readFileSync("bin/template.json", "utf8"))
  );

  template.config.popcap = config.popcap;
  template.config.baseMaxHealth = config.baseMaxHealth;
  template.config.resourcesPerPatch = config.resourcesPerPatch;
  template.config.resourcesPerTurn = config.resourcesPerTurn;
  template.config.resourcesPerSecond = config.resourcesPerSecond;
  template.config.defenseFactor = config.defenseFactor;
  template.config.typeFactor = config.typeFactor;

  template.players["1"].baseHealth = config.baseMaxHealth;
  template.players["1"].resources = config.resources;

  template.players["2"].baseHealth = config.baseMaxHealth;
  template.players["2"].resources = config.resources;

  template.battlefield.id = config.id;
  template.battlefield.size.width = json.svg.$.width;
  template.battlefield.size.height = json.svg.$.height;
  template.battlefield.missile.numberOfPlatforms = config.numberOfPlatforms;
  template.battlefield.missile.platforms = {};

  for (let i = 0; i < config.numberOfPlatforms; i++) {
    template.battlefield.missile.platforms[(i + 1).toString] = null;
  }

  console.log(template);
}
