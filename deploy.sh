echo "starting tftp to 192.168.97.6"
(echo -e "binary\rtrace\rverbose\rput clock.hex" ; cat) | tftp 192.168.97.60
