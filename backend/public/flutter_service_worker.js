'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a9299f63aa4d72192079b1d9e2a6068a",
"main.dart.js": "5d0efe1964b1675f65cde87cdb33ad1a",
"assets/NOTICES": "017362b399afdbd839f22123d23c8119",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/images/structures/pad_contested.png": "eca6b2f1375d8127848a2bc644a334c1",
"assets/assets/images/structures/missile.png": "b6879d0a846ffabfc4dd4bb16073290e",
"assets/assets/images/structures/pad_neutral.png": "0ec571b3480c0442351b5d23e5f51904",
"assets/assets/images/structures/resources.png": "8f6635fb5ec0c6a1872b7b61e380f801",
"assets/assets/images/structures/pad_player_1.png": "79110abb52bee8d81366767b2721a093",
"assets/assets/images/structures/pad_player_2.png": "00f42a4bef9b9365c5ef20c052201829",
"assets/assets/images/structures/launcher_2.png": "a8e7b202010f9a03b17efb6f22b319a9",
"assets/assets/images/structures/launcher_1.png": "cfa492ce63dd90c95d0cb9e2680106ff",
"assets/assets/images/nodes/rock.png": "0cfa506264d6f88dfb9160b1dd8fe72c",
"assets/assets/images/nodes/water.png": "90a8b341879936560970b1f76353b147",
"assets/assets/images/units/player_2/sniper.png": "e2cdd5433e90fa9e05f5a98588b8bca5",
"assets/assets/images/units/player_2/humvee.png": "85bde4f5363cca9ddc78cc7449c42503",
"assets/assets/images/units/player_2/rifle_squad.png": "f1ac495a4d102a71035cdaa9c0b44410",
"assets/assets/images/units/player_2/artillerty.png": "0acc9a82cc8e83e4d670051b9283ca5d",
"assets/assets/images/units/player_2/helicopter.png": "4743a35c829bdd7a81b1ba133966654b",
"assets/assets/images/units/player_2/fuel_truck.png": "3f77e726cf18fec9518cc7a96337f5ba",
"assets/assets/images/units/player_2/rpg_team.png": "990988e6684575bbcadbb41d22123247",
"assets/assets/images/units/player_2/tank.png": "76b76710646ebeb9961bee2eed88c93f",
"assets/assets/images/units/player_2/rocket_vehicle.png": "eee139cafaa6f33f6e135ffe23841a84",
"assets/assets/images/units/player_1/artillery.png": "cfa785d1e64b5c123ac90a9d8e800751",
"assets/assets/images/units/player_1/sniper.png": "adee8346c47529107f41a0b1755cc96c",
"assets/assets/images/units/player_1/humvee.png": "9c9fea91fa2bdc851c01cb1b0d220b78",
"assets/assets/images/units/player_1/rifle_squad.png": "ebecee86c47a056834be18689c76e887",
"assets/assets/images/units/player_1/helicopter.png": "77ec0f834f5d128277c75cb2e13242a6",
"assets/assets/images/units/player_1/fuel_truck.png": "10b65a86808f82745bb119a0500fb211",
"assets/assets/images/units/player_1/rpg_team.png": "31ceb2226b4422d04b9468c18ca6231f",
"assets/assets/images/units/player_1/tank.png": "99b1578609773cf7321a4d0fc078c2de",
"assets/assets/images/units/player_1/rocket_vehicle.png": "48b917570e1bfd737450c298058452e2",
"assets/assets/images/counter/aircraft_good.png": "c89aba7b643f2a86c348cf0888aae58b",
"assets/assets/images/counter/infantry_bad.png": "80b5c8bb16e2297be0fc33c6032d48c1",
"assets/assets/images/counter/vehicle_normal.png": "989b9cf67357acd9874ff32434bd55d0",
"assets/assets/images/counter/infantry_good.png": "ec4931aac70fb451a86eb4e7ecfd33d3",
"assets/assets/images/counter/aircraft_normal.png": "bef0fff7b7c3882baa64798d185d48ee",
"assets/assets/images/counter/vehicle_good.png": "eb7ece5fbbf737301cf86b4b4ce72049",
"assets/assets/images/counter/infantry_normal.png": "d331be24d4fa581a50cbf77f4c952cd2",
"assets/assets/images/counter/vehicle_bad.png": "f6fdf238243b90f7f5ccb1840a18a238",
"assets/assets/images/counter/aircraft_bad.png": "6bf77c4b7b7b7627ca255a1d57180d6a",
"assets/assets/images/battlefields/background.jpg": "fc067d3e0c7058519736bca04cdb1408",
"assets/assets/images/thumbnails/artillery.png": "50bc2f938335650f3eb239f74ec99874",
"assets/assets/images/thumbnails/sniper.png": "f17d71979815a2415400c515b590b5ed",
"assets/assets/images/thumbnails/humvee.png": "f0ed6f0bc978a567144c047c081e0438",
"assets/assets/images/thumbnails/rifle_squad.png": "09e44aa31307d0296107d6150475751f",
"assets/assets/images/thumbnails/helicopter.png": "5e768c784c744adba5500949b3742742",
"assets/assets/images/thumbnails/fuel_truck.png": "a2f3fd5e2faf664ba0b8f4c5ecd3a4b5",
"assets/assets/images/thumbnails/rpg_team.png": "f735b550eca7ff6242dd57f0a95836dd",
"assets/assets/images/thumbnails/tank.png": "cdf6443beeccc1c56f95ecbef594f71e",
"assets/assets/images/thumbnails/rocket_vehicle.png": "2e71793985c7f955be53b74a968ccf99",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "f18898e2ffb523290108c2b99993680b",
"assets/AssetManifest.json": "a15de99ee330a12068ba9fb6ae707cd3",
"assets/AssetManifest.bin.json": "f6b5470f360f090dfd93d34687f649d6",
"manifest.json": "3d5e19274a2e878d1df3652a9e8c6e25",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.ico": "7d5e71d98847316dae878429e3334569",
"version.json": "3ad0174b52ec3d255487c16af4957e57",
"index.html": "e78c41d9232aae978dba3fdf27ebcb1b",
"/": "e78c41d9232aae978dba3fdf27ebcb1b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
