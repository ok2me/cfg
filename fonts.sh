#!/bin/sh
echo "Do you wish to install powerline fonts?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh && cd .. && rm -rf fonts && echo "Done"; break;;
        No ) exit;;
    esac
done
# clone
#git clone https://github.com/powerline/fonts.git --depth=1
# install
#cd fonts
#./install.sh
# clean-up a bit
#cd ..
#rm -rf fonts
