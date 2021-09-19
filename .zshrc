#########################################################################################
# Environment variables
export PATH       = "$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
if [ -d "$HOME/.local/ohmyzsh" ] && [ "$(ls $HOME/.local/ohmyzsh)" != "" ]; then export ZSH="$HOME/.local/ohmyzsh"; fi
if [ -d "$HOME/.kube/" ] && [ "$(ls $HOME/.kube/*.yaml)" != ""  ]; then export KUBECONFIG=$(ls -r $HOME/.kube/*.yaml | tr '\n' ':'); fi

#########################################################################################
# ZSH Configuration
ZSH_THEME="nicoulaj"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  helm
  kubectl
  terraform
  zsh_reload
)

#########################################################################################
# Startup Scripts
source $ZSH/oh-my-zsh.sh

# Removing Linux SSH socket and replacing it by link to wsl2-ssh-pageant socket
export SSH_AUTH_SOCK=/$HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $? -ne 0 ]; then
  rm -f $SSH_AUTH_SOCK
  setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:$HOME/.ssh/wsl2-ssh-pageant.exe &>/dev/null &
fi

# Removing Linux GPG Agent socket and replacing it by link to wsl2-ssh-pageant GPG socket
export GPG_AGENT_SOCK=$HOME/.gnupg/S.gpg-agent
ss -a | grep -q $GPG_AGENT_SOCK
if [ $? -ne 0 ]; then
    rm -rf $GPG_AGENT_SOCK
    setsid nohup socat UNIX-LISTEN:$GPG_AGENT_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe --gpg S.gpg-agent" &>/dev/null &
fi

#########################################################################################
# Completion
source <(helm completion zsh)                       # helm
source <(hcloud completion zsh)                     # hcloud-cli
source <(kubectl completion zsh)                    # kubectl
complete -o nospace -C /usr/bin/terraform terraform # terraform

#########################################################################################
# Aliases

# ---------------------------------------------------------------------------------------
# Common
alias ll="ls -alh"

# ---------------------------------------------------------------------------------------
# Terraform
alias tf    = "terraform"
alias tfi   = "terraform init"
alias tfa   = "terraform apply"
alias tfp   = "terraform plan"
alias tfd   = "terraform destroy"
alias tfaaa = "terraform apply -auto-approve"

# ---------------------------------------------------------------------------------------
# Hetzner Cloud CLI
alias hc      = "hcloud"
alias hcssh   = "hcloud server ssh"

alias hcc     = "hcloud context"
alias hccu    = "hcloud context use"
alias hccl    = "hcloud context list"

alias hcdc    = "hcloud datacenter"
alias hcdcl   = "hcloud datacenter list"
alias hcdcd   = "hcloud datacenter describe"

alias hcfip   = "hcloud floating-ip"
alias hcfipl  = "hcloud floating-ip list"
alias hcfipd  = "hcloud floating-ip describe"

alias hcimg   = "hcloud image"
alias hcimgl  = "hcloud image list"
alias hcimgd  = "hcloud image describe"

alias hciso   = "hcloud iso"
alias hcisol  = "hcloud iso list"
alias hcisod  = "hcloud iso describe"

alias hcl     = "hcloud location"
alias hcll    = "hcloud location list"
alias hcld    = "hlcoud location describe"

alias hcn     = "hcloud network"
alias hcnl    = "hcloud network list"
alias hcnd    = "hcloud network describe"

alias hcs     = "hcloud server"
alias hcsl    = "hcloud server list"
alias hcsd    = "hcloud server describe"

alias hcst    = "hcloud server-type"
alias hcstl   = "hcloud server-type list"
alias hcstd   = "hcloud server-type describe"

alias hcsk    = "hcloud ssh-key"
alias hcskl   = "hcloud ssh-key list"
alias hcshd   = "hcloud ssh-key describe"

alias hcv     = "hcloud volume"
alias hcvl    = "hcloud volume list"
alias hcvd    = "hcloud volume describe"
