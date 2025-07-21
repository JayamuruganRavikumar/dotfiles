//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "/home/jay/.config/dwmblocks/battery-status",				10,		0},
	{"", "/home/jay/.config/dwmblocks/battery-notifier",			120,		0},
	{"", "/home/jay/.config/dwmblocks/volume-status",					15,		0},
	{"", "/home/jay/.config/dwmblocks/system-status",					5,		0},
	{"", "/home/jay/.config/dwmblocks/weather-status",				19000,		0},
	{" ", "date '+%b %d (%a) %I:%M%p'",					5,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
