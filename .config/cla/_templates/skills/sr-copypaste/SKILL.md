---
name: sr-copypaste
description: Protocol for commands or queries the user manually pastes into a host shell, psql, or another tool outside the agent's container, then returns the output. Use whenever asking the user to run something externally and paste its results back.
---

# sr-copypaste

The user is the bridge ("meat proxy") between the container and external tools. Pasted text may be padded, reflowed, or wrapped. Treat the copy/paste boundary as fragile.

## Message shape

- Start with prose, not a code block. Name the destination before each block.
- Use one paste-ready block per destination. Separate blocks when steps need to run independently.
- Put only executable input in blocks. Keep instructions and expected results outside them; comments belong inside only when valid for the destination.

## Commands and output

- Give complete commands, not fragments to assemble. Resend the full command when changing it.
- Keep lines short; split only at valid syntax boundaries. Avoid heredocs and whitespace-sensitive pastes.
- Prefer commands the user can read and verify at a glance.
- Prefer read-only checks. Flag destructive or irreversible operations. Avoid requesting unnecessary secrets or large output dumps; limit diagnostic output when practical.
- Prefer a one-time function over a temporary script file. Create `.local.sh` or `.local.sql` files only when reuse or length justifies cleanup.

## Host shell

- Assume zsh unless context indicates otherwise. Use zsh-specific syntax when useful, but prefer portable syntax when equally clear.
- Identify shell-specific requirements when relevant.
- Group sequential steps needing no intermediate inspection in one block. Guard dependent steps with `&&` or explicit checks rather than `set -e` in an interactive shell.

## Known tool-specific rules

Apply these only to the named tool, not by analogy to others.

### psql

- Prefer plain SQL in pasted batches. Avoid backslash meta-commands (`\echo`, `\x`) in batches; send them separately if needed.
- Prefer one statement per check. Combine related checks with `UNION ALL` into a compact key/value result when helpful.
- Break long SQL only at valid syntax boundaries, preferably keywords.

## Pacing and recovery

- If a later step depends on an earlier result, give only the first pass and wait for the output.
- Keep each pass small: a few related statements, not a long checklist.
- If pasting fails, check formatting first. Simplify and resend a short, complete line when practical.

## Evolving the protocol

- Notice reusable copy/paste problems and tool-specific quirks from real work; don't catalog hypothetical tools.
- When a concrete improvement seems worthwhile, briefly suggest it at a natural stopping point and ask whether to update the skill.
- Change the skill only with user approval. Keep additions concise, contextual, and grounded in experience.
