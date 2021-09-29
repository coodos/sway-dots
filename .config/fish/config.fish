set fish_greeting

################################# FISH BANG BANG #########################################

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

bind ! __history_previous_command
bind '$' __history_previous_command_arguments

################################ END BANG BANG ###############################################

export EDITOR=nvim

###################################### aliases ###############################################

alias nvme="cd /disks/nvme"
alias fontrefresh="sudo fc-cache -fv"
alias modbar="cd ~/.config/waybar/; nvim ."
alias vim="nvim"
alias modi3="nvim ~/.config/i3/config"
alias modpoly="nvim ~/.config/polybar/"
alias modxmo="nvim ~/.xmonad/xmonad.hs"
alias modvim="nvim ~/.config/nvim/init.vim"
alias cdpr="cd ~/Projects"
alias cdpkg="cd ~/Packages"
alias modfish="nvim ~/.config/fish/config.fish"
alias modkitty="nvim ~/.config/kitty/kitty.conf"
alias l="lsd -lah"
alias modpicom="nvim ~/.config/picom/picom.conf"
alias ls="lsd"
alias virsh="virsh --connect qemu:///system"
alias ..="cd .."
alias ...="cd ../../"
alias grep="grep --color=auto"
alias cp="cp -i"
alias df="df -h"
alias ssh="kitty +kitten ssh"
alias btw="neofetch"
alias BTW="fm6000"
alias Btw="pfetch | lolcat"
alias c="clear"
alias modsway="nvim ~/.config/sway/config"
alias gentoo-btw="neofetch --ascii_distro gentoo | sed 's/Arch Linux/Gentoo/' | sed 's/-arch1-/-gentoo1-/' | sed 's/pacman/emerge/' | sed 's/arch-btw/gentoo-btw/'"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias windoze="virsh start win100"
alias macOS="virsh start BigSur"
alias obscam="sudo modprobe v4l2loopback devices=1 video_nr=10 card_label=\"OBS Cam\" exclusive_caps=1"

# aliases for devour
alias vid="devour mpv"
alias pic="devour sxiv"
alias pdf="devour zathura"

# git aliases

alias gst="git status"
alias ga="git add ."
alias gpll="git pull"
alias gpsh="git push"
alias gc="git commit -am"
alias gb="git branch"
alias gckt="git checkout"
alias ginit="git init"
alias doomsync=".emacs.d/bin/doom sync"

##################################### end aliases ############################################
export ANDROID_SDK=/home/merul/Android/Sdk/
fish_vi_key_bindings
set -gx PATH $ANDROID_HOME/emulator $PATH

############################## begin propmpt #################################################


function fish_prompt

    set -g __fish_prompt_char "⋊ "

    set -l last_status $status

    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showcolorhints true

    set -l normal (set_color normal)
    set -l magenta (set_color magenta)
    set -l cyan (set_color cyan)
    set -l green (set_color green)
    set -l red (set_color red)

    set prefix ""

    if test "$VIRTUAL_ENV"
        set venv_name (basename $VIRTUAL_ENV)
        set prefix "$prefix""[$venv_name]"
    end

    if [ -f fabfile.py ]
        set prefix "$prefix""[fab]"
    end

    set -l status_color $magenta
    if [ $last_status -ne 0 ]
        set status_color $red
    end

    if [ $prefix != "" ]
        set prefix "$prefix:"
    end

    # Top
    echo -n $cyan$USER$normal at $green$__fish_prompt_hostname$normal in $green(prompt_pwd)$normal
    __fish_git_prompt

    # Line break
    echo

    # Bottom
    echo -n $status_color$__fish_prompt_char$normal$prefix $normal

end

set -U fish_key_bindings fish_default_key_bindings
