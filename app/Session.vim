let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd C:/dev/zmk/app
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +7 boards/arm/porne/porne.dts
badd +1 boards/arm/nice_nano/Kconfig
badd +9 boards/arm/porne/Kconfig.board
badd +12 boards/arm/nice_nano/Kconfig.board
badd +3 boards/arm/porne/Kconfig
badd +6 boards/arm/nice_nano/Kconfig.defconfig
badd +7 boards/arm/porne/Kconfig.defconfig
badd +1 boards/arm/nice_nano/arduino_pro_micro_pins.dtsi
badd +1 boards/arm/nice_nano/board.cmake
badd +5 boards/arm/porne/board.cmake
badd +16 boards/arm/nice_nano/nice_nano_v2.dts
badd +22 boards/arm/nice_nano/nice_nano.dtsi
badd +32 boards/arm/nice_nano/nice_nano-pinctrl.dtsi
badd +1 boards/arm/porne/porne-pinctrl.dtsi
badd +1 boards/arm/porne/nice_nano.dtsi
badd +1 boards/arm/porne/porne.yaml
badd +9 boards/arm/porne/porne.zmk.yml
badd +5 boards/arm/porne/porne_defconfig
badd +1 boards/arm/kekos/Kconfig
badd +1 boards/arm/kekos/Kconfig.board
badd +7 boards/arm/kekos/Kconfig.defconfig
badd +1 boards/arm/porne/arduino_pro_micro_pins.dtsi
badd +1 boards/arm/porne/nice_nano-pinctrl.dtsi
badd +1 boards/arm/nrfmicro/Kconfig
badd +1 boards/arm/porne/custom_status_screen.h
badd +18 boards/arm/porne/custom_status_screen.c
badd +62 boards/arm/porne/corneish_zen_v2_right_defconfig
badd +1 boards/arm/porne/CMakeLists.txt
badd +1 boards/arm/porne/corneish_zen.conf
badd +19 boards/arm/corneish_zen/corneish_zen.yaml
badd +1 boards/arm/corneish_zen/board.cmake
badd +1 boards/arm/corneish_zen/CMakeLists.txt
badd +43 boards/arm/corneish_zen/custom_status_screen.c
badd +98 build/left/zephyr/include/generated/autoconf.h
badd +19 boards/arm/corneish_zen/widgets/battery_status.h
badd +90 boards/arm/corneish_zen/widgets/battery_status.c
badd +76 src/display/widgets/battery_status.c
badd +36 include/zmk/event_manager.h
badd +20 boards/arm/corneish_zen/widgets/peripheral_status.c
badd +1 boards/arm/corneish_zen/widgets/icons/batt_0.c
badd +1 boards/arm/corneish_zen/corneish_zen_v2.yaml
badd +21 boards/arm/corneish_zen/corneish_zen.keymap
badd +32 boards/arm/corneish_zen/corneish_zen.dtsi
badd +33 include/zmk/display.h
badd +89 boards/arm/corneish_zen/corneish_zen_v1_left.dts
badd +28 boards/arm/corneish_zen/widgets/icons/batt_100_chg.c
badd +15 boards/arm/corneish_zen/corneish_zen_v1.zmk.yml
badd +2 boards/arm/nice_nano/nice_nano_defconfig
badd +1 boards/arm/nice_nano/nice_nano.yaml
badd +17 src/main.c
badd +15 src/display/main.c
badd +58 C:/dev/MegaApp/Assets/Scripts/Core/Infrastructure/UserAuth/AuthService/ServerAuthService.cs
badd +1 boards/arm/corneish_zen/Kconfig
badd +5 boards/arm/corneish_zen/corneish_zen.conf
badd +1 boards/arm/corneish_zen/Kconfig.board
badd +24 boards/arm/corneish_zen/Kconfig.defconfig
badd +49 boards/arm/corneish_zen/corneish_zen_v1_left_defconfig
badd +47 boards/arm/corneish_zen/corneish_zen_v2_right.dts
badd +59 boards/arm/corneish_zen/corneish_zen_v2_left_defconfig
badd +10 C:/dev/zmk/zephyr/drivers/gpio/Kconfig.nrfx
badd +1 boards/arm/corneish_zen/corneish_zen_v2_left.dts
badd +1 boards/arm/corneish_zen/widgets/output_status.c
badd +1 boards/arm/corneish_zen/widgets/layer_status.c
badd +1 boards/arm/planck/CMakeLists.txt
badd +2 boards/arm/gamma/CMakeLists.txt
badd +1 boards/arm/planck/Kconfig.board
badd +15 boards/arm/gamma/Kconfig.board
badd +8 boards/arm/nice_nano/nice_nano_v2_defconfig
badd +5 boards/arm/nice_nano/nice_nano_v2.zmk.yml
badd +14 boards/arm/nice_nano/nice_nano_v2.yaml
badd +1 boards/arm/nice_nano/nice_nano.dts
badd +1 C:/dev/zmk/zephyr/boards/arm/adafruit_feather_nrf52840/feather_connector.dtsi
badd +8 C:/dev/zmk/zephyr/boards/arm/adafruit_feather_nrf52840/adafruit_feather_nrf52840.dts
badd +11 C:/dev/zmk/zephyr/dts/arm/nordic/nrf52840_qiaa.dtsi
badd +1 C:/dev/zmk/zephyr/dts/arm/nordic/nrf52840.dtsi
badd +1 boards/arm/gamma/board.cmake
badd +69 boards/arm/gamma/Kconfig.defconfig
badd +70 boards/arm/gamma/gamma.keymap
badd +1 boards/arm/gamma/gamma.yaml
badd +4 boards/arm/gamma/gamma.zmk.yml
badd +1 boards/arm/nrf52840_m2/board.cmake
badd +2 boards/arm/glove80/CMakeLists.txt
badd +1 boards/arm/nice60/board.cmake
badd +1 boards/arm/gamma/gamma.conf
badd +1 boards/arm/gamma/Kconfig
badd +3 boards/arm/ferris/ferris_rev02_defconfig
badd +1 boards/arm/ferris/ferris_rev02.zmk.yml
badd +1 boards/arm/ferris/ferris_rev02.yaml
badd +1 boards/arm/ferris/ferris_rev02.keymap
badd +1 boards/arm/ferris/ferris_rev02.dts
badd +1 boards/arm/ferris/board.cmake
badd +1 boards/arm/ferris/README.md
badd +11 boards/arm/ferris/Kconfig.defconfig
badd +1 boards/arm/ferris/Kconfig.board
badd +9 boards/arm/gamma/gamma.c
badd +240 ~/AppData/Local/nvim/init.vim
badd +310 include/dt-bindings/zmk/keys.h
badd +34 src/battery.c
badd +85 boards/shields/nice_view/widgets/status.c
badd +98 boards/arm/gamma/digits.h
badd +1 boards/arm/corneish_zen/custom_status_screen.h
badd +9 include/zmk/battery.h
badd +16 include/zmk/usb.h
badd +12 include/zmk/events/battery_state_changed.h
badd +99 build/zephyr/include/generated/syscalls/sensor.h
badd +21 src/behaviors/behavior_hold_tap.c
badd +76 src/activity.c
badd +274 tests/ble/central/src/main.c
badd +239 src/ble.c
badd +1 boards/arm/glove80/usb_serial_number.c
badd +29 boards/arm/planck/planck_rev6.dts
badd +23 boards/arm/planck/planck_rev6.keymap
badd +11 boards/arm/planck/planck_rev6.yaml
badd +4 boards/arm/planck/planck_rev6.zmk.yml
badd +1 boards/arm/planck/planck_rev6_defconfig
badd +1 boards/arm/planck/board.cmake
badd +1 boards/arm/planck/Kconfig.defconfig
badd +39 src/behaviors/behavior_mouse_key_press.c
badd +16 src/behaviors/behavior_key_press.c
badd +228 src/behaviors/behavior_macro.c
badd +50 src/behaviors/behavior_reset.c
badd +74 src/kscan.c
badd +542 src/combo.c
badd +192 src/backlight.c
badd +329 src/keymap.c
badd +32 boards/arm/nrfmicro/nrfmicro_13.dts
badd +1 dts/bindings/behaviors/zero_param.yaml
badd +1 dts/bindings/behaviors/two_param.yaml
badd +1 dts/bindings/behaviors/macro_base.yaml
badd +8 dts/bindings/behaviors/zmk,behavior-key-press.yaml
badd +10 dts/bindings/behaviors/one_param.yaml
badd +8 dts/bindings/behaviors/zmk,behavior-backlight.yaml
badd +1 dts/bindings/behaviors/zmk,behavior-bluetooth.yaml
badd +1 dts/bindings/behaviors/zmk,behavior-caps-word.yaml
badd +1 dts/bindings/behaviors/zmk,behavior-to-layer.yaml
badd +1 dts/bindings/behaviors/zmk,behavior-key-toggle.yaml
badd +1 dts/bindings/behaviors/zmk,behavior-key-repeat.yaml
badd +8 dts/bindings/behaviors/zmk,behavior-bat-display.yaml
badd +36 src/behaviors/behavior_bt.c
badd +21 src/behaviors/behavior_bat_display.c
badd +7 src/behaviors/behavior_sensor_rotate.c
badd +71 src/behaviors/behavior_sticky_key.c
badd +1 src/behaviors/behavior_tap_dance.c
badd +75 src/behaviors/behavior_ext_power.c
badd +30 boards/arm/corneish_zen/corneish_zen_v1_right_defconfig
badd +37 boards/arm/puchi_ble/puchi_ble_v1.dts
badd +8 boards/arm/puchi_ble/puchi_ble_v1-pinctrl.dtsi
badd +7 boards/shields/snap/snap.zmk.yml
badd +202 module/drivers/sensor/max17048/max17048.c
badd +35 boards/arm/corneish_zen/corneish_zen_v2_right_defconfig
badd +1 boards/arm/corneish_zen/corneish_zen_v2.zmk.yml
badd +41 C:/dev/Adafruit_nRF52_Bootloader/src/boards/gamma/board.h
badd +49 C:/dev/Adafruit_nRF52_Bootloader/src/boards/boards.h
badd +305 C:/dev/Adafruit_nRF52_Bootloader/src/boards/boards.c
badd +51 C:/dev/zmk/zephyr/include/zephyr/drivers/gpio.h
badd +44 C:/dev/zmk/zephyr/include/zephyr/bluetooth/services/bas.h
badd +75 boards/shields/zmk_uno/zmk_uno.dtsi
badd +18 boards/arm/gamma/gamma_left_defconfig
badd +39 CMakeLists.txt
badd +18 boards/arm/gamma/gamma.dtsi
badd +1 boards/arm/gamma/gamma_left.dts
badd +1 boards/arm/gamma/gamma_right.dts
badd +33 boards/arm/gamma/gamma_right_defconfig
badd +20 boards/shields/zodiark/Kconfig.defconfig
badd +25 boards/arm/nrfmicro/nrfmicro_11_flipped_defconfig
badd +30 boards/arm/gamma/gamma_dongle_defconfig
badd +10 boards/shields/settings_reset/Kconfig.defconfig
badd +9 C:/dev/zmk/app/include/zmk/split/bluetooth/peripheral.h
badd +66 C:/dev/zmk/app/boards/arm/gamma/gamma_dongle.c
badd +42 C:/dev/zmk/app/boards/arm/gamma/gamma_dongle.dts
badd +12 include/zmk/ble.h
badd +14 include/zmk/behavior.h
badd +614 C:/dev/zmk/zephyr/include/zephyr/devicetree.h
badd +87 C:/dev/zmk/zephyr/include/zephyr/drivers/pwm.h
badd +370 C:/dev/zmk/zephyr/include/zephyr/bluetooth/conn.h
badd +700 src/split/bluetooth/central.c
badd +14 include/zmk/split/bluetooth/central.h
badd +19 src/hid_indicators.c
badd +1 include/zmk/hid_indicators.h
badd +28 C:/dev/zmk/app/boards/arm/gamma/gamma_halves.dts
badd +126 C:/dev/zmk/app/build/zephyr/include/generated/syscalls/kernel.h
badd +176 C:/dev/zmk/app/build/zephyr/include/generated/syscalls/gpio.h
badd +33 C:/dev/zmk/app/src/usb.c
badd +15 dts/behaviors/key_press.dtsi
badd +14 C:/dev/zmk/app/dts/behaviors/bluetooth.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/sticky_key.dtsi
badd +8 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-check-battery.yaml
badd +73 C:/dev/zmk/app/src/behaviors/behavior_backlight.c
badd +1 C:/dev/zmk/app/include/drivers/behavior.h
badd +14 dts/behaviors/reset.dtsi
badd +15 C:/dev/zmk/app/dts/behaviors/check_battery.dtsi
badd +11 C:/dev/zmk/app/dts/behaviors/gresc.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/ext_power.dtsi
badd +12 dts/behaviors.dtsi
badd +1 C:/dev/zmk/app/src/behaviors/behavior_none.c
badd +31 C:/dev/zmk/app/src/behaviors/behavior_rgb_underglow.c
badd +3 C:/dev/zmk/app/boards/arm/gamma/gamma.h
badd +1 C:/dev/zmk/zephyr/include/zephyr/device.h
badd +1 C:/dev/zmk/app/include/zmk/rgb_underglow.h
badd +1 C:/dev/zmk/app/dts/behaviors/to_layer.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/toggle_layer.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/transparent.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/soft_off.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/outputs.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/none.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/mouse_key_press.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/caps_word.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/backlight.dtsi
badd +1 C:/dev/zmk/app/dts/behaviors/macros.dtsi
badd +9 C:/dev/zmk/app/dts/behaviors/mod_tap.dtsi
badd +64 src/split/bluetooth/peripheral.c
badd +3 C:/dev/zmk/app/include/zmk/check_battery.h
badd +20 C:/dev/zmk/app/include/zmk/hid.h
badd +1 C:/dev/zmk/app/include/zmk/kscan.h
badd +1 C:/dev/zmk/app/include/zmk/matrix.h
badd +12 C:/dev/zmk/app/include/zmk/mouse.h
badd +20 src/mouse.c
badd +279 src/endpoints.c
badd +124 C:/dev/zmk/zephyr/include/zephyr/sys/util_macro.h
badd +50 C:/dev/zmk/zephyr/include/zephyr/sys/util_internal.h
badd +2 tests/wpm/2-multiple_keypress/native_posix_64.conf
badd +17 Kconfig
badd +43 src/display/status_screen.c
badd +1 module/dts/bindings/display/gooddisplay,il0323.yaml
badd +22 module/drivers/display/il0323.c
badd +1 C:/dev/zmk/app/module/drivers/display/il0323_regs.h
badd +44 src/display/widgets/peripheral_status.c
badd +1 C:/dev/zmk/zephyr/include/zephyr/drivers/display.h
badd +12 C:/dev/zmk/app/include/zmk/display/widgets/peripheral_status.h
badd +10 C:/dev/zmk/app/src/events/battery_state_changed.c
badd +166 C:/dev/zmk/zephyr/include/zephyr/sys/slist.h
badd +45 C:/dev/zmk/zephyr/include/zephyr/sys/list_gen.h
badd +498 src/rgb_underglow.c
badd +250 C:/dev/zmk/zephyr/include/zephyr/settings/settings.h
badd +7 C:/dev/zmk/app/include/dt-bindings/zmk/rgb.h
badd +1290 C:/dev/zmk/zephyr/include/zephyr/kernel.h
badd +121 C:/dev/zmk/zephyr/include/zephyr/sys_clock.h
badd +1 module/drivers/kscan/kscan_gpio.c
badd +1 module/drivers/kscan/kscan_gpio_direct.c
badd +16 C:/dev/zmk/app/src/workqueue.c
badd +169 ~/zephyr-sdk-0.16.3/arm-zephyr-eabi/arm-zephyr-eabi/include/sys/errno.h
badd +7 C:/dev/zmk/app/src/events/activity_state_changed.c
badd +13 C:/dev/zmk/app/include/zmk/events/activity_state_changed.h
badd +1 include/zmk/workqueue.h
badd +46 C:/dev/zmk/zephyr/include/zephyr/sys/poweroff.h
badd +95 src/pm.c
badd +10 src/events/usb_conn_state_changed.c
badd +1 C:/dev/zmk/app/src/events/endpoint_changed.c
badd +1 C:/dev/zmk/app/src/events/ble_active_profile_changed.c
badd +7 src/conditional_layer.c
badd +26 C:/dev/zmk/app/src/behaviors/behavior_check_battery.c
badd +1 C:/dev/zmk/app/src/behaviors/behavior_sensor_rotate_common.c
badd +9 C:/dev/zmk/app/include/zmk/pm.h
badd +16 include/zmk/events/usb_conn_state_changed.h
argglobal
%argdel
edit boards/arm/gamma/gamma_left_defconfig
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 136 + 137) / 274)
exe 'vert 2resize ' . ((&columns * 137 + 137) / 274)
argglobal
balt boards/arm/gamma/Kconfig
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("boards/arm/gamma/gamma_right_defconfig", ":p")) | buffer boards/arm/gamma/gamma_right_defconfig | else | edit boards/arm/gamma/gamma_right_defconfig | endif
if &buftype ==# 'terminal'
  silent file boards/arm/gamma/gamma_right_defconfig
endif
balt boards/arm/gamma/gamma_dongle_defconfig
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 136 + 137) / 274)
exe 'vert 2resize ' . ((&columns * 137 + 137) / 274)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
