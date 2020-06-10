function pacexp -d "Mark package(s) as explicitly installed"
  sudo pacman -D $argv --asexplicit
end
