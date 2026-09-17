# Window layout tracker

Karabiner emits Tinycast shortcuts directly. A small Swift login agent observes the
six layout shortcuts and rewrites the maximize shortcut to the remembered layout
on the second press. Tinycast performs all resizing.

Each window has its own history. Repeating a layout does not change the restore
target. Selecting another layout while maximized resets the toggle. With no
recorded layout, the first restore uses Reasonable Size. Manual resizing and
relative size changes are not recorded. History resets when the agent restarts.

The agent uses one keyboard event tap and a run loop. There are no polling timers,
AppleScript processes, frame snapshots, or history files. It only queries the
focused window for a recognized shortcut. History is capped at 128 windows.
Accessibility requests time out after 50 ms if an application is unresponsive.

## Build and install

```sh
npm run build:tracker
"$HOME/.cache/karabiner-window-toggle-bin" --self-test
cp com.santi.window-layout-tracker.plist "$HOME/Library/LaunchAgents/"
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.santi.window-layout-tracker.plist"
npm run build
```

The plist contains Santi's absolute home path. Adjust it on another computer.
Enable `karabiner-window-toggle-bin` in macOS Accessibility settings. The build signs
it with the Developer ID certificate, so the approval survives rebuilds. Tinycast must
be running with Window Management enabled and the configured shortcuts retained.

After rebuilding or granting permission:

```sh
launchctl kickstart -k "gui/$(id -u)/com.santi.window-layout-tracker"
```

Inspect with `launchctl print gui/$(id -u)/com.santi.window-layout-tracker`.
Errors go to `~/.cache/karabiner-window-tracker.log`.
To stop and disable login startup, run
`launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.santi.window-layout-tracker.plist`
and move the plist out of LaunchAgents. With the tracker stopped, F is simply
Tinycast Maximize; the other layout shortcuts continue working.
