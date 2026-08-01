---
name: spanish-cards
description: "Create Mexican-Spanish Anki flashcards for a word, verb, or phrase to learn in context. Use whenever the user names a Spanish or English term they want to study, asks for Spanish cards, or wants example sentences added to Anki. Generates 3 example sentences for the term and adds each as its own card with audio."
user-invocable: true
---

# spanish-cards

Turn a single Spanish word, verb, or phrase into Anki flashcards that teach it in context, with Mexican-Spanish audio.
The user just names a term to learn; this skill knows the rest, so they never have to re-explain the format.

## When to use

Use this whenever the user names a word/verb/phrase they want to learn, asks for Spanish cards, or wants sentences added to Anki.

## Card design (fixed - do not ask about the format)

For each term given:

- Produce exactly **3 example sentences**, each used in a different everyday context.
- Each sentence becomes **its own Anki card**, so one term produces 3 cards.
- **Front:** the Spanish sentence, with audio.
- **Back:** the English translation, plus a short grammar note describing the target word (see "Grammar note" below). No audio on the back.

## Generating the sentences (Claude does this directly)

Content is written by Claude in the chat. Do NOT call the Anthropic API or use an API key.

**Verbs** - the user specifies the verb, tense, and person, e.g. "hablar, present, yo".

- All 3 sentences use that **exact same conjugation** (e.g. all use "hablo"). Only the situation changes.
- Never change the conjugation, tense, or person across the 3. The goal is to drill one form in different contexts.
- If a verb is given without **both** the tense and the person, ASK before generating. Do not default or guess.

**Nouns, adjectives, and everything else** - the user just gives the word.

- Write 3 sentences using it in 3 different everyday contexts.

## Grammar note (the `note` field)

Every card includes a `note` that describes the target word(s) - base form and grammatical form.
It renders on the back, under the translation. Bold each target with `<b>...</b>`.

- **Verbs:** `<b>{conjugated form}</b> · {infinitive} ({English meaning}) · {tense}, {person}`
  - Spell out the tense in plain terms: `present`, `preterite (simple past)`, `imperfect (past habitual/ongoing)`.
  - Example: `<b>fui</b> · ser (to be) · preterite (simple past), yo`
- **Nouns, adjectives, other:** `<b>{word as it appears}</b> · {part of speech}{, gender for nouns} · base: {base form}` (drop "base:" if identical to the word).
  - Example: `<b>la cocina</b> · noun, feminine`

**The note is flexible - it can describe more than one element.** When a card teaches a construction or a phrase with several notable pieces, describe each on its own line separated by `<br>`. Keep each line short.

- Construction example (`Desde hace 6 años vivo aquí.`):
  `<b>desde hace + [tiempo]</b> · "for [time]" - how long something has been going on<br>Used with the <b>present</b> tense (vivo), not the past.`
- Multi-word example:
  `<b>propuse</b> · proponer (to propose) · preterite (simple past), yo<br><b>matrimonio</b> · noun, masculine - marriage`

## Generating the sentences guidelines

**Always:**

- Natural, everyday **Mexican Spanish**.
- Never use **vosotros** or **vos** (voseo) forms. Mexican Spanish uses *tú* and *ustedes*. A request for "all forms" still **excludes** vosotros and vos - use only *yo, tú, él/ella/usted, nosotros, ellos/ellas/ustedes*. Only include vosotros or vos if the user names that form specifically.
- The context must never be harder than the word itself.
- Keep each sentence short and learner-appropriate. If the target is already a tricky conjugation, don't introduce another complicated verb form in the same sentence unless it's genuinely needed - keep any other verbs simple (present tense, common forms).
- Give an accurate, natural English translation for each.
- If anything is unspecified or unclear, ask rather than assume.

## Adding the cards (the script)

The script lives at `~/Documents/spanish/add_card.py` and does the mechanical part: Google TTS audio + AnkiConnect.

1. Write the 3 cards to a JSON file (e.g. in the scratchpad or /tmp) as a list of objects:

   ```json
   [
     {"spanish": "Voy a la cocina por un vaso de agua.", "english": "I'm going to the kitchen for a glass of water.", "note": "<b>la cocina</b> · noun, feminine", "audio": "cocina_1.mp3"},
     {"spanish": "La cocina de mi abuela siempre huele a pan.", "english": "My grandma's kitchen always smells like bread.", "note": "<b>la cocina</b> · noun, feminine", "audio": "cocina_2.mp3"},
     {"spanish": "Necesito una cocina más grande para esta receta.", "english": "I need a bigger kitchen for this recipe.", "note": "<b>la cocina</b> · noun, feminine", "audio": "cocina_3.mp3"}
   ]
   ```

   Fields per card: `spanish` (the sentence), `english` (the translation), `note` (the grammar note - see below), and `audio` (the mp3 filename).
   Name the audio `<term>_1.mp3`, `<term>_2.mp3`, `<term>_3.mp3` using a slug of the term, so backups are recognizable.

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
- `google-cloud-texttospeech` installed for the Python being used.
- Google service-account key at `~/.spanish-audio-keys-676ab4a6e39a.json` (the script defaults to this).

## Config (set in ~/Documents/spanish/add_card.py)

- Deck name - **not** a config value; it is a required argument passed each run (see "Choosing the deck" above).
- `VOICE_NAME` = `es-US-Chirp3-HD-Charon` (natural male, Latin American Spanish). Google has no `es-MX` voices; `es-US` is its Mexican/Latin American Spanish.
- `LANGUAGE_CODE` = `es-US`.

## Notes

- Audio is embedded in Anki's media collection AND backed up locally to `~/Documents/spanish/audio/` (named with the term).
- Duplicate cards are skipped by AnkiConnect rather than duplicated.
