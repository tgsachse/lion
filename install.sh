# A small shell script that handles spinning up
# and shutting down the bot.

# Written by Tiger Sachse.


# dont need kill or start
# change install dependencies to full install of system
# remove dependencies for plugins
# create a shell script in /usr/local/bin to call the lioncli.py script

LION_PID="lion_pid_temp.txt"

# Kill the bot.
kill_lion() {
    if [ ! -f $LION_PID ]; then
        echo "Lion is not running."
    else
        printf "Killing Lion (%d)...\n" $(cat $LION_PID)
        kill $(cat $LION_PID)

        rm -rf source/plugins/__pycache__
        rm -f $LION_PID
    fi
}

# Start the bot.
start_lion() {
    kill_lion

    cd source

    echo "Starting Lion..."
    python3 lion.py &
    echo $! > ../$LION_PID

    cd ..
}

# Install dependencies.
install_dependencies() {
    if [[ $EUID -ne 0 ]]; then
        echo "This operation must be run as root." 
        exit 1
    fi

    apt install python3-pip
    pip3 install BeautifulSoup4 httplib2 pillow yarl==0.13.0
    pip3 install -U git+https://github.com/Rapptz/discord.py@rewrite#egg-discord.py

    printf "\n\n========================================================================\n"
    echo "You need the Discord and weather API tokens before the bot will work."
    echo "These are pinned in the #lion_development channel of the UCF CS Discord."
    echo "Ask a moderator for access to this channel."
    printf "========================================================================\n"
}

# Main entry point of the script.
case $1 in
    "--start")
        start_lion
        ;;
    "--kill")
        kill_lion
        ;;
    "--install-dependencies")
        install_dependencies
        ;;
esac
