echo "#########################################################################################################"
echo "Install GPUTILS"
echo "#########################################################################################################"
tar zxvf gputils-0.13.7.tar.gz
cd gputils-0.13.7
sudo ./configure
sudo make
sudo make install
echo "#########################################################################################################"
echo "Install SDCC"
echo "#########################################################################################################"
bunzip2 sdcc-src-20091215-5595.tar.bz2
tar xvf sdcc-src-20091215-5595.tar
cd sdcc
sudo ./configure
sudo make
sudo make install
echo "#########################################################################################################"
echo "Install SDCC"
echo "#########################################################################################################"
cd device/lib/pic16
sudo make
sudo make install 
echo "#########################################################################################################"
echo "Linking Libraries"
echo "#########################################################################################################"
cd /usr/local/lib/pic16
sudo ln -s libc18f.a libc18f.lib
sudo ln -s libdev18f97j60.a libdev18f97j60.lib
sudo ln -s libio18f97j60.a libio18f97j60.lib
sudo ln -s libm18f.a libm18f.lib
sudo ln -s libsdcc.a libsdcc.lib
