# shellcheck shell=bash

TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'0'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'7'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

if [ -z "${TMUX_POWERLINE_WINDOW_STATUS_CURRENT}" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[fg=black,bg=colour19]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		"#[fg=colour7,bg=colour19]" \
		" #I#F " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W " \
		"#[fg=colour19,bg=black]" \
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

if [ -z "${TMUX_POWERLINE_WINDOW_STATUS_STYLE}" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

if [ -z "${TMUX_POWERLINE_WINDOW_STATUS_FORMAT}" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
        "#{?window_activity_flag,#[fg=colour3 bg=black],#[$(format regular)]}" \
		"  #I#{?window_flags,#F, } " \
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
		" #W "
	)
fi

if [ -z "${TMUX_POWERLINE_LEFT_STATUS_SEGMENTS}" ]; then
    TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
        # "tmux_session_info 12 0 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
        "hostname 4 0" \
        "wan_ip 19 7 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
        "ifstat_sys 19 7" \
        "pwd 18 7"
    )
fi

if [ -z "${TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS}" ]; then
    TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
        "now_playing 18 20" \
        "date_day 9 0" \
        "date 9 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
        "time 9 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
    )
fi