function __fasd_print_completions
  set cmd (commandline -po)
  fasd $argv $cmd[2..-1] -l
end
