# DevSecOps – Curso de Liderança Técnica 2025.1 (CESAR School)

Repositório oficial da disciplina de **DevSecOps** do curso de **Liderança Técnica 2025.1** (CESAR School).  
Aqui você encontrará materiais, scripts e automações com foco em **segurança integrada ao ciclo DevOps**.

## Índice

- [Alunos](#alunos)
- [OWASP Juice Shop](#owasp-juice-shop)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Teste rápido](#teste-rápido)
- [Pre-commit (opcional)](#pre-commit-opcional)
- [Kubernetes local (Kind)](#kubernetes-local-kind)
- [GitHub Actions Runner (ARC)](#github-actions-runner-arc)
- [Workflows](#workflows)
  - [00 — Debug](#00--debug)
  - [01 — Secret Scanning (Gitleaks)](#01--secret-scanning-gitleaks)
  - [02 — SCA (Dependency-Track)](#02--sca-dependency-track)
  - [03 — SAST (SonarQube)](#03--sast-sonarqube)
  - [04 — Container Scanning](#04--container-scanning)
  - [05 — IaC Scanning](#05--iac-scanning)
  - [06 — Build & Deploy (K8s)](#06--build--deploy-k8s)
- [Referência rápida](#referência-rápida)
- [Apêndice A — WSL 2 (Windows)](#apêndice-a--wsl-2-windows)

---

## Alunos

- Lucas Matos  
- Magno Silva  
- Erick Nathan  
- Stiwe Sousa

---

## OWASP Juice Shop

![Juice Shop Logo](https://raw.githubusercontent.com/juice-shop/juice-shop/master/frontend/src/assets/public/images/JuiceShop_Logo_100px.png)

[![OWASP Flagship](https://img.shields.io/badge/owasp-flagship%20project-48A646.svg)](https://owasp.org/projects/#sec-flagships)
[![GitHub release](https://img.shields.io/github/release/juice-shop/juice-shop.svg)](https://github.com/juice-shop/juice-shop/releases/latest)
[![Twitter Follow](https://img.shields.io/twitter/follow/owasp_juiceshop.svg?style=social&label=Follow)](https://twitter.com/owasp_juiceshop)
[![Subreddit subscribers](https://img.shields.io/reddit/subreddit-subscribers/owasp_juiceshop?style=social)](https://reddit.com/r/owasp_juiceshop)

Aplicação vulnerável moderna para **treinos, CTFs e demonstrações**. Cobre **OWASP Top 10** e falhas reais.  
Projeto oficial: <https://owasp-juice.shop>

---

## Pré-requisitos

- **Git**, **Docker** e **Docker Compose**
- **Just** (task runner)
- **WSL 2 + Ubuntu** (somente Windows) — veja [Apêndice A](#apêndice-a--wsl-2-windows)

> **Windows:** trabalhe **sempre dentro do WSL** (Ubuntu) e no **home do WSL** (`cd ~`).  
> Evite `/mnt/c/...` por questões de performance e permissões.

---

## Instalação

```bash
# 1) Clonar repositório (em ~ do WSL/Linux/macOS)
cd ~
git clone https://github.com/lucas-devsecops-2025/juice-shop
cd juice-shop

# 2) Just
# macOS: brew install just
# Linux/WSL:
sudo apt update && sudo apt install -y just

# 3) Docker
docker --version && docker compose version  # verifique se está ok

# 4) Setup rápido (instala ferramentas auxiliares: kubectl, kind, helm, etc.)
just setup
```

---

## Teste rápido

```bash
# Subir app
just start
# Acessar: http://localhost:3000

# Parar
just stop
```

---

## Pre-commit (opcional)

Ativa validações locais (útil para demonstração; desative depois para não atrapalhar os labs).

```bash
# Ativar
pre-commit install

# Teste rápido (deve falhar por secret)
echo 'GITHUB_TOKEN="ghp_1234567890abc..."' > .env && git add .env && git commit -m "test: secret"
# Limpar
git reset HEAD~1 && rm .env

# Desativar (recomendado para os labs)
pre-commit uninstall
```

---

## Kubernetes local (Kind)

```bash
# Criar cluster local
just deploy-kind-cluster

# Verificar
kubectl get nodes
kubectl get pods -A
```

---

## GitHub Actions Runner (ARC)

> Executa jobs do GitHub Actions dentro do seu cluster.

1) Crie um **PAT** (GitHub) com escopos `repo` e `admin:org`.  
2) Crie `.env.secrets`:

```bash
cat > .env.secrets << 'EOF'
GITHUB_CONFIG_URL=https://github.com/<sua-org>
GITHUB_PAT=ghp_seu_token_aqui
EOF
```

3) Deploy:

```bash
just setup-github-runners
kubectl get pods -n arc-systems
kubectl get pods -n arc-runners
```

4) Em **Organization Settings → Actions → Runners → Runner groups (Default)**, habilite **Allow public repositories**.

---

## Workflows

### 00 — Debug

- Objetivo: validar conectividade dos runners e Docker-in-Docker.  
- Teste rápido:

```bash
git checkout -b test-runner-connectivity
echo "# Testing runners" > TEST.md
git add TEST.md && git commit -m "test: verify runner connectivity"
git push origin test-runner-connectivity
```

---

### 01 — Secret Scanning (Gitleaks)

1) Obtenha licença em <https://gitleaks.io/> e salve como secret `GITLEAKS_LICENSE`.  
2) Gere PR com secrets de teste (ou chave simulada) para ver alertas em “Checks” e “Security”.

---

### 02 — SCA (Dependency-Track)

1) Suba o Dependency-Track local: `just start-dependency-track` (http://localhost:8081 → `admin`/`admin`).  
2) Gere uma **API Key** e salve em `DEPENDENCYTRACK_APIKEY` (Actions Secret).  
3) Para testar, adicione uma dependência vulnerável e abra PR; verifique alertas no GitHub e no DT.

---

### 03 — SAST (SonarQube)

1) `just start-sonarqube` (http://localhost:9000 → `admin`/`admin`).  
2) Gere tokens e salve como `SONAR_TOKEN` e `SONAR_USER_TOKEN`.  
3) Abra PR com código “problemático” para ver **Security Hotspots/Issues**.

---

### 04 — Container Scanning

- Configure Docker Hub:
  - Secret: `DOCKERHUB_TOKEN`
  - Variable: `DOCKERHUB_USERNAME`
- Abra PR e verifique:
  - Build multi-plataforma
  - Publicação no Docker Hub
  - Achados de vulnerabilidade/licenças (Code Scanning)

---

### 05 — IaC Scanning

- Suba o **ArcherySec**: `just start-archerysec` (http://localhost:8083 → `admin@intra.local` / `admin`).  
- Gere API Key e salve como `ARCHERYSEC_APIKEY`.  
- Abra PR e confira resultados consolidados.

---

### 06 — Build & Deploy (K8s)

1) **Manifests** do app (namespace `nodegoat`, por exemplo).  
2) **KUBECONFIG** (base64) como secret `KUBECONFIG` para o workflow atuar no cluster.  
3) PR dispara build e deploy; verifique pods e acesso do serviço.

```bash
kubectl get pods -n nodegoat
# App exposto conforme manifesto (Ex.: NodePort/Ingress)
```

---

## Referência rápida

```bash
# Just
just --list
just setup
just start / just stop
just deploy-kind-cluster

# Kubernetes
kubectl get nodes
kubectl get pods -A
kubectl logs -n <ns> <pod>
kubectx / kubens
k9s

# Git
git status
git add .
git commit -m "msg"
git push origin <branch>

# Docker
docker ps
docker compose up -d
docker compose down
```

---

## Apêndice A — WSL 2 (Windows)

1) **Instalar** (PowerShell Admin):
```powershell
wsl --install
Restart-Computer
```

2) **Ubuntu**: criar usuário, depois:
```bash
sudo apt update && sudo apt upgrade -y
```

3) **Verificar versão**:
```powershell
wsl -l -v   # deve mostrar Ubuntu com VERSION = 2
```

> **Sempre** abra um terminal WSL (`wsl`) e trabalhe em `cd ~`.  
> Evite `/mnt/c/...` para performance/permissão.
