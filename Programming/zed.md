# Zed Configuration

## Prerequisites

This guide is for basic shortcuts and commands related to Zed.

## Extensions

Currently I do not need any extensions. Everything seems in place for my workflow with Python, Docker, YAML, JSON, Go.

## Settings

```jsonc
// Zed settings
//
// For information on how to configure Zed, see the Zed
// documentation: https://zed.dev/docs/configuring-zed
//
// To see all of Zed's default settings without changing your
// custom settings, run `zed: open default settings` from the
// command palette (cmd-shift-p / ctrl-shift-p)
{
  "telemetry": {
    "diagnostics": false,
    "metrics": false
  },
  "base_keymap": "VSCode",
  "icon_theme": "Zed (Default)",
  "ui_font_size": 22,
  "buffer_font_size": 18,
  "theme": {
    "mode": "dark",
    "light": "One Light",
    "dark": "One Dark"
  },
  "disable_ai": true,
  "restore_on_startup": "none",
  "buffer_font_family": "Roboto Mono",
  "buffer_font_fallbacks": [".ZedMono", "Andale Mono"]
}
```

I am not 100% happy with the themes available in Zed. I plan to create my own. The Zed Icons instead are quite nice.
