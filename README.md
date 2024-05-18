## Config Files

### dwm

![](desktop.png)

Basic Autostart shell script `dwm/autostart.sh` to display time, volume and charging status of the machine.

#### Dependencies

`pacman -S dmenu picom zathura ttf-font-awesome vifm feh ttf-dejavu ttf-liberation tmux zsh`

### Neovim

![](nvim.png)

Plugins used with vim plug,

- sainnhe/gruvbox-material (Gruvbox theme)
- neoclide/coc.nvim (Language server)
- lervag/vimtex (Latex for vim)
- godlygeek/tabular (Auto align of tabulation)
- iamcco/markdown-preview.nvim (Markdown preview)
- ixru/nvim-markdown (Markdown)
- tpope/vim-fugitive (Git)

#### Dependencies

`pacman -S nodejs npm yarn`

## Setting up the touch pad

- Check if the directory exists `sudo mkdir -p /etc/X11/xorg.conf.d`

- Create a new file in the directory for touchpad  `sudo touch /etc/X11/xorg.conf.d/90-touchpad.conf`

Paste the following Config in the file

```conf
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "TappingButtonMap" "lrm"
        Option "NaturalScrolling" "on"
        Option "ScrollMethod" "twofinger"
EndSection
```

