DevSecOps – Curso de Liderança Técnica 2025.1 (CESAR School)

Repositório oficial da disciplina de DevSecOps do curso de Liderança Técnica 2025.1 da CESAR School.
Este repositório contém os materiais, scripts e automações desenvolvidas ao longo do curso com foco em segurança integrada ao ciclo DevOps.

👨‍🎓 Alunos

Lucas Matos

Magno Silva

Erick Nathan

Stiwe Sousa


# ![Juice Shop Logo](https://raw.githubusercontent.com/juice-shop/juice-shop/master/frontend/src/assets/public/images/JuiceShop_Logo_100px.png) OWASP Juice Shop

[![OWASP Flagship](https://img.shields.io/badge/owasp-flagship%20project-48A646.svg)](https://owasp.org/projects/#sec-flagships)
[![GitHub release](https://img.shields.io/github/release/juice-shop/juice-shop.svg)](https://github.com/juice-shop/juice-shop/releases/latest)
[![Twitter Follow](https://img.shields.io/twitter/follow/owasp_juiceshop.svg?style=social&label=Follow)](https://twitter.com/owasp_juiceshop)
[![Subreddit subscribers](https://img.shields.io/reddit/subreddit-subscribers/owasp_juiceshop?style=social)](https://reddit.com/r/owasp_juiceshop)



OWASP Juice Shop is probably the most modern and sophisticated insecure web application! It can be used in security
trainings, awareness demos, CTFs and as a guinea pig for security tools! Juice Shop encompasses vulnerabilities from the
entire
[OWASP Top Ten](https://owasp.org/www-project-top-ten) along with many other security flaws found in real-world
applications!

![Juice Shop Screenshot Slideshow](screenshots/slideshow.gif)

For a detailed introduction, full list of features and architecture overview please visit the official project page:
<https://owasp-juice.shop>

# Manual do Aluno - Laboratório DevSecOps

Guia prático para configuração do ambiente e execução dos laboratórios.

**📝 Convenção de Nomes**: Ao longo deste manual, usamos `<seu-nome>-nodegoat` como exemplo de nome para o repositório pessoal (ex: `joao-nodegoat`, `maria-nodegoat`). Você pode escolher o nome que preferir para seu repositório, mas recomendamos seguir este padrão para facilitar a identificação.

---

## ⚠️ IMPORTANTE - Usuários Windows

Se você usa **Windows**, configure o **WSL 2** ANTES de continuar.

👉 Vá para: [Apêndice A: Configuração do WSL 2](#apêndice-a-configuração-do-wsl-2)

Após configurar, volte para a [Seção 1](#1-instalação-inicial).

**⚠️ NOTA IMPORTANTE**: Após configurar o WSL 2, você deve trabalhar **SEMPRE** dentro do ambiente WSL durante toda a disciplina. Para iniciar o WSL, abra o PowerShell ou CMD e digite:
```powershell
wsl
```
Todos os comandos e ferramentas devem ser executados dentro do terminal WSL (Ubuntu), não no Windows nativo.

**⚠️ IMPORTANTE - Diretório de Trabalho (WSL)**: Sempre trabalhe no diretório home do usuário WSL:
```bash
cd ~
```
**Não** trabalhe nos diretórios montados do Windows (`/mnt/c/`), pois isso causa problemas de performance e permissões. Clone os repositórios diretamente no home do WSL (`~`).

---

## Índice

- [Manual do Aluno - Laboratório DevSecOps](#manual-do-aluno---laboratório-devsecops)
  - [⚠️ IMPORTANTE - Usuários Windows](#️-importante---usuários-windows)
  - [Índice](#índice)
  - [1. Instalação Inicial](#1-instalação-inicial)
    - [1.1 Instalar Homebrew (macOS)](#11-instalar-homebrew-macos)
    - [1.2 Instalar Just](#12-instalar-just)
    - [1.3 Instalar Docker](#13-instalar-docker)
    - [1.4 Clonar Repositório e Instalar Ferramentas](#14-clonar-repositório-e-instalar-ferramentas)
  - [2. Configuração do GitHub](#2-configuração-do-github)
    - [2.1 Criar Organização](#21-criar-organização)
    - [2.2 Criar Repositório Pessoal](#22-criar-repositório-pessoal)
    - [2.3 Habilitar GitHub Advanced Security](#23-habilitar-github-advanced-security)
  - [3. Setup do Repositório](#3-setup-do-repositório)
  - [4. Pre-commit Hooks](#4-pre-commit-hooks)
    - [4.1 Copiar Configurações](#41-copiar-configurações)
    - [4.2 Ativar Hooks](#42-ativar-hooks)
    - [4.3 Testar Hooks](#43-testar-hooks)
    - [4.4 Desinstalar Hooks](#44-desinstalar-hooks)
  - [5. Kubernetes Local](#5-kubernetes-local)
    - [5.1 Copiar Configurações K8s](#51-copiar-configurações-k8s)
    - [5.2 Deploy Cluster](#52-deploy-cluster)
    - [5.3 Verificar Cluster](#53-verificar-cluster)
  - [6. GitHub Actions Runner](#6-github-actions-runner)
    - [6.1 Criar GitHub PAT](#61-criar-github-pat)
    - [6.2 Deploy Runner](#62-deploy-runner)
    - [6.3 Verificar Instalação](#63-verificar-instalação)
  - [7. Workflow 00 - Debug](#7-workflow-00---debug)
    - [7.1 Copiar Workflow](#71-copiar-workflow)
    - [7.2 Criar PR de Teste](#72-criar-pr-de-teste)
    - [7.3 Verificar Execução](#73-verificar-execução)
  - [8. Workflow 01 - Secret Scanning](#8-workflow-01---secret-scanning)
    - [8.1 Obter Licença Gitleaks](#81-obter-licença-gitleaks)
    - [8.2 Configurar Secret no GitHub](#82-configurar-secret-no-github)
    - [8.3 Copiar Workflow](#83-copiar-workflow)
    - [8.4 Testar Secret Scanning](#84-testar-secret-scanning)
  - [9. Workflow 02 - SCA (Software Composition Analysis)](#9-workflow-02---sca-software-composition-analysis)
    - [9.1 Deploy Dependency Track](#91-deploy-dependency-track)
    - [9.2 Configurar API Key](#92-configurar-api-key)
    - [9.3 Copiar Workflow](#93-copiar-workflow)
    - [9.4 Testar SCA](#94-testar-sca)
  - [10. Workflow 03 - SAST (Static Analysis)](#10-workflow-03---sast-static-analysis)
    - [10.1 Deploy SonarQube](#101-deploy-sonarqube)
    - [10.2 Gerar Tokens no SonarQube](#102-gerar-tokens-no-sonarqube)
    - [10.3 Copiar Workflow](#103-copiar-workflow)
    - [10.4 Testar SAST](#104-testar-sast)
  - [11. Workflow 04 - Container Scanning](#11-workflow-04---container-scanning)
    - [11.1 Criar Conta Docker Hub](#111-criar-conta-docker-hub)
    - [11.2 Criar Access Token](#112-criar-access-token)
    - [11.3 Criar Repositório Docker Hub](#113-criar-repositório-docker-hub)
    - [11.4 Configurar Secrets GitHub](#114-configurar-secrets-github)
    - [11.5 Deploy ArcherySec](#115-deploy-archerysec)
    - [11.6 Copiar Workflow](#116-copiar-workflow)
    - [11.7 Testar Container Scanning](#117-testar-container-scanning)
  - [12. Workflow 05 - IaC Scanning](#12-workflow-05---iac-scanning)
    - [12.1 Configurar ArcherySec API Key](#121-configurar-archerysec-api-key)
    - [12.2 Copiar Workflow](#122-copiar-workflow)
    - [12.3 Testar IaC Scanning](#123-testar-iac-scanning)
  - [13. Workflow 06 - Build e Deploy](#13-workflow-06---build-e-deploy)
    - [13.1 Deploy NodeGoat no Kubernetes](#131-deploy-nodegoat-no-kubernetes)
    - [13.2 Configurar KUBECONFIG Secret](#132-configurar-kubeconfig-secret)
    - [13.3 Copiar Workflow](#133-copiar-workflow)
    - [13.4 Testar Build e Deploy](#134-testar-build-e-deploy)
  - [14. Referência Rápida](#14-referência-rápida)
  - [Apêndice A: Configuração do WSL 2](#apêndice-a-configuração-do-wsl-2)
    - [A.1 Pré-requisitos](#a1-pré-requisitos)
    - [A.2 Instalar WSL 2](#a2-instalar-wsl-2)
    - [A.3 Configurar Ubuntu](#a3-configurar-ubuntu)
    - [A.4 Verificar Instalação](#a4-verificar-instalação)
    - [A.5 Atualizar Ubuntu](#a5-atualizar-ubuntu)
    - [A.6 Comandos Úteis](#a6-comandos-úteis)
    - [A.7 Acessar Arquivos](#a7-acessar-arquivos)
    - [A.8 Troubleshooting](#a8-troubleshooting)

---

## 1. Instalação Inicial
### 1.1 Instalar Homebrew (macOS)

**⚠️ Apenas para macOS**

```bash
# Verificar se já está instalado
brew --version

# Se não estiver instalado:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Seguir instruções na tela para adicionar ao PATH
```

### 1.2 Instalar Just

```bash
# macOS
brew install just

# Linux/WSL
sudo apt update && sudo apt install -y just
```

### 1.3 Instalar Docker

**macOS:**
- Baixar [Docker Desktop para Mac](https://docs.docker.com/desktop/setup/install/mac-install/)
- Instalar e iniciar

**Windows:**
- Baixar [Docker Desktop para Windows](https://docs.docker.com/desktop/setup/install/windows-install/)
- Durante instalação: marcar "Use WSL 2 instead of Hyper-V"
- Após instalação:
  - Abrir Docker Desktop
  - Settings → Resources → WSL Integration
  - Habilitar integração com Ubuntu

**Linux:**

Documentação oficial: https://docs.docker.com/engine/install/ubuntu/

```bash
# Remover versões antigas (se houver)
sudo apt remove docker docker-engine docker.io containerd runc

# Instalar dependências
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# Adicionar chave GPG oficial do Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Adicionar repositório Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adicionar usuário ao grupo docker
sudo usermod -aG docker $USER
newgrp docker

# Iniciar serviço
sudo systemctl enable docker
sudo systemctl start docker
```

**Verificar:**
```bash
docker --version
docker compose version
```

### 1.4 Clonar Repositório e Instalar Ferramentas

```bash
# Ir para o diretório home
cd ~
# Clonar repositório do projeto
git clone https://github.com/lucas-devsecops-2025/juice-shop
cd juice-shop
# Instalar TODAS as ferramentas automaticamente
just setup
```

**O que `just setup` instala:**
- Git
- kubectl (Kubernetes CLI)
- pre-commit (hooks framework)
- kind (Kubernetes in Docker)
- helm (package manager)
- kubectx/kubens (context switcher)
- k9s (TUI manager)

**⚠️ Linux/WSL - PATH do pipx:**
```bash
# Se pre-commit não for encontrado
source ~/.bashrc
# ou reiniciar terminal
```

## 3. Testar Aplicação
```bash
# Subir app
just start

# Acessar no browser: http://localhost:3000

# Parar
just stop
```

---

## 4. Pre-commit Hooks

### 4.1 Ativar Hooks

```bash
pre-commit install
```

### 4.3 Testar Hooks

```bash
# Teste - Secret Scanning
echo 'GITLAB_TOKEN="glpat-1234567890abcdefghij"' > .env
git add .env
git commit -m "test: secret detection"
# ❌ Deve falhar (Gitleaks detecta)

# Limpar
git reset HEAD~1 && rm .env
```

### 4.4 Desinstalar Hooks

**⚠️ IMPORTANTE**: Após testar, desinstale os pre-commit hooks. Usaremos security gates diferentes nos workflows de CI/CD para não atrapalhar os testes:

```bash
pre-commit uninstall
```

---

## 5. Kubernetes Local

### 5.1 Deploy Cluster
```bash
just deploy-kind-cluster
```

### 5.3 Verificar Cluster

```bash
# Verificar nodes
kubectl get nodes

# Verificar metrics-server
kubectl get pods -n kube-system | grep metrics-server

# Verificar ferramentas instaladas
kubectl version --client
kind version
helm version
kubectx --version
kubens --version
k9s version
```

---

## 6. GitHub Actions Runner

### 6.1 Criar GitHub PAT

1. GitHub → Settings → Developer settings
2. Personal access tokens → Tokens (classic)
3. Generate new token (classic)
4. Scopes: `repo`, `admin:org`
5. Copiar token gerado (será usado como `GITHUB_PAT` no próximo passo)

### 6.2 Deploy Runner

```bash

# Criar arquivo com credenciais
# Substitua:
#   <sua-org> = nome da organização criada na seção 2.1
#   ghp_seu_token_aqui = token copiado na seção 6.1
cat > .env.secrets << 'EOF'
GITHUB_CONFIG_URL=https://github.com/<sua-org>
GITHUB_PAT=ghp_seu_token_aqui
EOF

# Deploy Actions Runner Controller
just setup-github-runners
```

### 6.3 Verificar Instalação

```bash
# Verificar pods
kubectl get pods -n arc-systems
kubectl get pods -n arc-runners

# Verificar runner scale set
kubectl get runnerscaleset -n arc-runners
```

**No GitHub:**
- Organization Settings → Actions → Runners
- Deve aparecer: `arc-runner-set` (Active)
- **⚠️ IMPORTANTE - Habilitar para repositórios públicos:**
  1. Na mesma página (Organization Settings → Actions → Runners)
  2. Clicar na aba "Runner groups"
  3. Clicar no grupo "Default"
  4. Marcar a opção "Allow public repositories"
  5. Clicar em "Save group" para salvar alterações

---

## 7. Workflow 00 - Debug
### 7.1 Criar PR de Teste

```bash
git checkout -b test-runner-connectivity
echo "# Testing runners" > TEST.md
git add TEST.md
git commit -m "test: verify runner connectivity"
git push origin test-runner-connectivity
```

### 7.2 Verificar Execução

**No GitHub:**
1. Pull Requests → Abrir PR criado
2. Aba "Checks"
3. Confirmar 2 jobs em paralelo:
   - ✅ Debug - connectivity
   - ✅ Debug - docker-dind

**Troubleshooting:**
- `connectivity` falha → Problema no ARC/runner
- `docker-dind` falha → Verificar `containerMode.type="dind"`

**Limpar:**
1. Fechar PR (não merge)
2. Deletar branch: `git branch -D test-runner-connectivity`

---

## 8. Workflow 01 - Secret Scanning

### 8.1 Obter Licença Gitleaks

1. Acessar https://gitleaks.io/ e criar conta
2. Dashboard → Licenses
3. Solicitar **GitHub organization license**
4. Copiar licença (string `eyJ...`)

### 8.2 Configurar Secret no GitHub

1. Repository Settings → Secrets and variables → Actions
2. New repository secret
3. Name: `GITLEAKS_LICENSE`
4. Value: colar licença
5. Add secret

### 8.3 Testar Secret Scanning

```bash
# Criar branch de teste
git checkout -b test-secret-scanning

# Opção 1: Copiar chave privada (simular leak)
cp artifacts/cert/server.key leaked-private-key.pem

# Opção 2: Adicionar secrets de teste
cat > test-secrets.env << 'EOF'
AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
GITHUB_TOKEN="ghp_1234567890abcdefghijklmnopqrstuvwxyz"
DATABASE_PASSWORD="super-secret-password-123"
EOF

git add leaked-private-key.pem test-secrets.env
git commit -m "test: add secrets for scanning demo"
git push origin test-secret-scanning
```

**Verificar resultados:**
- Abrir PR no GitHub
- Aba "Checks": Verificar Trivy e Gitleaks
  - Trivy: Categoriza por severidade (CRITICAL, HIGH, MEDIUM, LOW)
  - Gitleaks: Reporta como WARNING
- Aba "Security" → "Code scanning": Ver anotações inline com tipo de secret detectado

**Limpar:**
- Fechar PR sem merge
- Deletar branch: `git branch -D test-secret-scanning`

---

## 9. Workflow 02 - SCA (Software Composition Analysis)

### 9.1 Deploy Dependency Track

```bash
just start-dependency-track
```

- Acesso: http://localhost:8081
- Login: `admin` / `admin`
- Aguardar inicialização (3-5 minutos)

### 9.2 Configurar API Key

**No Dependency Track:**
1. Administration → Access Management → Teams
2. Selecionar team "Administrators"
3. Aba "API Keys" → "+ Create API Key"
4. Copiar API Key

**No GitHub:**
1. Repository Settings → Secrets and variables → Actions
2. New repository secret
3. Name: `DEPENDENCYTRACK_APIKEY`
4. Value: colar API Key
5. Add secret

### 9.3 Testar SCA

```bash
# Criar branch de teste
git checkout -b test-sca

# Adicionar dependência vulnerável ao package.json
# Encontrar a linha "dependencies": { e adicionar:
# "axios": "0.21.1",

# Ou usar sed (Linux/macOS):
sed -i.bak '/"dependencies": {/a\
    "axios": "0.21.1",' package.json

# Gerar package-lock.json
npm install

git add package.json package-lock.json
git commit -m "test: add vulnerable dependency for SCA demo"
git push origin test-sca
```

**Criar PR e verificar:**

**No Dependency Track (http://localhost:8081):**
- Projeto "app" criado automaticamente
- **Overview**: Métricas resumidas, risk score
- **Components**: Dependências diretas e transitivas
- **Audit Vulnerabilities**: CVEs encontrados
  - Ver CVSS score (severidade técnica)
  - Ver EPSS score (probabilidade de exploração)

**No GitHub:**
- Aba "Security" → "Code scanning": Alertas do Trivy
- Aba "Insights" → "Dependency graph": Árvore de dependências

**Limpar:**
- Fechar PR e deletar branch
- Reverter package.json se necessário

---

## 10. Workflow 03 - SAST (Static Analysis)

### 10.1 Deploy SonarQube

```bash
# Deploy SonarQube
just start-sonarqube
```

- Acesso: http://localhost:9000
- Login: `admin` / `admin` (trocar senha no primeiro acesso)

### 10.2 Gerar Tokens no SonarQube

**Token 1 - Global Analysis Token:**
1. My Account → Security
2. Generate Tokens → Token name: `github-actions-token`
3. Type: **Global Analysis Token**
4. Expires in: No expiration
5. Generate → Copiar token

**Token 2 - User Token:**
1. Mesma página (My Account → Security)
2. Token name: `github-actions-user-token`
3. Type: **User Token**
4. Expires in: No expiration
5. Generate → Copiar token

**Configurar no GitHub:**
1. Repository Settings → Secrets and variables → Actions
2. Criar dois secrets:
   - Name: `SONAR_TOKEN` | Value: Global Analysis Token
   - Name: `SONAR_USER_TOKEN` | Value: User Token
   
### 10.3 Testar SAST

```bash
# Criar branch de teste
git checkout -b test-sast

# Copiar arquivo com vulnerabilidades intencionais
cp app/data/allocations-dao.js app/data/teste.js

git add app/data/teste.js
git commit -m "test: add vulnerable code for SAST demonstration"
git push origin test-sast
```

**Criar PR e verificar:**

**No GitHub:**
- Abrir PR da branch `test-sast`
- Aba "Security" → "Code scanning"
- Filtrar por Tool: "SonarQube"
- Ver anotações inline no código

**No SonarQube (http://localhost:9000):**
- Projeto "app" criado
- Métricas: Security, Reliability, Maintainability
- Security Hotspots
- Issues: NoSQL Injection, Code Smells, Complexidade

**Limpar:**
- Fechar PR e deletar branch

---

## 11. Workflow 04 - Container Scanning

### 11.1 Criar Conta Docker Hub

1. Acessar https://hub.docker.com/signup
2. Criar conta gratuita
3. Verificar email
4. Login: https://hub.docker.com

### 11.2 Criar Access Token

1. Avatar → Account Settings → Security
2. New Access Token
3. Description: "GitHub Actions - NodeGoat DevSecOps"
4. Access permissions: **Read, Write, Delete**
5. Generate → Copiar token

### 11.3 Criar Repositório Docker Hub

1. Repositories → Create Repository
2. Name: `nodegoat`
3. Visibility: **Public**
4. Create

### 11.4 Configurar Secrets GitHub

**Secret:**
1. Repository Settings → Secrets and variables → Actions
2. New repository secret
3. Name: `DOCKERHUB_TOKEN`
4. Value: colar Access Token
5. Add secret

**Variable:**
1. Aba "Variables" → New repository variable
2. Name: `DOCKERHUB_USERNAME`
3. Value: seu username Docker Hub
4. Add variable

### 11.5 Deploy ArcherySec

```bash
# Do repo do instrutor
cd $INSTRUCTOR_REPO

# Copiar manifestos ArcherySec
mkdir -p $STUDENT_REPO/k8s/archery
cp -r k8s/archery/* $STUDENT_REPO/k8s/archery/

cd $STUDENT_REPO
git add k8s/archery/
git commit -m "feat: add ArcherySec Kubernetes manifests"
git push origin main

# Parar SonarQube e subir ArcherySec
cd $INSTRUCTOR_REPO
just stop-sonarqube
just start-archerysec

# Aguardar pods Ready
kubectl get pods -n archerysec -w
```

- Acesso: http://localhost:8083
- Login: `admin@intra.local` / `admin`

### 11.6 Copiar Workflow

```bash
# Do repo do instrutor
cd $INSTRUCTOR_REPO

# Remover workflow anterior
rm $STUDENT_REPO/.github/workflows/03-sast.yaml

# Copiar workflow de container scanning
cp .github/workflows/04-container-scanning.yaml $STUDENT_REPO/.github/workflows/

# Ir para seu repo
cd $STUDENT_REPO

git add .github/workflows/
git commit -m "ci: remove SAST workflow and add container scanning"
git push origin main
```

### 11.7 Testar Container Scanning

```bash
# Criar PR de teste
git checkout -b test-container-scanning
echo "test" >> README.md
git add README.md
git commit -m "test: trigger container scanning"
git push origin test-container-scanning
```

**Verificar:**
- GitHub Actions: Build multi-plataforma
- Docker Hub: Imagem publicada
- Code Scanning: Vulnerabilidades e licenças

**Limpar:**
- Fechar PR e deletar branch

---

## 12. Workflow 05 - IaC Scanning

### 12.1 Configurar ArcherySec API Key

**No ArcherySec (http://localhost:8083):**
1. Login: `admin@intra.local` / `admin`
2. Settings → Access Keys
3. Generate New Key → Copiar token

**No GitHub:**
1. Repository Settings → Secrets and variables → Actions
2. New repository secret
3. Name: `ARCHERYSEC_APIKEY`
4. Value: colar token
5. Add secret

### 12.2 Copiar Workflow

```bash
# Do repo do instrutor
cd $INSTRUCTOR_REPO

# Remover workflow anterior
rm $STUDENT_REPO/.github/workflows/04-container-scanning.yaml

# Copiar workflow de IaC scanning
cp .github/workflows/05-iac-scanning.yaml $STUDENT_REPO/.github/workflows/

# Ir para seu repo
cd $STUDENT_REPO

git add .github/workflows/
git commit -m "ci: remove container scanning and add IaC scanning"
git push origin main
```

### 12.3 Testar IaC Scanning

```bash
# Criar PR de teste
git checkout -b test-iac-scanning
echo "test" >> README.md
git add README.md
git commit -m "test: trigger IaC scanning"
git push origin test-iac-scanning
```

**Verificar:**
- GitHub Actions: Trivy e Checkov scanning
- ArcherySec: Resultados centralizados

**Limpar:**
- Fechar PR e deletar branch

---

## 13. Workflow 06 - Build e Deploy

### 13.1 Deploy NodeGoat no Kubernetes

```bash
# Do repo do instrutor
cd $INSTRUCTOR_REPO

# Copiar manifestos NodeGoat
mkdir -p $STUDENT_REPO/k8s/nodegoat
cp -r k8s/nodegoat/* $STUDENT_REPO/k8s/nodegoat/

cd $STUDENT_REPO
git add k8s/nodegoat/
git commit -m "feat: add NodeGoat Kubernetes manifests"
git push origin main

# Parar ArcherySec e subir NodeGoat
cd $INSTRUCTOR_REPO
just stop-archerysec
just start-nodegoat-k8s

# Aguardar pods Ready
kubectl get pods -n nodegoat -w
```

- Acesso: http://localhost:8084

### 13.2 Configurar KUBECONFIG Secret

```bash
# macOS - Copiar para clipboard
kind get kubeconfig --name devsecops | \
  sed 's|https://127.0.0.1:[0-9]*|https://kubernetes.default.svc|g' | \
  base64 | pbcopy

# Linux - Copiar para clipboard
kind get kubeconfig --name devsecops | \
  sed 's|https://127.0.0.1:[0-9]*|https://kubernetes.default.svc|g' | \
  base64 -w 0 | xclip -selection clipboard
```

**No GitHub:**
1. Repository Settings → Secrets and variables → Actions
2. New repository secret
3. Name: `KUBECONFIG`
4. Value: colar output base64
5. Add secret

### 13.3 Copiar Workflow

```bash
# Do repo do instrutor
cd $INSTRUCTOR_REPO

# Remover workflow anterior
rm $STUDENT_REPO/.github/workflows/05-iac-scanning.yaml

# Copiar workflow de build/deploy
cp .github/workflows/06-build-deploy.yaml $STUDENT_REPO/.github/workflows/

# Ir para seu repo
cd $STUDENT_REPO

git add .github/workflows/
git commit -m "ci: remove IaC scanning and add build/deploy"
git push origin main
```

### 13.4 Testar Build e Deploy

```bash
# Criar PR de teste
git checkout -b test-build-deploy
echo "test" >> README.md
git add README.md
git commit -m "test: trigger build and deploy"
git push origin test-build-deploy
```

**Verificar:**
- GitHub Actions: Build → Deploy staging
- Docker Hub: Imagem com tag da branch
- Kubernetes: `kubectl get pods -n nodegoat`
- App: http://localhost:8084

**Fazer merge:**
- Aprovar e merge PR para main
- Verificar build com tag `latest`

---

## 14. Referência Rápida

**Just:**
```bash
just --list              # Comandos
just setup               # Instalar ferramentas
just start               # Subir app
just stop                # Parar app
just deploy-kind-cluster # Criar K8s
```

**Kubernetes:**
```bash
kubectl get nodes                         # Nodes
kubectl get pods -n <namespace>           # Pods
kubectl logs -n <namespace> <pod>         # Logs
kubectl get runnerscaleset -n arc-runners # Runners
kubectx                                   # Clusters
kubens                                    # Namespaces
k9s                                       # TUI
```

**Git:**
```bash
git status               # Status
git add .                # Add
git commit -m "msg"      # Commit
git push origin <branch> # Push
git checkout -b <branch> # Nova branch
```

**Docker:**
```bash
docker ps                # Containers
docker compose logs -f   # Logs
docker compose up -d     # Subir
docker compose down      # Parar
```

**Navegação:**
```bash
cd $INSTRUCTOR_REPO                # Repo instrutor
cd $STUDENT_REPO     # Seu repo
pwd                          # Diretório atual
```

---

## Apêndice A: Configuração do WSL 2

### A.1 Pré-requisitos

- Windows 10: Versão 2004+ (Build 19041+)
- Windows 11: Qualquer versão
- Permissões de Administrador

**Verificar versão:**
1. `Win + R`
2. Digite `winver`
3. Verificar requisitos

### A.2 Instalar WSL 2

**PowerShell como Admin:**
```powershell
wsl --install
```

Isso instala:
- Windows Subsystem for Linux
- Virtual Machine Platform
- Kernel Linux
- Ubuntu (padrão)

**⚠️ Reiniciar Windows:**
```powershell
Restart-Computer
```

### A.3 Configurar Ubuntu

1. Abrir "Ubuntu" no menu Iniciar
2. Aguardar inicialização (demora na 1ª vez)
3. Criar usuário e senha

### A.4 Verificar Instalação

```powershell
wsl -l -v
```

Deve mostrar:
```
NAME      STATE      VERSION
* Ubuntu  Running    2
```

**Se VERSION = 1:**
```powershell
wsl --set-version Ubuntu 2
wsl --set-default-version 2
```

### A.5 Atualizar Ubuntu

```bash
sudo apt update && sudo apt upgrade -y
```

### A.6 Comandos Úteis

```powershell
wsl                    # Iniciar Ubuntu
wsl -l -v              # Listar distribuições
wsl --shutdown         # Desligar WSL
wsl --terminate Ubuntu # Desligar Ubuntu
```

### A.7 Acessar Arquivos

**Windows → Ubuntu:**
- Explorador: `\\wsl$\Ubuntu\home\seuusuario`

**Ubuntu → Windows:**
```bash
cd /mnt/c/Users/SeuUsuario  # Drive C:
```

### A.8 Troubleshooting

**Erro "requires update":**
- https://aka.ms/wsl2kernel

**Erro "Virtualization not enabled":**
- BIOS → Habilitar VT-x/AMD-V

**Instalação trava:**
```powershell
wsl --shutdown
```

---

**Após configurar WSL 2:** [Voltar para Seção 1](#1-instalação-inicial)
