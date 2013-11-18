echo "Making the clock.c"
make clock 
echo "starting tftp to 192.168.97.6"
(echo -e "binary\rtrace\rverbose\r" ; cat) | tftp 192.168.97.60
