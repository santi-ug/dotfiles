# Karabiner config

`rules.ts` generates `karabiner.json`. Edit the TypeScript, then run `npm run build`.
Do not hand-edit `karabiner.json`.

## Window management (Hyper + W)

Tinycast handles window management. Raycast is no longer used for it. Karabiner sends
Tinycast's shortcuts (F13 to F22, some with modifiers) directly, so layouts resize with no delay.

`Hyper + W + F` toggles maximize. The second press restores the window's previous
layout (L, K, J, H, C or X). Tinycast's own Restore is not used: it restores the size
from before the first resize, not the size from before maximize.

`window-toggle.swift` provides the toggle. It is a login agent with one keyboard event
tap. It remembers the last layout per window and rewrites the second F press to that
layout's shortcut. See `WINDOW-TRACKER.md` for build, install and design.

### How it stays running

- `~/Library/LaunchAgents/com.santi.window-layout-tracker.plist` is a copy of the plist in
  this folder. `RunAtLoad` starts it at every login and after every restart. `KeepAlive`
  relaunches it within 60 s if it exits.
- The binary lives at `~/.cache/karabiner-window-toggle-bin`. If a cleanup tool empties
  `~/.cache`, run `npm run build:tracker` and restart the agent.
- macOS lists it under System Settings > General > Login Items as a background item.
  It must stay allowed there.

### If F stops restoring

F then acts as plain Tinycast Maximize: instant, with no restore. This almost always
means the tracker is not running.

1. `launchctl print gui/$(id -u)/com.santi.window-layout-tracker | grep -E 'state|last exit'`
2. `tail ~/.cache/karabiner-window-tracker.log`
3. If the log says "Enable Accessibility": open System Settings > Privacy & Security >
   Accessibility, remove `karabiner-window-toggle-bin`, drag the binary back in, enable it.
4. `launchctl kickstart -k gui/$(id -u)/com.santi.window-layout-tracker`

Accessibility approval is tied to the code signature. `npm run build:tracker` signs with
the Developer ID certificate, so rebuilds keep the approval. An ad-hoc signed build gets a
new signature each time and loses it. That caused the 2026-09-16 outage.
