state("Mafia3DefinitiveEdition")
{
	int loading       : 0x691E350;
    int smallLoads    : 0x691E008, 0x2C;
    string150 mission : 0x0691DD18, 0x2E0, 0x540;
}

init
{
    vars.doneMissions = new List<string>();
}

startup
  {

    settings.Add("MafiaIII", true, "All Missions");

    vars.Chapters = new Dictionary<string,string> 
	{
        //{"\"Why Take the Chance?\"","Why Take the Chance"},
        {"\"This Changes Everything\"", "This Changes Everything"},
        {"\"A Taste of the Action\"", "A Taste of the Action"},
        {"\"Go Down On Their Own\"", "Go Down on Their Own"},
        {"\"Never Going To Be Over\"", "Never Going to be Over"},
        {"\"...Time To Make A Change\"", "...Time to Make a Change"},
        {"\"Still Pull This Off\"", "Still Pull This Off"},
        {"\"Damn If This Ain't A Gas\"", "Damn if This Ain't a Gas"},
        {"\"...A Friend In Jesus\"", "...A Friend in Jesus"},
        {"\"Somethin' I've Got To Do\"", "Somethin' I've Got to Do"},
        {"Old Times' Sake", "Old Times' Sake"},
        {"Prostitution", "Prostitution"},
        {"Smack", "Smack"},
        {"Kill Ritchie Doucet", "Kill Ritchie Doucet"},
        {"\"That Goes Both Ways\"", "That Goes Both Ways"},
        {"\"Friends Like These\"", "Friends Like These"},
        {"\"We Partners Now?\"", "We Partners Now?"},
        {"Union Extortion", "Union Extortion"},
        {"Contraband", "Contraband"},
        {"Get Michael Grecco", "Get Michael Grecco"},
        {"Cut and Run", "Cut and Run"},
        {"Moonshine", "Moonshine"},
        {"Protection", "Protection"},
        {"Kill The Butcher", "Kill the Butcher"},
        {"\"Only Way's Forward\"", "Only Way's Forward"},
        {"\"An Emotional Attachment\"", "An Emotional Attachment"},
        {"Auto Theft", "Auto Theft"},
        {"Smuggling", "Smuggling"},
        {"Kill Frank Pagani: Setup", "Kill Frank Pagani: Setup"},
        {"Kill Frank Pagani: Takedown", "Kill Frank Pagani: Takedown"},
        {"\"Compromised Corruption\"", "Compromised Corruption"},
        {"\"The Dead Stay Gone\"", "The Dead Stay Gone"},
        {"Guns", "Guns"},
        {"Garbage", "Garbage"},
        {"Get Enzo Conti", "Get Enzo Conti"},
        {"PCP", "PCP"},
        {"Southern Union", "Southern Union"},
        {"Construction", "Construction"},
        {"Blackmail", "Blackmail"},
        {"Kill Tony Derazio", "Kill Tony Derazio"},
        {"Kill Remy Duvall", "Kill Remy Duvall"},
        {"Kill Olivia Marcano", "Kill Olivia Marcano"},
        {"Black Market", "Black Market"},
        {"Gambling", "Gambling"},
        {"Drugs", "Drugs"},
        {"Sex", "Sex"},
        {"Kill The Judge", "Kill the Judge"},
        {"Kill 'Uncle' Lou Marcano", "Kill 'Uncle' Lou Marcano"},
        {"Rescue Alvarez", "Rescue Alvarez"},
        {"\"My Name's Lincoln Clay...\"", "My Name's Lincoln Clay..."},
        {"Kill Tommy Marcano", "Kill Tommy Marcano"},
        {"Kill Sal Marcano", "Kill Sal Marcano"},
        {"\"Before They Bury You\"", "Before They Bury You"},
        {"Endings", "Endings"}
    };
    foreach (var Tag in vars.Chapters)
		{
			settings.Add(Tag.Key, true, Tag.Value, "MafiaIII");
    	};


		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Mafia III",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}



update
{ 
    // print(current.loading.ToString());
    // print(current.mission.ToString());
}

isLoading
{
	return current.loading == 1 || current.loading == 2 || current.smallLoads == 1;
}

start
{
    return old.mission != "\"Why Take The Chance?\"" && current.mission == "\"Why Take The Chance?\"";
}

onStart
{
    // This is part of a "cycle fix", makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
    vars.doneMissions.Add(current.mission);
}

split
{
    if (settings[current.mission] && (!vars.doneMissions.Contains(current.mission)))
    {
        vars.doneMissions.Add(current.mission);
        return true;
    }
}

onReset
{
    vars.doneMissions.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
