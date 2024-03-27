#! /bin/sh

TMP=$HOME/.local/neovim_tmp
INSTALLATION_DIR=$HOME/.local/neovim

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

BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && cd .. && echo `pwd`)
HOOKS_SCRIPT="${BASEDIR}/.githooks/post-merge"

echo "[+] Installing plugins..."

mv "$BASEDIR"/after "$BASEDIR"/after_bak
mv "$BASEDIR"/init.lua "$BASEDIR"/init.lua.bak

bash $HOOKS_SCRIPT > /dev/null

mv "$BASEDIR"/after_bak "$BASEDIR"/after
mv "$BASEDIR"/init.lua.bak "$BASEDIR"/init.lua

clean

echo "[+] Done! Run 'source $CONFIG_FILE' to refresh the PATH."
