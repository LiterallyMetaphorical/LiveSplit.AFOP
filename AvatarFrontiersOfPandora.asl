// Created by Binslev & Meta
// Game version 1.02
// Created on 16-12-2023 (DD-MM-YYYY)

state("afop")
{   //0 while loading, 1056964608 otherwise.
    int loading1 : 0x97CA9A8;
    int loading2 : 0x97CAA30;
}

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Avatar: Frontiers of Pandora",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

isLoading
{
    return current.loading1 == 0 && current.loading2 == 0;
}

exit
{
	timer.IsGameTimePaused = true;
}

update
{
//DEBUG CODE 
//print(current.loading1.ToString()); 
//print(current.loading2.ToString()); 
//print(modules.First().ModuleMemorySize.ToString());
}