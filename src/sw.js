
const CACHE_NAME = 'nihongo-cache';
const CACHE_URLS = [
  '/',
  '/assets/js/elm.js',
  '/assets/css/styles.css',
  '/favicon.ico',
  '/manifest.json',
  '/android-chrome-512x512.png',
  '/android-chrome-192x192.png',
  '/apple-touch-icon.png',
  '/favicon-32x32.png',
  'favicon-16x16.png'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(CACHE_URLS))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(res => {
        if (res)
          return res;
        return fetch(event.request);
      })
  );
});

self.addEventListener('activate', event => {
  const cacheAllowlist = [CACHE_NAME];

  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheAllowlist.indexOf(cacheName) === -1) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
