# Dot Files

## Introduction

Dotfiles are hidden configuration files (like .bashrc, .vimrc, .gitconfig) used by Unix-based systems (Linux, macOS) to manage user settings. They start with a dot to keep them out of normal directory listings.

The [$XDG_CONFIG_HOME](https://specifications.freedesktop.org/basedir-spec/latest/index.html) environment variable specifies where user-specific configuration files should be stored. If set, applications will look in this directory. If not set, it defaults to ~/.config. This helps keep configuration files organized and easy to manage.

## Install GNU Stow

[GNU Stow](http://www.gnu.org/software/stow) is a symlink farm manager that makes it easier to manage the installation of software packages, especially when you want to keep configuration files and directories organized. It is particularly useful for managing dotfiles and setting up software configurations in a clean, organized manner.

First, you need to install GNU Stow. On most Unix-like systems, you can do this through your package manager:

On macOS (using [homebrew](https://brew.sh)):

```bash
homebrew install stow
```

## Organize Your Dotfiles

Create a directory to hold your dotfiles. Typically, you'll have a directory structure where each package you want to manage with Stow has its own subdirectory. For example:

```text
.
├── bat
│   └── .config
│       └── bat
│           └── themes
├── git
│   ├── .gitconfig
│   └── .gitignore_global
├── hushlogin
│   └── .hushlogin
├── kitty
│   └── .config
│       └── kitty
│           ├── current-theme.conf
│           ├── kitty.app.icns
│           └── kitty.conf
├── ssh
│   └── .ssh
│       └── config
├── stow.sh
├── tmux
│   └── .tmux.conf
└── zsh
    ├── .zprofile
    └── .zshrc
```

In this structure, each subdirectory (e.g., tmux, git, kitty) represents a group of related configuration files.

## Create Symbolic Links

To use Stow, navigate to your dotfiles directory and run Stow with the package name (i.e., the subdirectory you want to manage). For example, to create symbolic links for the vim configuration:

```bash
cd ~/.dotfiles
stow tmux
```

This command will create symbolic links in your home directory pointing to the files and directories in ~/.dotfiles/tmux. If ~/.dotfiles/tmux/.tmux.conf is being stowed, it will create a symlink from ~/.dotfiles/tmux/.tmux.conf to ~/.tmux.conf.

Deeper nesting is suggested to store the majority of your dotfiles in $XDG_CONFIG_HOME which is generally ~/.config. This can be illustrated with kitty.

```bash
cd ~/.dotfiles
stow kitty
```

If kitty is being stowed, it will create a symlink from ~/.dotfiles/kitty/.config/kitty.conf to ~/.config/kitty/kitty.conf.

## Verify the Symlinks

Check your home directory to ensure that the symbolic links were created correctly. For example:

```bash
ls -l ~
```
You should see symlinks like:

```bash
lrwxr-xr-x@    - brycewhite 14 Sep 00:54  .tmux.conf -> .dotfiles/tmux/.tmux.conf
```
## Unstow Packages

If you need to remove the symbolic links created by Stow, you can use the -D option to "unstow" a package:

```bash
cd ~/.dotfiles
stow -D tmux
```

This will remove the symlinks created for the tmux package.

## Manage Multiple Packages

You can also stow multiple packages at once by listing them:

```bash
cd ~/.dotfiles
stow bash vim git
```

This will create symlinks for all three packages in one go.

However as your dotfiles increase, a better option would be the simple `stow.sh` script in this repository.

```bash
cd ~/.dotfiles
./stow.sh 

Usage: ./stow.sh <action>
Actions:
  stow     - Stow all dot files into the home directory.
  restow   - Restow all of files where the have already been stowed.
  unstow   - Unstow all files from the home directory.
```

The script simply iterates over each top level directory in the dotfiles repository and take care of the `stowing` for you.

## References

- [How I manage my dotfiles using GNU Stow](https://tamerlan.dev/how-i-manage-my-dotfiles-using-gnu-stow/)
- [GNU Stow](http://www.gnu.org/software/stow)
