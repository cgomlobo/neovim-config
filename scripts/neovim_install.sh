#! /bin/sh

TMP=$HOME/.local/neovim_tmp
INSTALLATION_DIR=$HOME/.local/neovim
BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && cd .. && echo `pwd`)
HOOKS_DIR="${BASEDIR}/.githooks"


function clean() {
    # Remove temp files
    echo "[+] Cleaning..."
    rm -rf $TMP
}

read -p "[+] Have you installed the required prerequisites? Visit https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites for reference. Continue with installation? [y/N] " answer

# Convert the user input to lowercase for case-insensitive comparison
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
    echo "[#] Proceeding with installation..."
else
    echo "[#] Installation aborted."
    exit 0
fi

mkdir -p $TMP

# Fetch neovim source code
echo "[+] Fetching neovim source code"
git clone https://github.com/neovim/neovim $TMP
cd $TMP
git checkout stable

# Build neovim
echo "[+] Building neovim source code"
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$INSTALLATION_DIR"

if [ $? -ne 0 ]; then
    echo "[+] Build failed"
    clean
    exit 1
fi

# Install neovim
echo "[+] Installing neovim"
mkdir -p $INSTALLATION_DIR
make CMAKE_INSTALL_PREFIX=$INSTALLATION_DIR install

if [ $? -ne 0 ]; then
    echo "[+] Installation failed"
    clean
    rm -rf $INSTALLATION_DIR
    exit 1
fi

cd $HOME

# Detect the shell configuration file
if [ -f "$HOME/.bashrc" ]; then
    CONFIG_FILE="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    echo "Unable to detect shell configuration file (.bashrc, .zshrc, etc.)."
    exit 1
fi

# Add neovim to PATH
echo "[+] Adding neovim to shell config file..."
echo "
# Add neovim to PATH
export PATH=$INSTALLATION_DIR/bin:\$PATH
" >> $CONFIG_FILE

export PATH=$INSTALLATION_DIR/bin:$PATH

cd $BASEDIR

echo "[+] Installing plugins..."

# Fetch packer code
mkdir -p ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install plugins using post-merge hook
mv after after_bak
mv init.lua init.lua.bak

bash $HOOKS_DIR/post-merge > /dev/null

mv after_bak after
mv init.lua.bak init.lua

clean

read -p "[+] Do you want to set up the hooks? [y/N] " answer

answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
    echo "[#] Setting up hooks..."
    bash $HOOKS_DIR/set_hooks.sh
fi

function install_language_servers() {
    # Typescript
    read -p "[+] Install tsserver? (requires npm) [y/N] " answer

    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
        npm install -g typescript typescript-language-server
        echo "[#] tsserver installed"
    fi

    # Python
    read -p "[+] Install jedi-language-server? (requires python) [y/N] " answer

    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
        pip install -U jedi-language-server
        echo "[#] jedi-language-server installed"
    fi

    # Rust
    read -p "[+] Install rust-analyzer? (requires rustup) [y/N] " answer

    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
        rustup component add rust-analyzer
        echo "[#] rust-analyzer installed"
    fi

    # Emmet
    read -p "[+] Install emmet-ls? (requires npm) [y/N] " answer

    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
        npm install -g emmet-ls
        echo "[#] emmet-ls installed"
    fi

    # Astro
    read -p "[+] Install @astrojs/language-server? (requires npm) [y/N] " answer

    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
        npm install -g @astrojs/language-server
        echo "[#] @astrojs/language-server installed"
    fi

    # Svelte
    read -p "[+] Install svelte-language-server? (requires npm) [y/N] " answer

    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

    if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
        npm install -g @svelte-language-server
        echo "[#] svelte-language-server installed"
    fi
}

# Install language servers
read -p "[+] Do ou want to install language servers? [y/N] " answer

answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

if [[ $answer == "yes" ]] || [[ $answer == "y" ]]; then
    install_language_servers
fi

echo "[+] Done! Run 'source $CONFIG_FILE' to refresh the PATH."
