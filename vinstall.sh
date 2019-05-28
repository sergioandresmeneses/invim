#/bin/bash
# $1 git URL, $2 plugin-name
# path ~/.vim/pack/myplugins/start/

function validation(){
	#echo "$(ls -lah ~/.$1)"
	if [ -d "/$HOME/.$1/pack/myplugins/start" ] ; then
		echo "The configuration folder is in place"
		
	else
		echo "Preparing the environtment..."
		mkdir ~/.$1
		mkdir ~/.$1/pack/
		mkdir ~/.$1/pack/myplugins/
		mkdir ~/.$1/pack/myplugins/start/
		echo "The configuration folder was configured properly!"
	fi

}

function install(){
	cd ~/.vim/pack/myplugins/start/
	git clone $2
	cd $2
	git submodule init
	git submodule add $2 vim/pack/start/$3
	git add .gitmodules vim/pack/start/$3
	git commit

}

function update(){
	#git submodule update --remote --merge
	#git commit
	echo "update completed!..."
}

function remove(){
	cd ~/.vim/pack/myplugins/start/$1
	git submodule deinit vim/pack/start/$1
	git rm vim/pack/start/$1
	rm -Rf .git/modules/vim/pack/start/$1
	git commit
}

validation "vim"

case $1 in 
	install)
		echo "Installing plugin..."
		install "$2 $3"
		;;
	update)
		echo "Updating components..."
		update
		;;
	remove)
		echo "Removing plugin $2"
		;;
	*)
		echo "Please insert a valid option [Install|Update|Remove]"
		;;
	esac

