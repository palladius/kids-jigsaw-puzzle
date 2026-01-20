'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "61d3e51da1c8da8332d0e503ee52c03d",
"index.html": "640642952eb719aeeba3429f98adbcd7",
"/": "640642952eb719aeeba3429f98adbcd7",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "4707d1556601d57ff6426a4429e4be48",
"assets/assets/images/reindeers-in-stadelhofen.png": "6505f1d5b5cb51523ff81abd25ae4391",
"assets/assets/images/ale-seby-tulum.png": "67a717bb7eba4af7b214881044ab0980",
"assets/assets/images/ale-seby-tandem-wow.png": "1af925bab445f03430dd69024f3adccf",
"assets/assets/images/family-pijama-estensi.png": "08b8cfcc2fade63a2912c698e0754846",
"assets/assets/images/comacchio-3ponti.png": "b51d22d052e8cecb6737a5b6150cfb34",
"assets/assets/images/lucy-bimbi-ikea.png": "51b7fadb6a121a5b722d4c7a0e5945e6",
"assets/assets/images/reindeers-polar-express.png": "a49e1f709196b291cc5b8d8d892add7d",
"assets/assets/images/seby-puzzle.png": "f71dbb6ee78f473c6760b10defbd7087",
"assets/assets/images/ale-tieffenbrunnen.png": "fd84106bb0a8681b9e72f8330ff50ea9",
"assets/assets/images/ale-seby-bordo-colorato.png": "25643c360fb3ca6236783b777f7ec987",
"assets/assets/images/ale-seby-ski.png": "753bb7f9d003ad900604fbde1b3140b3",
"assets/assets/images/ale-seby-xmas.png": "3c8d54d5c899b93abeb2b9b4c0d74c6e",
"assets/assets/images/seby-palla-di-natale.png": "6155155849cb0f57ce52ed796a95c210",
"assets/assets/images/ale-bici-meilen.png": "0d486357f50bdd6df7019efeaa8e6d4e",
"assets/assets/images/lucy-seby-estate-inverno.png": "69023e21b536df108927fe1e03239865",
"assets/assets/images/ricc-ale-seby-rubycon.png": "a813071c7f762e2779abadb5a07fbb1a",
"assets/assets/images/gdg-zurich-jan26.png": "c380edb45bfe644d8f85c08f8162bbbe",
"assets/assets/images/pupurabbu.png": "62b0fe52c62ac30231f7b453ebaa8f41",
"assets/assets/images/family-xmas-presents.png": "5765a283679a1dc015ec8498dcca0685",
"assets/assets/images/ale-seby-kate-argenta-ele-jc.png": "6cdbc6c967813161c6e5aca13caf1e87",
"assets/assets/images/seby-sgarrupato.png": "d5b7cc2f1dcf6cf56ccdc05368956344",
"assets/assets/images/puzzle-42.png": "274099c04429446493525ea1b4b14e63",
"assets/assets/images/aj-with-giraffe.png": "8e615ac852f8beab77aac01cd427b33a",
"assets/assets/images/ale-pupurabbu.png": "b73c7a30f12e82016b4c8bfc381bc034",
"assets/assets/images/ale-seby-xmas-cropped.png": "7b238cd5c5db9266b22412f892ee528b",
"assets/assets/images/ale-seby-mexico.png": "b88c5df5afdbcebf58e3d05df57bc508",
"assets/assets/images/ale-seby-halloween.png": "c498d88792973135f44696a17cf0f0dc",
"assets/assets/images/ale-seby-scacchi-locarno.png": "e2af7ed4d3d05bc7c0cdbd957f7e8a23",
"assets/assets/images/ale-maglietta-ele.png": "a2f8b12f7837dfe0204a3afd8404114c",
"assets/assets/images/lucy-kate-ale-rialto.png": "d01ce68c0a5484848d00e9958817ee48",
"assets/assets/images/logo.png": "f519073f607c7d82d994ac35cdc36441",
"assets/assets/images/family-silvester-lauf.png": "85d68b8e066f3d985902a2c41901ce25",
"assets/assets/images/ale-seby-lederhosen-g.png": "25377f170e4410a22127ff4f6f40b838",
"assets/assets/images/aj-megapuzzle.png": "8d7ab3d6c48477fbafb3726a0987e5e2",
"assets/assets/images/ale-seby-android.png": "c028d8fc3acffe6014c83f7e15163d8d",
"assets/assets/images/zurich-tram4.png": "dbb58d53f55289f17a85337f19f7bf45",
"assets/assets/images/seby-in-space.png": "1c957e4d76bdd944354d2e5a7f9d2169",
"assets/assets/images/ale-seby-train.png": "bea5017dca0e22f8921fa37b5f154f5c",
"assets/assets/images/ale-seby-google-chess3.png": "a7ec6b6f01bcc04388a10973a5eb9e32",
"assets/assets/images/seby-ski-italy.png": "04467fc0df08e094c213bb6bd56f45fd",
"assets/assets/images/arca-di-noe-torta-compleanno.png": "429ea31dc60f9cbc245cb3f271cd4de7",
"assets/assets/images/ricc-lucy-albero-lde.png": "cf05cef19e35367b567b5c8f1cf6d1b3",
"assets/assets/images/ricc-bimbi-lugano.png": "f5cb9ea44a55d14dd8a1bcf374428cc8",
"assets/assets/images/lucy-venezia-kate-bimbi-rialto.png": "e33610c4c1f4fdb2d7e85a4a3ad2fe76",
"assets/fonts/MaterialIcons-Regular.otf": "186f1cc9b7d5c9b92f25ad873c6753af",
"assets/NOTICES": "158aacbc2192793bf44dfd4cd35c10d4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "29ec9b020c1c74198f4be320d03ea59d",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "4decfb68d0e842a6e6ce82436ad849fd",
"version.json": "5bfb3aef033808dd1e95fabd090efe66",
"main.dart.js": "aaef4ffe7b9d7ff36b193d9dadd1c82d"};
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
