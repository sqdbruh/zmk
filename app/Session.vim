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
badd +9 C:/dev/zmk/app/boards/arm/porne/Kconfig.board
badd +12 C:/dev/zmk/app/boards/arm/nice_nano/Kconfig.board
badd +3 C:/dev/zmk/app/boards/arm/porne/Kconfig
badd +6 C:/dev/zmk/app/boards/arm/nice_nano/Kconfig.defconfig
badd +7 C:/dev/zmk/app/boards/arm/porne/Kconfig.defconfig
badd +1 C:/dev/zmk/app/boards/arm/nice_nano/arduino_pro_micro_pins.dtsi
badd +1 C:/dev/zmk/app/boards/arm/nice_nano/board.cmake
badd +5 C:/dev/zmk/app/boards/arm/porne/board.cmake
badd +16 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano_v2.dts
badd +22 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano.dtsi
badd +32 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano-pinctrl.dtsi
badd +1 C:/dev/zmk/app/boards/arm/porne/porne-pinctrl.dtsi
badd +1 C:/dev/zmk/app/boards/arm/porne/nice_nano.dtsi
badd +1 C:/dev/zmk/app/boards/arm/porne/porne.yaml
badd +9 C:/dev/zmk/app/boards/arm/porne/porne.zmk.yml
badd +5 C:/dev/zmk/app/boards/arm/porne/porne_defconfig
badd +1 C:/dev/zmk/app/boards/arm/kekos/Kconfig
badd +1 C:/dev/zmk/app/boards/arm/kekos/Kconfig.board
badd +7 C:/dev/zmk/app/boards/arm/kekos/Kconfig.defconfig
badd +1 C:/dev/zmk/app/boards/arm/porne/arduino_pro_micro_pins.dtsi
badd +1 C:/dev/zmk/app/boards/arm/porne/nice_nano-pinctrl.dtsi
badd +1 C:/dev/zmk/app/boards/arm/nrfmicro/Kconfig
badd +1 C:/dev/zmk/app/boards/arm/porne/custom_status_screen.h
badd +18 C:/dev/zmk/app/boards/arm/porne/custom_status_screen.c
badd +62 C:/dev/zmk/app/boards/arm/porne/corneish_zen_v2_right_defconfig
badd +1 C:/dev/zmk/app/boards/arm/porne/CMakeLists.txt
badd +1 C:/dev/zmk/app/boards/arm/porne/corneish_zen.conf
badd +19 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen.yaml
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/board.cmake
badd +24 C:/dev/zmk/app/boards/arm/corneish_zen/CMakeLists.txt
badd +61 C:/dev/zmk/app/boards/arm/corneish_zen/custom_status_screen.c
badd +98 ./build/left/zephyr/include/generated/autoconf.h
badd +14 boards/arm/corneish_zen/widgets/battery_status.h
badd +52 C:/dev/zmk/app/boards/arm/corneish_zen/widgets/battery_status.c
badd +78 ./src/display/widgets/battery_status.c
badd +67 ./include/zmk/event_manager.h
badd +20 C:/dev/zmk/app/boards/arm/corneish_zen/widgets/peripheral_status.c
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/widgets/icons/batt_0.c
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2.yaml
badd +21 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen.keymap
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen.dtsi
badd +16 include/zmk/display.h
badd +92 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v1_left.dts
badd +28 C:/dev/zmk/app/boards/arm/corneish_zen/widgets/icons/batt_100_chg.c
badd +15 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v1.zmk.yml
badd +2 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano_defconfig
badd +1 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano.yaml
badd +28 C:/dev/zmk/app/src/main.c
badd +91 ./src/display/main.c
badd +58 C:/dev/MegaApp/Assets/Scripts/Core/Infrastructure/UserAuth/AuthService/ServerAuthService.cs
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/Kconfig
badd +5 boards/arm/corneish_zen/corneish_zen.conf
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/Kconfig.board
badd +9 C:/dev/zmk/app/boards/arm/corneish_zen/Kconfig.defconfig
badd +49 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v1_left_defconfig
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2_right.dts
badd +16 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2_left_defconfig
badd +10 C:/dev/zmk/zephyr/drivers/gpio/Kconfig.nrfx
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2_left.dts
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/widgets/output_status.c
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/widgets/layer_status.c
badd +1 C:/dev/zmk/app/boards/arm/planck/CMakeLists.txt
badd +1 C:/dev/zmk/app/boards/arm/gamma/CMakeLists.txt
badd +1 C:/dev/zmk/app/boards/arm/planck/Kconfig.board
badd +7 C:/dev/zmk/app/boards/arm/gamma/Kconfig.board
badd +27 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano_v2_defconfig
badd +5 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano_v2.zmk.yml
badd +14 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano_v2.yaml
badd +1 C:/dev/zmk/app/boards/arm/nice_nano/nice_nano.dts
badd +1 C:/dev/zmk/zephyr/boards/arm/adafruit_feather_nrf52840/feather_connector.dtsi
badd +8 C:/dev/zmk/zephyr/boards/arm/adafruit_feather_nrf52840/adafruit_feather_nrf52840.dts
badd +11 C:/dev/zmk/zephyr/dts/arm/nordic/nrf52840_qiaa.dtsi
badd +1 C:/dev/zmk/zephyr/dts/arm/nordic/nrf52840.dtsi
badd +5 C:/dev/zmk/app/boards/arm/gamma/board.cmake
badd +15 C:/dev/zmk/app/boards/arm/gamma/Kconfig.defconfig
badd +96 C:/dev/zmk/app/boards/arm/gamma/gamma.dts
badd +26 C:/dev/zmk/app/boards/arm/gamma/gamma.keymap
badd +18 C:/dev/zmk/app/boards/arm/gamma/gamma.yaml
badd +12 C:/dev/zmk/app/boards/arm/gamma/gamma.zmk.yml
badd +26 C:/dev/zmk/app/boards/arm/gamma/gamma_defconfig
badd +1 C:/dev/zmk/app/boards/arm/nrf52840_m2/board.cmake
badd +2 C:/dev/zmk/app/boards/arm/glove80/CMakeLists.txt
badd +1 C:/dev/zmk/app/boards/arm/nice60/board.cmake
badd +1 C:/dev/zmk/app/boards/arm/gamma/gamma.conf
badd +1 C:/dev/zmk/app/boards/arm/gamma/Kconfig
badd +3 C:/dev/zmk/app/boards/arm/ferris/ferris_rev02_defconfig
badd +1 C:/dev/zmk/app/boards/arm/ferris/ferris_rev02.zmk.yml
badd +1 C:/dev/zmk/app/boards/arm/ferris/ferris_rev02.yaml
badd +1 C:/dev/zmk/app/boards/arm/ferris/ferris_rev02.keymap
badd +1 C:/dev/zmk/app/boards/arm/ferris/ferris_rev02.dts
badd +1 C:/dev/zmk/app/boards/arm/ferris/board.cmake
badd +1 C:/dev/zmk/app/boards/arm/ferris/README.md
badd +11 C:/dev/zmk/app/boards/arm/ferris/Kconfig.defconfig
badd +1 C:/dev/zmk/app/boards/arm/ferris/Kconfig.board
badd +38 C:/dev/zmk/app/boards/arm/gamma/gamma.c
badd +240 ~/AppData/Local/nvim/init.vim
badd +310 ./include/dt-bindings/zmk/keys.h
badd +55 src/battery.c
badd +85 boards/shields/nice_view/widgets/status.c
badd +289 boards/arm/gamma/digits.h
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/custom_status_screen.h
badd +9 ./include/zmk/battery.h
badd +24 ./include/zmk/usb.h
badd +12 include/zmk/events/battery_state_changed.h
badd +99 ./build/zephyr/include/generated/syscalls/sensor.h
badd +642 src/behaviors/behavior_hold_tap.c
badd +75 src/activity.c
badd +44 tests/ble/central/src/main.c
badd +116 src/ble.c
badd +1 C:/dev/zmk/app/boards/arm/glove80/usb_serial_number.c
badd +29 C:/dev/zmk/app/boards/arm/planck/planck_rev6.dts
badd +23 C:/dev/zmk/app/boards/arm/planck/planck_rev6.keymap
badd +11 C:/dev/zmk/app/boards/arm/planck/planck_rev6.yaml
badd +4 C:/dev/zmk/app/boards/arm/planck/planck_rev6.zmk.yml
badd +1 C:/dev/zmk/app/boards/arm/planck/planck_rev6_defconfig
badd +1 C:/dev/zmk/app/boards/arm/planck/board.cmake
badd +1 C:/dev/zmk/app/boards/arm/planck/Kconfig.defconfig
badd +39 src/behaviors/behavior_mouse_key_press.c
badd +30 C:/dev/zmk/app/src/behaviors/behavior_key_press.c
badd +228 C:/dev/zmk/app/src/behaviors/behavior_macro.c
badd +17 C:/dev/zmk/app/src/behaviors/behavior_reset.c
badd +74 C:/dev/zmk/app/src/kscan.c
badd +542 C:/dev/zmk/app/src/combo.c
badd +192 src/backlight.c
badd +315 src/keymap.c
badd +32 C:/dev/zmk/app/boards/arm/nrfmicro/nrfmicro_13.dts
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zero_param.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/two_param.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/macro_base.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-key-press.yaml
badd +10 C:/dev/zmk/app/dts/bindings/behaviors/one_param.yaml
badd +8 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-backlight.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-bluetooth.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-caps-word.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-to-layer.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-key-toggle.yaml
badd +1 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-key-repeat.yaml
badd +8 C:/dev/zmk/app/dts/bindings/behaviors/zmk,behavior-bat-display.yaml
badd +1 C:/dev/zmk/app/src/behaviors/behavior_bt.c
badd +21 C:/dev/zmk/app/src/behaviors/behavior_bat_display.c
badd +1 C:/dev/zmk/app/src/behaviors/behavior_sensor_rotate.c
badd +71 C:/dev/zmk/app/src/behaviors/behavior_sticky_key.c
badd +259 C:/dev/zmk/app/src/behaviors/behavior_tap_dance.c
badd +60 C:/dev/zmk/app/src/behaviors/behavior_ext_power.c
badd +30 boards/arm/corneish_zen/corneish_zen_v1_right_defconfig
badd +37 boards/arm/puchi_ble/puchi_ble_v1.dts
badd +8 C:/dev/zmk/app/boards/arm/puchi_ble/puchi_ble_v1-pinctrl.dtsi
badd +7 boards/shields/snap/snap.zmk.yml
badd +202 module/drivers/sensor/max17048/max17048.c
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2_right_defconfig
badd +1 C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2.zmk.yml
argglobal
%argdel
edit C:/dev/zmk/app/boards/arm/gamma/gamma.c
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
balt C:/dev/zmk/app/boards/arm/corneish_zen/corneish_zen_v2.zmk.yml
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 38 - ((37 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 38
normal! 075|
wincmd w
argglobal
if bufexists(fnamemodify("C:/dev/zmk/app/boards/arm/gamma/gamma.dts", ":p")) | buffer C:/dev/zmk/app/boards/arm/gamma/gamma.dts | else | edit C:/dev/zmk/app/boards/arm/gamma/gamma.dts | endif
if &buftype ==# 'terminal'
  silent file C:/dev/zmk/app/boards/arm/gamma/gamma.dts
endif
balt C:/dev/zmk/app/boards/arm/gamma/gamma.c
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
let s:l = 96 - ((50 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 96
normal! 073|
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
