#!/bin/bash
set -euo pipefail

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

# Verifica se o argumento --dry-run foi passado
DRY_RUN=0
for arg in "$@"; do
    if [ "$arg" = "--dry-run" ]; then
        DRY_RUN=1
    fi
done

# Função para executar ou imprimir comandos
run_or_echo() {
    if [ "$DRY_RUN" -eq 1 ]; then
        echo "DRY-RUN: $@"
    else
        echo "Executando: $@"
        eval "$@"
    fi
}

# Obtem a branch ou tag atual
describe_repo() {
    local REPO_PATH="$1"
    local REPO_NAME="$2"

    # Obtem a branch atual
    local CURRENT_BRANCH=$(git -C "$REPO_PATH" rev-parse --abbrev-ref HEAD)

    # Obtem a última tag e a contagem de commits desde essa tag
    local TAG_INFO=$(git -C "$REPO_PATH" describe --tags --always)

    # Se a tag segue o formato 'tag-n-gcommit', extrai a tag e o número de commits
    if [[ "$TAG_INFO" =~ ^([^-]+)-([0-9]+)-g([a-f0-9]+)$ ]]; then
        local LAST_TAG=${BASH_REMATCH[1]}
        local COMMITS_AHEAD=${BASH_REMATCH[2]}
        echo "Repositório $REPO_NAME: branch '$CURRENT_BRANCH', tag '$LAST_TAG', estamos a '$COMMITS_AHEAD' commits a partir da tag"
    else
        echo "Repositório $REPO_NAME: branch '$CURRENT_BRANCH', a tag mais recente é: $TAG_INFO"
    fi
}


confirm_directory_removal() {
    local REPO_PATH=$1
    read -rp "O diretório $REPO_PATH existe. Deseja remover? [s/N]: " user_choice
    user_choice=${user_choice:-N} # Default para 'N' se nenhuma entrada for fornecida
    if [[ $user_choice =~ ^[Ss]$ ]]; then
        echo "Removendo diretório..."
        run_or_echo "rm -rf \"$REPO_PATH\""
        return 0 # 0 para 'sim'
    else
        return 1 # 1 para 'não'
    fi
}

# Lista de repositórios e seus respectivos caminhos
# Formato: "REPO_URL CAMINHO_PARA_O_DIRETORIO"
# zsh e oh-my-zsh tem que estar instalados antes disso
REPOS=(
    "https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    "https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    "https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
    # Adicione mais repositórios aqui conforme necessário
)

for repo in "${REPOS[@]}"; do
    REPO_URL=$(echo "$repo" | awk '{print $1}')
    REPO_PATH=$(echo "$repo" | awk '{print $2}')
    REPO_NAME=$(echo "$REPO_URL" | awk -F/ '{print $(NF-1)"/"$NF}')

    echo "Começando a clonagem do repositório $REPO_NAME em $REPO_PATH..."

    if [ -d "$REPO_PATH/.git" ]; then
        echo "Atualizando o repositório existente com git pull em $REPO_PATH..."
        run_or_echo "git -C \"$REPO_PATH\" pull"
        describe_repo "$REPO_PATH" "$REPO_NAME"
    else
        if [ -d "$REPO_PATH" ]; then
            echo "O diretório existe em $REPO_PATH."

            if [ "$DRY_RUN" -eq 0 ]; then
                if confirm_directory_removal "$REPO_PATH"; then
                    echo "Remoção do diretório $REPO_PATH concluída."
                else
                    echo "Operação cancelada pelo usuário. Pulando este repositório."
                    continue
                fi
            else
                echo "DRY-RUN: Pergunta de remoção seria feita aqui para $REPO_PATH."
            fi

            echo "Clonando o repositório..."
            run_or_echo "git clone --single-branch --depth=1 \"$REPO_URL\" \"$REPO_PATH\""
        else
            echo "Diretório não encontrado em $REPO_PATH. Clonando o repositório..."
            run_or_echo "git clone --single-branch --depth=1 \"$REPO_URL\" \"$REPO_PATH\""
        fi

        if [ "$DRY_RUN" -eq 0 ]; then
            describe_repo "$REPO_PATH" "$REPO_NAME"
        fi
    fi
done

# sudo pacman -Syyu curl git base-devel ;\
# mkdir ~/.config/nvim ;\
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' ;\
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended ;\
# chsh -s "$(which zsh)"