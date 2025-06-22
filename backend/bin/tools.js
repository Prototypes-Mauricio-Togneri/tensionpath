const fs = require("fs");
var parser = require("xml2json");

const content = fs.readFileSync("maps/map1.svg", "utf8");
const json = JSON.parse(parser.toJson(content));
console.log(json.svg.g.path.length);
