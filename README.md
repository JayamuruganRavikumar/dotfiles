## Config Files

### dwm

![](desktop.png)

Basic Autostart shell script `dwm/autostart.sh` to display time, volume and charging status of the machine.

#### Dependencies

`sudo apt-get install dmenu compton zathura fonts-font-awesome vifm feh tmux zsh thunar lxappearance`

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

Install [nodejs](https://github.com/nodesource/distributions/blob/master/README.md)  

Install latest version of nvim for coc.nvim to work.
```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim xclip
```

## Creating a desktop entry

- Create a dwm.desktop file at `/usr/share/xsessions/`
- Paste the following in the file
```conf
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
```

- Change the file to executalble `chmod +x dwm.desktop`


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

