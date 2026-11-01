# CLI web build

Build from the **repository root** so Docker uses the current checkout:

```sh
docker build -f docker/cli/web/Dockerfile -t bibref-web .
docker run --rm -p 8080:80 bibref-web
```

Open http://localhost:8080/index-jt-dt.html. Commands run locally in WASM.
The old `GIT_COMMIT` argument is replaced by the checkout selected before building.

## Module inputs

Native installation still extracts `sword-lxx-sblgnt-statresgnt-kjv-fallback.zip`.
Its SHA-256 is `d548cda5d284cb8dae912bf3080c3f46e42624cf6aee0dc5c7f91ccd3592ccca`;
it contains LXX 3.2, SBLGNT 1.3.1, StatResGNT 1.5 and KJV 3.1.
No Greek module is upgraded, and `addBibles` is unchanged. This records the
actual checkout's versions; compatibility with a different book's numeric
positions must be checked against that book's module versions.

`install-modules.py` downloads these official CrossWire raw ZIP archives at
build time (verified 2026-10-13), rejecting checksum or layout changes:

- [HunRUF 1.0](https://crosswire.org/ftpmirror/pub/sword/packages/rawzip/HunRUF.zip),
  SHA-256 `b6db6d7e03b385e65fc9ca97e1c35ea754a0db5745e809335ef91c6497a8fa8f`,
  German versification, `mods.d/hunruf.conf` and `modules/texts/ztext/hunruf/`.
- [Aleppo 2.0.1](https://crosswire.org/ftpmirror/pub/sword/packages/rawzip/Aleppo.zip),
  SHA-256 `6a4fa5968075669695a05050a4882cb2fdb93790f041b9e2e3bace1a692c0798`,
  MT versification, `mods.d/aleppo.conf` and `modules/texts/ztext/aleppo/`.

Configs and data are extracted together beneath `$HOME/.sword`; CMake preloads
this tree into the browser filesystem. The installer verifies that existing
module files retain their hashes. Native lookups must pass before generating
the Greek addbooks cache and building WASM. Installation/build errors are fatal.

### Distribution notices

[Aleppo](https://crosswire.org/sword/modules/ModInfo.jsp?modName=Aleppo) declares
Public Domain. [HunRUF](https://crosswire.org/sword/modules/ModInfo.jsp?modName=HunRUF)
declares "Copyrighted; Permission to distribute granted to CrossWire" and names
the Hungarian Bible Society as copyright holder. Its full config, copyright
notice and support link are preserved. Fetching from CrossWire does not establish
permission for independent redistribution: confirm permission with the rights
holder before publicly hosting a generated payload/image containing HunRUF.
The contribution contains download code, not module archives.

Run installer validation with `python3 docker/cli/web/test-install-modules.py`.

## Browser acceptance

Use the terminal UI on a fresh load:

```text
help
lookup HunRUF Matthew 1:1
lookup HunRUF Psalms 47:10
lookup LXX Psalms 46:10
lookup Aleppo Isaiah 11:1
lookup Aleppo Psalms 119:176
lookup Aleppo Exodus 12:46
lookup Aleppo Zechariah 12:10
lookup LXX Genesis 1:1
lookup SBLGNT Matthew 1:23
lookup StatResGNT Matthew 1:23
lookup KJV Matthew 12:18
lookup1 LXX Genesis 1:1
lookup2 LXX Genesis 1:1
jaccard12
tokens StatResGNT John 7:38
search LXX 4215 5204 2
diagram svg
```

`help` must enumerate all six editions. Inspect Hebrew right-to-left text and
its punctuation alongside the prompt. HunRUF and LXX Psalm numbering differs.
Equal Greek clipboards should have Jaccard distance zero. Token/search commands
should return results. Set `diagram svg`, then
paste the complete Statement in `statements/StatResGNT/John/John-1,23+6.brst` as
one command with line breaks replaced by spaces; check that an SVG is displayed.
Check tab completion and an underscored book name such as `I_Corinthians`.
Record `bibref.data` size and cold page load time, including machine/browser and
network conditions. The first load also fetches terminal assets from cdnjs.

For automated Chromium acceptance (from the repository root, with the web
container running), install Playwright outside the checkout:

```sh
npm install --prefix /tmp/bibref-browser-check playwright
/tmp/bibref-browser-check/node_modules/.bin/playwright install chromium
NODE_PATH=/tmp/bibref-browser-check/node_modules node docker/cli/web/check-browser.cjs
```

The script exits nonzero on failed checks, browser errors or missing SVG. It
writes JSON results and Hebrew/Statement screenshots to a temporary directory
printed in the summary. Inspect the screenshots for Hebrew ordering and
punctuation; text assertions alone cannot verify visual rendering. Optionally
set `BIBREF_WEB_URL` to test another instance.

### Verified 2026-10-13

The Ubuntu 24.04 arm64 Docker build completed with Emscripten 4.0.3 and Graphviz
14.1.1. All six native lookup smoke checks and the five installer validation
tests passed. Chromium 156 passed every browser check above, including an
underscored book, actual Tab completion, token search and pasted Statement/SVG.
Hebrew verse ordering/punctuation and the SVG were also inspected visually.
No page errors occurred.

`bibref.data`: 27,803,603 bytes; `bibref.js`: 3,000,943 bytes (embedded WASM).
A fresh local Chromium context reached terminal readiness in about 2.1 seconds
on an Apple Silicon Mac, with Docker Desktop serving nginx on localhost and
terminal dependencies fetched from cdnjs. This is a local measurement, not a
public-hosting performance estimate. The bundled LXX 3.2 Statement example
retained its declared character positions and rendered successfully.
