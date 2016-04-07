function __fastdir_cd_num
	if not count $argv > /dev/null
		echo "need directory name"
		return 1
	end

	set -l current_dir_num (math (count $dirprev) + 1)
	set -l dir_diff (math $argv[1] - $current_dir_num)

	if test $dir_diff -gt 0
		if test $dir_diff -gt (count $dirnext)
			set dir_diff (count $dirnext)
		end
		return (nextd $dir_diff)
	else if test $dir_diff -lt 0
		set dir_diff (math 0 - $dir_diff)
		if test $dir_diff -gt (count $dirprev)
			set dir_diff (count $dirprev)
		end
		return (prevd $dir_diff)
	end

	return 0
end
