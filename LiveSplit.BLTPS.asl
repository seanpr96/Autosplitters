state("BorderlandsPreSequel")
{
	bool isLoading : "BorderlandsPreSequel.exe", 0x1C53040;
	bool playerIsLocked : "BorderlandsPreSequel.exe", 0x1C5AFC0;
	uint playerxp : "BorderlandsPreSequel.exe", 0x1C67914;
	uint playerxph : "BorderlandsPreSequel.exe", 0x1C67918;
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
