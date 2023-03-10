local nightclub = {
    safe = globals.get_int(262145 + 24045);
    income = globals.get_int(262145 + 24041)
}

globals.set_int((262145 + 24045), 300000)
globals.set_int((262145 + 24041), 300000)

STATS.STAT_SET_INT("CLUB_PAY_TIME_LEFT", 1, true)
STATS.STAT_SET_INT("CLUB_POPULARITY", 10000, true)
