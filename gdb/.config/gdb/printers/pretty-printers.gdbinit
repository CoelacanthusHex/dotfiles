python

import os
import sys
from pathlib import Path
home = str(Path.home())
sys.path.insert(0, home + '/.config/gdb/printers')

from qt import register_qt_printers
register_qt_printers (None)

from kde import register_kde_printers
register_kde_printers (None)

end

source ~/.config/gdb/printers/libcxx-printers.py

# use `register_libcxx_printers` to enable libc++ pretty printers
define register_libcxx_printers
    python register_libcxx_printer_loader()
end
