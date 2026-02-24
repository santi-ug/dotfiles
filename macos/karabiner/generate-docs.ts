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

  fs.writeFileSync("KEYBINDINGS.md", md);
  console.log("KEYBINDINGS.md generated");
}
