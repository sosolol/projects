P1 = MISC.GET_HASH_KEY("MP0_PROP_NIGHTCLUB_VALUE"); P2 = MISC.GET_HASH_KEY("MP1_PROP_NIGHTCLUB_VALUE"); LP = globals.get_int(1574918)
menu.show_message("Lua", "Mazebank Foreclosure -> Buy another nightclub -> value should be modded on trade in")

if (LP == 0) 
    then STATS.STAT_SET_INT(P1, ((1000000000*2) + 4500000), true);
    else STATS.STAT_SET_INT(P2, ((1000000000*2) + 4500000), true);
end