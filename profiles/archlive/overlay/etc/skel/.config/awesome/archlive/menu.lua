module("archlive.menu")

-- config_path = os.getenv("XDG_CONFIG_HOME") .. "/awesome/"
-- theme_path = config_path .. "archlive/archlive"

Archlive_menu = {}

Archlive_menu["Archlive_net"] = {
	{"Firefox网络浏览", "firefox"},
	{"Pidgin网络通讯", "pidgin"},
	{"Skype网络聊天", "skype"},
	{"Xchat交流", "xchat"},
	{"腾讯QQ", "qq"},
	{"奔流BT下载", "/usr/share/benliud/benliud"},
	{"Grdc远程桌面", "grdc"},
}
Archlive_menu["Archlive_pic"] = {
	{"GpicView图像查看", "gpicview"},
	{"Comix图像查看", "comix"},
	{"FoxitPDF查看器", "foxitreader %f"},  
	{"Gsnapshot抓屏", "gsnapshot"},
	{"xwd抓屏工具","xwd | xwud"},
}
Archlive_menu["Archlive_media"] = {
	{"Mplayer媒体播放", "gmplayer %F"},
	{"VLC媒体播放器", "vlc %U"},
	{"Streamtuner收音机", "streamtuner"},
	{"Gmlive网络电视", "gmlive"},
	{"Audacious音乐播放", "audacious %U"},
}
Archlive_menu["Archlive_txt"] = {
	{"Nano", "x-terminal-emulator -e ".."/bin/nano"},
	{"Leafpad文本编辑器", "leafpad"},
	{"Geany", "geany"},
}
Archlive_menu["Archlive_file"] = {
	{"PCManFM", "pcmanfm"},
	{"ROX-Filer", "rox"},
}
Archlive_menu["Archlive_console"] = {
	{"XTerm","xterm"},
	{"urxvt终端", "urxvt"},
	{"Sakura终端", "sakura"},
	{"Lxterminal终端", "lxterminal"},
}
Archlive_menu["Archlive_others"] = {
	{"进程查看", "urxvt -e htop"},
	{"SpoonWep2无线网络密码破解", "spoonwep"},
	{"SpoonWpa2无线网络密码破解", "spoonwpa"}, 
	{"GAdmin-Rsync备份", "gadmin-rsync"},
	{"RP-PPPoE拨号程序", "sudo tkpppoe"},
	{"网络配置向导", "sudo net-setup.sh"},
}

Archlive_menu["Archlive"] = {
	{ "网络工具", Archlive_menu["Archlive_net"] },
	{ "图形图像", Archlive_menu["Archlive_pic"] },
	{ "媒体播放", Archlive_menu["Archlive_media"] },
	{ "文本编辑", Archlive_menu["Archlive_txt"] },
	{ "文件管理", Archlive_menu["Archlive_file"] },
	{ "终端程序", Archlive_menu["Archlive_console"] },
	{ "其他工具", Archlive_menu["Archlive_others"] },
	{"Pgarted分区", "gparted"},
	{"Larchin安装程序", "/opt/larchin/run/larchin.py"},
	{"Archlive安装程序", "/opt/archlive-installer/bin/archlive-installer"},
}
