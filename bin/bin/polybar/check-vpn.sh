if [ "0" == $(ifconfig | grep tun0 | wc -l) ]; then
    echo "vpn active";
else
    echo "no vpn";
fi
