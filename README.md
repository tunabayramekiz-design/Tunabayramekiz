# Tunabayramekiz

## Studio workspace

The `studio/` directory is an [Architecture Studio](https://github.com/AlpacaLabsLLC/skills-for-architects) workspace ("Two+"), scaffolded per that plugin's `/as:studio init` conventions:

- `STUDIO.md` — studio manifest (working units, default jurisdiction, registered projects)
- `AGENTS.md` / `CLAUDE.md` — studio instructions for Codex / Claude Code
- `.mcp.json` — reserved, empty connector manifest
- `.claude/skills/`, `.agents/skills/` — firm-specific skills
- `projects/` — registered projects

To use it, install the `as@skills-for-architects` plugin in Claude Code or Codex, then run `/as:studio status` (or `$studio status`) from inside `studio/`.