#!/bin/sh -e

OS=${1%/}
ONLY=
VAGRANT=

if [ ! -d "$OS" ]; then
    echo "OS '$OS' does not exist. Please rerun the command with proper OS.";
    exit;
fi

PS3='Please enter your choice: '
options=("VMWare" "VirtualBox" "both (VMWare and VirtualBox)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "VMWare")
            echo "Only VMWare image will be built."
            ONLY=vmware-iso
            break
            ;;
        "VirtualBox")
            echo "Only VirtualBox image will be built."
            ONLY=virtualbox-iso
            break
            ;;
        "both (VMWare and VirtualBox)")
            echo "Both VMWare and VirtualBox images will be built."
            ONLY=vmware-iso,virtualbox-iso
            break
            ;;
        "Quit")
            exit 0
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

while true; do
    read -p "Output as Vagrant BOX file? (y/n)? " choice
    case "$choice" in 
    [Yy]* )
        # sed -i.bak 's/"vagrant": ".*$/"vagrant": "run"/' $OS/$OS.json
        # sed -i.bak 's/"_post-processors":/"post-processors":/' $OS/$OS.json
        VAGRANT="-vagrant"
        break
        ;;
    [Nn]* )
        # sed -i.bak 's/"vagrant": ".*$/"vagrant": "skip"/' $OS/$OS.json
        # sed -i.bak 's/"post-processors":/"_post-processors":/' $OS/$OS.json
        break
        ;;
    * ) 
        echo "Please answer yes or no."
        ;;
    esac
done
# rm $OS/$OS.json.bak

read -p "Hostname (Default: ubuntu): " HOSTNAME

if [[ -z "$HOSTNAME" ]]; then
    HOSTNAME="ubuntu"
fi

export PACKER_CACHE_DIR=`pwd`/packer_cache
cd $OS
echo "Building image with 'packer build -only=${ONLY} -var "hostname=$HOSTNAME" $OS${VAGRANT}.json'"
packer build -only=${ONLY} -var "hostname=$HOSTNAME" $OS${VAGRANT}.json 
