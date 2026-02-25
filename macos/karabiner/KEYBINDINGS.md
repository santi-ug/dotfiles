# Hyper Key Bindings

> **Hyper** = `CapsLock` — tap alone sends `Escape`

---

## Space

| Keys | Action |
|------|--------|
| `Hyper + Space` | Quick Add Reminder |

## B — Browse

| Keys | Action |
|------|--------|
| `Hyper + B + T` | Twitter |
| `Hyper + B + P` | Calendar (mxstbr.com/cal) |
| `Hyper + B + Y` | Hacker News |

## O — Open Apps

| Keys | Action |
|------|--------|
| `Hyper + O + B` | Orion |
| `Hyper + O + C` | Calendar |
| `Hyper + O + V` | Zed |
| `Hyper + O + K` | Slack |
| `Hyper + O + N` | Notion |
| `Hyper + O + T` | WezTerm |
| `Hyper + O + F` | Finder |
| `Hyper + O + S` | Spotify |
| `Hyper + O + W` | WhatsApp |
| `Hyper + O + R` | Reminders |
| `Hyper + O + M` | Mail |

## W — Window

| Keys | Action |
|------|--------|
| `Hyper + W + ;` | Window: Hide |
| `Hyper + W + Y` | Window: previous-display |
| `Hyper + W + O` | Window: next-display |
| `Hyper + W + K` | Window: top-half |
| `Hyper + W + J` | Window: bottom-half |
| `Hyper + W + H` | Window: left-half |
| `Hyper + W + L` | Window: right-half |
| `Hyper + W + C` | Window: almost-maximize |
| `Hyper + W + U` | Window: Previous Tab |
| `Hyper + W + I` | Window: Next Tab |
| `Hyper + W + N` | Window: Next Window |
| `Hyper + W + B` | Window: Back |
| `Hyper + W + M` | Window: Forward |

## S — System

| Keys | Action |
|------|--------|
| `Hyper + S + U` | Volume Up |
| `Hyper + S + J` | Volume Down |
| `Hyper + S + I` | Brightness Up |
| `Hyper + S + K` | Brightness Down |
| `Hyper + S + L` | Lock Screen |
| `Hyper + S + P` | Play / Pause |
| `Hyper + S + ;` | Fast Forward |
| `Hyper + S + D` | Do Not Disturb Toggle |
| `Hyper + S + T` | Toggle Dark Mode |
| `Hyper + S + C` | Open Camera |
| `Hyper + S + V` | Push to Talk |

## V — Move

| Keys | Action |
|------|--------|
| `Hyper + V + H` | ← |
| `Hyper + V + J` | ↓ |
| `Hyper + V + K` | ↑ |
| `Hyper + V + L` | → |
| `Hyper + V + M` | Magic Move (Homerow) |
| `Hyper + V + S` | Scroll Mode (Homerow) |
| `Hyper + V + D` | Dictionary |
| `Hyper + V + U` | Page Down |
| `Hyper + V + I` | Page Up |

## C — Music

| Keys | Action |
|------|--------|
| `Hyper + C + P` | Play / Pause |
| `Hyper + C + N` | Next Track |
| `Hyper + C + B` | Previous Track |

## R — Raycast

| Keys | Action |
|------|--------|
| `Hyper + R + 1` | Connect Bluetooth Device 1 |
| `Hyper + R + C` | Color Picker |
| `Hyper + R + N` | Dismiss Notifications |
| `Hyper + R + E` | Emoji Search |
| `Hyper + R + P` | Confetti |
| `Hyper + R + H` | Clipboard History |

---

# Tmux Keybindings

> **Leader** = `Ctrl + Space`

---

## Sessions

| Keys | Action |
|------|--------|
| `Leader + d` | Detach session |
| `Leader + s` | List / switch sessions |
| `Leader + $` | Rename session |
| `Leader + o` | SessionX — fuzzy session manager |
| `Leader + Ctrl + s` | Save session (tmux-resurrect) |
| `Leader + Ctrl + r` | Restore session (tmux-resurrect) |

## Windows

| Keys | Action |
|------|--------|
| `Ctrl + Tab` | Next window |
| `Ctrl + Shift + Tab` | Previous window |
| `Leader + c` | New window |
| `Leader + ,` | Rename window |
| `Leader + w` | List windows |
| `Leader + n` | Next window |
| `Leader + p` | Previous window |
| `Leader + f` | Find window |
| `Leader + &` | Kill window |

## Panes

| Keys | Action |
|------|--------|
| `Leader + h` | Split pane horizontally (current dir) |
| `Leader + v` | Split pane vertically (current dir) |
| `Leader + x` | Kill pane |
| `Leader + z` | Zoom / unzoom pane |
| `Leader + q` | Show pane numbers |
| `Leader + {` | Swap pane up |
| `Leader + }` | Swap pane down |
| `Leader + !` | Break pane into new window |
| `Leader + o` | Rotate panes |

## Navigation (vim-tmux-navigator)

> Works seamlessly across vim splits and tmux panes

| Keys | Action |
|------|--------|
| `Ctrl + h` | Navigate left |
| `Ctrl + j` | Navigate down |
| `Ctrl + k` | Navigate up |
| `Ctrl + l` | Navigate right |
| `Ctrl + \\` | Navigate to previous pane |

## Copy Mode & Clipboard

| Keys | Action |
|------|--------|
| `Leader + [` | Enter copy mode |
| `Leader + ]` | Paste buffer |
| `y` *(copy mode)* | Copy selection to system clipboard (tmux-yank) |
| `Y` *(copy mode)* | Copy line to command line (tmux-yank) |
| `Leader + y` | Copy tmux selection to clipboard (tmux-yank) |
| `Leader + Y` | Copy current working directory to clipboard (tmux-yank) |
| `Leader + Space` | Thumbs mode — hint-based copy (tmux-thumbs) |

## FZF & URLs

| Keys | Action |
|------|--------|
| `Leader + F` | Open tmux-fzf menu |
| `Leader + u` | Pick URL from visible pane with fzf (tmux-fzf-url) |

## SessionX

| Keys | Action |
|------|--------|
| `Leader + o` | Open SessionX |
| `Tab` *(in SessionX)* | Select up |
| `Shift + Tab` *(in SessionX)* | Select down |

## Plugin Management (TPM)

| Keys | Action |
|------|--------|
| `Leader + I` | Install plugins |
| `Leader + U` | Update plugins |
| `Leader + Alt + u` | Remove unused plugins |

## Misc

| Keys | Action |
|------|--------|
| `Leader + :` | Command prompt |
| `Leader + ?` | List all keybindings |
| `Leader + t` | Show clock |

