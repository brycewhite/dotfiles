# dotfiles

My Linux configuration files, managed with a bare git repository.

## How it works

Rather than symlinking files, this repo uses a bare git repo stored in `~/.dotfiles` with `$HOME` as the working tree. A `config` alias replaces `git` for all dotfile operations — no extra tools required.

## Setup on a new machine

**1. Clone the repo**

```bash
git clone --bare git@github.com:you/dotfiles.git $HOME/.dotfiles
```

**2. Define the alias**

```bash
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

**3. Check out your files**

```bash
config checkout
```

If this fails due to conflicting files (e.g. a default `.bashrc`), back them up and try again:

```bash
mkdir -p ~/.dotfiles-backup
config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} ~/.dotfiles-backup/{}
config checkout
```

**4. Hide untracked files**

```bash
config config status.showUntrackedFiles no
```

**5. Make the alias permanent**

Add this to your `.bashrc` or `.zshrc`:

```bash
echo "alias config='git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" >> ~/.bashrc
```

## Starting from scratch

If you're setting this up for the first time rather than cloning:

```bash
git init --bare $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
echo "alias config='git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" >> ~/.bashrc
```

## Daily usage

Use `config` exactly like you'd use `git`:

```bash
config status
config add ~/.bashrc
config add ~/.config/nvim/init.lua
config commit -m "add nvim config"
config push
```

## Structure

```
~
├── .bashrc
├── .gitconfig
├── .config/
│   ├── nvim/
│   └── ...
└── ...
```

Files are stored at their real paths under `$HOME` — no indirection, no symlinks.
