#!/bin/bash

HERE=`(cd "${0%/*}" 2>/dev/null; echo "$PWD"/)`

if [ -z "${ITERM_BG_FONT}" ]; then
    ITERM_BG_FONT=/Library//Fonts/Microsoft\ Sans\ Serif.ttf
fi

function generate_text_image {
    # Depends on `convert` from ImageMagick.
    # TODO:
    echo HELLLOOO >> /tmp/argh
    TEXT="$1"
    IMG_PATH="$2"
    /usr/local/bin/convert -background black -fill white -font "$FONT" -size 400x200 \
            -rotate 20 "label:${TEXT}" "${IMG_PATH}"  >> /tmp/argh 2>&1
    echo "convert -background black -fill white -font \"${ITERM_BG_FONT}\" -size 400x200 -rotate 20 \"label:${TEXT}\" \"$IMG_PATH\"" >> /tmp/argh
}

NOW=`date`
echo "I RAN AT $NOW" >> /tmp/argh

TEXT="$1"

# Overrides
case "$TEXT" in
    djserver)
        TEXT=vagrant
        ;;
    web598)
        TEXT=slinkp
        ;;
esac


IMG_DIR=~/.hostbackgrounds

mkdir -p "${IMG_DIR}"

if [ -z "$TEXT" ]; then
    IMG_PATH=""
else
    IMG_PATH="${IMG_DIR}"/${TEXT}.png
fi


if [ -n "$IMG_PATH" ]; then
    echo Will set image as "$IMG_PATH" >> /tmp/argh
    if [ ! -f "$IMG_PATH" ]; then
        echo Generating new image at "$IMG_PATH" >> /tmp/argh
        generate_text_image "$TEXT" "$IMG_PATH"
    fi
else
    echo Will clear image >> /tmp/argh
fi

osascript $HERE/iterm_set_bg.scpt "$IMG_PATH"
