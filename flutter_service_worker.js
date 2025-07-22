'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "dab0f4e2b328c953eb98b109d7aaed9a",
"version.json": "53fb59e54fb87bb44dba7c2200e1dead",
"index.html": "5a63c4966622010de7151b30aebd45e4",
"/": "5a63c4966622010de7151b30aebd45e4",
"main.dart.js": "02c1fdd31bf3b0f84bcd5c6c185692f2",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "f02d13b0c8a5af3e061389e39272c4f7",
"icons/Icon-192.png": "bd8221d1c0be8f22a4ba6a318a6ed03e",
"icons/Icon-maskable-192.png": "bd8221d1c0be8f22a4ba6a318a6ed03e",
"icons/Icon-maskable-512.png": "b102776fd3ab7f22194311b4950d277d",
"icons/Icon-512.png": "b102776fd3ab7f22194311b4950d277d",
"manifest.json": "c478904412ca8fcd00a70df68b238c82",
"assets/AssetManifest.json": "46f01584f1fec7dfb3ec7702a6ba6e3e",
"assets/NOTICES": "b41b3821d05f7d109e21ab2da8f7a2bd",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "95f82fa6555205ee9c1a3c34ee855c7d",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/assets/images/e-buletin.png": "0297a00d5817ed9fce4f63aab77ef99e",
"assets/lib/assets/images/approval_relasi_pancang.webp": "fdafbee21bf42a4215ecbf550b9249b4",
"assets/lib/assets/images/wms.png": "71f6ab13e51fdae7145f4e2a3e07b05c",
"assets/lib/assets/images/ebc.png": "4b57f3977581bb18c40a50c6b2be818c",
"assets/lib/assets/images/ynj-removebg.png": "49030e9dde6dc341578a21c31204f5d0",
"assets/lib/assets/images/profile.png": "907df69427fb889267eb8282aaa452a5",
"assets/lib/assets/images/ynj-title.png": "f86efc8911dd2d5773ac37ca07352f38",
"assets/lib/assets/images/mpd.png": "71faee986b9673517562794e506d8423",
"assets/lib/assets/images/approval_relasi_pancang.png": "bb92d09ec4e1b07635e0dc2c205ea835",
"assets/lib/assets/images/profile1.jpg": "93e1ae0d39f46179342d731eeeffef5d",
"assets/lib/assets/icons/email.png": "c4523d4c163f6aff1b1bc1b2b97cca5e",
"assets/lib/assets/icons/github.png": "5a3336ec283572fe3a4d72aed0492705",
"assets/lib/assets/icons/account.png": "acc0a128939892f5f6b4b68e735d533f",
"assets/lib/assets/icons/linkedin.png": "34b457572ff838f9462c55144611eec1",
"assets/lib/assets/icons/whatsapp.png": "0e6f195d36d90c22cd2c018108713166",
"assets/AssetManifest.bin": "11d02db68532fac1397dc66701b01220",
"assets/fonts/MaterialIcons-Regular.otf": "5b86ccb1c1c5f290c58387fd04d11b37",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
