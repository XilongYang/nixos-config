{ config, pkgs, ... }:
{
  xdg.configFile."ncmpcpp/config".text = ''
    song_status_format = {$b$5%t$9$/b by $b$3%a$9$/b}
    alternative_header_first_line_format = {{$5$b%t$/b$9}}
    alternative_header_second_line_format = {{$3$b%a$/b$9}{ - $8$b%b$9}}|{%D}
    current_item_prefix = $(blue)$r
    current_item_suffix = $/r$(end)
    current_item_inactive_column_prefix = $(green)$r
    current_item_inactive_column_suffix = $/r$(end)
    browser_playlist_prefix = "$5playlist$9 "
    song_columns_list_format = (20)[cyan]{a} (50)[white]{t} (25)[blue]{b} (5)[magenta]{l}
    execute_on_song_change = notify-send "󰝚 Now Playing" "$(mpc --format '%title% \n%artist% - %album%' current)"
    playlist_display_mode = columns
    browser_display_mode = columns
    search_engine_display_mode = columns
    volume_change_step = 5
    autocenter_mode = yes
    centered_cursor = yes
    progressbar_look = "───"
    user_interface = classic
    header_visibility = no
    statusbar_visibility = yes
    titles_visibility = no
    cyclic_scrolling = yes
    allow_for_physical_item_deletion = no
    startup_screen = playlist
    mouse_support = no
    external_editor = nvim
    use_console_editor = yes
    colors_enabled = yes
    empty_tag_color = green
    header_window_color = blue
    volume_color = cyan:b
    state_line_color = white
    state_flags_color = white:b
    main_window_color = white
    color1 = blue
    color2 = white
    progressbar_elapsed_color = cyan:b
    statusbar_time_color = cyan:b
    player_state_color = white:b
    alternative_ui_separator_color = green:b
    window_border_color = green
    active_window_border = blue

    lyrics_directory = ~/.local/share/mpd/lyrics
    follow_now_playing_lyrics = yes
    fetch_lyrics_for_current_song_in_background = yes
    store_lyrics_in_song_dir = no
  '';
}
