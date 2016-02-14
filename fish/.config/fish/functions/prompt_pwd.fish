# modified version of default prompt_pwd in /usr/share/fish/functions/prompt_pwd.fish
# if the path is longer than the $COLUMNS (with a little tweak)

set -l args_pre
set -l args_post
switch (uname)
	case Darwin
		set args_pre $args_pre -e 's|^/private/|/|'
	case 'CYGWIN_*'
		set args_pre $args_pre -e 's|^/cygdrive/\(.\)|\1/:|'
		set args_post $args_post -e 's-^\([^/]\)/:/\?-\u\1:/-'
end

function prompt_pwd -V args_pre -V args_post --description "Print the current working directory, shortened to fit the prompt"
	set -l LPWD (echo $PWD | sed -e "s|$HOME|~|")
	set pwd_l (expr length $LPWD)
	# use full path prompt if the path is not long
	if test $pwd_l -lt (math $COLUMNS-10) # the number 10 is needed
		if test "$PWD" != "$HOME"
			printf " %s " (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
		else
			echo ' ~'
		end
	else
		set -l realhome ~
		set -l LPWD2 (echo $PWD | sed -e "s|^$realhome\$|~|" -e "s|^$realhome/|~/|" $args_pre -e 's-\([^/.]\{3\}\)[^/]*/-\1/-g' $args_post)
		set pwd_2 (expr length $LPWD2)
		# use 3 chars each dir for long path first, if it is still longer, use 1 char.
		if test $pwd_2 -gt (math $COLUMNS-10)
			echo $PWD | sed -e "s|^$realhome\$|~|" -e "s|^$realhome/|~/|" $args_pre -e 's-\([^/.]\)[^/]*/-\1/-g' $args_post
		else
			echo $PWD | sed -e "s|^$realhome\$|~|" -e "s|^$realhome/|~/|" $args_pre -e 's-\([^/.]\{3\}\)[^/]*/-\1/-g' $args_post
		end
	end
end
