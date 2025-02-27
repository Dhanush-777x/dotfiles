# Dotfiles

### Install Stow

You can easily install Stow on most Linux distributions. For Arch based distros you can just run:

```bash
sudo pacman -S stow
```

### Clone this repository

```bash
git clone https://github.com/Dhanush-777x/dotfiles.git
```

### Change directory 

`cd` into the newly cloned directory

```bash
cd ~/dotfiles
```

### Using Stow

Just run this command

```bash
stow <package name>
```

Lets say if you want to inject nvim config files. Just run,

```bash
stow nvim
```

>[!NOTE]
> To change the color of the tty for ly (display manager)
> - Copy this line and paste it inside `/lib/systemd/system/ly.service` file

```bash
ExecStartPre=/usr/bin/printf '%%b' '\e]P0FFC5C4\e]P7FFFFFF\ec' # Paste it just above ExecStart=/usr/bin/ly
```

Enjoy :)
