---
name: sr-handover
description: Write or pick up a work handover, or prepare a project update or executive summary tailored to its recipient.
---

# sr-handover

## Make authorship and addressee clear

By default, write from the agent's perspective and make its authorship clear.
Address whoever will act on the handover, even if someone else forwards it.
When a teammate's agent will pick up the work, address that agent directly.
Attribute findings, decisions, and actions to the people or agents responsible.

A summary can use an impersonal voice. Use a human sign-off when the user
wants a draft to send under their own name, and keep claims about who did
the work accurate.

## Fit the recipient

Write for what the recipient needs to know, decide, or do. For an executive
feature update, lead with what changes for users, who is affected, and when.
Include a decision or risk if it needs attention. For a chat update, put the
ask or main point first. For someone taking over work, include enough verified
state, references, open decisions, and next steps for them to continue. Include
technical detail when it helps the recipient.

## Name and save local drafts

Use the repo's conventions when they exist. Pick `.txt` for plain text the user
will copy and paste and `.md` when Markdown helps. A short name like
`email.local.txt` works for one obvious draft. Add a topic or ticket number
when it helps distinguish files, as in
`proj-142-billing-rollout.handover.local.md`.

In a Git repo, verify the actual path with `git check-ignore -- <path>`.
If no rule covers it, suggest an exact-path rule in `.git/info/exclude`
for a personal draft. Suggest `*.local` and `*.local.*` in `.gitignore`
when the team wants a shared local-file convention. Send or post only
when explicitly asked.

## Pick up and retire handovers

When resuming work, check the recorded state against the workspace and
carry forward any unresolved decisions and permission limits. Reading
the note is a good time to flag cleanup. Suggest deleting or archiving
it once it has served its purpose and any context still needed is saved
elsewhere. Leave the cleanup decision to the user.
