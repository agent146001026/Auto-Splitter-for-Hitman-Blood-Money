state("HitmanBloodMoney", "Steam")
{
	byte Load : 0x005FC9C, 0x0;
	int Start : 0x042DF64, 0x20;
	short AllLevels : 0x005DB64, 0x0;
	int End : 0x01A1A74, 0x54;
	string30 scene : 0xFFD4D0CC; //0x0014D0cc;
	byte Cutscene3 : 0x00B7D80, 0x7EC;
}

state("HitmanBloodMoney", "Retail")
{
	byte Load : 0x005FDCC, 0x0;
	int Start : 0x042EF64, 0x20;
	short AllLevels : 0x005DD14, 0x0;
	int End : 0x01A22B4, 0x54;
}

startup
{

	settings.Add("option2", true, "120 Hz Refresh Rate");
	settings.SetToolTip("option2", "How many times per second the script checks the game memory values for changes. Default is 60 Hz. Higher Refresh Rate is more accurate and gives more accurate splits. IMPORTANT! Set also the Refresh Rate of the timer in Livesplit settings to the same value at least 60 Hz.");

    settings.Add("am", true, "All Levels");
    settings.SetToolTip("am", "Choose which levels to split after");
	
	settings.Add("level1", true, "A Vintage Year", "am");
	settings.Add("level2", true, "Curtains Down", "am");
	settings.Add("level3", true, "Flatline", "am");
	settings.Add("level4", true, "A New Life", "am");
	settings.Add("level5", true, "The Murder of Crows", "am");
	settings.Add("level6", true, "You Better Watch Out...", "am");
	settings.Add("level7", true, "Death on The Mississippi", "am");
	settings.Add("level8", true, "Till Death Do Us Part", "am");
	settings.Add("level9", true, "A House of Cards", "am");
	settings.Add("level10", true, "A Dance With The Devil", "am");
	settings.Add("level11", true, "Amendment XXV", "am");
	settings.Add("level12", true, "Requiem", "am");
	
	settings.Add("option1", true, "Game Time");
	settings.SetToolTip("option1", "Enables loadless time, to see it switch livesplit comparison to Game Time");
	
}

init
{
	if (modules.First().ModuleMemorySize == 0x05C8000)
	version = "Steam";
	if (modules.First().ModuleMemorySize == 0x05C0000)
	version = "Retail";
	
	vars.start = 0;
}

start
{

  refreshRate = 60;
  if (settings["option2"] == true){
	  refreshRate = 120;
	  }
	  
	 vars.refresh_rate = refreshRate;

	 if (!current.scene.Equals(old.scene) && current.scene.Equals("scenes/m01/m01_main.prp")) { //Improved Start Method in AVY.
	      vars.start = 1;
	      }
	           
	 if (current.Cutscene3 == 0 && vars.start == 1) {
	   vars.start = 0;
	    return true;
      }
}

split
{
	return(
	(settings["level1"] && current.AllLevels == 2040 && old.AllLevels != current.AllLevels)||
	(settings["level2"] && current.AllLevels == 4488 && old.AllLevels != current.AllLevels)||
	(settings["level3"] && current.AllLevels == 3737 && old.AllLevels != current.AllLevels)||
	(settings["level4"] && current.AllLevels == 4679 && old.AllLevels != current.AllLevels)||
	(settings["level5"] && current.AllLevels == 5685 && old.AllLevels != current.AllLevels)||
	(settings["level6"] && current.AllLevels == 3653 && old.AllLevels != current.AllLevels)||
	(settings["level7"] && current.AllLevels == 3428 && old.AllLevels != current.AllLevels)||
	(settings["level8"] && current.AllLevels == 1634 && old.AllLevels != current.AllLevels)||
	(settings["level9"] && current.AllLevels == 2703 && old.AllLevels != current.AllLevels)||
	(settings["level10"] && current.AllLevels == 3026 && old.AllLevels != current.AllLevels)||
	(settings["level11"] && current.AllLevels == 3121 && old.AllLevels != current.AllLevels)||
	(settings["level12"] && current.End == 825193317 && current.End != old.End && current.AllLevels == 4446)
	);
}

reset // Resets an already started run when A Vintage Year starts.
{

if(!current.scene.Equals(old.scene) && current.scene.Equals("scenes/m01/m01_main.prp")){
  return true;
  } else {
  return false;
  }
}

isLoading
{
	return settings["option1"] && current.Load == 0;
}

// originally made by Kennert 007
// updated by agent146001026 Feb, 2023 Ver. 1.0b (simple)