# Git & PR Guidelines

## Commits
- Write a concise imperative subject line describing the overall feature/change
- No commit body — keep it to the subject line only
- Keep one commit per branch — amend rather than stack new commits
- Good: `Add user authentication`, `Fix null pointer in payment handler`, `Remove deprecated API endpoints`
- Bad: `fixed bug`, `WIP`, `updates`, `misc changes`

## Branches
- kebab-case, named after the feature or change
- Good: `add-user-auth`, `fix-payment-null-pointer`, `remove-deprecated-endpoints`
- Most repos use trunk-based development — branch off the trunk (usually `main` or `master`)

## Pull Requests
- PR title matches the commit subject exactly
- Put detail in the PR description, not the commit message
- **Always create PRs as draft** — only mark ready for review when the human has signaled it's ready AND a code review agent has self-reviewed
