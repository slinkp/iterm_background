
## Purpose

This automatically sets the background image on iterm2 anytime you ssh to
another host.

It actually doesn't matter if it's via ssh; we use iTerm2 triggers that just
pattern-match on the prompt.

## Demo

<img src="http://recordit.co/RoxFH5k7YW"  alt="an animation showing terminal backgrounds changing" />

## Prerequisites

* MacOS
* Iterm2 3.x (tested on 3.1.6)
* `convert` from ImageMagick must be somewhere on `$PATH`. I think I used
  homebrew, but honestly don't remember.


## Installation

* Check out this repo and put this directory somewhere on your `$PATH`.

* If you want to override the default font (boring Microsoft Sans),
  just export `ITERM_BG_FONT` env var, set it to the full path of any TTF font you like.

* iTerm2 manual configuration of triggers XXX TODO

* If you don't like the generated images, play around with the `convert`
  command in `iterm_set_bg_for_host.sh` to your liking.


## Fun Hack

Since the images are just cached files in a directory, you can literally drop
in any image you like named after a given host and it'll be used.

## Known Issues

* The Applescript sets the background of the currently focused window.
  `ssh` can take a while to connect / disconnect so there is of course a
  race condition where you might be focused on a different iTerm2 window
  by the time the prompt changes. The script doesn't know which terminal
  triggered the change - only which terminal is focused.

* Iterm2 triggers get fired on every prompt.  This means we are constantly
  telling the terminal to change the background even if it's already set correctly.
  This seems inefficient, but avoiding it may be difficult and I don't know
  if this consumes any resources worth caring about.
