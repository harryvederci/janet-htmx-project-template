# janet-htmx-project-template
This is a project template for using htmx to create full stack web
applications with Janet + zero or very little handwritten JavaScript.

## realistic welcome message
Hi! I think I'm on to something really nice here. It's still WIP and pretty
rough, but you'll probably find it interesting regardless.

The main interesting thing isn't in the usage of htmx yet, but in how I'm
generating routes through the structure of the project.

### no router boilerplate
You don't have to add routes to a router key-value mapping. Any `.janet`
file you add to `src/routes/**` will automatically be added to the
router.

### generated variables for urls
Instead of messing around with strings to specify a url in your front-end
code, you can use `>>/`-prefixed variables.
 - What you're probably used to is i.e. posting to  `"/some/endpoint"`.
 - What you'll be doing from here on is posting to `>>/some/endpoint`.
Notice the first is a string, the second is a variable that is impossible to
mess up with a typo.

The reason for using the `>>/` prefix is that it makes it insanely easy to
search for the usages of an endpoint in your entire project. It can be replaced
with anything you like.

### no test boilerplate
When you run tests (with `jpm run test`), warnings will be displayed if tests
are missing for these generated routes.

Since I was on a roll with preventing boilerplate code, the test setup is made
for you automatically through file structure as well. If you add a route with
no tests the test runner will give you instructions similar to the following:

You need to create a directory matching the route, and in that directory
create one or more groups of files with the following layout:
 - `1_expected-output-body.html`
 - `1_expected-status-code.txt`
 - `1_input-body.edn`
 - `1_test-description.txt`

You can replace `1_` with anything, so it's probably nice to use something
short and descriptive there.

Creating the expected html output and reading test errors is still a bit
rough, but:
- rhat should be pretty easy to improve by adding a html-specific diff-creating
  function to (a fork of) the Testament library.
- I could create something that opens a browser with the expected output, the
  actual output, where you can see how it's rendered then decide if the actual
  output is better than what you had. Then it'll overwrite the existing
  expected output file with the new and improved version.
   - If you have the application running as a server while doing this, you
     could probably even interact with both vesions of the output and see if
     it behaves as expected. Maybe that's easier said than done, though.


### how?
What makes this setup possible is the fact that I'm only using `POST` requests
when using htmx. I wouldn't design a normal API this way, but since the UI of
your application will be the only consumer of this API, it doesn't have a
negative impact on external parties. You can also add normal endpoints if you
want to expose your API to others, I guess, but the `src/routes` dir is
intended for frontend-consumed stuff.


## premature hyped up welcome message
Congratulations, you have reached web app development enlightenment. You'll
never have to manually create a route mapping again. The days of creating test
boilerplate code are over. The concepts "frontend" and "backend" will soon blur
into a vague memory of the past. You'll never forget to create a test for a new
feature again. Messing up a url string? You cannot imagine ever doing that.

> "Everything is OK. You're in the good place."



## issues
### ugly everything-is-table-prefixed schema
Agreed, it's ugly, but it's not really important for this template. Also, read
my personal Janet style guide below to understand why I'm using it for now.

### blocking issues
#### prevent XSS scripting
(Probably only really an issue if you will allow users to add content, and
allow that content to be displayed.)

From the HTMX docs:
> htmx allows you to define logic directly in your DOM. [...]
> One concern with this approach, however, is security. This is especially the
> case if you are injecting user-created content into your site without any
> sort of HTML escaping discipline.

> You should, of course, escape all 3rd party untrusted content that is
> injected into your site to prevent, among other issues, [XSS
> attacks](https://en.wikipedia.org/wiki/Cross-site_scripting).
> Attributes starting with `hx-` and `data-hx`, as well as inline `<script>`
> tags should be filtered.

I think that means all user-created content should be validated by a regex
checker that rejects this pattern:
```
"&#x?\w+;|[<>\{\}\[\]]"
```

On top of that, I need to prevent content containing `hx-` and `data-hx`
attributes.

#### no size/chars limit for DB text columns
Should be fixed before launch. Limit amount of chars to something sensible for
each text column.


## My code style guide (eary draft, please prove me wrong)
- Database: prefix your ID columns with the table name.
  This seems tedious, BUT:
  - It saves you the annoyance of querying `city.id as city_id` all over the
    place.
  - It makes the rest of your codebase less ambiguous: it's easy to understand
    what `:city-id` refers to. It's more mental overhead to understand what
    `:id` refers to.
  - It makes harder to screw things up when querying the DB: You'd have to make
    a mistake twice when writing `something.something_id`, versus once in
    `something.id`, when you actually wanted to query the id of the
    `something_else` table.
- Janet specific: Always use imports without modifiers.
  - Good: `(import /src/utils/html-utils)`
  - Bad:  `(import /src/utils/html :as html-utils)`
  - Why?
    - This makes it easy to recognise the origin (file) that contains that
      `html-utils` thing that you're referring to in the code.
    - It's less mental overhead. If you would use aliases, you'd have to do an
      extra step in your head when reading/writing code: "Where does this
      `html-utils` thing come from, again?" -> [look up the import] -> "Oh I
      see, it's a file named html, in the utils directory."
      With this style guide its approach, at least you know the file name for
      sure.
      TODO: maybe add a checker: all janet file names must be unique.
    - It forces you to use descriptive file names, because you'll be referring
      to them in your code.
      (Downside is some possible duplication in the file path + file name. For
      example: "utils" is part of both the path and the file name in the
      "Good:" example above. I think the benefits outweigh this by muy muy
      mucho, though.)
    - It makes it very easy to find references to a function without needing
      LSP. You can write 
- HTMX:
  - Run all of the following through a helper function (in utils/hxu - the
    htmx utils file):
      - html id attributes (those that are relevant to htmx)
      - hx-target attributes
      - html components that are a placeholder for htmx (so the result of an
        http request would be swapped at this placeholder)
     -> Why?
        - It's harder to screw things up if you ensure consistency by using a
          helper function.
        - It makes it easy for you to pinpoint htmx usage throughout the
          application. This is good for insight, and I guess it would make life
          much easier if you'd ever have to replace htmx with something else.



### authentication (don't read, work in progress)
For now, this section mostly contains notes to myself on how to implement this.
You should ignore it, or you can help me out by implementing it and
contributing your code. That would be awesome.

#### getting a jwt
TODO: update this section after implementing the `/auth` endpoint, and/or add a
section on using a third party to handle this part for you.

#### storing the token in client-side (browser) localStorage
The following should be possible:
- Create and include a JavaScript function `storeAuthToken()` as part of the
  html sent to users. (Make sure you verify that function is *always* included
  in the page.)
  This function should store the auth token in the browser its localStorage.
- Then, in responses to authentication  requests (i.e. to a to-be-build `/auth`
  endpoint), add an `HX-Trigger` header with a value of `storeAuthToken`.

#### adding the stored token to follow-up requests
You'll have to create and include a JavaScript function `getAuthToken()` as
part of the website. (Make sure you verify that function is *always* included in
the page!)

Then you can use the event `htmx:configRequest`, which is triggered after htmx
has collected parameters for inclusion in the request. It will look (something)
like this:
```js
document.body.addEventListener('htmx:configRequest', function(evt) {
  evt.detail.parameters['auth_token'] = getAuthToken();
  // or maybe something like   evt.detail.headers.add(......
});
```
(Maybe first get the auth token from local storage, check if it is null, and if
so, show an error message and redirect the user to the login page.)
