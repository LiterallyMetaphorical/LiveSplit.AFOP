// Created by Binslev, Credit to Meta, Diggity and Sarentig
// Game version 1.03 Ubisoft Connect (Untested on Epic Games)
// Last updated 26-03-2024 (DD-MM-YYYY) by Binslev

state("afop")
{
// Load remover pointers. Double pointers as a failsafe. Value is 0 while loading, 1056964608 otherwise.

    int loading1 : 0x8F7BC38;
    int loading2 : 0x8F7BC7C;

// Autosplitter pointers for main quests. Value starts at 1 during "Awakening", +1 when you complete a main quest. 
// Each game slot in the save file has a different pointer.
// The four addresses that are pointed to will always vary by a hex value of +588 from the last.

    int q1 : 0x0925F6A8, 0x80, 0xC0, 0x20, 0x330, 0x640; // save slot 1
    int q2 : 0x0925F6A8, 0x80, 0xC0, 0x20, 0x330, 0xBC8; // save slot 2
    int q3 : 0x0925F6A8, 0x80, 0xC0, 0x20, 0x330, 0x1150; // save slot 3
    int q4 : 0x0925F6A8, 0x80, 0xC0, 0x20, 0x330, 0x16D8; // save slot 4
}



startup
{
    {
    // Loads Settings.xml into Livesplit using "asl-help".

        Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
        vars.Helper.GameName = "Avatar: Frontiers Of Pandora";
        vars.Helper.Settings.CreateFromXml("Components/AvatarFrontiersOfPandora.Settings.xml");
    }

    {
    // Asks user to change to game time if LiveSplit is currently set to Real Time.

        vars.Helper.AlertLoadless();
    }
}



onStart
{
    // This makes sure the timer always starts at 0.00.

    timer.IsGameTimePaused = true;
}



split
{
// Split every time one of q1-q4 goes up by 1, if the setting for that specific split is checked in the settings.

if
  ((current.q1 == old.q1 + 1 && settings["Q" + old.q1]) || 
   (current.q2 == old.q2 + 1 && settings["Q" + old.q2]) || 
   (current.q3 == old.q3 + 1 && settings["Q" + old.q3]) ||
   (current.q4 == old.q4 + 1 && settings["Q" + old.q4]))  
    {
        return true;
    }
}



isLoading
{
// Pause the timer when loading1 and loading2 are both 0. Double pointers as a failsafe.

return current.loading1 == 0 && current.loading2 == 0;
}



exit
{
// Pause the timer if the game is closed.
	timer.IsGameTimePaused = true;
}
