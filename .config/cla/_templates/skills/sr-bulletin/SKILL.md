---
name: sr-bulletin
description: On-disk, append-only bulletins for coordinating agents and the user in a shared workspace. Use when joining shared work or exchanging coordination notes.
---

# sr-bulletin

## Joining and coordinating

Use `BULLETIN.local.md` at the repo root unless the project identifies another main bulletin. Check existing `BULLETIN*.local.md` files before creating one; a topic-specific bulletin may point to the main one. Bulletins should be git-ignored; suggest an ignore rule if needed.

Read enough history to understand current work, participants, and outstanding asks. When joining work, post an opening note with your name, task, and files or areas you expect to touch. Use the user's assigned name, or choose an unused short handle, and keep it stable.

Rename your agent session, or ask the user to rename it if you cannot do so yourself. Always also offer the user a short, tag-like name to use for their tmux window or equivalent terminal label. Both names must start with your agent name as used in the bulletin. Optional task context and a ticket number in angle brackets may follow, e.g. `Nova · migrations <ABC-123>`.

Read new entries at the start of each turn and before overlapping work. Post useful claims, decisions, questions, blockers, and handoffs; reference code or commits rather than repeating them. Post a closing update when others need to know you're finished or stopping, including any unresolved handoff.

## Signing

Consistently sign posts as `name (harness / model)`, with an optional separate recipient: `**From:** Nova (Codex / gpt-6.1-terra)  **To:** Iris`.

Before each post, check the current runtime or session variables and metadata for the active harness and model: the model may change mid-session. Use `unknown` for unavailable values rather than guessing. Configured defaults and installed CLI versions do not establish what is running in this session.

- **pi:** inspect relevant environment values with `printenv PI_CODING_AGENT PI_PROVIDER PI_MODEL PI_SESSION_ID`.
- **Codex:** use the active runtime/session to identify the harness and an explicitly supplied model ID, if available. In some sessions the runtime supplies the model in its instructions; environment variables may not expose it. `~/.codex/config.toml` gives defaults; `codex --version` gives the installed CLI version.
- **Other harnesses:** use active-session metadata or documented session environment variables.

## Appending

Append posts using `>>`; do not rewrite the bulletin with an editor or patch tool. Rewrites can cause watchers to replay old posts. Use an actual UTC timestamp and keep posts short. For example:

```sh
stamp="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
post=$(cat <<'EOF'
**From:** Nova (Codex / gpt-6.1-terra)  **To:** Iris

Starting parser work in src/parser.py. Are you editing that file?
EOF
)
printf '\n---\n\n## Parser coordination — %s\n\n%s\n' "$stamp" "$post" >> BULLETIN.local.md
```

The quoted heredoc preserves literal `$` and backticks in the body. A single append command reduces interleaving risk but is not a lock between writers.

## Close coordination

While actively waiting for a reply, use a bounded live watch:

```sh
timeout 60 tail -n 0 -F BULLETIN.local.md
```

Read pending entries before watching and check new entries afterward: `-n 0` only shows writes after the watch starts. File changes cannot wake an idle agent; the user or harness must resume it. Keep failed wake-up attempts out of the bulletin; record a resulting blocker or handoff only when useful to others.

For sustained 1:1 or small-group work, agree on a separate bulletin such as `BULLETIN.parser.local.md`. Announce its path, participants, and purpose in the main bulletin. Use the same signing and append conventions, watch the relevant file, and bring outcomes affecting the wider group back to the main bulletin. These files are separate channels, not private ones.

If a bulletin needs a reset, agree with participants before archiving it and starting fresh; avoid resetting during active work.
