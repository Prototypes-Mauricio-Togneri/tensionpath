'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "1f75d77882c3522e85099204f156d103",
"main.dart.js": "b4a8103bdb00b65a9335861d6c80da26",
"assets/NOTICES": "a67f67dc3ce791b72bbf44979bea8b13",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/images/structures/pad_contested.png": "f9b84ac566cf3a458272d7d5b0d2e8df",
"assets/assets/images/structures/missile.png": "4f943190fd2e9d52c08560e6f87c8244",
"assets/assets/images/structures/pad_neutral.png": "a4d40d726e647093dd52988b9b97a309",
"assets/assets/images/structures/resources.png": "bc851acce354ba42160cdd053ac3b5eb",
"assets/assets/images/structures/rocks_low.png": "a0eede7634d069806198e89fed7589a8",
"assets/assets/images/structures/pad_player_1.png": "e4e6b1cfb5bcd0dd7e75dded359aa022",
"assets/assets/images/structures/pad_player_2.png": "3f91063b5104eb6c138f02e7ba57ce82",
"assets/assets/images/structures/launcher_2.png": "fbe34109979525b0fc2cb185c19d1476",
"assets/assets/images/structures/launcher_1.png": "6d717257bb3a01ddccae92730a157947",
"assets/assets/images/units/counter/aircraft_good.png": "c89aba7b643f2a86c348cf0888aae58b",
"assets/assets/images/units/counter/infantry_bad.png": "80b5c8bb16e2297be0fc33c6032d48c1",
"assets/assets/images/units/counter/vehicle_normal.png": "989b9cf67357acd9874ff32434bd55d0",
"assets/assets/images/units/counter/infantry_good.png": "ec4931aac70fb451a86eb4e7ecfd33d3",
"assets/assets/images/units/counter/aircraft_normal.png": "bef0fff7b7c3882baa64798d185d48ee",
"assets/assets/images/units/counter/vehicle_good.png": "eb7ece5fbbf737301cf86b4b4ce72049",
"assets/assets/images/units/counter/infantry_normal.png": "d331be24d4fa581a50cbf77f4c952cd2",
"assets/assets/images/units/counter/vehicle_bad.png": "f6fdf238243b90f7f5ccb1840a18a238",
"assets/assets/images/units/counter/aircraft_bad.png": "6bf77c4b7b7b7627ca255a1d57180d6a",
"assets/assets/images/units/player_2/harvester/harvester.png": "9929abddd9bc5c17b33c0f34ba223dc3",
"assets/assets/images/units/player_2/infantry/shocks.png": "7687578d370d21d3880f9440d9f62968",
"assets/assets/images/units/player_2/infantry/sniper.png": "1ef2e51e00a5edbb8ab93e2a0ac84dbe",
"assets/assets/images/units/player_2/infantry/missiles.png": "1eb534217bc101a3f5d2587b0b260bde",
"assets/assets/images/units/player_2/infantry/riflemen.png": "68c458f8af3db9d266141776f9c7b880",
"assets/assets/images/units/player_2/infantry/grenadier.png": "ae6869623295a67ab73e91cf4076c140",
"assets/assets/images/units/player_2/aircraft/hammerhead.png": "b85ed6e1356a3c63707b4af65694074c",
"assets/assets/images/units/player_2/aircraft/talon.png": "4743a35c829bdd7a81b1ba133966654b",
"assets/assets/images/units/player_2/aircraft/mohawk.png": "64c0cc808ccbb620327659a119a80d48",
"assets/assets/images/units/player_2/aircraft/razorback.png": "88d97642c69b319496de11a473cc36d5",
"assets/assets/images/units/player_2/aircraft/orca.png": "17d8309acf156828f12d1fbf350d33e1",
"assets/assets/images/units/player_2/vehicle/mlrs.png": "6817dd5419960018422faaa0b49c179c",
"assets/assets/images/units/player_2/vehicle/shatterer.png": "deb2888e2868e432773641873465b199",
"assets/assets/images/units/player_2/vehicle/pitbull.png": "89058ad66e660277754bb8284427a457",
"assets/assets/images/units/player_2/vehicle/rhino.png": "12d927451cfaaea23453193e6b79d1d0",
"assets/assets/images/units/player_2/vehicle/predator.png": "186503f29df4980ad0c7d82127232488",
"assets/assets/images/units/player_1/harvester/harvester.png": "6debf76186ca78ad672c2bf780689b38",
"assets/assets/images/units/player_1/infantry/shocks.png": "c2c2c2e6b4f8ad3ddaff4bc61b665314",
"assets/assets/images/units/player_1/infantry/sniper.png": "3e395f5601d10b161755dd088c7d1074",
"assets/assets/images/units/player_1/infantry/missiles.png": "bc939cdab90e92a7c821a719f0cc18bf",
"assets/assets/images/units/player_1/infantry/riflemen.png": "535ca5bec165212eea1b8684575dc0f9",
"assets/assets/images/units/player_1/infantry/grenadier.png": "a7150b7bc6d29317cf4f3c76b233c821",
"assets/assets/images/units/player_1/aircraft/hammerhead.png": "fee5c8afb857491d1f5a9d641bba2115",
"assets/assets/images/units/player_1/aircraft/talon.png": "77ec0f834f5d128277c75cb2e13242a6",
"assets/assets/images/units/player_1/aircraft/mohawk.png": "103d2436ab1d8a34509ab13206444832",
"assets/assets/images/units/player_1/aircraft/razorback.png": "69707427eae526e88630fef605cb26cf",
"assets/assets/images/units/player_1/aircraft/orca.png": "acee5147522bc72575697b4eb8faa1b4",
"assets/assets/images/units/player_1/vehicle/mlrs.png": "f59e47c9d6a45143767b178bc7135dce",
"assets/assets/images/units/player_1/vehicle/shatterer.png": "5e0ee84c5590b72783a984df1042a6fe",
"assets/assets/images/units/player_1/vehicle/pitbull.png": "7206bbf618ba1c4b3949844a82da8d7d",
"assets/assets/images/units/player_1/vehicle/rhino.png": "6caabf57f35b1f4d49a2f0c1774999ff",
"assets/assets/images/units/player_1/vehicle/predator.png": "b4d9a40e514711f05cc459674db5c67f",
"assets/assets/images/units/cards/infantry/shocks.png": "9de31ad882c0e37621ae00806e959ffd",
"assets/assets/images/units/cards/infantry/sniper.png": "3c9b51a59921dc3349c1ea1ac7f86f79",
"assets/assets/images/units/cards/infantry/missiles.png": "bec5e05919fbeff5b7b749f9695cde66",
"assets/assets/images/units/cards/infantry/riflemen.png": "9f5ab6d7aa6709da8200949788952d8d",
"assets/assets/images/units/cards/infantry/grenadier.png": "d368e4f90d7bb356f5fd9accfe930580",
"assets/assets/images/units/cards/aircraft/hammerhead.png": "a23954b846293f5c13c0542307b5a3e7",
"assets/assets/images/units/cards/aircraft/talon.png": "4bf2c18aa644b21c15691d431c4b43be",
"assets/assets/images/units/cards/aircraft/mohawk.png": "c4e8bcbb256eca02640a481fd7c217d0",
"assets/assets/images/units/cards/aircraft/razorback.png": "d45183e3673cfd5abcb902ac24afb5a5",
"assets/assets/images/units/cards/aircraft/orca.png": "39d842093fb1d2538307fb249609ce69",
"assets/assets/images/units/cards/vehicle/mlrs.png": "0e67069cf88008e12cb33beebe971465",
"assets/assets/images/units/cards/vehicle/shatterer.png": "1dc56fe95d34d38d54560578b8cbb90c",
"assets/assets/images/units/cards/vehicle/pitbull.png": "b0341d3a33676935f8a85e00e421b204",
"assets/assets/images/units/cards/vehicle/rhino.png": "d4ad936a49aae9e746a5b533a3de8808",
"assets/assets/images/units/cards/vehicle/predator.png": "fbc6aab46d6296e671d52315f161af29",
"assets/assets/images/battlefields/background.png": "faaa466ff0872e8db61bdcf5c98704ab",
"assets/fonts/MaterialIcons-Regular.otf": "c6dc8891b7bf44aa7d1f231adfe97ccc",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "4509a9474571c67de34a417a9951b2d1",
"assets/AssetManifest.json": "d120c76338a1ba344529e35b01e1b8b4",
"assets/AssetManifest.bin.json": "7bded1d5f865f899c4446364e607df18",
"manifest.json": "3d5e19274a2e878d1df3652a9e8c6e25",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.ico": "7d5e71d98847316dae878429e3334569",
"version.json": "3ad0174b52ec3d255487c16af4957e57",
"index.html": "73f9937991fb38537e1089c12cf7607f",
"/": "73f9937991fb38537e1089c12cf7607f"};
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
