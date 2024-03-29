typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=false
typeset -g POWERLEVEL9K_DIR_FOREGROUND=0
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=0
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=0
typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=18
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=18
typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=18
typeset -g POWERLEVEL9K_DIRENV_BACKGROUND=18
typeset -g POWERLEVEL9K_TERRAFORM_VERSION_BACKGROUND=18


# From Zsh documentation: http://zsh.sourceforge.net/Doc/Release/Parameters.html#index-ZLE_005fRPROMPT_005fINDENT
# ZLE_RPROMPT_INDENT <S>
# If set, used to give the indentation between the right hand side of the right prompt in the line editor as given by RPS1 or RPROMPT and the right hand side of the screen. If not set, the value 1 is used.
# Typically this will be used to set the value to 0 so that the prompt appears flush with the right hand side of the screen.
# Extra space without background on the right side of right prompt
# Powerlevel10k respects this parameter.
# If you set ZLE_RPROMPT_INDENT=1 (or leave it unset, which is the same thing as setting it to 1) you'll get an empty space to the right of right prompt
# If you set ZLE_RPROMPT_INDENT=0, your prompt will go to the edge of the terminal. This is how it works in every theme except Powerlevel9k.
# Note: Several versions of Zsh have bugs that get triggered when you set ZLE_RPROMPT_INDENT=0.
# Powerlevel10k can work around these bugs when using powerline prompt style. If you notice visual artifacts in prompt, or wrong cursor position, try removing ZLE_RPROMPT_INDENT from ~/.zshrc.
typeset -g ZLE_RPROMPT_INDENT=0

# When set to true, icons appear before content on both sides of the prompt. When set
# to false, icons go after content. If empty or not set, icons go before content in the left
# prompt and after content in the right prompt.
#
# You can also override it for a specific segment:
#
#   POWERLEVEL9K_STATUS_ICON_BEFORE_CONTENT=false
#
# Or for a specific segment in specific state:
#
#   POWERLEVEL9K_DIR_NOT_WRITABLE_ICON_BEFORE_CONTENT=false
typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true

# The list of segments shown on the left. Fill it with the most important segments.
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir                     # current directory
  context                 # user@hostname
)

# The list of segments shown on the right. Fill it with less important segments.
# Right prompt on the last prompt line (where you are typing your commands) gets
# automatically hidden when the input line reaches it. Right prompt above the
# last prompt line gets hidden if it would overlap with left prompt.
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    vcs                     # git status
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    direnv                  # direnv status (https://direnv.net/)
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    terraform               # terraform workspace (https://www.terraform.io)
    terraform_version       # terraform version (https://www.terraform.io)
    aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    per_directory_history   # Oh My Zsh per-directory-history local/global indicator
)
