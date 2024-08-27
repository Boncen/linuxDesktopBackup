curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo 'export PATH=$PATH:$HOME/.cargo/bin' >> $HOME/.bashrc
source $HOME/.bashrc
