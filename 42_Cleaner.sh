#calculating the current available storage
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
echo -e "\nBefore : $Storage"

function clean {
	# to avoid printing empty lines
	# or unnecessarily calling /bin/rm
	# we resolve unmatched globs as empty strings.
	shopt -s nullglob

	#42 Caches
	clean_glob "$HOME"/Library/*.42*
	clean_glob "$HOME"/*.42*
	clean_glob "$HOME"/.zcompdump*
	clean_glob "$HOME"/.cocoapods.42_cache_bak*

	#Trash
	clean_glob "$HOME"/.Trash/*

	#General Caches files
	#giving access rights on Homebrew caches, so the script can delete them
	/bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null
	clean_glob "$HOME"/Library/Caches/*
	clean_glob "$HOME"/Library/Application\ Support/Caches/*

	#Slack, VSCode, Discord and Chrome Caches
	clean_glob "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Slack/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/discord/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/discord/Code\ Cache/js*
	clean_glob "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*
	clean_glob "$HOME"/Library/Application\ Support/Code/Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Code/CachedData/*
	clean_glob "$HOME"/Library/Application\ Support/Code/Crashpad/completed/*
	clean_glob "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/*
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/*

	#.DS_Store files
	clean_glob "$HOME"/Desktop/**/*/.DS_Store

	#tmp downloaded files with browsers
	clean_glob "$HOME"/Library/Application\ Support/Chromium/Default/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System
	clean_glob "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System

	#things related to pool (piscine)
	clean_glob "$HOME"/Desktop/Piscine\ Rules\ *.mp4
	clean_glob "$HOME"/Desktop/PLAY_ME.webloc

}
clean

#calculating the new available storage after cleaning
Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
if [ "$Storage" == "0BB" ];
then
	Storage="0B"
fi
sleep 1
echo -e "After  : $Storage\n"
