#!/usr/bin/env bash
# Script de instalação/atualização rápida do Umbriel para Void Linux
set -euo pipefail

REPO="Wiljapa/umbriel-void"

echo "==> Verificando a versão mais recente do Umbriel..."
LATEST_URL=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" \
  | grep "browser_download_url.*\.xbps" \
  | head -n 1 \
  | cut -d '"' -f 4)

if [ -z "${LATEST_URL:-}" ]; then
  echo "Erro: Não foi possível obter o link da última release."
  exit 1
fi

PKG_FILE=$(basename "${LATEST_URL}")
TMP_DIR=$(mktemp -d /tmp/umbriel-install.XXXXXX)
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "==> Baixando ${PKG_FILE}..."
curl -# -L "${LATEST_URL}" -o "${TMP_DIR}/${PKG_FILE}"

echo "==> Instalando via xbps-install..."
sudo xbps-install --repository="${TMP_DIR}" -u umbriel

echo "==> Instalação concluída com sucesso!"
echo "    Versão instalada: $(umbriel --version 2>/dev/null || echo 'concluída')"
