import fs from "fs";
import { LayerCommand } from "./utils";
import { KeyCode } from "./types";

const KEY_LABELS: Partial<Record<string, string>> = {
  spacebar: "Space",
  semicolon: ";",
  quote: "'",
  grave_accent_and_tilde: "`",
  open_bracket: "[",
  close_bracket: "]",
  delete_or_backspace: "Backspace",
  return_or_enter: "Enter",
};

const SECTION_NAMES: Partial<Record<string, string>> = {
  spacebar: "Space",
  b: "B — Browse",
  o: "O — Open Apps",
  w: "W — Window",
  s: "S — System",
  v: "V — Move",
  c: "C — Music",
  r: "R — Raycast",
};

function keyLabel(key: string): string {
  return KEY_LABELS[key] ?? key.toUpperCase();
}

function actionLabel(cmd: LayerCommand): string {
  if (cmd.description) {
    // app(): "Open -a 'Slack.app'" → "Slack"
    const appMatch = cmd.description.match(/Open -a '(.+)\.app'/);
    if (appMatch) return appMatch[1];

    return cmd.description;
  }

  // Fallback: inspect the to array
  const first = cmd.to?.[0];
  if (!first) return "?";
  if (first.key_code) return keyLabel(first.key_code);
  if (first.shell_command) return first.shell_command;
  return "?";
}

export function generateDocs(
  subLayers: { [key_code in KeyCode]?: LayerCommand | { [key_code in KeyCode]?: LayerCommand } }
) {
  let md = `# Hyper Key Bindings\n\n`;
  md += `> **Hyper** = \`CapsLock\` — tap alone sends \`Escape\`\n\n`;
  md += `---\n\n`;

  const directActions: [string, LayerCommand][] = [];
  const sublayerEntries: [string, { [key: string]: LayerCommand }][] = [];

  for (const [key, value] of Object.entries(subLayers)) {
    if (!value) continue;
    if ("to" in value) {
      directActions.push([key, value as LayerCommand]);
    } else {
      sublayerEntries.push([key, value as { [key: string]: LayerCommand }]);
    }
  }

  // Direct actions (e.g. Hyper + Space)
  if (directActions.length > 0) {
    for (const [key, cmd] of directActions) {
      const name = SECTION_NAMES[key] ?? keyLabel(key);
      md += `## ${name}\n\n`;
      md += `| Keys | Action |\n|------|--------|\n`;
      md += `| \`Hyper + ${keyLabel(key)}\` | ${actionLabel(cmd)} |\n\n`;
    }
  }

  // Sublayers
  for (const [layerKey, commands] of sublayerEntries) {
    const name = SECTION_NAMES[layerKey] ?? `${keyLabel(layerKey)}`;
    md += `## ${name}\n\n`;
    md += `| Keys | Action |\n|------|--------|\n`;
    for (const [key, cmd] of Object.entries(commands)) {
      if (!cmd) continue;
      md += `| \`Hyper + ${keyLabel(layerKey)} + ${keyLabel(key)}\` | ${actionLabel(cmd)} |\n`;
    }
    md += "\n";
  }

  md += generateTmuxDocs();

  fs.writeFileSync("KEYBINDINGS.md", md);
  console.log("KEYBINDINGS.md generated");
}

function generateTmuxDocs(): string {
  let md = `---\n\n`;
  md += `# Tmux Keybindings\n\n`;
  md += `> **Leader** = \`Ctrl + Space\`\n\n`;
  md += `---\n\n`;

  // Sessions
  md += `## Sessions\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + d\` | Detach session |\n`;
  md += `| \`Leader + s\` | List / switch sessions |\n`;
  md += `| \`Leader + $\` | Rename session |\n`;
  md += `| \`Leader + o\` | SessionX — fuzzy session manager |\n`;
  md += `| \`Leader + Ctrl + s\` | Save session (tmux-resurrect) |\n`;
  md += `| \`Leader + Ctrl + r\` | Restore session (tmux-resurrect) |\n`;
  md += `\n`;

  // Windows
  md += `## Windows\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Ctrl + Tab\` | Next window |\n`;
  md += `| \`Ctrl + Shift + Tab\` | Previous window |\n`;
  md += `| \`Leader + c\` | New window |\n`;
  md += `| \`Leader + ,\` | Rename window |\n`;
  md += `| \`Leader + w\` | List windows |\n`;
  md += `| \`Leader + n\` | Next window |\n`;
  md += `| \`Leader + p\` | Previous window |\n`;
  md += `| \`Leader + f\` | Find window |\n`;
  md += `| \`Leader + &\` | Kill window |\n`;
  md += `\n`;

  // Panes
  md += `## Panes\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + h\` | Split pane horizontally (current dir) |\n`;
  md += `| \`Leader + v\` | Split pane vertically (current dir) |\n`;
  md += `| \`Leader + x\` | Kill pane |\n`;
  md += `| \`Leader + z\` | Zoom / unzoom pane |\n`;
  md += `| \`Leader + q\` | Show pane numbers |\n`;
  md += `| \`Leader + {\` | Swap pane up |\n`;
  md += `| \`Leader + }\` | Swap pane down |\n`;
  md += `| \`Leader + !\` | Break pane into new window |\n`;
  md += `| \`Leader + o\` | Rotate panes |\n`;
  md += `\n`;

  // Navigation (vim-tmux-navigator)
  md += `## Navigation (vim-tmux-navigator)\n\n`;
  md += `> Works seamlessly across vim splits and tmux panes\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Ctrl + h\` | Navigate left |\n`;
  md += `| \`Ctrl + j\` | Navigate down |\n`;
  md += `| \`Ctrl + k\` | Navigate up |\n`;
  md += `| \`Ctrl + l\` | Navigate right |\n`;
  md += `| \`Ctrl + \\\\\` | Navigate to previous pane |\n`;
  md += `\n`;

  // Copy mode & clipboard
  md += `## Copy Mode & Clipboard\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + [\` | Enter copy mode |\n`;
  md += `| \`Leader + ]\` | Paste buffer |\n`;
  md += `| \`y\` *(copy mode)* | Copy selection to system clipboard (tmux-yank) |\n`;
  md += `| \`Y\` *(copy mode)* | Copy line to command line (tmux-yank) |\n`;
  md += `| \`Leader + y\` | Copy tmux selection to clipboard (tmux-yank) |\n`;
  md += `| \`Leader + Y\` | Copy current working directory to clipboard (tmux-yank) |\n`;
  md += `| \`Leader + Space\` | Thumbs mode — hint-based copy (tmux-thumbs) |\n`;
  md += `\n`;

  // FZF & URLs
  md += `## FZF & URLs\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + F\` | Open tmux-fzf menu |\n`;
  md += `| \`Leader + u\` | Pick URL from visible pane with fzf (tmux-fzf-url) |\n`;
  md += `\n`;

  // SessionX bindings
  md += `## SessionX\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + o\` | Open SessionX |\n`;
  md += `| \`Tab\` *(in SessionX)* | Select up |\n`;
  md += `| \`Shift + Tab\` *(in SessionX)* | Select down |\n`;
  md += `\n`;

  // Plugin management
  md += `## Plugin Management (TPM)\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + I\` | Install plugins |\n`;
  md += `| \`Leader + U\` | Update plugins |\n`;
  md += `| \`Leader + Alt + u\` | Remove unused plugins |\n`;
  md += `\n`;

  // Misc
  md += `## Misc\n\n`;
  md += `| Keys | Action |\n|------|--------|\n`;
  md += `| \`Leader + :\` | Command prompt |\n`;
  md += `| \`Leader + ?\` | List all keybindings |\n`;
  md += `| \`Leader + t\` | Show clock |\n`;
  md += `\n`;

  return md;
}
