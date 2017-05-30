state("salt")
{
	float vanquished: "salt.exe", 0x5ECAA060, 0xA8, 0x440, 0x774, 0x4, 0x10;
	float end: "salt.exe", 0x5ECAA0D8, 0x420, 0x298, 0x6BC, 0x32C, 0x3E4;
	int menu: "salt.exe", 0x5ECAA0D8, 0x448, 0x774, 0x740, 0xA0, 0x58, 0x14;
	int transition: "salt.exe", 0x5ECAA0D8, 0x448, 0x774, 0x740, 0xA0, 0x58, 0x18;
}

start
{
	return current.menu == 11 && current.transition == 3;
}

split
{
	if (old.vanquished == 0 && current.vanquished > 0 && timer.CurrentSplitIndex < timer.Run.Count - 1) return true;
	else if (timer.CurrentSplitIndex == timer.Run.Count - 1 && current.end > 0) return true;
	
	return false;
}