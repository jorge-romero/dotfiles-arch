#!/usr/bin/env bash
DIR=`dirname "$(realpath "$0")"`
source $DIR/log.sh
source $DIR/read_settings.sh

function init_swww(){
    mkdir -p $HOME/.cache/swww
    swww query || swww-daemon --format xrgb &
}

function init(){
    echo_info "Init wallpaper engine"
    local engine=$(settings wallpaper_engine)
    engine=swww
    if [[ $? -eq 0 ]]; then
       echo_info "Engine to use: $engine"
       init_$engine
    fi
}

init
