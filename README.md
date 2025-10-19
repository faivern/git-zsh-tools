# 🧠 zsh-git-helpers

Lightweight Zsh scripts that make your Git workflow faster, cleaner, and more structured.

## 🚀 What It Solves

Tired of messy commits or repetitive setup?  
**zsh-git-helpers** improves consistency and speed by adding:
- **`gcm`** – an interactive commit helper for Conventional Commits  
- **`gnew`** – a one-command project initializer with optional remote setup  

## ✨ Features

- **Conventional Commits**: Guided prompts for structured commit messages.
- **Project Initialization**: Quickly set up new Git repositories with optional remote configuration.
- **Zsh Integration**: Seamlessly integrates into your Zsh shell environment.

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/faivern/git-zsh-tools.git ~/.zsh-git-helpers
   ```

2. Add the scripts to your `~/.zshrc`:
   ```bash
   echo 'source ~/.zsh-git-helpers/githelpers/commitHelper.zsh' >> ~/.zshrc
   echo 'source ~/.zsh-git-helpers/githelpers/initHelper.zsh' >> ~/.zshrc
   ```

3. Reload your Zsh configuration:
   ```bash
   source ~/.zshrc
   ```

## 💡 Usage

### Create a new repository
```bash
gnew my-project
```
Creates a new folder, initializes Git with a README, and optionally sets a remote.

### Make a structured commit
```bash
gcm
```
Guided prompt for commit type, scope, summary, and optional description.