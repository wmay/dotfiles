# Configuration file for ipython.

import IPython

c = get_config()

if IPython.version_info[0] > 8:
    c.InteractiveShell.enable_tip = False
