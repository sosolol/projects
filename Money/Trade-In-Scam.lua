
nlprice = MISC.GET_HASH_KEY("MP0_PROP_NIGHTCLUB_VALUE")
nlprice2 = MISC.GET_HASH_KEY("MP1_PROP_NIGHTCLUB_VALUE")
leplayer = globals.get_int(1574918)

menu.show_message("Lua", "Mazebank Foreclosure -> Buy another nightclub -> value should be modded on trade in")


if (leplayer == 0) 
    then STATS.STAT_SET_INT(nlprice, ((1000000000*2) + 4500000), true);
    else STATS.STAT_SET_INT(nlprice2, ((1000000000*2) + 4500000), true);
end
