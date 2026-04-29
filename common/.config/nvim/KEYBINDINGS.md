# Neovim Key Bindings

> **Leader** = `Space`
>
> **Normal** = regular editing mode
>
> **Visual** = selected text mode
>
> **Insert** = typing mode
>
> **Terminal** = inside a terminal buffer

---

# Core Keybindings

## Basic

| Keys | Action |
|------|--------|
| `Esc` | Clear search highlight |
| `Ctrl + s` | Save buffer |
| `Leader + q` | Close window |
| `Leader + x` | Delete current buffer |
| `Leader + Tab` | Next buffer |
| `y` | Yank to system clipboard |
| `yy` | Yank current line to system clipboard |

## Files & Splits

| Keys | Action |
|------|--------|
| `Ctrl + n` | Create file or folder |
| `Leader + h` | Open vertical split |
| `Leader + v` | Open horizontal split |

## Tools

| Keys | Action |
|------|--------|
| `Leader + tt` | Open terminal buffer |
| `Leader + to` | Open Oil file browser |
| `Leader + tc` | Pick colorscheme with Telescope |

## Diagnostics

| Keys | Action |
|------|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `Leader + e` | Open diagnostic float |
| `Leader + dq` | Send diagnostics to location list |

## Terminal

| Keys | Action |
|------|--------|
| `jj` *(Terminal)* | Exit terminal mode |

## Tmux / Pane Navigation

> Works across Neovim splits and tmux panes.

| Keys | Action |
|------|--------|
| `Ctrl + h` | Navigate left |
| `Ctrl + j` | Navigate down |
| `Ctrl + k` | Navigate up |
| `Ctrl + l` | Navigate right |
| `Ctrl + \\` | Navigate to previous pane |

---

# Plugin Keybindings

> Plugin sections are ordered like `lua/plugins`.

## autopairs.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Auto-pairs brackets, quotes, and similar characters in Insert mode |

## better-escape.lua

| Keys | Action |
|------|--------|
| `jk` *(Insert)* | Exit Insert mode |
| `jj` *(Insert)* | Exit Insert mode |
| `jk` / `jj` *(Command line)* | Cancel command line |
| `jk` *(Terminal)* | Exit terminal mode |
| `jk` *(Visual/Select)* | Exit Visual or Select mode |

## cmp.lua

| Keys | Action |
|------|--------|
| `Tab` *(Insert completion)* | Select next completion item |
| `Shift + Tab` *(Insert completion)* | Select previous completion item |
| `Enter` *(Insert completion)* | Confirm completion |
| `Ctrl + Space` *(Insert)* | Open completion menu |
| `Ctrl + l` *(Insert/Snippet)* | Expand or jump forward in snippet |
| `Ctrl + h` *(Insert/Snippet)* | Jump backward in snippet |

## code-runner.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Code Runner commands are available, but no shortcut is configured |

## colorizer.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Color highlighting runs from plugin setup |

## colorschemes.lua

| Keys | Action |
|------|--------|
| `Leader + tc` | Pick colorscheme with Telescope |

## comment.lua

| Keys | Action |
|------|--------|
| `gcc` *(Normal)* | Toggle line comment |
| `gc` *(Normal/Visual)* | Toggle comment |

## conform.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Formats configured filetypes on save |

## copilot.lua

| Keys | Action |
|------|--------|
| No active keybinds | Copilot config is commented out |

## dashboard-nvim.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Dashboard opens on `VimEnter` |

## diffview.lua

| Keys | Action |
|------|--------|
| `Leader + gd` | Open Diffview for working tree changes |
| `Leader + gD` | Open Diffview for staged changes |
| `Leader + gh` | Open Diffview history for current file |
| `Leader + gH` | Open Diffview history for whole repo |
| `Leader + gq` | Close Diffview |
| `Tab` *(Diffview)* | Next changed file |
| `Shift + Tab` *(Diffview)* | Previous changed file |
| `[c` *(Diffview)* | Previous diff hunk |
| `]c` *(Diffview)* | Next diff hunk |
| `:DiffviewToggleFiles` | Toggle file panel |
| `:DiffviewFocusFiles` | Focus file panel |
| `:DiffviewRefresh` | Refresh current diff view |

## flash.lua

| Keys | Action |
|------|--------|
| `zk` | Flash jump |
| `Zk` | Flash Treesitter jump |
| `r` *(Operator pending)* | Remote Flash |
| `R` *(Operator pending/Visual)* | Treesitter search |
| `Ctrl + s` *(Command line)* | Toggle Flash search |

## fmt-utils.lua

| Keys | Action |
|------|--------|
| `Leader + m` | Toggle split/join with Treesj |
| `sa` | Add surrounding |
| `sd` | Delete surrounding |
| `sf` | Find surrounding to the right |
| `sF` | Find surrounding to the left |
| `sh` | Highlight surrounding |
| `sr` | Replace surrounding |
| `sn` | Update surrounding search lines |

## gitsigns.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Git signs and current-line blame are enabled |

## lint.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Linting runs after buffer write |

## lsp.lua

> These work when a language server is attached to the current buffer.

| Keys | Action |
|------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gI` | Go to implementation |
| `gr` | Find references |
| `K` | Hover docs |
| `Leader + D` | Go to type definition |
| `Leader + rn` | Rename symbol |
| `Leader + ca` | Code action |
| `Leader + ds` | Document symbols |
| `Leader + ws` | Workspace symbols |

## lualine.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Statusline only |

## markdown-preview.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Use `:MarkdownPreview`, `:MarkdownPreviewToggle`, or `:MarkdownPreviewStop` |

## neo-tree.lua

| Keys | Action |
|------|--------|
| `Leader + n` | Toggle Neo-tree on the left |

## oil.lua

| Keys | Action |
|------|--------|
| `Leader + to` | Open Oil file browser |
| `-` | Open Oil in a floating window |
| `Ctrl + t` *(Oil)* | Open entry in a new tab |
| `Ctrl + p` *(Oil)* | Preview entry |
| `Ctrl + l` *(Oil)* | Refresh |
| `q` *(Oil)* | Close Oil |

## smear-cursor.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Cursor animation only |

## tabout.lua

| Keys | Action |
|------|--------|
| `Tab` *(Insert)* | Tab out of quotes/brackets when possible |
| `Shift + Tab` *(Insert)* | Tab out backward when possible |

## telescope.lua

| Keys | Action |
|------|--------|
| `Leader + Leader` | Find open buffers |
| `Leader + /` | Fuzzy search current buffer |
| `Leader + sh` | Search help |
| `Leader + sk` | Search keymaps |
| `Leader + sf` | Search files |
| `Leader + ss` | Search Telescope pickers |
| `Leader + sw` | Search word under cursor |
| `Leader + sg` | Search text in project |
| `Leader + sd` | Search diagnostics |
| `Leader + sr` | Resume last Telescope search |
| `Leader + s.` | Search recent files |
| `Leader + s/` | Search text in open files |
| `Leader + sn` | Search Neovim config files |
| `Leader + saf` | Search all files, including ignored and hidden |
| `Leader + sag` | Search all text, including ignored and hidden |
| `Leader + saw` | Search current word everywhere, including ignored and hidden |
| `q` *(Telescope normal mode)* | Close Telescope picker |

## todo.lua

| Keys | Action |
|------|--------|
| No custom keybinds | TODO comments plugin is configured with signs disabled |

## tpipeline.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Tmux statusline integration only |

## treesitter.lua

| Keys | Action |
|------|--------|
| No custom keybinds | Treesitter highlighting, indentation, and context are enabled |

## treesj.lua

| Keys | Action |
|------|--------|
| `Leader + m` | Toggle split/join |
| `Leader + j` | Join code block |
| `Leader + s` | Split code block |

## vim-tmux-navigator.lua

| Keys | Action |
|------|--------|
| `Ctrl + h` | Navigate left |
| `Ctrl + j` | Navigate down |
| `Ctrl + k` | Navigate up |
| `Ctrl + l` | Navigate right |
| `Ctrl + \\` | Navigate to previous pane |

## which-key.lua

| Keys | Action |
|------|--------|
| `Leader + c` | Code group |
| `Leader + d` | Document group |
| `Leader + g` | Git group |
| `Leader + r` | Rename group |
| `Leader + s` | Search group |
| `Leader + w` | Workspace group |
