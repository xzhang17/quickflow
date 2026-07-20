#!/usr/bin/env sh
# Quick Flow installer.
# Copies the skill into the shared skills directory your coding agent (omp,
# Pi agent, Codex, Claude Code, ...) discovers. Quick Flow is foreground-only:
# it spawns no agents, so there is nothing else to install.
#
# Override the destination with an environment variable if your layout differs:
#   AGENTSFLOW_SKILLS_DIR / QUICKFLOW_SKILLS_DIR   (default: ~/.agents/skills)

set -eu

SRC="$(cd "$(dirname "$0")" && pwd)"

SKILLS_DIR="${QUICKFLOW_SKILLS_DIR:-${AGENTSFLOW_SKILLS_DIR:-$HOME/.agents/skills}}"

# Safety guard: never operate on an empty destination path.
[ -n "$SKILLS_DIR" ] || { echo "SKILLS_DIR is empty; aborting." >&2; exit 1; }

echo "Installing Quick Flow"
echo "  skill -> $SKILLS_DIR/quickflow"

mkdir -p "$SKILLS_DIR"

# Replace any previous copy cleanly.
rm -rf "$SKILLS_DIR/quickflow"
cp -R "$SRC/skills/quickflow" "$SKILLS_DIR/quickflow"

echo "Done."
echo "Start a new agent session (or restart) so skill discovery picks it up."
echo "Verify by invoking the skill, e.g.:  /skill:quickflow"
