const fs = require("fs");
const path = require("path");
const parser = require("xml2json");

const maps = JSON.parse(fs.readFileSync("maps/maps.json", "utf8"));

for (const map of maps) {
  generateMap(map);
}

function generateMap(map) {
  const name = path.parse(map.path).name;
  const content = fs.readFileSync(map.path, "utf8");
  const xml = parser.toJson(content);
  const json = JSON.parse(xml);
  const template = JSON.parse(fs.readFileSync("maps/template.json", "utf8"));

  template.config.popcap = map.popcap;
  template.config.baseMaxHealth = map.baseMaxHealth;
  template.config.resourcesPerPatch = map.resourcesPerPatch;
  template.config.resourcesPerTurn = map.resourcesPerTurn;
  template.config.resourcesPerSecond = map.resourcesPerSecond;
  template.config.defenseFactor = map.defenseFactor;
  template.config.typeFactor = map.typeFactor;

  template.players["1"].baseHealth = map.baseMaxHealth;
  template.players["1"].resources = map.resources;

  template.players["2"].baseHealth = map.baseMaxHealth;
  template.players["2"].resources = map.resources;

  template.battlefield.id = name;
  template.battlefield.size.width = map.width;
  template.battlefield.size.height = map.height;
  template.battlefield.missile.numberOfPlatforms = map.numberOfPlatforms;
  template.battlefield.missile.platforms = {};

  for (let i = 0; i < map.numberOfPlatforms; i++) {
    template.battlefield.missile.platforms[(i + 1).toString()] = null;
  }

  template.battlefield.nodes = json.svg.g.path.map((data) =>
    getNode(data, map.nodeSize)
  );

  const result = JSON.stringify(template, null, 2);
  fs.writeFileSync(`functions/static/maps/${name}.json`, result, "utf8");
}

function getNode(data, nodeSize) {
  const label = data["inkscape:label"].split("-");
  const coordinates = data.d;
  const location = getLocation(coordinates, nodeSize);

  return {
    x: location.x,
    y: location.y,
    type: "land",
    unit: undefined,
    structure: getStructure(label),
  };
}

function getLocation(coordinates, nodeSize) {
  const points = getPoints(coordinates);
  const center = getHexagonCenter(points);

  const locationX = (4 * center.x) / (3 * nodeSize.x);
  const locationY = center.y / nodeSize.y - (2 * center.x) / (3 * nodeSize.x);

  return {
    x: Math.round(locationX),
    y: Math.round(locationY),
  };
}

function getPoints(pathString) {
  const commands = pathString.match(/[a-zA-Z][^a-zA-Z]*/g);
  const coords = [];
  let startX = 0;
  let startY = 0;
  let currentX = 0;
  let currentY = 0;

  for (const command of commands) {
    const type = command[0];
    const args = command
      .slice(1)
      .trim()
      .split(/[\s,]+/)
      .map(Number);

    switch (type) {
      case "M":
      case "L":
        for (let i = 0; i < args.length; i += 2) {
          const x = args[i];
          const y = args[i + 1];
          coords.push({ x, y });
          currentX = x;
          currentY = y;
          if (type === "M") {
            startX = x;
            startY = y;
          }
        }
        break;

      case "H":
        for (const x of args) {
          currentX = x;
          coords.push({ x: currentX, y: currentY });
        }
        break;

      case "Z":
      case "z":
        currentX = startX;
        currentY = startY;
        break;

      default:
        throw new Error(`Unsupported command: ${type}`);
    }
  }

  return coords;
}

function getHexagonCenter(points) {
  if (points.length !== 6) {
    throw new Error(`Expected an array of exactly 6 points. ${points}`);
  }

  const sum = points.reduce(
    (acc, point) => {
      acc.x += point.x;
      acc.y += point.y;
      return acc;
    },
    { x: 0, y: 0 }
  );

  return {
    x: parseInt(sum.x / 6),
    y: parseInt(sum.y / 6),
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
  } else if (type === "resources") {
    return {
      type: "resources",
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
