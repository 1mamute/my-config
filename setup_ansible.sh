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

echo "Verificando existência do python3..."
if ! command_exists python3; then
    echo "Python 3 não está instalado, instalando..."
    run_or_echo "DEBIAN_FRONTEND=noninteractive sudo apt update -y"
    run_or_echo "DEBIAN_FRONTEND=noninteractive sudo apt install -y python3"
    echo "Python3 foi instalado, versão: $(python3 --version)"
else 
    echo "Python3 já estava instalado, versão: $(python3 --version)"
fi

echo "Verificando existência do pip..."
if ! command_exists pip; then
    echo "pip não está instalado, instalando..."
    run_or_echo "python3 -m ensurepip --upgrade"
    echo "pip foi instalado, versão: $(pip --version)"
else
    echo "pip já estava instalado, versão: $(pip --version)"
fi

echo "Verificando existência do ansible..."
if ! command_exists ansible; then
    echo "ansible não está instalado, instalando..."
    run_or_echo "python3 -m pip install --user ansible"
    echo "ansible foi instalado, versão: $(ansible --version)"
else
    echo "ansible já estava instalado, versão: $(ansible --version)"
fi