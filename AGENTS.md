# Diretrizes e Memória de Sessão (Antigravity)

Este arquivo é lido automaticamente pelo Antigravity em todas as sessões para manter o contexto contínuo e nunca se perder.

---

## 📌 Perfil do Projeto & Princípios do Usuário (Wil)

1. **Repositório do Projeto**: `umbriel-void` (`/home/wil/umbriel-void`)
   - Empacotamento do compositor Wayland **Umbriel** para **Void Linux** (x86_64).
   - CI/CD automatizado via GitHub Actions que constrói e publica o repositório XBPS nativo no GitHub Pages (`gh-pages`).

2. **Princípios e Preferências**:
   - **Continuidade & Memória**: Sempre salvar e atualizar este arquivo com o progresso, decisões e estado atual para manter a memória entre sessões.
   - **Compatibilidade com Apps Antigos (X11) e Fontes**:
     - O Umbriel deve ter compatibilidade com aplicativos legados (X11) via `xorg-server-xwayland`.
     - Inclui `virtual?font:sans-serif` para garantir renderização de texto e mensagens de diagnóstico do compositor.
   - **O que é o "Portal"**:
     - No Wayland, "portal" refere-se exclusivamente ao `xdg-desktop-portal-umbriel` (necessário para compartilhamento de tela no Discord/Meet/OBS e Flatpaks).
     - **Não é nada sobre IA**; é o termo técnico para o subsistema de captura e permissões do Wayland.
     - Ele é um projeto e pacote **separado** do compositor. O pacote `umbriel` permanece focado apenas no compositor. Se necessário no futuro, criaremos o subpacote/template `xdg-desktop-portal-umbriel`.
   - **Qualidade do Empacotamento (Void Linux / xbps-src / Upstream Specs)**:
     - Seguir rigorosamente as boas práticas do `xbps-src`, `xlint` e o `PACKAGING.md` oficial do upstream.
     - Evitar redundâncias como `meson ninja` em `hostmakedepends` quando `build_style=meson`.
     - Respeitar suporte upstream (ex: `lcms2` para cores, `xorg-server-xwayland` para X11 nativo).

---

## 📝 Histórico de Decisões e Polimento do Template (`srcpkgs/umbriel/template`)

1. **Dependência de X11 e Fontes**:
   - `depends="xorg-server-xwayland virtual?font:sans-serif"`.
   - `xwayland-satellite` foi removido definitivamente. O Umbriel chama `/usr/bin/Xwayland` nativamente para rodar qualquer aplicativo X11 sem intermediários.
2. **Dependência de Cores (ICC)**:
   - Adicionado `lcms2-devel` a `makedepends` para permitir gerenciamento de cores e perfis ICC pelo `umbrielfx`.
3. **Limpeza de `hostmakedepends`**:
   - `meson` e `ninja` são providos automaticamente pelo `build_style=meson` do `xbps-src`, mantendo a lista limpa: `pkg-config wayland-devel git`.
4. **Fetch limpo**:
   - Mantido `rm -rf "$wrksrc"` antes de `git clone` em `do_fetch()` para permitir rebuilds locais sem falhas de diretório existente.
5. **Documentação**:
   - Instalados `LICENSE`, `README.md` e `PACKAGING.md` via `vlicense` e `vdoc`.

---

## 🚀 Estado Atual
- Template do `umbriel` polido e validado com `xlint`.
- Versão atual: `0.1.0git20261003_1` (commit upstream `ef2c16e`).
