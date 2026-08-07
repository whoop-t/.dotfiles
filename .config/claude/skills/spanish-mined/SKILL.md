---
name: spanish-mined
description: "Create Mexican-Spanish Anki flashcards for a vocabulary word or phrase to learn in context (the 'Spanish Mined from Lessons/Videos' deck). Use whenever the user names a Spanish or English word/phrase they want to study, asks for Spanish cards, or wants example sentences added to Anki. Generates 3 example sentences for the term and adds each as its own card with audio. (For drilling verb conjugations, use spanish-conjugation-listening instead.)"
user-invocable: true
---

# spanish-mined

Turn a Spanish vocabulary word or phrase into Anki flashcards that teach it in context, with Mexican-Spanish audio.
The user just names a term to learn; this skill knows the rest, so they never have to re-explain the format.
(Verb-conjugation practice lives in the separate `spanish-conjugation-listening` skill - see the verb note below.)

## When to use

Use this whenever the user names a vocabulary word or phrase they want to learn, asks for Spanish cards, or wants sentences added to Anki. (If they name a verb to drill, see the verb note below - that usually belongs in `spanish-conjugation-listening`.)

## Curate the list first (when given multiple words)

When the user provides a **list** of words/phrases (e.g. pasted lesson or video notes), do not assume they want cards for all of them.
First, go through the list **with the user to decide which terms they actually want to keep**. This is a separate step from approving card text later.

- Present the extracted terms and ask the user to confirm which ones to make cards for - offer to go through them one by one if that's easier.
- Drop the ones they don't want; keep only the confirmed terms.
- Then continue with the tracker check and card generation for the kept terms only.
- A single word (not a list) doesn't need this curation step - but still run the tracker check below before making its cards.

## Check the tracker first (avoid duplicates)

Before generating any cards, check each requested term against the tracker file at `~/Documents/spanish/CARDS_TRACKER.md`.
It lists every term that already has cards, grouped by deck.

- If a term is already in the tracker, do **not** silently make a duplicate. Tell the user it already has cards (and in which deck), and ask whether to skip it or make cards anyway.
- Only generate cards for terms that are new (or that the user explicitly wants remade).
- After cards are successfully added, **update the tracker**: add each new term under the matching deck's section (create the section if the deck is new).

## Card design (fixed - do not ask about the format)

For each term given:

- Produce exactly **3 example sentences**, each used in a different everyday context.
- Each sentence becomes **its own Anki card**, so one term produces 3 cards.
- **Front:** the Spanish sentence, with audio. The target word/phrase is shown **bold + italic** within the sentence so it's clear which word the card teaches (done automatically via the `focus` field - see "Adding the cards").
- **Back:** the English translation, plus a short grammar note describing the target word (see "Grammar note" below). No audio on the back.

## Generating the sentences (Claude does this directly)

Content is written by Claude in the chat. Do NOT call any API to generate the sentence text - Claude writes it directly. (The `add_card.py` script separately calls ElevenLabs for the audio.)

This deck is for **vocabulary and phrases** mined from lessons/videos - nouns, adjectives, adverbs, expressions, connectors, and multi-word phrases. The user gives a term; write **3 example sentences** using it in 3 different everyday contexts.

- **Words** (nouns, adjectives, etc.) - use the term naturally in 3 different situations.
- **Phrases / constructions** (e.g. _vale la pena_, _tener chance de_, _ya no_, _desde hace + [tiempo]_) - show the phrase working naturally in 3 different situations; keep the rest of each sentence simple.

**If the term is a verb, ASK before making cards here.** Verbs generally belong in the separate **`spanish-conjugation-listening`** skill/deck, not this one. When the user names a verb (or a mined list contains verbs), point that out and ask whether they want it in the conjugation-listening deck instead. Only make a mined vocab card for a verb if the user explicitly says they want it here (e.g. to learn its meaning in context rather than drill its forms).

## Grammar note (the `note` field)

Every card includes a `note` that describes the target word(s) - base form and grammatical form.
It renders on the back, under the translation. Bold each target with `<b>...</b>`.

- **Verbs:** `<b>{conjugated form}</b> · {infinitive} ({English meaning}) · {tense}, {person}`
  - **ALWAYS give the tense its plain-English name in parentheses right after the Spanish grammatical term** - never write the bare Spanish term alone. This applies to every tense, e.g.:
    - `present (simple present)`
    - `preterite (simple past)`
    - `imperfect (past habitual/ongoing)`
    - `conditional (would ...)`
    - `future (simple future)`
    - `informal future (going to ...)`
    - `present perfect (have/has ...)`
  - Example: `<b>fui</b> · ser (to be) · preterite (simple past), yo`
- **Nouns, adjectives, other:** `<b>{word as it appears}</b> · {part of speech}{, gender for nouns} · base: {base form}` (drop "base:" if identical to the word).
  - Example: `<b>la cocina</b> · noun, feminine`

**The note is flexible - it can describe more than one element.** When a card teaches a construction or a phrase with several notable pieces, describe each on its own line separated by `<br>`. Keep each line short.

**Always describe conjugated verbs, even when they are not the requested study word.** If a sentence contains any conjugated verb alongside the noun/verb/adjective/etc. that was asked for, give that verb its own note line with the full verb breakdown (conjugated form · infinitive (English meaning) · tense, person). Conjugated verbs are important to the learner regardless of whether they were the specified target - do not leave them untranslated. The requested study word still comes first; the extra conjugated verbs follow on their own `<br>` lines.

- Example (study word is the noun `la receta`, but the sentence also conjugates `seguir`):
  `<b>la receta</b> · noun, feminine - recipe<br><b>sigo</b> · seguir (to follow) · present, yo`

- Construction example (`Desde hace 6 años vivo aquí.`):
  `<b>desde hace + [tiempo]</b> · "for [time]" - how long something has been going on<br>Used with the <b>present</b> tense (vivo), not the past.`
- Multi-word example:
  `<b>propuse</b> · proponer (to propose) · preterite (simple past), yo<br><b>matrimonio</b> · noun, masculine - marriage`

## Generating the sentences guidelines

**Always:**

- **Sound like a real person, not a textbook.** Every sentence must be something an actual Mexican speaker would say in everyday life - the kind of phrasing you'd overhear in a kitchen, a store, or a text message. Avoid stiff, literal, or "textbook-correct but nobody-says-this" constructions. If a sentence reads like it was translated word-for-word from English, or like a grammar-drill example, rewrite it until it sounds natural. Favor common vocabulary, contractions, and everyday word order over formal or overly precise phrasing.
- Natural, everyday **Mexican Spanish**.
- Never use **vosotros** or **vos** (voseo) forms. Mexican Spanish uses _tú_ and _ustedes_. A request for "all forms" still **excludes** vosotros and vos - use only _yo, tú, él/ella/usted, nosotros, ellos/ellas/ustedes_. Only include vosotros or vos if the user names that form specifically.
- The context must never be harder than the word itself.
- Keep each sentence short and learner-appropriate. If the target is already a tricky conjugation, don't introduce another complicated verb form in the same sentence unless it's genuinely needed - keep any other verbs simple (present tense, common forms).
- Give an accurate, natural English translation for each.
- **Ambiguous subject pronouns:** When a conjugation could refer to more than one subject (e.g. third-person forms that are equally _he_, _she_, _you (usted)_, or _it_, or nosotros that could be _we (masc./fem.)_), reflect that ambiguity in the English translation rather than silently picking one. Use a slashed gloss such as "He/She plays outside" or "He/She/You (formal) already left" so the learner sees every subject the Spanish form allows. Only commit to a single pronoun when the sentence itself makes the subject explicit (a named subject, an explicit pronoun, or clear context).
- If anything is unspecified or unclear, ask rather than assume.

## Show for approval before adding

Show the user each card's text - the Spanish sentence, the English translation, and the grammar note - and get approval before adding anything. If they want changes, revise and show again.

- **Default: always approve one by one.** Show each term's cards and get approval before moving to the next, no matter how many cards there are. Never batch approval on your own initiative.
- **Only skip per-card approval if the user explicitly says so** (e.g. "just generate them all", "don't make me approve each one"). In that case, **do not print the cards at all** - printing them clogs the terminal and defeats the purpose of skipping. Just write the JSON, run the script (which generates the audio and adds the cards), and report the summary of what was added.

Approval is about reviewing the card **text** - it does not change how the script runs. Once the cards are approved, collect them all into one JSON file and run the script **a single time** on the full set. The script takes a JSON list and adds every card in one run; it is never run per card.

## Adding the cards (the script)

The script lives at `~/Documents/spanish/add_card.py` and does the mechanical part: ElevenLabs audio + AnkiConnect.

1. Write the 3 cards to a JSON file (e.g. in the scratchpad or /tmp) as a list of objects:

   ```json
   [
     {
       "spanish": "Voy a la cocina por un vaso de agua.",
       "english": "I'm going to the kitchen for a glass of water.",
       "note": "<b>la cocina</b> · noun, feminine",
       "focus": "cocina",
       "audio": "cocina_1.mp3"
     },
     {
       "spanish": "La cocina de mi abuela siempre huele a pan.",
       "english": "My grandma's kitchen always smells like bread.",
       "note": "<b>la cocina</b> · noun, feminine",
       "focus": "La cocina",
       "audio": "cocina_2.mp3"
     },
     {
       "spanish": "Necesito una cocina más grande para esta receta.",
       "english": "I need a bigger kitchen for this recipe.",
       "note": "<b>la cocina</b> · noun, feminine",
       "focus": "cocina",
       "audio": "cocina_3.mp3"
     }
   ]
   ```

   Fields per card: `spanish` (the sentence), `english` (the translation), `note` (the grammar note - see below), `focus` (the target word/phrase **exactly as it appears in that sentence** - the script bold+italics it on the front so it's clear which word the card teaches; the audio is generated from the plain sentence, so tags never reach the TTS), and `audio` (the mp3 filename).
   The `focus` is the surface form in the sentence, which may differ from the dictionary form in `note` (e.g. note `la cocina` but focus `cocina`; a plural/agreeing adjective; or the conjugated part of an expression like `tengo chance de`). Name the audio `<term>_1.mp3`, `<term>_2.mp3`, `<term>_3.mp3` using a slug of the term, so backups are recognizable.

2. Run the script (Anki must be open). **The deck name is a required argument** - it is never hardcoded:

   ```
   python3 ~/Documents/spanish/add_card.py <cards.json> "<Deck Name>"
   ```

   The script generates Mexican-Spanish audio for each sentence, embeds it, and adds each card to the deck.
   It reports what was added or skipped. If the deck doesn't exist yet, the script creates it.

## Choosing the deck (always ask if unspecified)

The target deck is decided per request and passed to the script - **never assume or hardcode it**.

- If the user names a deck, use exactly that name.
- If the user does NOT name a deck, **ask which deck before generating**. It helps to list the current decks so they can pick one; get them with the AnkiConnect `deckNames` action (`http://127.0.0.1:8765`).

## Requirements

- **Anki open** with the **AnkiConnect** add-on installed (code 2055492159), reachable at http://127.0.0.1:8765.
- An ElevenLabs API key saved at `~/.elevenlabs-api-key` (or the `ELEVENLABS_API_KEY` env var).
- Python 3 (the script uses only the standard library for HTTP).

## Config (set in ~/Documents/spanish/add_card.py)

- Deck name - **not** a config value; it is a required argument passed each run (see "Choosing the deck" above).
- Audio provider: **ElevenLabs**. `VOICE_ID` = `p1Q3ihQuPjyyENa1RGtl`, `MODEL_ID` = `eleven_multilingual_v2` (top quality; `eleven_flash_v2_5` is cheaper).
- API key is read from `~/.elevenlabs-api-key` (or `$ELEVENLABS_API_KEY`); never hardcoded or printed.

## Notes

- Audio is embedded in Anki's media collection AND backed up locally to `~/Documents/spanish/audio/` (named with the term).
- Duplicate cards are skipped by AnkiConnect rather than duplicated.
