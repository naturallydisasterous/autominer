# DEPENDENCIES: arch linux

mine_eth()
{

    dialog --nocancel --pause "Mining ETH..." 20 30 5
    teamredminer -a ethash -o stratum+tcp://us-eth.2miners.com:2020 -u 0x0f4a5595fc74a0279dfe0aab8f5823b63400e15a.teamredftw
}

mine_etc()
{
    dialog --nocancel --pause "Mining ETC..." 20 30 5
    lolminer --algo ETCHASH --pool etc.2miners.com:1010 --user 0x982c75a4fcbe85B22881A52828830fd95b5C5163.teamredftw
}

mine_rvn()
{
    dialog --nocancel --pause "Mining RVN..." 20 30 5
    teamredminer -a kawpow -o stratum+tcp://us-rvn.2miners.com:6060 -u RRtygmvzTFRvSfCbMerFWM9nZteCHmFq9F.teamredftw
}

setup_miner()
{
    # DEPENDENCY: dialog
    if ! [ -x "$(command -v dialog)" ]; then
        echo 'Error: dialog is not installed' >&2
        exit 1;
    fi

    # DEPENDENCY: teamredminer
    if ! [ -x "$(command -v teamredminer)" ]; then
        echo 'Error: teamredminer is not installed' >&2
        exit 1;
    fi

    # DEPENDENCY: lolminer
    if ! [ -x "$(command -v lolminer)" ]; then
        echo 'Error: lolminer is not installed' >&2
        exit 1;
    fi

}

setup_miner
dialog --nocancel --timeout 15 --menu "Which coin to mine? (Defaults to ETH after 15 sec)" 15 40 3 1 ETH 2 ETC 3 RVN 2>minetemp

if [ "$?" = "0" ]
then
    _return=$(cat minetemp)
    rm -f minetemp
    clear
    
    # /home is selected
    if [ "$_return" = "1" ]
    then
        mine_eth
    fi
    
    # /root is selected
    if [ "$_return" = "2" ]
    then
        mine_etc
    fi
    
    # /tmp is selected
    if [ "$_return" = "3" ]
    then
        mine_rvn
    fi
    
    # Cancel is pressed
else
    mine_eth
fi

# end of mine.sh
