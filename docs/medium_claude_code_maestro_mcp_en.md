# Medium article — copy/paste ready

> **How to use this file:** everything between `▼ ARTICLE STARTS` and `▲ ARTICLE ENDS` is the article body — select it, paste it into the Medium editor, then upload the images and embed the gists at the marked slots. The metadata block below goes into Medium's own fields. The checklist at the very bottom is for you, not for readers.
>
> **⚠️ Two formatting rules this file obeys on purpose — don't "tidy" them:**
>
> 1. **Every paragraph and bullet is on ONE long line.** Medium keeps a single newline as a hard line break inside the paragraph, so a source file wrapped at 90 characters pastes in with ragged breaks mid-sentence. Long lines look wrong in an editor and correct in Medium. Turn on soft word wrap instead of re-wrapping the text.
> 2. **There are no markdown tables.** Medium has no table support at all — a pasted table collapses into one run-on paragraph. Row-like content is a bullet list; the one genuinely tabular block (the screen map) is a fixed-width ASCII table inside a code block, which Medium preserves in monospace.
>
> What *does* survive a paste: headings, bold, italics, inline `code`, fenced code blocks, bullet and numbered lists, blockquotes, links, and a bare URL on its own line (becomes an embed).
>
> **Title:** Autonomous Flutter UI Testing: Claude Code + Maestro MCP on a Real, Live App
> **Subtitle:** No hand-written selectors. The agent drove an iOS simulator, read the real view hierarchy, and produced 8 Maestro flows that pass in 218 seconds — plus an honest list of what it couldn't reach.
> **Tags (Medium allows 5):** `Flutter` · `Artificial Intelligence` · `Software Testing` · `MCP` · `Mobile App Development`
> **Cover image:** `docs/assets/cover_1500x750.png` (source: `cover.html`, re-render with `./docs/assets/render_figures.sh`).
> **Companion video:** <https://youtu.be/8xSukTDwe8A> — pasted bare on its own line inside the article so Medium turns it into an embed.
> **Gists to create first:** `docs/gists/1_bootstrap.yaml`, `docs/gists/2_suite_and_favorite_flow.yaml`, `docs/gists/3_run.sh` → paste each into gist.github.com, then replace the three `GIST_URL_n` placeholders in the body.

---

# ▼ ARTICLE STARTS

---

## TL;DR

I connected [Maestro](https://maestro.dev)'s MCP server to [Claude Code](https://claude.com/claude-code), gave it a 624-line instruction manual, and let it loose on a Flutter app that's live on both app stores. It explored the app on an iOS simulator by itself and wrote the E2E suite.

* **Generated** — 8 smoke flows + 5 reusable sub-flows, 444 lines of YAML
* **Result** — one run, **218 seconds, 0 failures**, against live Firestore
* **Source changes** — **zero lines under `lib/`**, and that was a hard rule
* **Best find** — 7 accessibility ids in my own app that don't exist on the device

Three things worth your time even if you never touch Maestro:

* **Flutter's `Key()` is invisible to UI automation.** Only `Semantics(identifier:)` becomes a native accessibility id. My "instrumented" home screen was opaque.
* **Giving an agent tools ≠ giving it judgement.** The rules that mattered were all *prohibitions*.
* **The shift isn't that AI writes tests. It's that it can now check its own work** against a running device instead of guessing from source.

---

## The app

**Hatayı Yaşat** ("Keep Hatay Alive") — open-source Flutter app for Hatay, the Turkish province hit hardest by the February 2023 earthquakes. Thousands of local businesses were destroyed or relocated into container marketplaces; the app exists so people can find them again, and so the city's visual memory doesn't disappear with its buildings.

Place directory · maps & directions · community feed (news / events / jobs) · a shared before-and-after photo gallery · favourites · TR/EN · Material 3 light + dark.

Flutter 3.7+, **Riverpod v3** (`@riverpod` codegen, no Freezed), `go_router` typed routes, `get_it`, and a **live Firestore backend** — that last one shapes every testing decision below.

[Google Play](https://play.google.com/store/apps/details?id=com.hatayiyasat.app&hl=tr) · [App Store](https://apps.apple.com/us/app/hatay%C4%B1-ya%C5%9Fat/id6465691080) · [GitHub](https://github.com/VB-CORE/life_client) (MIT, v8.1.0) · [Instagram](https://www.instagram.com/hatayiyasat/)

> **🖼️ IMAGE 1 — the app itself.** Upload `docs/assets/figure1_app_1600x1120.png`.
> *Caption: "The place directory, a place detail, and the shared memories gallery. All three frames were captured by the agent, not by me."*

---

## The problem: zero UI tests

Four bottom tabs. A directory backed by live Firestore. A community feed with three sub-tabs. A memories gallery with a first-visit dialog. An onboarding flow, a version-gated "What's New" sheet, and a FAB speed dial with three forms that write to production.

And **zero end-to-end tests** — not because nobody cared, but because writing them is a grind that never gets prioritised: tap around, write a selector, it breaks, discover the button has no accessible id, add one, rebuild, retry. Multiply by forty screens.

So instead of writing the tests, I wrote **the thing that writes the tests**, and got out of its way. The whole session is on video — in Turkish, but the terminal and the simulator carry it:

https://youtu.be/8xSukTDwe8A

---

## Piece 1: Maestro over MCP

Maestro flows are plain YAML. No compilation, no page-object ceremony:

```yaml
appId: com.hatayiyasat.app
---
- launchApp
- tapOn: "Mekanlar"
- assertVisible: "İşletme Açıklaması"
```

Great format — but you still had to *write* it, which means knowing what's on screen first.

Then Maestro shipped an **MCP server**. [MCP](https://modelcontextprotocol.io) is the standard that lets an agent call real tools instead of hallucinating about them. Connected, the agent gets a physical toolbox:

```
list_devices · start_device · launch_app · stop_app
inspect_view_hierarchy · take_screenshot
tap_on · input_text · back
run_flow · run_flow_files · check_flow_syntax
cheat_sheet · query_docs
```

Three of those change everything:

* **`inspect_view_hierarchy`** — reads what's *actually rendered*, real ids and real labels, not source-code guesses.
* **`take_screenshot`** — the agent sees the result of its own action.
* **`run_flow`** — it verifies the YAML it just wrote, immediately, on a live device.

The agent stops being a code generator and becomes something closer to a QA engineer holding the phone. Wiring it up is nine lines at the repo root:

```json
// .mcp.json
{
  "mcpServers": {
    "maestro": { "command": "maestro", "args": ["mcp"], "env": {} }
  }
}
```

Restart Claude Code and the tools are live.

> **🖼️ IMAGE 2 — the connection.** Screenshot of `.mcp.json` next to `claude mcp list` output showing `maestro: connected`.

---

## Piece 2: the skill, because tools aren't judgement

With just the MCP connected and a prompt like *"write me some UI tests"*, the agent does exactly what you'd fear. It reads the source, sees `Key('homeSearchField')`, writes `tapOn: { id: "homeSearchField" }`, gets a failure — and starts **improvising**: retrying blindly, tapping coordinates, loosening assertions until something goes green. You get a suite that passes and proves nothing.

A [**Claude Code skill**](https://docs.claude.com/en/docs/claude-code/skills) is a folder of markdown loaded into context when a matching task shows up. Not code — an operating manual:

```
.claude/skills/hata-maestro-auto/
├── SKILL.md                        188 lines — 4-phase protocol + 10 hard rules
└── references/
    ├── screen-map.md                64 lines — 25+ screens: route, path, anchor, gaps
    ├── selectors.md                121 lines — live Semantics ids vs. text anchors
    ├── flow-templates.md           189 lines — bootstrap / goto-* / smoke starters
    └── key-injection.md             62 lines — what to do when a control has no selector
```

624 lines of instructions to produce 444 lines of tests. That ratio looks absurd until you notice the instructions are reusable and the tests are disposable.

### The rules that changed the output

1. **Never write a selector you haven't inspected.** Re-inspect after *every* navigation — a stale tree produces confident, wrong selectors.
2. **Never touch `lib/`.** If a control can't be selected, write it down and ask. The most important rule in the file; there's a whole section on why below.
3. **Never assert on live data.** Static labels or structural facts only — place names and news items come from Firestore and change hourly.
4. **Never assert on version-dependent text.** `Yenilikler v8.1.0 🎉` dies at the next release. Catch that sheet with `id: whatsNewSheet` instead.
5. **Maestro YAML text matching is exact regex.** `"Mekanlar"` won't match `"Mekanlar!"`. Meanwhile the MCP `tap_on` tool is *fuzzy* by default — so a tap that works interactively can fail inside the flow.
6. **iOS tab labels are multiline *and* localised.** Tab 4 reads `"Sekme 4 / 4\nFavoriler"` — position first, label second, both translated. The English mental model (`"Favorites\nTab 4 of 4"`) is wrong twice over.
7. **On failure, STOP.** Screenshot, report the failing step and the screen state, then wait. *A stuck screen is itself a finding.* This is the rule that separates a test suite from a green-checkmark generator.
8. **Flutter `Key` is not an accessibility id.** This one deserves its own section. ↓

---

## The finding that justified the whole exercise

`references/selectors.md` has a column that reads "is it live?" — and seven entries marked **no**:

```
homeView · homeScrollView · homeSliverAppBar · homeSearchFilterRow ·
homeSearchField · homeFilterButton · homeCategoriesSection
```

The project has a proper id registry: a `GeneralSemanticKeys` enum plus a `GeneralSemantic` wrapper. All seven names are *defined* in that enum. Someone did the work. But in `home_view.dart` they're wired with Flutter's `Key(...)` instead of the wrapper:

```dart
// invisible to Maestro, and to VoiceOver
TextField(key: const Key('homeSearchField'), …)

// produces a real native id
GeneralSemantic(semanticKey: GeneralSemanticKeys.homeTab, child: …)
```

> `Semantics(identifier: 'foo')` compiles to `accessibilityIdentifier` on iOS and `resource-id` on Android — what Maestro matches with `id: "foo"`. `Key` / `ValueKey` produces **no native id at all**. It exists for widget tests.

So the home screen *looked* fully instrumented in code review and was completely opaque to any external automation tool. The agent found it in minutes — not by reading code, but by comparing the enum against the live tree and noticing the enum was lying.

> **🖼️ IMAGE 3 — the proof.** Upload `docs/assets/figure3_key_vs_semantics_1600x610.png`.
> *Caption: "Same enum, wired two ways. The search field arrives on the device with no `resource-id`. The tab next to it arrives with one. Same tree, same run."*

---

## Three more things it found just by looking

**A dialog nobody remembered.** The Memories tab opens a one-time info dialog on first visit — `SharedCache.isFirstHistoryPageVisit`, post-frame, `barrierDismissible: false`. I wrote that code and had completely forgotten it: on my device it fired once, in 2024. The agent hit it on the first `clearState` run and the flow died — with a non-dismissible modal up, **every control underneath disappears from the accessibility tree**, so even "is the Memories tab selected?" fails. It now has an explicit guard, and flow 05 asserts the dialog on purpose.

**`back` doesn't always mean back on iOS.** The photo viewer is a full-screen modal route. Maestro's `back` — a left-edge swipe — doesn't close it; you have to tap the X. Worth knowing before you sprinkle `back` through a suite.

**My own reference doc was lying.** I'd hand-written the community sub-tab order as *News / Jobs / Events*. On the device it's *News / **Events** / Jobs*. I got my own app's tab order wrong in the document I wrote to make the agent accurate — and the only reason it didn't matter is that rule #1 forbids trusting exactly that kind of note. Static docs drift; the running device doesn't.

---

## How the run actually works

### Phase 0 — prove the ground is solid

Check the MCP responds, boot a simulator, and make sure the installed binary is current:

```bash
flutter build ios --simulator --debug
xcrun simctl install Booted build/ios/iphonesimulator/Runner.app
```

If the install is stale, `launch_app` silently opens the old binary and you spend an hour debugging selectors that were fixed yesterday.

Then the gate: **`bootstrap.yaml` green twice in a row** before writing anything else. If the entry point isn't boringly repeatable, every flow inherits the flakiness. (Mine passed this gate and *still* had a race in it — below.)

### Phase 1 — autonomous exploration

One action at a time, always from the live tree. Never batched from memory:

```
inspect → pick exactly ONE next action from what's ACTUALLY on screen
        → tap / type / swipe / back
        → screenshot to maestro/reports/explore-<area>/NN-<label>.png
        → inspect again
```

The target list: four bottom tabs, home category chips and search delegate, filter screen, a place detail, community sub-tabs, AppBar overflow, the FAB speed dial (**open the forms, go back, never submit** — that's a live Firestore write), settings.

Output is a regenerated `screen-map.md`. Per screen: entry route, path from home, a durable anchor, which sub-flow to reuse, and a **needs-id** column. A slice of it:

```
SCREEN          ROUTE                    FROM HOME          ANCHOR                NEEDS-ID?
──────────────  ───────────────────────  ─────────────────  ────────────────────  ─────────────────────────────
Main shell      /main                    —                  id: mainTabView       —
Home            tab 0                    id: homeTab        "Mekanlar"            search field, filter button,
                                                                                  category strip — Key(), NOT LIVE
Filter          /main/filter             filter btn (icon)  "İlçeler"             icon-only + no id → point:
Place detail    /main/placeDetail/:id    tap a card         "İşletme Açıklaması"  card ids dynamic, grid only
Community       tab 1                    id: communityTab   "Haberler"            sub-tabs have no ids
Business form   /main/placeRequestForm   FAB → menu         "Yeni İşletme Talebi" FAB icon-only · NEVER SUBMIT
```

### Phase 2 — write the suite

Five reusable sub-flows (one `bootstrap` + a `goto_*` per tab), then eight smoke flows on top. `bootstrap.yaml` is the spine — and the comment in it is scar tissue from a bug two sections down:

```yaml
- launchApp: { clearState: true }

# The splash screen is TRANSIENT; waiting for it to *appear* is a race.
# Anchor on the first DURABLE state after it — with clearState, onboarding is guaranteed.
- extendedWaitUntil: { visible: { id: "onboardButton" }, timeout: 90000 }
- tapOn: { id: "onboardButton" }
…
```

> **📎 GIST 1 — `bootstrap.yaml` in full.** Embed `GIST_URL_1`.

The eight smoke flows and what each one locks down:

* **`01_app_launch`** — cold start: splash → onboarding → what's-new → the four-tab shell.
* **`02_home_tab`** — home: place list loaded, search field present, no empty-state.
* **`03_home_place_detail`** — detail: Call / Directions buttons, tab bar hidden, back works.
* **`04_community_tab`** — the News / Events / Jobs sub-tab strip.
* **`05_memories_tab`** — first-visit dialog, photo grid, favourite-memories sheet.
* **`06_favorite_tab`** — favourites empty state.
* **`07_favorite_add_and_list`** — **end-to-end:** favourite from a detail screen → see it in the list → clear all.
* **`08_tab_bar_navigation`** — full tab tour plus the "exactly one tab selected" invariant.

The design decision worth stealing: **every flow starts from `bootstrap` with `clearState`.** Tests are fully isolated — the favourite flow 07 adds can't leak into flow 06's empty-state assertion. Costs a few seconds each, buys a red result you can trust.

> **📎 GIST 2 — the suite + flow 07, the one I'd show a skeptic.** Embed `GIST_URL_2`.
> Add → verify → **clean up after itself**. That last part is what most generated suites forget.

Here's flow 07 actually running — no human touching the device. Open a place from the directory, favourite it, go back (the card's heart is red now), switch to the Favourites tab, find it there, then clear the list and land back on the empty state:

> **🎞️ GIF — flow 07 on a live device.** Upload `docs/assets/flow07_favorite.gif`.
> *Caption: "Flow 07 in 19 seconds: favourite a place, verify it in the Favourites tab, clean up after itself. Every tap here is an assertion that has to hold."*

### Phase 3 — report the gaps, don't fix them

When a control has no stable selector: prove the gap live, locate the widget in `lib/`, **write it down, stop**, and ask the user once. Only on an explicit yes does the id actually get added. So the generated YAML ships comments like this on purpose:

```yaml
# NEEDS-ID: the heart FAB has no id, tapped by position (endDocked, bottom-right).
# If `GeneralSemanticKeys.memoryFavoriteButton` is added, replace this with `id:`.
- tapOn:
    point: "89%,75%"
```

This is the design choice I'd defend hardest. **An agent that can edit your app to make its own tests pass has a conflict of interest.** The moment "the test is red" and "I can change the app" are both true, the cheapest path to green stops going through *correctness*. Cutting that path means every red result is information — and the diff stays reviewable.

---

## The two parts where it broke

Neither bug was in the app. Both are the kind you only find by running the thing on a device.

### Bug one: the screenshots went somewhere else

First full-suite run, actual JUnit:

```xml
<testcase id="smoke_test_auto" status="ERROR" time="19.0">
  <failure>Unknown error</failure>
</testcase>
```

Two minutes later, a single flow: `status="SUCCESS"`. Individual green, combined red.

The cause: flows wrote screenshots to `"../../reports/smoke/…"`, relative to the flow file. **Maestro resolves `takeScreenshot` paths against the project root.** Twelve paths across eight files, plus a runner that didn't guarantee its working directory:

```bash
# takeScreenshot paths resolve against the PROJECT ROOT ("maestro/reports/smoke/…"),
# so maestro is always invoked from the project root.
cd "$PROJECT_DIR"
```

The honest version of "AI wrote my tests" includes the twenty minutes of path debugging. The agent produced a suite that was structurally correct and environmentally wrong — exactly the failure mode to expect and plan for.

### Bug two: waiting for a screen that's already gone

This one was mine, and it's more interesting because it *passed* for a while first:

```yaml
- extendedWaitUntil: { visible:    { id: "splashView" }, timeout: 30000 }
- extendedWaitUntil: { notVisible: { id: "splashView" }, timeout: 60000 }
```

Read it out loud and it sounds careful. Then, mid-suite, flow 02 died on the first line:

```
Assertion 'id: splashView is visible' failed.
```

The splash had come and gone faster than Maestro's first poll. **Waiting for a transient screen to appear is a race by construction** — the faster the app gets, the more often you lose. And because it only loses *sometimes*, it reads as flaky infrastructure rather than a wrong test.

The same reasoning killed the two `when:` guards that used to wrap onboarding and the what's-new sheet. `when: visible:` reads as robustness but it's a **snapshot, not a wait** — if the state hasn't rendered yet, the guard silently skips and the flow marches into a screen it doesn't understand. With `clearState` both sheets are certainties, so asserting them outright is simpler *and* stricter: if either stops appearing, I want a red line, not a shrug.

---

## The result

```xml
<testsuite device="iPhone 17 - iOS 26.4" tests="1" failures="0" time="218.0">
  <testcase id="smoke_test_auto" status="SUCCESS" time="218.0"/>
</testsuite>
```

Eight flows chained into one run, 218 seconds, against live Firestore. Thirteen screenshots, none of them taken by a human:

> **🖼️ IMAGE 4 — the contact sheet.** Upload `docs/assets/figure4_contactsheet_1600x1030.png`.
> *Caption: "One run, 218 seconds, thirteen frames. A storyboard of an app being exercised end to end by something that had never seen it before."*

Maestro will also record the whole thing as video, which is the fastest way to show someone what "the agent drove the app" actually means — terminal steps going green on the left, the app being driven on the right:

```bash
maestro record --local maestro/flows/smoke_test_auto.yaml smoke_test_auto.mp4
```

One warning worth passing on: `record` re-runs the flow and records *whatever happens*, including a failure. My first recording was a tidy 19 seconds and I nearly shipped it — until I noticed 19 seconds was exactly how long the suite survived before the screenshot-path bug killed it. A short video isn't a compact video; it's a dead run. Check the duration against your JUnit time before you publish it anywhere.

---

## Steal this for your own app

```bash
# 1) Maestro
curl -fsSL "https://get.maestro.mobile.dev" | bash

# 2) MCP definition at the repo root
cat > .mcp.json <<'JSON'
{ "mcpServers": { "maestro": { "command": "maestro", "args": ["mcp"], "env": {} } } }
JSON

# 3) the skill
npx degit VB-CORE/life_client/.claude/skills/hata-maestro-auto#release/v2/1.0.0_1 \
  .claude/skills/hata-maestro-auto

# 4) restart Claude Code, then verify
claude mcp list
```

One script wraps boot → build → install → run → JUnit report, and the output drops straight into CI:

```bash
./maestro/run.sh                # smoke_test_auto — every flow in one run
./maestro/run.sh --build        # build + install first
./maestro/run.sh smoke          # the smoke/ flows one by one
./maestro/run.sh flows/smoke/01_app_launch.yaml   # a single flow
```

> **📎 GIST 3 — `run.sh` in full.** Embed `GIST_URL_3`.

The folder contract the skill maintains — flows that stay green get **promoted** from `smoke/` to `regression/`, and the regression set only ever grows:

```
maestro/
├── flows/
│   ├── core/         bootstrap + goto_* sub-flows
│   ├── smoke/        [smoke]       the critical path — always green
│   ├── regression/   [regression]  promoted, stable — only grows
│   └── bugs/         [bug]         reproductions, kept until fixed
├── reports/          screenshots, JUnit, run notes
└── run.sh
```

**Three things to change:** the `appId`, the text anchors (mine are Turkish, pulled from `assets/translations/tr.json`), and the path to your accessibility-id registry. The phases, the rules and the folder contract transfer as is.

**Repo:** [the skill](https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto) · [`SKILL.md`](https://github.com/VB-CORE/life_client/blob/release/v2/1.0.0_1/.claude/skills/hata-maestro-auto/SKILL.md) · [the flows](https://github.com/VB-CORE/life_client/tree/release/v2/1.0.0_1/maestro)

### The MCP servers in my setup

Only the first was needed here, but for the curious:

* [**Maestro**](https://docs.maestro.dev) — drives the device: inspect, tap, screenshot, run flows.
* **codebase-memory-mcp** — code knowledge graph: call chains, impact analysis.
* [**claude-mem**](https://github.com/thedotmack/claude-mem) — persistent memory across sessions.
* **Figma** — design → code.

---

## What's next

The suite covers the critical path. Next, in order: **close the needs-id list** — three coordinate taps today, plus roughly ten more controls with no selector at all (the filter button, the AppBar icons, the ⋮ menu, the FAB dial). Then **home search and filter**, the two highest-traffic interactions in the app and still uncovered. Then **the three request forms**: fill them, assert validation, go back without submitting — which really needs a separate Firebase test project. Then **settings**, because switching TR → EN invalidates every text anchor in the suite, which is exactly why it's worth testing. Then **CI + Android**, where `resource-id` is the other side of the same `Semantics(identifier:)` coin.

The pattern I'd suggest: cover the critical path first with hard, data-independent assertions, then expand into the surfaces where regressions actually cost you — and let the needs-id list drive your accessibility work as a side effect. **Better test selectors and better VoiceOver support are literally the same task.**

---

## Takeaways

Beyond the eight rules above, the things that cost me real time:

* **iOS merges sibling text into one accessibility node.** A place detail's whole description block arrives as a single node, so `assertVisible: "İşletme Açıklaması"` finds nothing — you need `'[\s\S]*İşletme Açıklaması[\s\S]*'`.
* **`selected:` is a selector, not just an attribute.** On a screen with literally no text — the Memories tab is a photo grid and two icon FABs — `assertVisible: { id: "memoriesTab", selected: true }` was the *only* assertion available. Bonus: it gives you the "exactly one tab selected" invariant for free.
* **`point:` percentages must be integers.** `"89%,13.4%"` throws `For input string: "13.4"` — reads like a Maestro bug, isn't.
* **Screenshot every state.** The exploration contact sheet turned out to be as useful as the tests.
* **Instructions are the reusable asset.** 624 lines of skill outlived the 444 lines of YAML it produced. The YAML is regenerable; the judgement isn't.

Plausible-looking YAML has been cheap for a while, and it's worth very little. What changed is that the agent could **check** — tap, look, re-read the tree, and find out it was wrong in seconds instead of at code review.

The other half is the constraint: the most valuable rules in that skill are all prohibitions. Tools made the agent capable; the rules made the output trustworthy. Ship either one without the other and you get a suite that's green and useless.

The generated tests will rot. The skill won't.

---

*If you build this for your own app, I'd genuinely like to know how many "needs-id" controls it finds. I expected two or three. I got more than ten — on a codebase I wrote myself.*

**Veli Bacık** · [GitHub](https://github.com/VB-CORE) · Hatayı Yaşat: [Play Store](https://play.google.com/store/apps/details?id=com.hatayiyasat.app&hl=tr) · [App Store](https://apps.apple.com/us/app/hatay%C4%B1-ya%C5%9Fat/id6465691080) · [Instagram](https://www.instagram.com/hatayiyasat/)

---

# ▲ ARTICLE ENDS

---

## Before you publish (delete this section)

**Paste order that works:**

1. Paste the body into a fresh Medium draft.
2. Check the four spots where a code block should be monospace — especially the **screen-map ASCII table**. If Medium turned it into a paragraph, select it and hit the code-block button; the alignment survives as long as it's monospace.
3. Upload the images at the 🖼️ markers and delete the marker paragraphs.
4. Paste each gist URL on its own line at the 📎 markers and delete those.
5. Confirm the two bare YouTube URLs turned into embeds.
6. Set the title, subtitle, tags and cover in Medium's own fields.

**Gists — do these first, the body has three placeholders:**

* [ ] `docs/gists/1_bootstrap.yaml` → gist → replace `GIST_URL_1`
* [ ] `docs/gists/2_suite_and_favorite_flow.yaml` → gist → replace `GIST_URL_2`
* [ ] `docs/gists/3_run.sh` → gist → replace `GIST_URL_3`

**Images:**

* [x] Cover: `docs/assets/cover_1500x750.png`
* [x] Image 1: `docs/assets/figure1_app_1600x1120.png`
* [x] Image 3: `docs/assets/figure3_key_vs_semantics_1600x610.png`
* [x] Image 4: `docs/assets/figure4_contactsheet_1600x1030.png`
* [x] GIF: `docs/assets/flow07_favorite.gif` — 540×1174, 18.8s, 4.0 MB (Medium's GIF limit is 25 MB). Rebuild: `./docs/assets/make_gif.sh maestro/flows/smoke/07_favorite_add_and_list.yaml flow07_favorite 34 19 540 12`
* [ ] **Image 2** — `.mcp.json` next to `claude mcp list`. Optional; has to come off your screen.
* [ ] Scrub every screenshot for user data, API keys and real Firestore content.

**Video (not embedded in the article, but you'll want it for social):**

* `maestro/reports/smoke_test_auto.mp4` — the full run, **225s**, 1920×1080, 329 MB.
* `maestro/reports/smoke_test_auto_720p.mp4` — same run at 1280×720, **11 MB**. Use this one anywhere you actually have to upload.
* Both are gitignored (`maestro/.gitignore` covers `reports`), so they won't bloat the repo.

> Rebuild all four generated figures with `./docs/assets/render_figures.sh` (single figure: `./docs/assets/render_figures.sh figure3`). Swap a frame by editing the `<img src>` in the matching `.html` and re-running.

**Repo links:**

* [ ] The four GitHub links point at `release/v2/1.0.0_1`, which does **not** contain the screenshot-path fix or the bootstrap fix described in this article. Either push those, or accept that the gists are the accurate version and the repo links are context.
* [ ] After merging to `main`, swap `release/v2/1.0.0_1` → `main` (4 links + the `degit` command).

**Polish:**

* [ ] Add your LinkedIn / X / Medium handles to the author line.
* [ ] Cross-post to dev.to and r/FlutterDev — the `Key` vs `Semantics` finding is the hook that travels.
