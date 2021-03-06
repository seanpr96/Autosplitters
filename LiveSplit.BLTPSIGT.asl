state("BorderlandsPreSequel", "103")
{
	bool isLoading : "BorderlandsPreSequel.exe", 0x1C53040;
	bool playerIsLocked : "BorderlandsPreSequel.exe", 0x1C5AFC0;
	uint playerxp : "BorderlandsPreSequel.exe", 0x1C67914;
	uint playerxph : "BorderlandsPreSequel.exe", 0x1C67918;
}

state("BorderlandsPreSequel", "104")
{
	bool isLoading : "BorderlandsPreSequel.exe", 0x1C6C0D0;
	bool playerIsLocked : "BorderlandsPreSequel.exe", 0x1C740C4;
	uint playerxp : "BorderlandsPreSequel.exe", 0x1C80A64;
	uint playerxph : "BorderlandsPreSequel.exe", 0x1C80A68;
}

init
{
	switch (modules.First().FileVersionInfo.FileVersion)	
	{
		case "1.0.34031.34031":
			version = "103";
			break;
		case "1.0.99567.99567":
			version = "103";
			break;
		case "1.0.36500.36500":
			version = "104";
			break;
		case "1.0.102036.102036":
			version = "104";
			break;
	}
}

start
{
	current.loadingTime = 0.0;
	return !current.isLoading && current.playerxph==0 && current.playerxp==0 && !current.playerIsLocked && old.playerIsLocked;
}

isLoading
{
	if (current.isLoading && !old.isLoading)
	{
		current.loadingTime = timer.CurrentTime.RealTime.Value.TotalMilliseconds;
	}
	return current.isLoading;
}

gameTime
{
	if (old.isLoading && !current.isLoading)
	{
		if (timer.CurrentTime.RealTime.Value.TotalMilliseconds - current.loadingTime > 40000.0)
		{
			return timer.CurrentTime.GameTime.Value.Add(TimeSpan.FromMilliseconds(timer.CurrentTime.RealTime.Value.TotalMilliseconds - current.loadingTime));
		}
	}
	
	return null;
}