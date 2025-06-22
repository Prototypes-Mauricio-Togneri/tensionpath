const fs = require("fs");
const path = require("path");
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
  width: 7,
  height: 11,
  numberOfPlatforms: 3,
});

function generateMap(sourcePath, config) {
  const name = path.parse(sourcePath).name;
  const content = fs.readFileSync(sourcePath, "utf8");
  const xml = parser.toJson(content);
  const json = JSON.parse(xml);
  const template = JSON.parse(fs.readFileSync("bin/template.json", "utf8"));

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

  template.battlefield.id = name;
  template.battlefield.size.width = config.width;
  template.battlefield.size.height = config.height;
  template.battlefield.missile.numberOfPlatforms = config.numberOfPlatforms;
  template.battlefield.missile.platforms = {};

  for (let i = 0; i < config.numberOfPlatforms; i++) {
    template.battlefield.missile.platforms[(i + 1).toString()] = null;
  }

  template.battlefield.nodes = json.svg.g.path.map(getNode);

  const result = JSON.stringify(template, null, 2);
  fs.writeFileSync(`functions/static/maps/${name}.json`, result, "utf8");
}

function getNode(data) {
  const label = data["inkscape:label"].split("-")[0];
  const coordinates = data.d;

  console.log(label, coordinates);

  return {
    x: 0,
    y: 0,
    type: label,
    unit: undefined,
    structure: undefined,
  };
}
