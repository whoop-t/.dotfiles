---
name: spanish-conjugation-listening
description: "Build Spanish verb-conjugation listening cards with Mexican-Spanish audio. Use when the user wants to study/practice verb conjugations across tenses and persons, or add verbs to the 'Spanish Verb Conjugation Listening' deck. Each verb produces 25 cards (5 tenses x 5 persons); front = an example sentence, back = the English translation, its tense + person, a faint verb gloss, and the audio."
user-invocable: true
---

# spanish-conjugation-listening

Build Anki cards for practicing Spanish verb conjugations: the front shows an example sentence; the back reveals the English translation, its tense + person, a faint verb gloss, and the audio (so you can read the sentence and identify the form, then hear it on the back).
This is a **separate deck and card type** from the `spanish-mined` skill (which makes sentence/vocab cards). If the user wants to learn a word's meaning in context, use `spanish-mined` instead. If a bare verb is ambiguous between the two, ask.

## When to use

Use whenever the user wants to study/practice conjugations, add verbs to the **Spanish Verb Conjugation Listening** deck, or work through verb forms across tenses/persons.
The user just names a verb (or a few); this skill knows the rest.

## What each verb produces (fixed - do not ask about the format)

**25 cards per verb = 5 tenses x 5 persons.**

- **Tenses**: `present`, `preterite`, `imperfect`, `conditional`, `informal future`. On the back, show each with its plain-English label: `present (simple present)`, `preterite (simple past)`, `imperfect (past habitual/ongoing)`, `conditional (would ...)`, `informal future (going to ...)`.
  - `informal future` is the **voy a + infinitive** form ONLY (e.g. _voy a hablar_). Do **not** use the simple future (_hablaré_).
- **Persons** (Mexican - never vosotros/vos): `yo`, `tú`, `él/ella/usted`, `nosotros`, `ellos/ellas/ustedes`.

## Card design (fixed)

The learner reads the sentence on the front, identifies the tense, person, and meaning, then flips to check the answer and hear the audio.

- **Front:** the example sentence (plain text, no audio), with the **focused conjugated form in bold + italic** so it's clear which word the card is about. The script does this automatically (it finds `{form}` in `{sentence}` and wraps it), so you just supply the plain sentence.

  ```
  ... <b><i>{form}</i></b> ...
  ```

- **Back:** the English translation (plain), then the tense (with English label) + person (slightly small), then a faint verb gloss, then the audio. There is **no** bold conjugated-form line and **no** separate faint translation line - the translation _is_ the top line.

  ```
  {translation}<br><span style="font-size:0.9em">{tense label}, {person}</span><br><span style="color:#777;font-size:0.8em">{gloss}</span><br>[sound:{file}]
  ```

  - For `informal future`, the sentence uses the _voy a {infinitive}_ phrase (e.g. `voy a hablar`); the translation reflects it (e.g. "going to ...").
  - `{gloss}` is `{infinitive} · {English meaning}` (e.g. `hablar · to speak`).
  - The `add_conjugation_card_11labs.py` script assembles this front/back HTML from the JSON fields, so you only supply the raw fields (see below).

## Writing the example sentences (natural but EASY)

The conjugation is the hard part - everything around it must be simple, so the target form stays front-and-center.

- **Natural, everyday Mexican Spanish** - something a real person would actually say, not textbook filler. Common words, natural word order.
- **But easy.** Short sentences. The context must never be harder than the form being drilled. Keep any other verbs in simple, common forms. Avoid tricky idioms or extra hard vocab that competes with the target.
- **tú / ustedes only** - never vosotros or vos.
- **No "as a child / de niño" framing for the imperfect.** Use other ongoing/habitual contexts (e.g. _Hablaba por teléfono cuando llegaste._).
- **Ambiguous subjects:** for third-person and nosotros forms that could map to more than one English subject, use a slashed gloss (e.g. "He/She would...") unless the sentence makes the subject explicit.

## Grammar note

There is no separate grammar-note field on these cards - the back already shows the English translation, the tense + person, and the faint verb gloss (`{infinitive} · {English meaning}`). That's all that's needed. (The conjugated form is not repeated as a separate line on the back; the learner reads it in the front sentence and hears it in the back audio.)

## Show for approval before adding

Before adding a verb, show its 25 lines in the chat - grouped by tense, each line showing the **form**, the **example sentence**, and the **English translation** - and get approval. Revise and re-show if the user wants changes.

- Default: approve verb by verb.
- Only skip printing if the user explicitly says so (e.g. "just generate them"); then write the JSON, run the script, and report the summary.

Approval is about the text. Once approved, collect a verb's 25 cards into one JSON file and run the script **once** on the full set.

## Adding the cards (the script)

The script lives at `~/Documents/spanish/add_conjugation_card_11labs.py`. It builds the front/back HTML, generates ElevenLabs audio for each example sentence, embeds it in Anki, backs it up, and adds each note.

1. Write the cards to a JSON file as a list of objects. Fields per card:
   `verb`, `gloss`, `tense`, `person`, `form`, `sentence`, `translation`, `audio`.

   ```json
   [
     {
       "verb": "hablar",
       "gloss": "hablar · to speak",
       "tense": "preterite",
       "person": "yo",
       "form": "hablé",
       "sentence": "Ayer hablé con mi jefe por teléfono.",
       "translation": "Yesterday I spoke with my boss on the phone.",
       "audio": "hablar_preterite_yo.mp3"
     }
   ]
   ```

   Audio filenames: `{verb}_{tense}_{person}.mp3` using a person slug (`yo`, `tu`, `el`, `nosotros`, `ellos`), so backups are recognizable.

2. Run the script (Anki must be open). The deck name is a required argument:

   ```
   python3 ~/Documents/spanish/add_conjugation_card_11labs.py <cards.json> "Spanish Verb Conjugation Listening"
   ```

## Audio (ElevenLabs)

- Provider: **ElevenLabs** (chosen for naturalness). Voice id `p1Q3ihQuPjyyENa1RGtl`, model `eleven_multilingual_v2`. Both are set in the script.
- API key is read from `~/.elevenlabs-api-key` (or `$ELEVENLABS_API_KEY`). **Never hardcode or print the key.**
- Audio backups go to `~/Documents/spanish/audio_11labs/` - kept separate from the mined deck's `audio/` dir (used by the `spanish-mined` skill).

## The deck

- Deck name: **`Spanish Verb Conjugation Listening`** (the script creates it if missing).
- All cards are tagged `conjugation-listening`.

## Tracker

The deck has its own checklist section, **"Spanish Verb Conjugation Listening deck"**, in `~/Documents/spanish/CARDS_TRACKER.md`, listing the target verbs.

- Only build the verbs the user asks for (one at a time, or small batches). Don't build the whole list unprompted.
- After a verb's 25 cards are successfully added, **check it off** in the tracker (`- [x]`).
- If the user wants a new verb not on the list, add it (checked) when done.

## Scope safety (important)

- Only ever **add** to the `Spanish Verb Conjugation Listening` deck. Never touch the `Spanish Mined from Lessons/Videos` deck or others.
- **Never run broad file deletes** (e.g. `rm .../audio/verb_*.mp3`). A wide glob can clobber unrelated audio backups. If cleanup is ever needed, list exact files and confirm first.

## Requirements

- **Anki open** with the **AnkiConnect** add-on (code 2055492159), reachable at http://127.0.0.1:8765.
- An ElevenLabs API key saved at `~/.elevenlabs-api-key`.
- Python 3 (the script uses only the standard library for HTTP).
