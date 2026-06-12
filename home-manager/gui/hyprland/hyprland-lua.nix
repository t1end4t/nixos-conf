{
  pkgs,
  hostConfig ? "",
}:
let
  ROOT = toString ./.;
in
''
  local mod = "SUPER"

  local function exec(command)
    return hl.dsp.exec_cmd(command)
  end

  ${hostConfig}

  hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("${pkgs.hyprpaper}/bin/hyprpaper")
    hl.exec_cmd("${pkgs.waybar}/bin/waybar")
    hl.exec_cmd("${pkgs.mako}/bin/mako --default-timeout 5000")
    hl.exec_cmd("${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store")
    hl.exec_cmd("${pkgs.hyprsunset}/bin/hyprsunset")
    hl.exec_cmd("${pkgs.hypridle}/bin/hypridle")
    hl.exec_cmd("${pkgs.fcitx5}/bin/fcitx5")
  end)

  hl.config({
    general = {
      gaps_in = 2,
      gaps_out = 2,
      layout = "master",
    },
    decoration = {
      blur = { enabled = false },
      shadow = { enabled = false },
    },
    input = {
      accel_profile = "adaptive",
      touchpad = {
        natural_scroll = true,
        drag_lock = 2,
        middle_button_emulation = true,
      },
    },
    cursor = {
      hide_on_key_press = true,
      inactive_timeout = 3,
    },
    animations = { enabled = false },
  })

  hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
  hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
  hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
  hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

  hl.bind(mod .. " + S", exec("sh ${ROOT}/swap_containers.sh"))
  hl.bind(mod .. " + SHIFT + S", exec("sh ${ROOT}/swap_workspaces.sh"))

  hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
  hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
  hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
  hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

  hl.bind(mod .. " + SHIFT + RETURN", exec("${pkgs.rofi}/bin/rofi -show drun"))
  hl.bind(mod .. " + D", exec("${pkgs.rofi}/bin/rofi -show run"))
  hl.bind(mod .. " + SHIFT + Q", exec("${pkgs.wlogout}/bin/wlogout"))
  hl.bind(mod .. " + CTRL + L", exec("${pkgs.hyprlock}/bin/hyprlock"))

  hl.bind(mod .. " + Q", hl.dsp.window.close())
  hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
  hl.bind(mod .. " + TAB", exec([[${pkgs.hyprland}/bin/hyprctl eval 'hl.dispatch("workspace previous")']]))

  hl.bind(mod .. " + B", exec("firefox"))
  hl.bind(mod .. " + M", exec("${pkgs.thunderbird}/bin/thunderbird"))
  hl.bind(mod .. " + E", exec("${pkgs.kitty}/bin/kitty -e ${pkgs.yazi}/bin/yazi"))
  hl.bind(mod .. " + RETURN", exec("${pkgs.kitty}/bin/kitty"))

  hl.bind(mod .. " + V", exec("${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"))

  hl.bind("PRINT", exec([[${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png]]))
  hl.bind(mod .. " + SHIFT + PRINT", exec([[${pkgs.grim}/bin/grim -o $(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .name')]]))

  for i = 1, 9 do
    hl.bind(mod .. " + code:1" .. (i - 1), hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + code:1" .. (i - 1), hl.dsp.window.move({ workspace = i }))
  end

  hl.bind("XF86MonBrightnessDown", exec("${pkgs.brightnessctl}/bin/brightnessctl set 5%-"), { locked = true, repeating = true })
  hl.bind("XF86MonBrightnessUp", exec("${pkgs.brightnessctl}/bin/brightnessctl set +5%"), { locked = true, repeating = true })
  hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
  hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
  hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
  hl.bind("XF86AudioPlay", exec("${pkgs.playerctl}/bin/playerctl play-pause"), { locked = true })
  hl.bind("XF86AudioNext", exec("${pkgs.playerctl}/bin/playerctl next"), { locked = true })
  hl.bind("XF86AudioPrev", exec("${pkgs.playerctl}/bin/playerctl prev"), { locked = true })
''
