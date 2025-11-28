'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "30acfbb30bbf2a3f262603d3b7ca6d90",
"main.dart.js": "cff86e18a8cd1f654ab6031c2ece29ca",
"assets/NOTICES": "9b108ecd2ad04f3928a8939e2160029c",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/assets/audio/sound/voice/attack/fire_at_will.mp3": "f9ce958ea8a7792c43a8c0f00130672c",
"assets/assets/audio/sound/voice/attack/target_locked.mp3": "e8674742f75a29d50a084c1f79c7e9bd",
"assets/assets/audio/sound/voice/attack/open_fire.mp3": "d9fa21e8e113f5e881885feb949dd30c",
"assets/assets/audio/sound/voice/attack/give_em_hell.mp3": "142f955fa3b54429a5fa992354e52459",
"assets/assets/audio/sound/voice/attack/target_acquired.mp3": "9db2a69ebe30a7078aed218415db7689",
"assets/assets/audio/sound/voice/eva/unit_lost.mp3": "c945ae201a3c0960467e97053cccb295",
"assets/assets/audio/sound/voice/eva/cannot_deploy.mp3": "602ca2f38654b5673c53e2c430b237d0",
"assets/assets/audio/sound/voice/eva/building_online.mp3": "3ab889307ae677f509de7dee680c1713",
"assets/assets/audio/sound/voice/eva/mission_failed.mp3": "0c54c2a7d8ace984eb05dc5c8f71329d",
"assets/assets/audio/sound/voice/eva/base_under_attack.mp3": "c795b51ef4a69376a1d58b9a9e5c4755",
"assets/assets/audio/sound/voice/eva/missile_launched.mp3": "47a049382fafa1bcbb213ed98b07cb6b",
"assets/assets/audio/sound/voice/eva/harvester_under_attack.mp3": "652d7d357a09b5ef2a78d1f7eb8e62f9",
"assets/assets/audio/sound/voice/eva/select_target.mp3": "1c3ba9a8f5e97a7dfc224bde51104227",
"assets/assets/audio/sound/voice/eva/unit_ready.mp3": "5179df8398903ee090df097ca4574f8d",
"assets/assets/audio/sound/voice/movement/on_my_way.mp3": "018d563743ce45834b48051c7e0bd49f",
"assets/assets/audio/sound/voice/movement/moving_out.mp3": "cdcb29c41cd1ee99cb11238cdbb6b05c",
"assets/assets/audio/sound/voice/movement/advancing.mp3": "fa9314c33546c970ea3c2130215fd913",
"assets/assets/audio/sound/voice/movement/copy_that.mp3": "062fe93bd063cce887fc85ed3fa9ee5e",
"assets/assets/audio/sound/voice/movement/orders_received.mp3": "81762decd348a4571b1ff955b5d69be2",
"assets/assets/audio/sound/effects/mission_accomplished.mp3": "8480c6e35221d312a47b495c23c0caf5",
"assets/assets/audio/sound/effects/missile_launched.mp3": "45f37b136dcf8aad392a75005528b48e",
"assets/assets/audio/sound/effects/missile_alarm.mp3": "011271892107fa671907292f535bbaac",
"assets/assets/audio/sound/effects/pad.mp3": "e3560fd47a254fd5ed44f164b52c46d4",
"assets/assets/audio/sound/effects/missile_impact.mp3": "8d0991c33f3e8af8e322775f982e3ec8",
"assets/assets/audio/music/music.mp3": "c09bfaf3803fef704450ee09eec8d00d",
"assets/assets/images/structures/pad_contested.png": "f9b84ac566cf3a458272d7d5b0d2e8df",
"assets/assets/images/structures/pad_neutral.png": "a4d40d726e647093dd52988b9b97a309",
"assets/assets/images/structures/resources.png": "81cff1ef8fad631a9c17d77257fff35d",
"assets/assets/images/structures/rocks_low.png": "77caa550ee356366218f1fb06edf3b1a",
"assets/assets/images/structures/pad_player_1.png": "e4e6b1cfb5bcd0dd7e75dded359aa022",
"assets/assets/images/structures/building_2.png": "fbe34109979525b0fc2cb185c19d1476",
"assets/assets/images/structures/pad_player_2.png": "3f91063b5104eb6c138f02e7ba57ce82",
"assets/assets/images/structures/building_1.png": "6d717257bb3a01ddccae92730a157947",
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
"assets/assets/images/units/player_2/infantry/zone.png": "d7d30b6bfcb2acb8d77b545b57b1c1ad",
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
"assets/assets/images/units/player_2/vehicle/disruptor.png": "9338d1fd33601bebdd305f0cdb0c39b7",
"assets/assets/images/units/player_2/vehicle/wolverine.png": "26d5133e8dc882b1073d4d932bb40396",
"assets/assets/images/units/player_2/vehicle/titan.png": "6e34707cc3d760acf0cd79f685163987",
"assets/assets/images/units/player_2/vehicle/predator.png": "186503f29df4980ad0c7d82127232488",
"assets/assets/images/units/player_2/vehicle/mammoth.png": "4bbbd339cebfa11044230df47f4fc0db",
"assets/assets/images/units/player_1/harvester/harvester.png": "6debf76186ca78ad672c2bf780689b38",
"assets/assets/images/units/player_1/infantry/shocks.png": "c2c2c2e6b4f8ad3ddaff4bc61b665314",
"assets/assets/images/units/player_1/infantry/sniper.png": "3e395f5601d10b161755dd088c7d1074",
"assets/assets/images/units/player_1/infantry/missiles.png": "bc939cdab90e92a7c821a719f0cc18bf",
"assets/assets/images/units/player_1/infantry/zone.png": "eb60c374b7194fa3aef50a3f5ccda459",
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
"assets/assets/images/units/player_1/vehicle/disruptor.png": "1fe9867349848b6f0b0f40d89f6eb958",
"assets/assets/images/units/player_1/vehicle/wolverine.png": "ffd60f21f9e1a69a4ea3035369efb441",
"assets/assets/images/units/player_1/vehicle/titan.png": "301e7bdae84c1ecb7736da15d3aeb269",
"assets/assets/images/units/player_1/vehicle/predator.png": "b4d9a40e514711f05cc459674db5c67f",
"assets/assets/images/units/player_1/vehicle/mammoth.png": "d3c75125658cdc515913de69aa55c7b3",
"assets/assets/images/units/cards/infantry/shocks.png": "9de31ad882c0e37621ae00806e959ffd",
"assets/assets/images/units/cards/infantry/sniper.png": "3c9b51a59921dc3349c1ea1ac7f86f79",
"assets/assets/images/units/cards/infantry/missiles.png": "bec5e05919fbeff5b7b749f9695cde66",
"assets/assets/images/units/cards/infantry/zone.png": "02068f710bd9fb1a2ab9b89a7767a392",
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
"assets/assets/images/units/cards/vehicle/disruptor.png": "43ddb8148af52c4d2dd5801a8cb15433",
"assets/assets/images/units/cards/vehicle/wolverine.png": "1e178fbd080146edf30a01348704fae1",
"assets/assets/images/units/cards/vehicle/titan.png": "04a1439006c7ff528051b711cf40ac90",
"assets/assets/images/units/cards/vehicle/predator.png": "fbc6aab46d6296e671d52315f161af29",
"assets/assets/images/units/cards/vehicle/mammoth.png": "5423071e460f2d82fe6e939c707ace84",
"assets/assets/images/buildings/airfield_on.png": "acf949945c5a688d79d1d8f794cdb9c7",
"assets/assets/images/buildings/main_on.png": "3f15e4b955bb80164ee7ed4c10246d99",
"assets/assets/images/buildings/factory_on.png": "ff19eb881e292e0ad229acb19d8f94c2",
"assets/assets/images/buildings/tech_on.png": "effc44c915bf512af0be58f6e180d980",
"assets/assets/images/buildings/airfield_off.png": "95607bc250fd3026f56aefd38232a725",
"assets/assets/images/buildings/factory_off.png": "b1592cfae6897c52c598c9db6572c809",
"assets/assets/images/buildings/barracks_on.png": "bbb1245d775d367d749a8ac9fb50c811",
"assets/assets/images/buildings/tech_off.png": "f1e3efdf376dd6a733a66c1caaa12fdb",
"assets/assets/images/buildings/barracks_off.png": "c0df11d827798912e52fa67ef0abf570",
"assets/assets/images/other/missile.png": "ed5b6a1706f8af3a29fddccf2efca7f6",
"assets/assets/images/battlefields/background.png": "faaa466ff0872e8db61bdcf5c98704ab",
"assets/assets/text/changelog.txt": "d993a0ad725b10d5db2fe039e2d18e0b",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "87259b0df3f9745c8530542fd9db259a",
"assets/AssetManifest.bin.json": "0cf41c2209bf3c278fb5f04aad6b629c",
"manifest.json": "1da0152e6393fbc7868523d2fb7cc328",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
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
