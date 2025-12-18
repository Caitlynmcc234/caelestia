function yayq --wraps='yay -Q | grep' --description 'alias yayq=yay -Q | grep'
    yay -Q | grep $argv
end
