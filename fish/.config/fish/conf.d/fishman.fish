#!/usr/bin/fish

set command D F Fy Q Qd Qdt Qe Qg Qi Qk Qkk Ql Qm Qn Qo Qs Qt Qu R Rs Rsn S Sc Scc Sg Si Sl Ss Sw Syu U
# 1 means sudo is needed
set sudo    1 0 1  0 0   0  0  0  0  1   1  0  0  0  0  0  0  0  1 1   1  1 1   1  0  0  0  0  1   1  1

for i in (seq (count $command))
  set _command $command[$i]

  if ! abbr -q $_command
    if test $sudo[$i] = 1
      abbr -g $_command sudo pacman -$_command
    else
      abbr -g $_command pacman -$_command
    end
  end
end
