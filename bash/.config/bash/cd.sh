# If not running interactively, don't do anything
if ((! $INTERACTIVE)); then return; fi

# CD to home folder (WSL hack)
cd ~