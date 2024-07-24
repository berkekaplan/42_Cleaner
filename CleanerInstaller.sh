#!/bin/bash

#get the shell configuration file name
shell_f=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${shell_f}rc"

# Check if cclean alias already exists and remove it
if grep -q "^alias cclean=" "$shell_f"; then
    echo "Removing existing cclean alias..."
    sed -i '/^alias cclean=/d' "$shell_f"
fi

#take confirmation
while true; do
    echo -en "\nDo you really want to install this program ? (y/n) "
    read -r yn
    case $yn in
        [Yy]*) break ;;
        [Nn]*) exit ;;
        *) echo -e "\nPlease answer yes or no !\n" ;;
    esac
done

#remove the old Cleaner and Cleaner42 if there are any, then copy the current one to Home dir
/bin/rm -rf ~/42_Cleaner.sh &>/dev/null
/bin/rm -rf ~/Cleaner_42.sh &>/dev/null
/bin/rm -rf ~/Cleaner.sh &>/dev/null
cp -f ./42_Cleaner.sh "$HOME"

# Add new alias for cclean
if ! grep "alias cclean='bash ~/42_Cleaner.sh'" <"$shell_f" &>/dev/null; then
    echo -e "\nalias cclean='bash ~/42_Cleaner.sh'" >>"$shell_f"
fi

# Confirm installation
if grep "alias cclean='bash ~/42_Cleaner.sh'" <"$shell_f" &>/dev/null && ls "$HOME"/42_Cleaner.sh &>/dev/null; then
    sleep 0.5
    echo -e "\n -- cclean command has been successfully installed ! --\n"
    sleep 0.5
    echo -e "-- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m cclean \033[0m\033[36m]--\n"
else
    sleep 0.5
    echo -e "\n -- cclean command has NOT been installed ! --\n"
    exit 1
fi

exit 0
