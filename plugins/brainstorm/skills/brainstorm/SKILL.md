---
name: brainstorm
model: opus
description: Interviews you relentlessly about a plan or design until you reach shared understanding — walking each branch of the design tree, resolving decision dependencies one at a time, recommending an answer for every question. Invoked when asked to brainstorm, pressure-test a plan, think through a design, interrogate an approach, or when user says "brainstorm this", "interview me about X", or "let's think through the design".
argument-hint: '[plan or topic to interview about]'
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.
- Ask the questions one at a time.
- If a question can be answered by exploring the codebase, explore the codebase instead.
- If a question can be answered from context I gave you, make an assumption and confirm it with me.

When the tree is fully resolved, synthesize the shared understanding into a short summary of the decisions reached.
