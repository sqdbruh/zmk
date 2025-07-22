let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd C:/dev/zmk
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 app/boards/arm/porne/porne.dts
badd +1 app/boards/arm/nice_nano/Kconfig
badd +9 app/boards/arm/porne/Kconfig.board
badd +12 app/boards/arm/nice_nano/Kconfig.board
badd +3 app/boards/arm/porne/Kconfig
badd +6 app/boards/arm/nice_nano/Kconfig.defconfig
badd +7 app/boards/arm/porne/Kconfig.defconfig
badd +1 app/boards/arm/nice_nano/arduino_pro_micro_pins.dtsi
badd +1 app/boards/arm/nice_nano/board.cmake
badd +5 app/boards/arm/porne/board.cmake
badd +1 app/boards/arm/nice_nano/nice_nano_v2.dts
badd +94 app/boards/arm/nice_nano/nice_nano.dtsi
badd +32 app/boards/arm/nice_nano/nice_nano-pinctrl.dtsi
badd +1 app/boards/arm/porne/porne-pinctrl.dtsi
badd +1 app/boards/arm/porne/nice_nano.dtsi
badd +1 app/boards/arm/porne/porne.yaml
badd +9 app/boards/arm/porne/porne.zmk.yml
badd +5 app/boards/arm/porne/porne_defconfig
badd +1 app/boards/arm/kekos/Kconfig
badd +1 app/boards/arm/kekos/Kconfig.board
badd +7 app/boards/arm/kekos/Kconfig.defconfig
badd +1 app/boards/arm/porne/arduino_pro_micro_pins.dtsi
badd +1 app/boards/arm/porne/nice_nano-pinctrl.dtsi
badd +1 app/boards/arm/nrfmicro/Kconfig
badd +1 app/boards/arm/porne/custom_status_screen.h
badd +18 app/boards/arm/porne/custom_status_screen.c
badd +62 app/boards/arm/porne/corneish_zen_v2_right_defconfig
badd +1 app/boards/arm/porne/CMakeLists.txt
badd +1 app/boards/arm/porne/corneish_zen.conf
badd +19 app/boards/arm/corneish_zen/corneish_zen.yaml
badd +1 app/boards/arm/corneish_zen/board.cmake
badd +1 app/boards/arm/corneish_zen/CMakeLists.txt
badd +43 app/boards/arm/corneish_zen/custom_status_screen.c
badd +98 app/build/left/zephyr/include/generated/autoconf.h
badd +19 app/boards/arm/corneish_zen/widgets/battery_status.h
badd +90 app/boards/arm/corneish_zen/widgets/battery_status.c
badd +66 app/src/display/widgets/battery_status.c
badd +36 app/include/zmk/event_manager.h
badd +32 app/boards/arm/corneish_zen/widgets/peripheral_status.c
badd +1 app/boards/arm/corneish_zen/widgets/icons/batt_0.c
badd +1 app/boards/arm/corneish_zen/corneish_zen_v2.yaml
badd +1 app/boards/arm/corneish_zen/corneish_zen.keymap
badd +32 app/boards/arm/corneish_zen/corneish_zen.dtsi
badd +33 app/include/zmk/display.h
badd +89 app/boards/arm/corneish_zen/corneish_zen_v1_left.dts
badd +28 app/boards/arm/corneish_zen/widgets/icons/batt_100_chg.c
badd +15 app/boards/arm/corneish_zen/corneish_zen_v1.zmk.yml
badd +2 app/boards/arm/nice_nano/nice_nano_defconfig
badd +1 app/boards/arm/nice_nano/nice_nano.yaml
badd +23 app/src/main.c
badd +122 app/src/display/main.c
badd +58 C:/dev/MegaApp/Assets/Scripts/Core/Infrastructure/UserAuth/AuthService/ServerAuthService.cs
badd +1 app/boards/arm/corneish_zen/Kconfig
badd +5 app/boards/arm/corneish_zen/corneish_zen.conf
badd +1 app/boards/arm/corneish_zen/Kconfig.board
badd +24 app/boards/arm/corneish_zen/Kconfig.defconfig
badd +39 app/boards/arm/corneish_zen/corneish_zen_v1_left_defconfig
badd +47 app/boards/arm/corneish_zen/corneish_zen_v2_right.dts
badd +59 app/boards/arm/corneish_zen/corneish_zen_v2_left_defconfig
badd +10 zephyr/drivers/gpio/Kconfig.nrfx
badd +40 app/boards/arm/corneish_zen/corneish_zen_v2_left.dts
badd +1 app/boards/arm/corneish_zen/widgets/output_status.c
badd +1 app/boards/arm/corneish_zen/widgets/layer_status.c
badd +1 app/boards/arm/planck/CMakeLists.txt
badd +1 app/boards/arm/gamma/CMakeLists.txt
badd +1 app/boards/arm/planck/Kconfig.board
badd +9 app/boards/arm/gamma/Kconfig.board
badd +8 app/boards/arm/nice_nano/nice_nano_v2_defconfig
badd +5 app/boards/arm/nice_nano/nice_nano_v2.zmk.yml
badd +14 app/boards/arm/nice_nano/nice_nano_v2.yaml
badd +1 app/boards/arm/nice_nano/nice_nano.dts
badd +1 zephyr/boards/arm/adafruit_feather_nrf52840/feather_connector.dtsi
badd +8 zephyr/boards/arm/adafruit_feather_nrf52840/adafruit_feather_nrf52840.dts
badd +11 zephyr/dts/arm/nordic/nrf52840_qiaa.dtsi
badd +1 zephyr/dts/arm/nordic/nrf52840.dtsi
badd +6 app/boards/arm/gamma/board.cmake
badd +69 app/boards/arm/gamma/Kconfig.defconfig
badd +76 app/boards/arm/gamma/gamma.keymap
badd +23 app/boards/arm/gamma/gamma.yaml
badd +4 app/boards/arm/gamma/gamma.zmk.yml
badd +1 app/boards/arm/nrf52840_m2/board.cmake
badd +2 app/boards/arm/glove80/CMakeLists.txt
badd +1 app/boards/arm/nice60/board.cmake
badd +1 app/boards/arm/gamma/gamma.conf
badd +1 app/boards/arm/gamma/Kconfig
badd +3 app/boards/arm/ferris/ferris_rev02_defconfig
badd +1 app/boards/arm/ferris/ferris_rev02.zmk.yml
badd +1 app/boards/arm/ferris/ferris_rev02.yaml
badd +1 app/boards/arm/ferris/ferris_rev02.keymap
badd +1 app/boards/arm/ferris/ferris_rev02.dts
badd +1 app/boards/arm/ferris/board.cmake
badd +1 app/boards/arm/ferris/README.md
badd +11 app/boards/arm/ferris/Kconfig.defconfig
badd +1 app/boards/arm/ferris/Kconfig.board
badd +240 ~/AppData/Local/nvim/init.vim
badd +310 app/include/dt-bindings/zmk/keys.h
badd +28 app/src/battery.c
badd +250 app/boards/shields/nice_view/widgets/status.c
badd +98 app/boards/arm/gamma/digits.h
badd +1 app/boards/arm/corneish_zen/custom_status_screen.h
badd +9 app/include/zmk/battery.h
badd +16 app/include/zmk/usb.h
badd +18 app/include/zmk/events/battery_state_changed.h
badd +99 app/build/zephyr/include/generated/syscalls/sensor.h
badd +21 app/src/behaviors/behavior_hold_tap.c
badd +74 app/src/activity.c
badd +274 app/tests/ble/central/src/main.c
badd +475 app/src/ble.c
badd +1 app/boards/arm/glove80/usb_serial_number.c
badd +29 app/boards/arm/planck/planck_rev6.dts
badd +23 app/boards/arm/planck/planck_rev6.keymap
badd +11 app/boards/arm/planck/planck_rev6.yaml
badd +4 app/boards/arm/planck/planck_rev6.zmk.yml
badd +1 app/boards/arm/planck/planck_rev6_defconfig
badd +1 app/boards/arm/planck/board.cmake
badd +1 app/boards/arm/planck/Kconfig.defconfig
badd +39 app/src/behaviors/behavior_mouse_key_press.c
badd +16 app/src/behaviors/behavior_key_press.c
badd +228 app/src/behaviors/behavior_macro.c
badd +50 app/src/behaviors/behavior_reset.c
badd +74 app/src/kscan.c
badd +542 app/src/combo.c
badd +1 app/src/backlight.c
badd +329 app/src/keymap.c
badd +32 app/boards/arm/nrfmicro/nrfmicro_13.dts
badd +1 app/dts/bindings/behaviors/zero_param.yaml
badd +1 app/dts/bindings/behaviors/two_param.yaml
badd +1 app/dts/bindings/behaviors/macro_base.yaml
badd +8 app/dts/bindings/behaviors/zmk,behavior-key-press.yaml
badd +10 app/dts/bindings/behaviors/one_param.yaml
badd +8 app/dts/bindings/behaviors/zmk,behavior-backlight.yaml
badd +1 app/dts/bindings/behaviors/zmk,behavior-bluetooth.yaml
badd +1 app/dts/bindings/behaviors/zmk,behavior-caps-word.yaml
badd +1 app/dts/bindings/behaviors/zmk,behavior-to-layer.yaml
badd +1 app/dts/bindings/behaviors/zmk,behavior-key-toggle.yaml
badd +1 app/dts/bindings/behaviors/zmk,behavior-key-repeat.yaml
badd +8 app/dts/bindings/behaviors/zmk,behavior-bat-display.yaml
badd +36 app/src/behaviors/behavior_bt.c
badd +21 app/src/behaviors/behavior_bat_display.c
badd +7 app/src/behaviors/behavior_sensor_rotate.c
badd +71 app/src/behaviors/behavior_sticky_key.c
badd +218 app/src/behaviors/behavior_tap_dance.c
badd +75 app/src/behaviors/behavior_ext_power.c
badd +30 app/boards/arm/corneish_zen/corneish_zen_v1_right_defconfig
badd +37 app/boards/arm/puchi_ble/puchi_ble_v1.dts
badd +8 app/boards/arm/puchi_ble/puchi_ble_v1-pinctrl.dtsi
badd +7 app/boards/shields/snap/snap.zmk.yml
badd +36 app/module/drivers/sensor/max17048/max17048.c
badd +35 app/boards/arm/corneish_zen/corneish_zen_v2_right_defconfig
badd +1 app/boards/arm/corneish_zen/corneish_zen_v2.zmk.yml
badd +41 C:/dev/Adafruit_nRF52_Bootloader/src/boards/gamma/board.h
badd +49 C:/dev/Adafruit_nRF52_Bootloader/src/boards/boards.h
badd +305 C:/dev/Adafruit_nRF52_Bootloader/src/boards/boards.c
badd +51 zephyr/include/zephyr/drivers/gpio.h
badd +44 zephyr/include/zephyr/bluetooth/services/bas.h
badd +75 app/boards/shields/zmk_uno/zmk_uno.dtsi
badd +50 app/boards/arm/gamma/gamma_left_defconfig
badd +125 app/CMakeLists.txt
badd +24 app/boards/arm/gamma/gamma.dtsi
badd +1 app/boards/arm/gamma/gamma_left.dts
badd +1 app/boards/arm/gamma/gamma_right.dts
badd +43 app/boards/arm/gamma/gamma_right_defconfig
badd +20 app/boards/shields/zodiark/Kconfig.defconfig
badd +25 app/boards/arm/nrfmicro/nrfmicro_11_flipped_defconfig
badd +35 app/boards/arm/gamma/gamma_dongle_defconfig
badd +10 app/boards/shields/settings_reset/Kconfig.defconfig
badd +9 app/include/zmk/split/bluetooth/peripheral.h
badd +75 app/boards/arm/gamma/gamma_dongle.c
badd +44 app/boards/arm/gamma/gamma_dongle.dts
badd +12 app/include/zmk/ble.h
badd +14 app/include/zmk/behavior.h
badd +614 zephyr/include/zephyr/devicetree.h
badd +87 zephyr/include/zephyr/drivers/pwm.h
badd +370 zephyr/include/zephyr/bluetooth/conn.h
badd +700 app/src/split/bluetooth/central.c
badd +14 app/include/zmk/split/bluetooth/central.h
badd +33 app/src/hid_indicators.c
badd +1 app/include/zmk/hid_indicators.h
badd +26 app/boards/arm/gamma/gamma_halves.dts
badd +126 app/build/zephyr/include/generated/syscalls/kernel.h
badd +176 app/build/zephyr/include/generated/syscalls/gpio.h
badd +34 app/src/usb.c
badd +15 app/dts/behaviors/key_press.dtsi
badd +14 app/dts/behaviors/bluetooth.dtsi
badd +1 app/dts/behaviors/sticky_key.dtsi
badd +8 app/dts/bindings/behaviors/zmk,behavior-check-battery.yaml
badd +73 app/src/behaviors/behavior_backlight.c
badd +1 app/include/drivers/behavior.h
badd +14 app/dts/behaviors/reset.dtsi
badd +15 app/dts/behaviors/check_battery.dtsi
badd +11 app/dts/behaviors/gresc.dtsi
badd +1 app/dts/behaviors/ext_power.dtsi
badd +1 app/dts/behaviors.dtsi
badd +1 app/src/behaviors/behavior_none.c
badd +129 app/src/behaviors/behavior_rgb_underglow.c
badd +3 app/boards/arm/gamma/gamma.h
badd +1 zephyr/include/zephyr/device.h
badd +1 app/include/zmk/rgb_underglow.h
badd +1 app/dts/behaviors/to_layer.dtsi
badd +1 app/dts/behaviors/toggle_layer.dtsi
badd +1 app/dts/behaviors/transparent.dtsi
badd +1 app/dts/behaviors/soft_off.dtsi
badd +1 app/dts/behaviors/outputs.dtsi
badd +1 app/dts/behaviors/none.dtsi
badd +1 app/dts/behaviors/mouse_key_press.dtsi
badd +1 app/dts/behaviors/caps_word.dtsi
badd +1 app/dts/behaviors/backlight.dtsi
badd +1 app/dts/behaviors/macros.dtsi
badd +9 app/dts/behaviors/mod_tap.dtsi
badd +28 app/src/split/bluetooth/peripheral.c
badd +1 app/include/zmk/check_battery.h
badd +20 app/include/zmk/hid.h
badd +1 app/include/zmk/kscan.h
badd +1 app/include/zmk/matrix.h
badd +12 app/include/zmk/mouse.h
badd +20 app/src/mouse.c
badd +25 app/src/endpoints.c
badd +124 zephyr/include/zephyr/sys/util_macro.h
badd +50 zephyr/include/zephyr/sys/util_internal.h
badd +2 app/tests/wpm/2-multiple_keypress/native_posix_64.conf
badd +83 app/Kconfig
badd +43 app/src/display/status_screen.c
badd +1 app/module/dts/bindings/display/gooddisplay,il0323.yaml
badd +22 app/module/drivers/display/il0323.c
badd +1 app/module/drivers/display/il0323_regs.h
badd +43 app/src/display/widgets/peripheral_status.c
badd +1 zephyr/include/zephyr/drivers/display.h
badd +12 app/include/zmk/display/widgets/peripheral_status.h
badd +10 app/src/events/battery_state_changed.c
badd +166 zephyr/include/zephyr/sys/slist.h
badd +45 zephyr/include/zephyr/sys/list_gen.h
badd +320 app/src/rgb_underglow.c
badd +250 zephyr/include/zephyr/settings/settings.h
badd +7 app/include/dt-bindings/zmk/rgb.h
badd +1290 zephyr/include/zephyr/kernel.h
badd +121 zephyr/include/zephyr/sys_clock.h
badd +1 app/module/drivers/kscan/kscan_gpio.c
badd +1 app/module/drivers/kscan/kscan_gpio_direct.c
badd +16 app/src/workqueue.c
badd +169 ~/zephyr-sdk-0.16.3/arm-zephyr-eabi/arm-zephyr-eabi/include/sys/errno.h
badd +7 app/src/events/activity_state_changed.c
badd +13 app/include/zmk/events/activity_state_changed.h
badd +1 app/include/zmk/workqueue.h
badd +46 zephyr/include/zephyr/sys/poweroff.h
badd +95 app/src/pm.c
badd +10 app/src/events/usb_conn_state_changed.c
badd +1 app/src/events/endpoint_changed.c
badd +1 app/src/events/ble_active_profile_changed.c
badd +7 app/src/conditional_layer.c
badd +43 app/src/behaviors/behavior_check_battery.c
badd +1 app/src/behaviors/behavior_sensor_rotate_common.c
badd +9 app/include/zmk/pm.h
badd +16 app/include/zmk/events/usb_conn_state_changed.h
badd +25 app/boards/arm/nrfmicro/nrfmicro_13_defconfig
badd +1 app/boards/shields/settings_reset/settings_reset.conf
badd +22 app/boards/arm/kbdfans_tofu65/kbdfans_tofu65_v2_defconfig
badd +117 app/boards/arm/gamma/kabarga.c
badd +23 app/boards/arm/ckp/Kconfig.defconfig
badd +112 app/Session.vim
badd +110 app/src/usb_hid.c
badd +1 app/boards/arm/gamma_mk3/CMakeLists.txt
badd +125 app/boards/arm/gamma/gamma_seg.c
badd +99 app/boards/arm/gamma/gamma.c
badd +35 app/boards/arm/nice60/nice60.dts
badd +12 app/boards/shields/kyria/kyria_rev3.keymap
badd +1 app/boards/shields/kyria/kyria_rev2.conf
badd +1 app/boards/shields/kyria/kyria_rev3.dtsi
badd +1 app/include/zmk/sensors.h
badd +100 app/src/hid_listener.c
badd +16 app/include/zmk/events/split_peripheral_status_changed.h
badd +10 app/src/events/split_peripheral_status_changed.c
badd +91 app/boards/shields/nice_view/widgets/peripheral_status.c
badd +116 app/src/split/bluetooth/service.c
badd +1 app/src/display/widgets/output_status.c
badd +18 app/include/zmk/events/endpoint_changed.h
badd +17 app/include/zmk/events/ble_active_profile_changed.h
badd +14 app/include/zmk/ble/profile.h
badd +222 app/src/studio/gatt_rpc_transport.c
badd +1 app/src/display/widgets/CMakeLists.txt
badd +1 app/src/display/widgets/Kconfig
badd +69 app/include/zmk/endpoints.h
badd +11 app/boards/shields/nice_view/CMakeLists.txt
badd +86 app/boards/arm/gamma/gamma2.c
badd +25 zephyr/drivers/sensor/apds9960/apds9960.c
badd +227 zephyr/drivers/sensor/apds9960/apds9960.h
badd +1 zephyr/drivers/sensor/apds9960/apds9960_trigger.c
badd +542 zephyr/drivers/sensor/veml7700/veml7700.c
badd +1 zephyr/drivers/sensor/voltage_divider/voltage.c
badd +23 zephyr/drivers/sensor/opt3001/opt3001.c
badd +23 zephyr/drivers/sensor/opt3001/opt3001.h
badd +97 zephyr/drivers/sensor/vcnl4040/vcnl4040.c
badd +1 zephyr/drivers/sensor/vcnl4040/vcnl4040_trigger.c
badd +95 zephyr/drivers/sensor/vcnl4040/vcnl4040.h
badd +1 app/include/drivers/input_processor.h
badd +122 zephyr/include/zephyr/drivers/sensor/veml7700.h
badd +28 zephyr/include/zephyr/drivers/sensor/opt3001.h
badd +1 zephyr/include/zephyr/drivers/sensor/tsl2540.h
badd +1 new
badd +9 app/src/behaviors/behavior_snap_tap.c
argglobal
%argdel
edit app/boards/arm/gamma/gamma.c
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
balt app/dts/behaviors/check_battery.dtsi
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
let s:l = 99 - ((24 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 99
normal! 043|
wincmd w
argglobal
if bufexists(fnamemodify("app/src/behaviors/behavior_snap_tap.c", ":p")) | buffer app/src/behaviors/behavior_snap_tap.c | else | edit app/src/behaviors/behavior_snap_tap.c | endif
if &buftype ==# 'terminal'
  silent file app/src/behaviors/behavior_snap_tap.c
endif
balt app/boards/arm/gamma/gamma.c
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
