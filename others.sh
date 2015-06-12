
# make prompt colorful 
sed -i "s/#force_color_prompt=yes/force_color_prompt=yes/g" ~/.bashrc
echo '"\e[A": history-search-backward  # arrow up' >> ~/.inputrc
echo '"\e[B": history-search-forward   # arrow down' >> ~/.inputrc

# install tree
sudo apt-get --yes --force-yes install tree 

# install git
sudo apt-get --yes --force-yes install git

# install python parser for vim
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo 'execute pathogen#infect()' >> ~/.vimrc
cd ~/.vim/bundle && \
git clone git://github.com/scrooloose/syntastic.git


