# Diretrizes e Memória de Sessão (Antigravity)

Este arquivo é lido automaticamente pelo Antigravity em todas as sessões para manter o contexto contínuo e nunca se perder.

---

## 📌 Perfil do Projeto & Princípios do Usuário (Wil)

1. **Repositório do Projeto**: `umbriel-void` (`/home/wil/umbriel-void`)
   - Empacotamento completo da suíte Wayland **Umbriel** para **Void Linux** (x86_64).
   - Fornece dois pacotes nativos:
     - `umbriel`: O compositor Wayland principal.
     - `xdg-desktop-portal-umbriel`: O portal oficial para captura de tela (Discord, OBS, Flatpaks).
   - CI/CD automatizado via GitHub Actions que constrói e publica o repositório XBPS nativo no GitHub Pages (`gh-pages`).

2. **Princípios e Preferências**:
   - **Continuidade & Memória**: Sempre salvar e atualizar este arquivo com o progresso, decisões e estado atual para manter a memória entre sessões.
   - **Instalação Completa "Out-of-the-Box"**:
     - Ao instalar `sudo xbps-install -Syu umbriel`, o XBPS instala automaticamente:
       1. O compositor `umbriel`.
       2. A compatibilidade com apps legados X11 (`xorg-server-xwayland`).
       3. A renderização de fontes e overlays (`virtual?font:sans-serif`).
       4. O portal de tela (`xdg-desktop-portal-umbriel`) e seu frontend (`xdg-desktop-portal`).
   - **Qualidade do Empacotamento (Void Linux / xbps-src / Upstream Specs)**:
     - Seguir rigorosamente as boas práticas do `xbps-src`, `xlint` e o `PACKAGING.md` oficial do upstream.
     - Evitar redundâncias como `meson ninja` em `hostmakedepends` quando `build_style=meson`.
     - Respeitar suporte upstream (ex: `lcms2` para cores, `xorg-server-xwayland` para X11 nativo, `libgbm-devel` para buffer management).

---

## 📝 Histórico de Decisões e Templates

1. **Template `srcpkgs/umbriel/template`**:
   - `depends="xorg-server-xwayland virtual?font:sans-serif xdg-desktop-portal-umbriel"`.
   - `xwayland-satellite` foi removido definitivamente. O Umbriel chama `/usr/bin/Xwayland` nativamente para rodar qualquer aplicativo X11 sem intermediários.
   - Adicionado `lcms2-devel` aos `makedepends` para gerenciamento de cores ICC.
   - Limpeza de `hostmakedepends`: `pkg-config wayland-devel git`.
   - `do_fetch()` com `rm -rf "$wrksrc"` para rebuilds limpos.
   - `post_install()` com `vlicense LICENSE`, `vdoc README.md` e `vdoc PACKAGING.md`.

2. **Template `srcpkgs/xdg-desktop-portal-umbriel/template`**:
   - Criado para prover o backend oficial do XDG Desktop Portal para o Umbriel.
   - Dependências completas: `sdbus-c++-devel`, `pipewire-devel`, `wayland-devel`, `wayland-protocols`, `libdrm-devel`, `libgbm-devel`, `cairo-devel`, `tomlplusplus-devel`, `json-c++`, `gtk4-devel` (para o `umbriel-share-picker`).
   - `depends="xdg-desktop-portal"`.

3. **Workflow GitHub Actions (`.github/workflows/build.yml`)**:
   - Atualizado para copiar ambos os templates (`cp -r /custom-repo/srcpkgs/* /void-packages/srcpkgs/`).
   - Compila primeiro `xdg-desktop-portal-umbriel` e em seguida `umbriel`.
   - Indexa, assina e publica ambos os pacotes `.xbps` no GitHub Pages e na GitHub Release diária.

---

## 🌐 Tradução da UI (Refinamento & Validação na Máquina do Wil)
- **Patch de Tradução**: `srcpkgs/umbriel/patches/0001-portuguese-ui.patch` (sincronizado em `void-packages` e preparado em `umbriel-void`).
- **Diretriz de Tradução**:
  - Evitar termos robóticos ou repetitivos como "Alternar ..." para cada `Toggle...`. Usar termos limpos e diretos da indústria (`Tela cheia`, `Janela flutuante`, `Guia de atalhos`, `Visão geral`, `Modo abas`).
- **Escopo Traduzido**:
  1. **Cabeçalho e Rodapé do Cheatsheet (`cheatsheet.cpp`)**: "Atalhos do Umbriel", aviso de configuração e "pressione qualquer tecla para fechar".
  2. **Grupos do Cheatsheet (`cheatsheet_rows.cpp`)**: Aplicativos, Transmissão, Foco, Mover & Redimensionar, Janelas, Scratchpad, Espaços de Trabalho, Visão Geral, Sistema.
  3. **Ações dos Atalhos (`cheatsheet_rows.cpp`)**: Tradução limpa e direta (`Tela cheia`, `Janela flutuante`, `Guia de atalhos`, `Fechar janela`, `Maximizar janela`, `Foco à esquerda`, `Mudar espaço: 1-9`, `Sair do Umbriel`, etc.).
  4. **Diálogo de Saída (`quit_confirm.cpp`)**: "Sair do Umbriel? Enter confirma...", etc.
  5. **Banners de Configuração (`config_banner.cpp`)**: Alertas de erros e avisos em português.

---

## 🚀 Estado Atual
- Suíte completa do Umbriel (compositor + portal) **compilada com 100% de sucesso via `xbps-src` e validada em produção pelo Wil**.
- Patch de tradução da interface (`0001-portuguese-ui.patch`) aprovado, integrado e publicado no repositório `umbriel-void`.
- GitHub Actions acionado para compilação contínua e distribuição pública dos pacotes via GitHub Pages e GitHub Releases.
- Arquivo de configuração em `~/.config/umbriel/config.toml` alinhado e validado (`config: ok`).
