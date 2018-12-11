Lemon Bar
=========

For a nice pretty status bar in i3 I have tried BumblebeeStatus .. that was using python, I like pain, so am trying
using a thinner bar.


To Install
----------

      $ git clone https://aur.archlinux.org/ttf-font-awesome-4.git
      $ cd ttf-font-awesome-4
      $ makepkg -si
      $ git clone https://aur.archlinux.org/lemonbar-xft-git.git
      $ cd lemonbar-xft-git/
      $ makepkg -si

To Run
------

      $ ./bar.sh | lemonbar -p -f "Font Awesome"  -f "Roboto Medium"

