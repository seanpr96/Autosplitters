state("Iconoclasts")
{
    double xPos:        "Iconoclasts.exe", 0x9AD75C, 0x2C, 0x1C, 0x28, 0x648;
    double yPos:        "Iconoclasts.exe", 0x9AD75C, 0x2C, 0x1C, 0x28, 0x650;
    double selectedGun: "Iconoclasts.exe", 0x9ADBFC, 0x2C, 0x1C, 0x28, 0x640;
    double gotWrench:   "Iconoclasts.exe", 0x9ADBFC, 0x2C, 0x1C, 0x28, 0x650;
    double soldiers:    "Iconoclasts.exe", 0x9aE0CC, 0x34, 0x74, 0x42C, 0, 0x28;
    double bossHP:      "Iconoclasts.exe", 0x9AE0E8, 0xE0, 0x2C, 0x1C, 0x28, 0x650;
    double roomID:      "Iconoclasts.exe", 0x9AE1BC, 0x2C, 0x1C, 0x28, 0x610;
    double dodger:      "Iconoclasts.exe", 0x9AE22C, 0x60, 0xEA8;
    double bossHPAlt:   "Iconoclasts.exe", 0x9AE418, 0x100, 0x34, 0x34, 0x28, 0x650;
    
    // Boss rush timer
    double minutes:     "Iconoclasts.exe", 0x9AD558, 0x18, 0x34, 0x38, 0x28, 0x600;
    double seconds:     "Iconoclasts.exe", 0x9AD55C, 0x108, 0x38, 0x34, 0x28, 0x600;
    double centiseconds:"Iconoclasts.exe", 0x9AD55C, 0x34, 0x38, 0x28, 0x600;
}

startup
{
    settings.Add("Boss Rush Mode", false);
    settings.Add("Controller");
    settings.Add("Wrench");
    settings.Add("Settlement 17");
    settings.Add("Kerthunk");
    settings.Add("Bombs");
    settings.Add("Kibuka");
    settings.Add("Helicopter");
    settings.Add("Dad Cutscene");
    settings.Add("Dodger Schematic");
    settings.Add("Inti");
    settings.Add("White");
    settings.Add("Wrench 2");
    settings.Add("Carver");
    settings.Add("Reclaimed Wrench");
    settings.Add("Wrench 3");
    settings.Add("Watchman 2");
    settings.Add("Tower End");
    settings.Add("Possessed Thunk");
    settings.Add("Omega Controller");
    settings.Add("Ash");
    settings.Add("Usurper");
    settings.Add("Blocker");
    settings.Add("Black 1");
    settings.Add("Mother");
    settings.Add("City Escape");
    settings.Add("Mendeleev");
    settings.Add("Nobel");
    settings.Add("Lawrence");
    settings.Add("Black 2");
    settings.Add("Impact");
    settings.Add("Nightmares");
    settings.Add("Starworm");
}

update
{
    if (old.roomID != current.roomID)
    {
        vars.roomChangeTime = timer.CurrentTime.RealTime.Value.TotalMilliseconds;
    }
}

start
{
    vars.roomChangeTime = 0;
    
    vars.controllerStarted = false;
    vars.controllerSplit = !settings["Controller"];
    
    vars.wrenchSplit = !settings["Wrench"];
    vars.settlementSplit = !settings["Settlement 17"];
    vars.kerthunkSplit = !settings["Kerthunk"];
    vars.bombSplit = !settings["Bombs"];
    
    vars.kibukaStarted = false;
    vars.kibukaSplit = !settings["Kibuka"];
    
    vars.helicopterStarted = false;
    vars.helicopterSplit = !settings["Helicopter"];
    
    vars.dadSplit = !settings["Dad Cutscene"];
    vars.dodgerSplit = !settings["Dodger Schematic"];
    
    vars.intiStarted = false;
    vars.intiSplit = !settings["Inti"];
    
    vars.whiteState = 0;
    vars.whiteSplit = !settings["White"];
    
    vars.wrench2Started = false;
    vars.wrench2Split = !settings["Wrench 2"];
    
    vars.carverSplit = !settings["Carver"];
    vars.reclaimedWrenchSplit = !settings["Reclaimed Wrench"];
    vars.wrench3Split = !settings["Wrench 3"];
    
    vars.watchman2Started = false;
    vars.watchman2Split = !settings["Watchman 2"];
    
    vars.towerSplit = !settings["Tower End"];
    
    vars.possessedThunkStarted = false;
    vars.possessedThunkSplit = !settings["Possessed Thunk"];
    
    vars.omegaControllerStarted = false;
    vars.omegaControllerSplit = !settings["Omega Controller"];
    
    vars.ashStarted = false;
    vars.ashSplit = !settings["Ash"];
    
    vars.usurperSplit = !settings["Usurper"];
    
    vars.blockerStarted = false;
    vars.blockerSplit = !settings["Blocker"];
    
    vars.black1Started = false;
    vars.black1Split = !settings["Black 1"];
    
    vars.motherSplit = !settings["Mother"];
    vars.cityEscapeSplit = !settings["City Escape"];
    
    vars.mendeleevStarted = false;
    vars.mendeleevSplit = !settings["Mendeleev"];
    
    vars.nobelSplit = !settings["Nobel"];
    
    vars.lawrenceStarted = false;
    vars.lawrenceSplit = !settings["Lawrence"];
    
    vars.black2State = 0;
    vars.black2Split = !settings["Black 2"];
    
    vars.impactSplit = !settings["Impact"];
    vars.nightmaresSplit = !settings["Nightmares"];
    
    vars.starwormStarted = false;
    vars.starwormSplit = !settings["Starworm"];
    
    vars.birdState = 0;
    vars.birdTimer = 0;
    
    vars.bossRushTime = TimeSpan.FromSeconds(0);
    
    return current.roomID == 253 || (settings["Boss Rush Mode"] && current.roomID != 0 && old.roomID == 0);
}

gameTime
{
    if (settings["Boss Rush Mode"])
    {
        if (current.roomID == 0 || current.roomID == 24)
        {
            return vars.bossRushTime;
        }
        
        vars.bossRushTime = TimeSpan.FromMilliseconds(current.minutes * 60 * 1000 + current.seconds * 1000 + current.centiseconds * 10);
        
        return vars.bossRushTime;
    }
    
    return timer.CurrentTime.RealTime.Value;
}

reset
{
    if (settings["Boss Rush Mode"])
    {
        return current.roomID == 0;
    }
    
    return false;
}

split
{
    if (settings["Boss Rush Mode"])
    {
        return current.roomID != old.roomID && old.roomID != 24;
    }
    
    if (current.roomID == 271 && current.bossHP == 700)
    {
        vars.controllerStarted = true;
    }
    else if (current.roomID != 271)
    {
        vars.controllerStarted = false;
    }
    
    if (!vars.controllerSplit && vars.controllerStarted && current.bossHP <= 0)
    {
        vars.controllerSplit = true;
        return true;
    }
    
    if (!vars.wrenchSplit && current.roomID == 311 && current.gotWrench == 1 && old.gotWrench == 0)
    {
        vars.wrenchSplit = true;
        return true;
    }
    
    if (!vars.settlementSplit && current.roomID == 1314 && old.roomID != 1314)
    {
        vars.settlementSplit = true;
        return true;
    }
    
    if (!vars.kerthunkSplit && current.roomID == 496 && current.xPos >= 1705)
    {
        if (timer.CurrentTime.RealTime.Value.TotalMilliseconds - vars.roomChangeTime <= 250)
        {
            return false;
        }
        
        vars.kerthunkSplit = true;
        return true;
    }
    
    if (!vars.bombSplit && current.roomID == 420 && current.selectedGun == 2)
    {
        vars.bombSplit = true;
        return true;
    }
    
    if (current.roomID == 324 && current.bossHPAlt == 1180)
    {
        vars.kibukaStarted = true;
    }
    else if (current.roomID != 324)
    {
        vars.kibukaStarted = false;
    }
    
    if (!vars.kibukaSplit && vars.kibukaStarted && current.bossHPAlt <= 0)
    {
        vars.kibukaSplit = true;
        return true;
    }
    
    if (current.roomID == 394 && current.bossHP == 140000)
    {
        vars.helicopterStarted = true;
    }
    else if (current.roomID != 394)
    {
        vars.helicopterStarted = false;
    }
    
    if (!vars.helicopterSplit && vars.helicopterStarted && current.bossHP <= 0)
    {
        vars.helicopterSplit = true;
        return true;
    }
    
    if (!vars.dadSplit && current.roomID == 397 && old.roomID != 397)
    {
        vars.dadSplit = true;
        return true;
    }
    
    if (!vars.dodgerSplit && current.roomID == 388 && current.dodger == 1)
    {
        vars.dodgerSplit = true;
        return true;
    }
    
    if (current.roomID == 774 && current.bossHP == 1500)
    {
        vars.intiStarted = true;
    }
    else if (current.roomID != 774)
    {
        vars.intiStarted = false;
    }
    
    if (!vars.intiSplit && vars.intiStarted && current.bossHP <= 0)
    {
        vars.intiSplit = true;
        return true;
    }
    
    if (!vars.whiteSplit)
    {
        switch ((int)vars.whiteState)
        {
            case 0:
                if (current.roomID == 774 && current.bossHP == 500)
                {
                    vars.whiteState = 1;
                }
                
                break;
            case 1:
                if (current.roomID == 1625)
                {
                    vars.whiteState = 2;
                }
                
                break;
            case 2:
                if (current.roomID == 774)
                {
                    vars.whiteSplit = true;
                    return true;
                }
                
                break;
        }
    }
    
    if (current.roomID == 1079 && current.soldiers == 13)
    {
        vars.wrench2Started = true;
    }
    else if (current.roomID != 1079 && current.roomID != 543 && current.roomID != 915 && current.roomID != 357)
    {
        vars.wrench2Started = false;
    }
    
    if (!vars.wrench2Split && vars.wrench2Started && current.soldiers == 0 && current.roomID == 543)
    {
        vars.wrench2Split = true;
        return true;
    }
    
    if (!vars.carverSplit && current.roomID == 1844 && old.roomID == 1853)
    {
        vars.carverSplit = true;
        return true;
    }
    
    if (!vars.reclaimedWrenchSplit && current.roomID == 408 && old.gotWrench == 0 && current.gotWrench == 1)
    {
        vars.reclaimedWrenchSplit = true;
        return true;
    }
    
    if (!vars.wrench3Split && current.roomID == 481 && current.xPos >= 1880 && current.yPos == 512)
    {
        vars.wrench3Split = true;
        return true;
    }
    
    if (current.roomID == 676 && current.bossHP == 5)
    {
        vars.watchman2Started = true;
    }
    else if (current.roomID != 676)
    {
        vars.watchman2Started = false;
    }
    
    if (!vars.watchman2Split && vars.watchman2Started && current.bossHP <= 0)
    {
        vars.watchman2Split = true;
        return true;
    }
    
    if (!vars.towerSplit && current.roomID == 671 && old.roomID == 1652)
    {
        vars.towerSplit = true;
        return true;
    }
    
    if (current.roomID == 432 && current.bossHP == 880)
    {
        vars.possessedThunkStarted = true;
    }
    else if (current.roomID != 432)
    {
        vars.possessedThunkStarted = false;
    }
    
    if (!vars.possessedThunkSplit && vars.possessedThunkStarted && current.bossHP <= 0)
    {
        vars.possessedThunkSplit = true;
        return true;
    }
    
    if (current.roomID == 969 && current.bossHP == 700)
    {
        vars.omegaControllerStarted = true;
    }
    else if (current.roomID != 969)
    {
        vars.omegaControllerStarted = false;
    }
    
    if (!vars.omegaControllerSplit && vars.omegaControllerStarted && current.bossHP <= 0)
    {
        vars.omegaControllerSplit = true;
        return true;
    }
    
    if (current.roomID == 1243 && current.bossHP == 330)
    {
        vars.ashStarted = true;
    }
    else if (current.roomID != 1243)
    {
        vars.ashStarted = false;
    }
    
    if (!vars.ashSplit && vars.ashStarted && current.bossHP <= 0)
    {
        vars.ashSplit = true;
        return true;
    }
    
    if (!vars.usurperSplit && current.roomID == 773 && current.selectedGun == 3)
    {
        vars.usurperSplit = true;
        return true;
    }
    
    if (current.roomID == 360 && current.bossHP == 550)
    {
        vars.blockerStarted = true;
    }
    else if (current.roomID != 360)
    {
        vars.blockerStarted = false;
    }
    
    if (!vars.blockerSplit && vars.blockerStarted && current.bossHP <= 0)
    {
        vars.blockerSplit = true;
        return true;
    }
    
    if (current.roomID == 248 && current.bossHP == 1500)
    {
        vars.black1Started = true;
    }
    else if (current.roomID != 248)
    {
        vars.black1Started = false;
    }
    
    if (!vars.black1Split && vars.black1Started && current.bossHP <= 0)
    {
        vars.black1Split = true;
        return true;
    }
    
    if (!vars.motherSplit && current.roomID == 72 && old.roomID != 72)
    {
        vars.motherSplit = true;
        return true;
    }
    
    if (!vars.cityEscapeSplit && current.roomID == 105 && old.roomID == 151)
    {
        vars.cityEscapeSplit = true;
        return true;
    }
    
    if (current.roomID == 376 && current.bossHP == 4000)
    {
        vars.mendeleevStarted = true;
    }
    else if (current.roomID != 376)
    {
        vars.mendeleevStarted = false;
    }
    
    if (!vars.mendeleevSplit && vars.mendeleevStarted && current.bossHP <= 0)
    {
        vars.mendeleevSplit = true;
        return true;
    }
    
    if (!vars.nobelSplit && current.roomID == 279 && old.roomID == 464)
    {
        vars.nobelSplit = true;
        return true;
    }
    
    if (current.roomID == 299 && current.bossHP == 800)
    {
        vars.lawrenceStarted = true;
    }
    else if (current.roomID != 299)
    {
        vars.lawrenceStarted = false;
    }
    
    if (!vars.lawrenceSplit && vars.lawrenceStarted && current.bossHP <= 0)
    {
        vars.lawrenceSplit = true;
        return true;
    }
    
    if (!vars.black2Split)
    {
        if (current.roomID != 562)
        {
            vars.black2State = 0;
        }
        else
        {
            switch ((int)vars.black2State)
            {
                case 0:
                    if (current.bossHP == 1350)
                    {
                        vars.black2State = 1;
                    }
                    
                    break;
                case 1:
                    if (current.bossHP <= 0)
                    {
                        vars.black2State = 2;
                    }
                    
                    break;
                case 2:
                    if (current.bossHP == 800)
                    {
                        vars.black2State = 3;
                    }
                    
                    break;
                case 3:
                    if (current.bossHP <= 0)
                    {
                        vars.black2Split = true;
                        return true;
                    }
                    
                    break;
            }
        }
    }
    
    if (!vars.impactSplit && current.roomID == 159 && old.roomID != 159)
    {
        vars.impactSplit = true;
        return true;
    }
    
    if (!vars.nightmaresSplit && current.roomID == 217 && old.roomID == 159)
    {
        vars.nightmaresSplit = true;
        return true;
    }
    
    if (current.roomID == 217 && current.bossHP == 2400)
    {
        vars.starwormStarted = true;
    }
    else if (current.roomID != 217)
    {
        vars.starwormStarted = false;
    }
    
    if (!vars.starwormSplit && vars.starwormStarted && current.bossHP <= 0)
    {
        vars.starwormSplit = true;
        return true;
    }
    
    if (current.roomID != 217)
    {
        vars.birdState = 0;
    }
    else
    {
        switch ((int)vars.birdState)
        {
            case 0:
                if (current.bossHP == 2650)
                {
                    vars.birdState = 1;
                }
                
                break;
            case 1:
                if (current.bossHP <= 0)
                {
                    vars.birdState = 2;
                }
                
                break;
            case 2:
                if (current.xPos == 1600)
                {
                    vars.birdState = 3;
                }
                
                break;
            case 3:
                if (current.xPos == 1400)
                {
                    vars.birdState = 4;
                    vars.birdTimer = timer.CurrentTime.RealTime.Value.TotalMilliseconds;
                }
                
                break;
            case 4:
                if (timer.CurrentTime.RealTime.Value.TotalMilliseconds - vars.birdTimer >= 5000)
                {
                    vars.birdState = 0;
                    return true;
                }
                
                break;
        }
    }
    
    return false;
}
