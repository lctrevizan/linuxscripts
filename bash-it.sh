if [ "$SHELL" = "/bin/bash" ]; then
    while true; do
        echo "Install bash-it? (y/n)"
        read input

        case $input in
            [yY]* )
                echo "Checking if git is installed..."
                if ! command -v git >/dev/null 2>&1; then
                    echo "Git is not installed. Please install it and try again."
                    exit 1
                fi

                echo "Checking if .bash_it directory exists..."
                if [ -d "$HOME/.bash_it" ]; then
                    echo "The .bash_it directory already exists. Overwrite? (y/n)"
                    read overwrite
                    if [ "$overwrite" = "y" ]; then
                        rm -rf ~/.bash_it
                    else
                        echo "Not overwriting. Exiting."
                        exit 1
                    fi
                fi

                echo "Installing bash-it."
                git clone --depth=1 https://github.com/lctrevizan/bash-it.git ~/.bash_it
                ~/.bash_it/install.sh
                source ~/.bashrc
                bash-it enable plugin history-substring-search sudo
                break
                ;;
            [nN]* )
                echo "Not installing bash-it."
                break
                ;;
            * )
                echo "Invalid input. Please try again."
                ;;
        esac
    done
else
    echo "You are not running Bash."
fi
