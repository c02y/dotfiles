# https://github.com/tuvistavie/fish-fastdir
function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end

function -; cd -; end
function d --description 'list the directories in history, prompt and enter a num into the directory'
	if test (math (count $dirprev) + (count $dirnext)) -gt 0
		__fastdir_dirhist -l -n
		and begin
			# prompt
			echo '---------------------'
			echo "Which directory into?"
			read arg
			if test $arg -gt 0 -a $arg -lt 100
				__fastdir_cd_num $arg
			end
		end
	else
		set_color -o red
		echo "!!!" (pwd|sed "s=$HOME=~=") "is the only directory in history !!!"
		set_color normal
	end
end

function 1; __fastdir_cd_num 1; end
function 2; __fastdir_cd_num 2; end
function 3; __fastdir_cd_num 3; end
function 4; __fastdir_cd_num 4; end
function 5; __fastdir_cd_num 5; end
function 6; __fastdir_cd_num 6; end
function 7; __fastdir_cd_num 7; end
function 8; __fastdir_cd_num 8; end
function 9; __fastdir_cd_num 9; end
