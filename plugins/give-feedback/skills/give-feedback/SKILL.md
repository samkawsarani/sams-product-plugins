---
name: give-feedback
model: sonnet
description: Crafts high-impact feedback (constructive or positive) using the SBIR framework. Turns a vague reaction into specific, actionable, behavior-focused feedback and scores it against the 5 traits of high-impact feedback. Also coaches on receiving feedback graciously. Invoked via /give-feedback or "help me give feedback", "how do I tell X that...", "reword this feedback", "draft feedback for my 1:1", "I need to have a hard conversation with".
allowed-tools: Read, Write, Bash(qmd *)
argument-hint: '[the situation + who it''s for, e.g. "my report kept interrupting the client"]'
---

## What this skill does

Takes a raw reaction ("their Slack posts are too long", "great job today") and rebuilds it into feedback the recipient can act on based on SBIR framework, the Anatomy of High-Impact Feedback, and Radical Candor.

**The core standard:** *If the person receiving the feedback doesn't know exactly what to do differently next time, the feedback wasn't instructional enough.*

---

## Step 1: Get the raw material

If the user hasn't already given it, ask for both in one message:
1. **What happened** — the specific situation and behavior (not "they're disorganized" — *what did they do*).
2. **Who it's for + the relationship** — direct report, peer, or someone more senior. This sets the Radical Candor framing.

If they only have a vague label ("not a team player", "bad at meetings"), pull the concrete moment out of them — the feedback can't be built without one observable behavior anchored in time. Don't proceed on a generalization.

Skip the interrogation if they've already supplied a situation + behavior. Bias for drafting.

---

## Step 2: Classify — constructive or positive

Both use SBIR. Don't sandwich them together: **keep praise and criticism in separate conversations**, each gets its own space.

- **Positive feedback is not "great job."** Generic praise is noise. It must be *instructional* — tell them the exact behavior to repeat and why it mattered.
- **Constructive feedback** communicates a change you want to see.

---

## Step 3: Build it in SBIR

Draft the feedback across four parts:

| Part | What goes here | Test |
|------|----------------|------|
| **S — Situation** | Anchor it. "In yesterday's client demo at 2pm…" | No generalities. A specific time/place. |
| **B — Behavior** | Observable actions only. "You interrupted the client twice." | NOT interpretation ("you were rude"). Could a camera have recorded it? |
| **I — Impact** | The effect that behavior had. "The client went quiet and we lost the pitch's momentum." | Ties the behavior to a real consequence. |
| **R — Request** | What you'd like next time, OR a question inviting their view. "Can you help me understand what was happening?" / "Next time, can we lead with the status?" | Gives a path forward or opens collaboration. |

For **positive** feedback, R = reinforce: "That instinct to create space is vital — keep doing it."

---

## Step 4: Score against the Anatomy of High-Impact Feedback

Run the draft through all 5. Flag any that fail and fix before delivering:

1. **Timely** — delivered while fresh. If this is weeks old, note that recall/relevance has decayed.
2. **Objective** — based on facts, direct observation, measurable outcomes. Strip assumptions.
3. **Specific** — no vague generalizations; focused on the *behavior*, not the *person*. ("You missed the cutoff by 3 hours," not "you're unreliable.")
4. **Actionable** — answers *how* they adjust going forward.
5. **Collaborative** — invites the receiver's input on the path forward.

Then apply the core standard: does the recipient now know **exactly what to do differently next time**? If not, it's not instructional enough — revise.

---

## Step 5: Sanity-check the framing (Radical Candor)

- **Care personally AND challenge directly.** You earn the right to challenge directly by caring first. Feedback is something you do *for* someone, not *to* them.
- Watch the failure modes: **Ruinous Empathy** (softening so much the message is lost) and **Obnoxious Aggression** (direct without care). Under stress people default to one — name which risk this draft leans toward and correct it.
- **Power dynamics:** if the recipient is more senior, feedback is still valid — "see something, say something," it isn't about reporting structure. If they're your report, make it safe for them to respond.

---

## Step 6: Deliver the output

Return, concisely:
1. **The feedback, written out in SBIR**, ready to say or send.
2. **One-line note** on anything that failed the Anatomy check and how the draft handles it (e.g. "This is 2 weeks old — acknowledge the delay when you open").
3. If useful, a **before/after**: their vague version → the SBIR version.

Match voice and tone of the person giving the feedback if the feedback is going in writing (Slack/email).

---

## Receiving feedback (when that's the ask)

If the user is on the receiving end, coach with the following rules:
- **Listen to understand, not to win.** Don't defend while they're speaking.
- **Say thank you** — even if it stings. It marks you as safe to give feedback to.
- **Ask clarifying questions:** "Can you give me an example so I know when it shows up?" / "Tell me more about that impact."
- **Feel it later, act now.** It's normal for it to hurt — process the emotion later, respect the giver now.
- **Ask yourself:** what could go wrong if I acted on this?

---

## Reference — principles behind the model

- **Silence isn't kindness.** Withholding feedback says "I don't think you can handle the truth or change." High performance depends on clarity, not politeness.
- **The Trust Bank (5:1).** Aim for five positive interactions per one corrective. When the trust bank is full, corrective feedback lands as a gift, not a withdrawal — so don't skip the meaningful positive feedback.
- **Pull, not just push.** Normalizing *asking* for feedback ("What's one thing I could do differently?") de-escalates the threat response faster than anything else.
- **Watch for bias** when judging behavior: confirmation bias, halo/horns effect, fundamental attribution error (over-weighting character, under-weighting situation), affinity bias, leniency bias. Ask: *what context might I be missing?*
