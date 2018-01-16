#!/bin/bash
sed -i '1s/^/\#\n\# Source common settings\n\#\nsource ~\/.zshrc_common\n\n\#\n\# Platform\/machine specific settings\n\#\n/' ~/.zshrc
