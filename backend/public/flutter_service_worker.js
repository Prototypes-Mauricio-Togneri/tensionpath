'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "d2ab71e49b3a7579c60c43a3411692a4",
"main.dart.js": "4928b0ba6817b642866ee83f2b243463",
"assets/NOTICES": "0734c55eded78d52cd40876693e3d704",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/audio/sound/voice/attack/fire_at_will.mp3": "f9ce958ea8a7792c43a8c0f00130672c",
"assets/assets/audio/sound/voice/attack/target_locked.mp3": "e8674742f75a29d50a084c1f79c7e9bd",
"assets/assets/audio/sound/voice/attack/open_fire.mp3": "d9fa21e8e113f5e881885feb949dd30c",
"assets/assets/audio/sound/voice/attack/give_em_hell.mp3": "142f955fa3b54429a5fa992354e52459",
"assets/assets/audio/sound/voice/attack/target_acquired.mp3": "9db2a69ebe30a7078aed218415db7689",
"assets/assets/audio/sound/voice/eva/unit_lost.mp3": "c945ae201a3c0960467e97053cccb295",
"assets/assets/audio/sound/voice/eva/cannot_deploy.mp3": "602ca2f38654b5673c53e2c430b237d0",
"assets/assets/audio/sound/voice/eva/mission_failed.mp3": "0c54c2a7d8ace984eb05dc5c8f71329d",
"assets/assets/audio/sound/voice/eva/base_under_attack.mp3": "c795b51ef4a69376a1d58b9a9e5c4755",
"assets/assets/audio/sound/voice/eva/missile_launched.mp3": "47a049382fafa1bcbb213ed98b07cb6b",
"assets/assets/audio/sound/voice/eva/harvester_under_attack.mp3": "652d7d357a09b5ef2a78d1f7eb8e62f9",
"assets/assets/audio/sound/voice/eva/select_target.mp3": "1c3ba9a8f5e97a7dfc224bde51104227",
"assets/assets/audio/sound/voice/eva/unit_ready.mp3": "5179df8398903ee090df097ca4574f8d",
"assets/assets/audio/sound/voice/movement/on_my_way.mp3": "018d563743ce45834b48051c7e0bd49f",
"assets/assets/audio/sound/voice/movement/orders-received.mp3": "81762decd348a4571b1ff955b5d69be2",
"assets/assets/audio/sound/voice/movement/moving_out.mp3": "cdcb29c41cd1ee99cb11238cdbb6b05c",
"assets/assets/audio/sound/voice/movement/advancing.mp3": "fa9314c33546c970ea3c2130215fd913",
"assets/assets/audio/sound/voice/movement/copy_that.mp3": "062fe93bd063cce887fc85ed3fa9ee5e",
"assets/assets/audio/sound/effects/mission_accomplished.mp3": "8480c6e35221d312a47b495c23c0caf5",
"assets/assets/audio/sound/effects/missile_alarm.mp3": "011271892107fa671907292f535bbaac",
"assets/assets/audio/sound/effects/pad.mp3": "e3560fd47a254fd5ed44f164b52c46d4",
"assets/assets/audio/music/music.mp3": "c09bfaf3803fef704450ee09eec8d00d",
"assets/assets/images/structures/pad_contested.png": "f9b84ac566cf3a458272d7d5b0d2e8df",
"assets/assets/images/structures/missile.png": "4f943190fd2e9d52c08560e6f87c8244",
"assets/assets/images/structures/pad_neutral.png": "a4d40d726e647093dd52988b9b97a309",
"assets/assets/images/structures/resources.png": "81cff1ef8fad631a9c17d77257fff35d",
"assets/assets/images/structures/rocks_low.png": "77caa550ee356366218f1fb06edf3b1a",
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
"assets/assets/images/units/player_2/aircraft/mohawk.png": "060cae33e56d779437a24c689a49a736",
"assets/assets/images/units/player_2/aircraft/razorback.png": "db911b19f17e0e593112b213be3e68a0",
"assets/assets/images/units/player_2/aircraft/orca.png": "17d8309acf156828f12d1fbf350d33e1",
"assets/assets/images/units/player_2/vehicle/mlrs.png": "222c1f1351afa88b09be72cf5f76d62a",
"assets/assets/images/units/player_2/vehicle/shatterer.png": "deb2888e2868e432773641873465b199",
"assets/assets/images/units/player_2/vehicle/pitbull.png": "1d4fedb90f1c035f485997cd26456df4",
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
"assets/assets/images/units/player_1/aircraft/mohawk.png": "350d3101f07b9ca146ddba2a1f87d253",
"assets/assets/images/units/player_1/aircraft/razorback.png": "a621e4b92f7b197584b96a52be263a98",
"assets/assets/images/units/player_1/aircraft/orca.png": "acee5147522bc72575697b4eb8faa1b4",
"assets/assets/images/units/player_1/vehicle/mlrs.png": "81a2386c5360a98602c880de461327b6",
"assets/assets/images/units/player_1/vehicle/shatterer.png": "5e0ee84c5590b72783a984df1042a6fe",
"assets/assets/images/units/player_1/vehicle/pitbull.png": "4c792274a697d7dc6d7e034f9d0dc570",
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
"assets/assets/text/changelog.txt": "7b2404263ba572d02aac181856c2e2a8",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "e91f2db4a27a4b4d7af58f7a151def8b",
"assets/AssetManifest.json": "98a6b7dd970f90736e6e1738317f8122",
"assets/AssetManifest.bin.json": "85bed6fe261d5081959da5accf67ba06",
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
