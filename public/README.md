Files in this dir are made publicly available by the router.

Why the double `public` directory?
-> The router makes everything in `<project root>/public` available to anyone,
   BUT:
    - The router does that by making `public` the root of the uri for those
      requests, meaning `/public/` becomes `/`.
    - Authorisation checks are done in the server middleware.
    - We don't want to specify in too much detail what is and isn't allowed in
      those authorisation checks. So instead, we check if the resource has a
      `/public/` prefix.
    - Since `/public/` becomes `/` in the router, we add an extra `public`
      subdir here to make things work for the auth middleware.
