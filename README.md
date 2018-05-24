
## Purpose

This automatically sets the background image on iterm2 anytime you ssh to
another host.

For many uses, [iTerm2 badges](https://iterm2.com/documentation-badges.html)
are easier to set up and might be just as good.  This script is a proof of concept to see if I can do
more interesting things.

It actually doesn't matter if it's via ssh; we use
iTerm2 [triggers](https://iterm2.com/features.html#triggers)
that just pattern-match on the prompt.

It uses iTerm2's [scripting support](https://iterm2.com/documentation-scripting.html)

## Demo Screen Capture

![an animation showing terminal backgrounds changing](http://g.recordit.co/RoxFH5k7YW.gif)


## Prerequisites

* MacOS
* Iterm2 3.x (tested on 3.1.6)
* `convert` from ImageMagick must be somewhere on `$PATH`. I think I used
  homebrew, but honestly don't remember.


## Installation

* Check out this repo and put this directory somewhere on your `$PATH`.

* Enable [shell integration](https://iterm2.com/documentation-shell-integration.html)

* If you want to override the default font (boring Microsoft Sans),
  just export `ITERM_BG_FONT` env var, set it to the full path of any TTF font you like.

* iTerm2 manual configuration of triggers:
  * Go to Iterm2 -> Preferences -> Profiles -> Advanced -> Triggers -> Edit
  * Click the "+" button to add a trigger. We'll start with one that matches a
    very common default prompt style, so should work on most hosts you ssh to.
    * **Regular expression**: `^\[(.*)@(.*)`
    * **Action**: "Run Command"
    * **Parameters**: `<path to your checkout>/iterm_set_bg_for_host.sh \2`
    * **Instant**: Turn this on if you want the background to change when prompt
      first appears. If left off, the background only changes on newline,
      i.e. after you enter the first command on the host.
    * Try ssh'ing somewhere from an iterm window. The background should
      change. If not, see Troubleshooting below.
  * Add more triggers with different patterns as needed, to match whatever
    prompts you use.
  * If you want to disable the background image for your default localhost
    shell, for now that's done by adding a another trigger that matches only
    that host, and set the Parameters to `iterm_set_bg_for_host.sh ""`.
    Sending an empty string clears out the background image. (Note this is
    not great as it would temporarily disable any default image you may have
    set for your iTerm2 profile.)

* If you don't like the generated images, play around with the `convert`
  command in `iterm_set_bg_for_host.sh` to your liking.


## Troubleshooting

The images should go in `~/.hostbackgrounds`.  Check if any files appear there.

Try manually running the applescript file, eg.
`osascript iterm_set_bg.scpt /path/to/some/image`

Try manually running the shell script, eg. `iterm_set_bg_for_host.sh "HelloWorld"`
and see if there are errors.

Try manually running the `convert` command.

If the manual checks above work, perhaps your script isn't being triggered? Double-check your trigger
regular expression in your iterm2 preferences.


## Fun Hack

Since the images are just cached files in a directory, you can literally drop
in any image you like named after a given host and it'll be used instead of the
default rotated-text image.

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
