import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, window, shell } from "./utils";
import { generateDocs } from "./generate-docs";

const subLayers = {
  spacebar: {
    description: "Quick Add Reminder",
    to: [
      {
        key_code: "spacebar",
        modifiers: ["left_control", "left_option", "left_shift", "left_command"],
      },
    ],
  },
  // b = "B"rowse
  b: {
    t: { ...open("https://twitter.com"), description: "Twitter" },
    p: { ...open("https://mxstbr.com/cal"), description: "Calendar (mxstbr.com/cal)" },
    y: { ...open("https://news.ycombinator.com"), description: "Hacker News" },
  },
  // o = "Open" applications
  o: {
    b: app("Orion"),
    c: app("Calendar"),
    v: app("Zed"),
    k: app("Slack"),
    n: app("Notion"),
    t: app("WezTerm"),
    f: app("Finder"),
    s: app("Spotify"),
    w: app("WhatsApp"),
    r: app("Reminders"),
  },

  // w = "Window"
  w: {
    semicolon: {
      description: "Window: Hide",
      to: [
        {
          key_code: "h",
          modifiers: ["right_command"],
        },
      ],
    },
    y: window("previous-display"),
    o: window("next-display"),
    k: window("top-half"),
    j: window("bottom-half"),
    h: window("left-half"),
    l: window("right-half"),
    f: window("maximize"),
    c: window("almost-maximize"),
    u: {
      description: "Window: Previous Tab",
      to: [
        {
          key_code: "tab",
          modifiers: ["right_control", "right_shift"],
        },
      ],
    },
    i: {
      description: "Window: Next Tab",
      to: [
        {
          key_code: "tab",
          modifiers: ["right_control"],
        },
      ],
    },
    n: {
      description: "Window: Next Window",
      to: [
        {
          key_code: "grave_accent_and_tilde",
          modifiers: ["right_command"],
        },
      ],
    },
    b: {
      description: "Window: Back",
      to: [
        {
          key_code: "open_bracket",
          modifiers: ["right_command"],
        },
      ],
    },
    m: {
      description: "Window: Forward",
      to: [
        {
          key_code: "close_bracket",
          modifiers: ["right_command"],
        },
      ],
    },
  },

  // s = "System"
  s: {
    u: { description: "Volume Up", to: [{ key_code: "volume_increment" }] },
    j: { description: "Volume Down", to: [{ key_code: "volume_decrement" }] },
    i: { description: "Brightness Up", to: [{ key_code: "display_brightness_increment" }] },
    k: { description: "Brightness Down", to: [{ key_code: "display_brightness_decrement" }] },
    l: { description: "Lock Screen", to: [{ key_code: "q", modifiers: ["right_control", "right_command"] }] },
    p: { description: "Play / Pause", to: [{ key_code: "play_or_pause" }] },
    semicolon: { description: "Fast Forward", to: [{ key_code: "fastforward" }] },
    d: { ...open(`raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`), description: "Do Not Disturb Toggle" },
    t: { ...open(`raycast://extensions/raycast/system/toggle-system-appearance`), description: "Toggle Dark Mode" },
    c: { ...open("raycast://extensions/raycast/system/open-camera"), description: "Open Camera" },
    v: { description: "Push to Talk", to: [{ key_code: "spacebar", modifiers: ["left_option"] }] },
  },

  // v = "moVe" (hjkl like vim)
  v: {
    h: { description: "←", to: [{ key_code: "left_arrow" }] },
    j: { description: "↓", to: [{ key_code: "down_arrow" }] },
    k: { description: "↑", to: [{ key_code: "up_arrow" }] },
    l: { description: "→", to: [{ key_code: "right_arrow" }] },
    m: { description: "Magic Move (Homerow)", to: [{ key_code: "f", modifiers: ["right_control"] }] },
    s: { description: "Scroll Mode (Homerow)", to: [{ key_code: "j", modifiers: ["right_control"] }] },
    d: { description: "Dictionary", to: [{ key_code: "d", modifiers: ["right_shift", "right_command"] }] },
    u: { description: "Page Down", to: [{ key_code: "page_down" }] },
    i: { description: "Page Up", to: [{ key_code: "page_up" }] },
  },

  // c = Musi*c*
  c: {
    p: { description: "Play / Pause", to: [{ key_code: "play_or_pause" }] },
    n: { description: "Next Track", to: [{ key_code: "fastforward" }] },
    b: { description: "Previous Track", to: [{ key_code: "rewind" }] },
  },

  // r = "Raycast"
  r: {
    c: { ...open("raycast://extensions/thomas/color-picker/pick-color"), description: "Color Picker" },
    n: { ...open("raycast://script-commands/dismiss-notifications"), description: "Dismiss Notifications" },
    e: { ...open("raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"), description: "Emoji Search" },
    p: { ...open("raycast://extensions/raycast/raycast/confetti"), description: "Confetti" },
    h: { ...open("raycast://extensions/raycast/clipboard-history/clipboard-History"), description: "Clipboard History" },
    1: { ...open("raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"), description: "Connect Bluetooth Device 1" },
    // 2: { ...open("raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"), description: "Connect Bluetooth Device 2" },
  },
} as const;

const rules: KarabinerRules[] = [
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: { optional: ["any"] },
        },
        to: [{ set_variable: { name: "hyper", value: 1 } }],
        to_after_key_up: [{ set_variable: { name: "hyper", value: 0 } }],
        to_if_alone: [{ key_code: "escape" }],
        type: "basic",
      },
    ],
  },
  ...createHyperSubLayers(subLayers),
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: { show_in_menu_bar: false },
      profiles: [
        {
          name: "Default",
          virtual_hid_keyboard: { keyboard_type_v2: "ansi" },
          complex_modifications: { rules },
        },
      ],
    },
    null,
    2
  )
);

generateDocs(subLayers);
