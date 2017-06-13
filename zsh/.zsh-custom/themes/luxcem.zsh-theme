# Theme for oh-my-zsh

ZSH_THEME_GIT_PROMPT_PREFIX="[%B$FG[148]±%{$reset_color%}%b "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="$FG[154]✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="$FG[229]%B↑%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="$FG[163]%B↓%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="$FG[034]⚫%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="$FG[220]⚫%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="$FG[001]⚫%{$reset_color%}"

bureau_git_branch () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

bureau_git_status () {
  _INDEX=$(command git status --porcelain -b 2> /dev/null)
  _STATUS=""
  if $(echo "$_INDEX" | grep '^[AMRD]. ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
  fi
  if $(echo "$_INDEX" | grep '^.[MTD] ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
  fi
  if $(echo "$_INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi
  if $(echo "$_INDEX" | grep '^UU ' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi
  if $(echo "$_INDEX" | grep '^## .*ahead' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$_INDEX" | grep '^## .*behind' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$_INDEX" | grep '^## .*diverged' &> /dev/null); then
    _STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  echo $_STATUS
}

bureau_git_prompt () {
  local _branch=$(bureau_git_branch)
  local _status=$(bureau_git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$ZSH_THEME_GIT_PROMPT_PREFIX%B$_branch%b%{$reset_color%}"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
  echo $_result
}

virtualenv_prompt () {
    local _result=""
    if [[ $VIRTUAL_ENV ]]; then
        _result=$(basename "$VIRTUAL_ENV")
    fi
    echo $_result
}

if [[ $(whoami) = "root" ]]; then
  local user_name='%B$FG[093]%n$FG[178]@%b'
else
  local user_name='%B$FG[005]%n$FG[178]@%b'
fi

local host_name='%{$fg_bold[white]%}%m:'
local dir_name='%B$FG[045]%~%b'
# local git_prompt='%{$fg_bold[blue]%}$(git_prompt_info) '

PROMPT="${user_name}${host_name}${dir_name}%{$reset_color%} "'%{$reset_color%}'"
%B%(!.#.$)%b "
# RPS1="${return_code}"
RPROMPT='$(virtualenv_prompt) $(bureau_git_prompt)'
