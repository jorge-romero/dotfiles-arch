#!/usr/bin/env bash
DIR=`dirname "$(realpath "$0")"`

source $DIR/log.sh
source $DIR/read_settings.sh

wallpapers_dir=$(settings wallpaper_images)

function wallpaper_change(){
    local wallpaper=${1:-}
    local engine=$(settings wallpaper_engine)

    if [[ $? -eq 1 ]]; then
       exit 1
    fi

    echo_info "Change Wallpaper."
    echo_info "Engine to use: $engine."
    echo_info "Wallpapers folder: $wallpapers_dir."
    [[ -n "$wallpaper" ]] && echo_info "Wallpaper name: $wallpaper."

    wallpaper_change_$engine $wallpaper
}

function wallpaper_change_swww(){
    local wallpaper=${1:-}
    if [[ -z "$wallpaper" ]]; then
	echo_info "Choosing wallpaper from $wallpapers_dir."

	if [[ -d $wallpapers_dir ]]; then
	   local pics=("$wallpapers_dir"/*)
           wallpaper=${pics[RANDOM % ${#pics[@]}]}
    	fi
    fi

    echo "swww img ${wallpaper} --transition-fps 30 --transition-type any -durantion 3"
    swww img --transition-fps 30 \
             --transition-type any \
	     --transition-duration 3 ${wallpaper}
    echo_done "Wallpaper $wallpaper set"
}

wallpaper_change
