function __fastdir_dirhist --description "Print the current directory history (the back- and fwd- lists)"
	if count $argv > /dev/null
		switch $argv[1]
			case -h --help
				__fish_print_help dirh
				return 0
		end
	end

	# Avoid set comment
	set -l current (command pwd)
	set -l separator "	"
	set -l line_len (math (count $dirprev) + (echo $dirprev $current $dirnext | wc -m) )
	set -l line_num false
	if test $line_len -gt $COLUMNS
		# Print one entry per line if history is long
		set separator "\n"
	end

	if count $argv > /dev/null
		for i in (seq (count $argv))
			switch $argv[$i]
				case '-l' --long
					set separator "\n"
					continue
				case '-n' --num --number
					set line_num true
					continue
				case '-*'
					printf (_ "%s: Unknown option %s\n" ) nextd $argv[$i]
					return 1
			end
		end
	end

	set -l current_line 0

	
	# BSD seq 0 outputs '1 0' instead of nothing
	if count $dirprev > /dev/null
		for i in (seq (count $dirprev))
			if test $line_num = true
				echo -n "$i "
				echo -n -e $dirprev[$i]$separator
			end
			set current_line $i
		end
	end

	set_color $fish_color_history_current
	if test $line_num = true
		set current_line (math $current_line + 1)
		echo -n "$current_line "
	end
	echo -n -e $current$separator
	set_color normal

	# BSD seq 0 outputs '1 0' instead of nothing
	if count $dirnext > /dev/null
		for i in (seq (echo (count $dirnext)) -1 1)
			if test $line_num = true
				set -l line (math (count $dirnext) - $i + $current_line + 1)
				echo -n "$line "
			end
			echo -n -e $dirnext[$i]$separator
		end
	end

	if test $separator != "\n"
		echo
	end
end
