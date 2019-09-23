state("Blasphemous")
{
	bool isLoading : "UnityPlayer.dll", 0x13AAD50, 0x560, 0x3E8, 0x100, 0x210, 0x1D8;
}

isLoading
{
	return current.isLoading;
}
