function pacdep -d "Mark package(s) as dependency"
  sudo pacman -D $argv --asdeps
end
