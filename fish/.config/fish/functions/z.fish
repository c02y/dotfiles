function z -d "cd, same functionality as j in autojump"
    fasd_cd -d $argv
end

function zz -d 'cd from the list, interactively'
    z -i
end
