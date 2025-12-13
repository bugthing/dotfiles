# include .profile if it exists
[[ -f ~/.profile ]] && . ~/.profile

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc


# libpq - advice from homebrew
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/libpq/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/libpq/include"
export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/libpq/lib/pkgconfig"
