const fs = require("fs");
const { get } = require("http");
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
  const label = data["inkscape:label"].split("-");
  const coordinates = data.d;
  const location = getLocation(coordinates);

  return {
    x: location.x,
    y: location.y,
    type: "land",
    unit: undefined,
    structure: getStructure(label),
  };
}

function getLocation(coordinates) {
  console.log(coordinates);
  const parts = coordinates.split(" ");
  const x = parseInt(parts[1]);
  const y = parseInt(parts[2]);

  return {
    x: x,
    y: y,
  };
}

function getStructure(label) {
  const type = label[0];

  if (type === "launcher") {
    return {
      type: "launcher",
      playerId: label[1],
    };
  } else if (type === "pad") {
    return {
      type: "pad",
      platformId: label[1],
    };
  } else if (type === "resource") {
    return {
      type: "resource",
    };
  } else if (type === "missile") {
    return {
      type: "missile",
    };
  } else if (type === "obstacle") {
    return {
      type: "obstacle",
    };
  } else {
    return undefined;
  }
}
