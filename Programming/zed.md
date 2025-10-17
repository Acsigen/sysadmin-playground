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
  "buffer_font_fallbacks": [".ZedMono", "Andale Mono"],
  "experimental.theme_overrides": {
    "border": "#222222",
    "border.variant": "#222222",
    "border.focused": "#222222",
    "border.selected": "#FFFFFF", // Unknown
    "border.transparent": "#00000000",
    "border.disabled": "#FFFFFF", //Unknown
    "elevated_surface.background": "#2F2F2F",
    "surface.background": "#FFF", // Unknown
    "background": "#222222",
    "element.background": "#FFF", //Unknown
    "element.hover": "#4A4A4A",
    "element.active": "#FFF", //Unknown
    "element.selected": "#4A4A4A",
    "element.disabled": "#FFF", //Unknown
    "drop_target.background": "#F2F2F22F",
    "ghost_element.background": "#2F2F2F", //Butoanele din bara de jos
    "ghost_element.hover": "#4A4A4A",
    "ghost_element.active": "#0F0F0F",
    "ghost_element.selected": "#4A4A4A",
    "ghost_element.disabled": "#FFF", //Unknown
    "text": "#F2F2F2",
    "text.muted": "#AAAAAA",
    "text.placeholder": "#AAAAAA",
    "text.disabled": "#AAAAAA",
    "text.accent": "#F2F2F2",
    "icon": "#FFF", //Unknown
    "icon.muted": "#FFF", //Unknown
    "icon.disabled": "#FFF", // Unknown
    "icon.placeholder": "#FFF", //Unknown
    "icon.accent": "#FFF", //Unknown
    "status_bar.background": "#2F2F2F",
    "title_bar.background": "#2F2F2F",
    "title_bar.inactive_background": "#FFF", //Unknown
    "toolbar.background": "#2F2F2F",
    "tab_bar.background": "#1F1F1F",
    "tab.inactive_background": "#2A2A2A",
    "tab.active_background": "#2F2F2F",
    "search.match_background": "#A2A2A2",
    "panel.background": "#2F2F2F",
    "panel.focused_border": null,
    "pane.focused_border": null,
    "scrollbar.thumb.background": "#A2A2A22F",
    "scrollbar.thumb.hover_background": "#F2F2F22F",
    "scrollbar.thumb.border": "#A2A2A22F",
    "scrollbar.track.background": "#00000000",
    "scrollbar.track.border": "#F2F2F22F",
    "editor.foreground": "#F2F2F2",
    "editor.background": "#222222",
    "editor.gutter.background": "#222222",
    "editor.subheader.background": "#FFF", //Unknown
    "editor.active_line.background": "#2F2F2F",
    "editor.highlighted_line.background": "#FFF", //Unknown
    "editor.line_number": "#777777",
    "editor.active_line_number": "#F2F2F2",
    "editor.hover_line_number": "#F2F2F2",
    "editor.invisible": "#FFF", //Cannot see effects
    "editor.wrap_guide": "#FFF", //Unknown
    "editor.active_wrap_guide": "#FFF", //Unknown
    "editor.document_highlight.read_background": "#AFAFAF2F",
    "editor.document_highlight.write_background": "#AFAFAF2F",
    "terminal.background": "#222222",
    "terminal.foreground": "#F2F2F2",
    "syntax": {
      "comment": {
        "color": "#AAAAAA"
      }
    }
  }
}
```

I am not 100% happy with the themes available in Zed. I plan to create my own. The Zed Icons instead are quite nice.
