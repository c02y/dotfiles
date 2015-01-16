#!/bin/bash

iface=$1
RXB=$(</sys/class/net/"$iface"/statistics/rx_bytes)
TXB=$(</sys/class/net/"$iface"/statistics/tx_bytes)

sleep 0.5

RXBN=$(</sys/class/net/"$iface"/statistics/rx_bytes)
TXBN=$(</sys/class/net/"$iface"/statistics/tx_bytes)
RXDIF=$(echo $((RXBN - RXB)) )
TXDIF=$(echo $((TXBN - TXB)) )

echo -e "$((RXDIF / 1024 / 2))K/s $((TXDIF / 1024 / 2))K/s"
