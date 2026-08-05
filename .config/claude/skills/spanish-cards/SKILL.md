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
- **Front:** the Spanish sentence, with audio.
- **Back:** the English translation, plus a short grammar note describing the target word (see "Grammar note" below). No audio on the back.

## Generating the sentences (Claude does this directly)

Content is written by Claude in the chat. Do NOT call the Anthropic API or use an API key.

**Verbs** come in two modes:

- **Drill one conjugation** - the user specifies the verb, tense, and person, e.g. "hablar, present, yo".
  - All 3 sentences use that **exact same conjugation** (e.g. all use "hablo"). Only the situation changes.
  - Never change the conjugation, tense, or person across the 3. The goal is to drill one form in different contexts.
- **Infinitive-in-context** (default for mined vocab) - the user just gives the verb in dictionary form, or a whole list of vocab, with no tense/person.
  - Teach the verb by its infinitive, using this fixed 3-card structure (keeps it simple and predictable):
    1. **Sentence 1** uses the **literal infinitive form** (e.g. after a verb like _gusta_, _quiero_, _puedo_, or _voy a_).
    2. **Sentence 2** uses the **simple present** tense.
    3. **Sentence 3** uses the **simple past** (preterite).
  - Vary the person/context freely across the three; only the tense structure above is fixed.
  - The grammar note still labels whichever form actually appears in each sentence.
  - This is the right default when the goal is learning the word's meaning/usage rather than cementing one specific form.

If it's genuinely ambiguous which mode the user wants (e.g. a single verb given on its own, not as part of a vocab list), ASK. For lists of mined vocab, default to infinitive-in-context.

**Nouns, adjectives, and everything else** - the user just gives the word.

- Write 3 sentences using it in 3 different everyday contexts.

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

The script lives at `~/Documents/spanish/add_card.py` and does the mechanical part: Google TTS audio + AnkiConnect.

1. Write the 3 cards to a JSON file (e.g. in the scratchpad or /tmp) as a list of objects:

   ```json
   [
     {
       "spanish": "Voy a la cocina por un vaso de agua.",
       "english": "I'm going to the kitchen for a glass of water.",
       "note": "<b>la cocina</b> · noun, feminine",
       "audio": "cocina_1.mp3"
     },
     {
       "spanish": "La cocina de mi abuela siempre huele a pan.",
       "english": "My grandma's kitchen always smells like bread.",
       "note": "<b>la cocina</b> · noun, feminine",
       "audio": "cocina_2.mp3"
     },
     {
       "spanish": "Necesito una cocina más grande para esta receta.",
       "english": "I need a bigger kitchen for this recipe.",
       "note": "<b>la cocina</b> · noun, feminine",
       "audio": "cocina_3.mp3"
     }
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
