'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "c0a9d5be15b331ca9bad30c6a85d9b63",
"main.dart.js": "99f077b24b3c72186617f027fbdc9864",
"assets/NOTICES": "b060564cae87d2181708698b7c1a6b1e",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/images/structures/platform.png": "0ec571b3480c0442351b5d23e5f51904",
"assets/assets/images/structures/missile.png": "15884a9dd0534866256ec57bd3d7da22",
"assets/assets/images/structures/resources.png": "8f6635fb5ec0c6a1872b7b61e380f801",
"assets/assets/images/structures/launcher_2.png": "a8e7b202010f9a03b17efb6f22b319a9",
"assets/assets/images/structures/launcher_1.png": "cfa492ce63dd90c95d0cb9e2680106ff",
"assets/assets/images/nodes/rock.png": "0cfa506264d6f88dfb9160b1dd8fe72c",
"assets/assets/images/nodes/water.png": "90a8b341879936560970b1f76353b147",
"assets/assets/images/units/artillery.png": "46518f69668c52019f2298261f820368",
"assets/assets/images/units/sniper.png": "f564e2fa1478d542bb3c1dedfef298c9",
"assets/assets/images/units/humvee.png": "e83e63e4a493a248eb914ded8a9bc966",
"assets/assets/images/units/rifle_squad.png": "54b56d8abe47c05f601859b5c4ae72ca",
"assets/assets/images/units/helicopter.png": "c30cfdf462ff7443f862bd547cd090a6",
"assets/assets/images/units/fuel_truck.png": "c79cbfd67ecc9a4101dbf48962f31b6c",
"assets/assets/images/units/rpg_team.png": "5bfffc9824395027fcac755d2707d712",
"assets/assets/images/units/tank.png": "6a705d1845ce5ee2a18ee9fd822c272f",
"assets/assets/images/units/rocket_vehicle.png": "9d2a35cb4f4e7280e9ed5534d93b5563",
"assets/assets/images/battlefields/background.jpg": "fc067d3e0c7058519736bca04cdb1408",
"assets/assets/images/thumbnails/artillery.png": "0975ea249a95bc013d0d022df6e0e2b7",
"assets/assets/images/thumbnails/sniper.png": "baa774f700158f9cbe46fba30a56a1a5",
"assets/assets/images/thumbnails/humvee.png": "2c12b4ad6b0643da098ccdcbf9fd2579",
"assets/assets/images/thumbnails/rifle_squad.png": "b6eb5da2e3c7d9d44306df61793c3bf8",
"assets/assets/images/thumbnails/helicopter.png": "19c380a7fb1ad999e49ac9fa9940d742",
"assets/assets/images/thumbnails/fuel_truck.png": "fe5b9bd368f3ce9ee9011aaa1e0d8b9b",
"assets/assets/images/thumbnails/rpg_team.png": "aa25ab66e4d1afbc665969447f2d841a",
"assets/assets/images/thumbnails/tank.png": "68d21959cf7af176792d6efd3b2fbcab",
"assets/assets/images/thumbnails/rocket_vehicle.png": "867c4515f32c9911bbe9b9724767d321",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "51de02e2d7e8bf29b2a9665ec926b696",
"assets/AssetManifest.json": "08259b4f6a460c808dcb119a37bcc79f",
"assets/AssetManifest.bin.json": "6c0002b5b3c3b91568df9b13045fb784",
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
