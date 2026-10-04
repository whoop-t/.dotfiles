---
name: spanish-practice-test
description: "Run an interactive Mexican-Spanish translation practice test. Two modes: reading (Claude gives a Spanish sentence, the user translates to English) and producing (Claude gives an English sentence, the user translates to Spanish). The user picks a CEFR level (A1-C1) for randomly generated sentences, or 'In my deck' to drill sentences built from the terms they are already studying (the CARDS_TRACKER.md / Anki deck here). Grades leniently (meaning over spelling), shows a score, then reviews every question with corrections and advice. Use whenever the user wants to practice, test, quiz, or drill their Spanish translation."
user-invocable: true
---

# spanish-practice-test

Give the user an interactive Spanish translation test, grade it leniently, then walk through every question with corrections and advice.
The user just asks to practice; this skill knows the format, so they never have to re-explain it.

All Spanish here is **natural, everyday Mexican Spanish** - the same voice as the `spanish-mined` deck.
Never use **vosotros** or **vos**; Mexican Spanish uses _tú_ and _ustedes_.
Use **carro** for "car", never _coche_.

## When to use

Use this whenever the user wants to practice, test, quiz, or drill their Spanish - translating sentences in either direction.
This is **not** about making Anki cards (that is the `spanish-mined` skill); nothing here is ever added to Anki.

## Step 1 - Set up the test (ask these up front)

Before writing any sentences, collect four choices from the user.
Ask them together in one message; if the user already stated some, only ask for what's missing.

1. **Direction** (what kind of test):
   - **Reading** - Claude gives a **Spanish** sentence, the user translates it **to English**. (comprehension)
   - **Producing** - Claude gives an **English** sentence, the user translates it **to Spanish**. (production)
2. **Level**:
   - One of **A1, A2, B1, B2, C1** - Claude invents random sentences at that level (see "Level guide").
   - **In my deck** - Claude builds sentences from the terms the user is already studying (see "'In my deck' mode").
3. **Length** - how many questions (e.g. 5, 10, 20). Default to **10** if they don't care.
4. (Optional) a **theme** if they want one (e.g. cooking, work, travel). Otherwise vary the topics naturally.

If anything is unclear, ask rather than assume.

## Step 2 - Run the test (one question at a time, no feedback yet)

This is a **test**, so do not grade or hint while it's running - just collect answers.

- Present **one question at a time**, numbered (e.g. `Question 1/10:`).
- Show only the prompt sentence (the Spanish sentence for reading, or the English sentence for producing). Nothing else - no hints, no vocab, no translation.
- Wait for the user's answer, then move straight to the next question with no comment on correctness. A brief neutral acknowledgement (`Got it.`) is fine; never reveal whether they were right.
- Keep an internal record of each prompt, the intended/correct translation, and the user's answer. You'll need all of it in Step 4.
- Let the user stop early (e.g. "that's enough", "stop") - if they do, grade only the questions they answered.

Write every sentence yourself, directly in chat. Do not call any API or script - this skill generates nothing but text.

### Sentence rules (apply to every generated sentence)

- **Sound like a real person, not a textbook.** Favor everyday phrasing a Mexican speaker would actually use.
- Match the chosen **level** (see "Level guide"). The sentence as a whole should sit at that level - vocabulary, tense, and clause complexity all included.
- Keep each sentence self-contained and translatable on its own (no "it"/"that" referring to a missing previous sentence).
- Vary the subject, tense, and topic across the test so it isn't ten near-identical sentences. Don't repeat the same sentence frame.
- For **producing** tests, make the **English** prompt unambiguous enough to translate - but natural English, not stilted word-for-word Spanish. If a Spanish nuance can't be forced by the English (e.g. tú vs. usted, ser vs. estar), accept either reasonable choice when grading.
- Never use vosotros/vos; use _carro_ not _coche_; Mexican Spanish throughout.

## Step 3 - Grade (lenient - meaning over spelling)

Grade for **understanding and communication**, not precision typing.

**Ignore entirely** (never counts against the user):

- Accents and diacritics (_esta_ for _está_, _el_ for _él_).
- Capitalization and punctuation (missing ¿ ¡, commas, periods).
- Minor typos / spelling slips where the intended word is obvious (_kiero_ → _quiero_, _recieve_ → _receive_).
- Reasonable synonyms and equally valid phrasings (_rápido_ / _de prisa_; "kid" / "child"; "I'm going to eat" / "I will eat").
- For reading: any accurate, natural English that captures the meaning - exact wording doesn't matter.
- Choices the prompt genuinely left open (tú vs. usted, ser vs. estar when both fit, singular "you" vs. plural when unmarked).

**Counts as wrong / partially wrong** (these change the meaning):

- Wrong vocabulary that changes the meaning (used the wrong word, not just misspelled it).
- Wrong tense or mood when the prompt clearly required a specific one (said present when the English was clearly past).
- Wrong subject/person, negation flipped, or a clause dropped so the meaning changes.
- Gender/number agreement errors **only if** they obscure meaning - otherwise mention them as advice, not as wrong.

Score each question as **correct**, **partial** (meaning mostly there but a real error), or **incorrect**.
Compute a simple score: count correct as 1, partial as 0.5. Report as `X / N` plus a quick percentage and a one-line encouraging read of how it went.

## Step 4 - Review every question

After the score, go through **each question in order** and, for each one, show:

- The original prompt.
- The user's answer.
- A clear **verdict**: correct / partial / incorrect.
- The **model answer** (a natural Mexican-Spanish or English translation).
- If it wasn't fully correct, a short **why** - what was off and how to fix it, in plain language.
- **One piece of advice** to make even a correct answer more natural or more idiomatic when there's something worth adding (a better word choice, a more common phrasing, a note on tú/usted, ser/estar, a false-friend, etc.). Keep it short and practical. Skip the advice line when the answer was already idiomatic and there's nothing useful to add - don't invent nitpicks.

Keep each question's review compact and scannable. No emojis.
At the end, offer a quick summary of recurring patterns worth working on (e.g. "preterite vs. imperfect tripped you up twice"), and offer to run another test or focus the next one on the weak spots.

## Level guide (for A1-C1 random sentences)

Target the whole sentence at the level - don't slip a C1 verb into an A1 sentence.

- **A1** - Present tense only. High-frequency vocab (ser, estar, tener, ir, querer, comer, casa, agua, familia, trabajo). Short, one clause. Simple statements and questions. _Tengo dos hermanos._ / _¿Dónde está el baño?_
- **A2** - Present, near future (_ir a_ + infinitive), and simple preterite of common verbs. Basic reflexives, basic connectors (_porque, pero, y, cuando_). One or two short clauses. _Ayer fui al mercado porque no había comida en casa._
- **B1** - Preterite vs. imperfect in the same sentence, simple future, _ir a_, common present subjunctive triggers (_quiero que, es importante que_), object pronouns, more connectors. Two clauses comfortably. _Cuando era niño siempre iba a casa de mis abuelos los domingos._
- **B2** - Subjunctive (present and past), conditional, perfect tenses, passive-ish and impersonal _se_, richer and more abstract vocabulary, idiomatic expressions. Multi-clause. _Si hubiera sabido que ibas a venir, habría hecho más comida._
- **C1** - Complex subordination, nuanced or abstract topics, register shifts, advanced idioms and collocations, discourse connectors (_no obstante, dado que, por más que_). Long, layered sentences. _Por más que se esfuercen, dudo que logren cambiar algo a estas alturas._

Keep even the hardest levels sounding like a real person - C1 means complex, not artificial.

## "In my deck" mode (drill what the user is studying)

When the user picks **In my deck**, build the test sentences around the terms they already have cards for, so the test reinforces their own vocabulary.

**Source of terms (primary):** the tracker at `~/Documents/spanish/CARDS_TRACKER.md`.
It lists every term that has cards, grouped by deck. Read it and pull a varied sample of terms to build sentences around.

- Spread the picks across the list (nouns, verbs, adjectives, phrases) and across topics - don't just take the first N lines.
- Each test sentence should feature **at least one** tracker term as its centerpiece; the rest of the sentence should stay at or below that term's difficulty so the studied word is the focus (same principle as the `spanish-mined` deck).
- For **reading**, the Spanish sentence contains the term. For **producing**, write the English prompt so the natural translation uses the term (but accept any correct Spanish when grading).
- In the Step 4 review, name which tracked term each sentence was exercising, so the user connects it back to their cards.

**Optional - pull real sentences from Anki.** If Anki is open with AnkiConnect (http://127.0.0.1:8765), you may read actual card sentences to reuse or adapt:

- `deckNames` to list decks; `findNotes` with a query like `deck:"Spanish Mined from Lessons/Videos"`; `notesInfo` to read fields.
- Use these as inspiration for prompts. Do not modify, add, or delete any cards - this skill is read-only toward Anki.
- If Anki isn't reachable, just use the tracker file; don't block the test on it.

If the deck is large, sample it (and say you're sampling) rather than trying to cover everything - the test length the user chose decides how many sentences you write.

## Notes

- Nothing in this skill is ever added to Anki, and no script is run. It only reads the tracker (and optionally reads the Anki deck).
- Present everything as plain text - no emojis.
- Keep the user moving: one question at a time during the test, a clean score, then a tight per-question review.
