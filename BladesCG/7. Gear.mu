/*
+load <light|normal|heavy|encumbered> - set your load

+gear - list your gear
+load - same
+gear <player> - staff-only, list a player's gear

+gear/clear - clear all your gear for a new score
+gear/mark <gear> - mark a piece of gear present for this score
+gear/unmark <gear> - unmark a piece of gear for this score

+gear/prove <player> - show your gear to someone

+gear/give <player>=<gear> - staff-only, give a player a piece of Other gear
+gear/take <player>=<gear> - staff-only, take a player's Other gear

+armor/mark - mark your armor
+armor/mark <armor, heavy, or special> - mark your armor
+armor/clear - clear all marks
+armor/unmark all - clear all marks
+armor/unmark - unmark your armor
+armor/unmark <armor, heavy, or special> - unmark your armor
*/

&f.get-player-load-list [v(d.cgf)]=if(t(finditem(ulocal(f.get-player-stat, %0, abilities), Mule, |)), Light:|1-5|Normal:|6-7|Heavy:|8|Encumbered:|9, Light:|1-3|Normal:|4-5|Heavy:|6|Encumbered:|7-9)

&f.get-max-player-load [v(d.cgf)]=if(t(finditem(ulocal(f.get-player-stat, %0, abilities), Mule, |)), switch(%1, Normal, 7, Heavy, 8, Encumbered, 9, 5), switch(%1, Normal, 5, Heavy, 6, Encumbered, 9, 3))

@@ %0: List
@@ %1: Search term
@@ %2: 0 for unticked, 1 for ticked results, blank for all
&f.get-gear-list [v(d.cgf)]=extract(%0, ulocal(f.find-tickable, %0, %1, %2), 1, |, |)

@@ %0: A full boxed piece of gear
@@ %1: Are we marking or unmarking? 1 for mark, 0 for unmark
&f.get-gear-name [v(d.cgf)]=strcat(setq(0, edit(%0, %[ %], %[_%], %] %[, %]_%[)), trim(if(strmatch(%q0, *%[*%]*), case(%1, 0, before(last(rest(%q0), %[X%]), %[_%]), switch(first(%q0), *%[X%]*, last(%q0, %[_%]), *%[_%]*, before(rest(%q0), %[_%]))), %q0)))

@@ %0: a gear list
&f.get-gear-without-zero-load-items [v(d.cgf)]=squish(trim(iter(%0, switch(itext(0), *%(0L%)*,, itext(0)), |, |), b, |), |)

&f.get-player-load [v(d.cgf)]=add(ulocal(f.count-ticks, ulocal(f.get-gear-without-zero-load-items, ulocal(f.get-player-stat, %0, gear))), ulocal(f.count-ticks, ulocal(f.get-gear-without-zero-load-items, ulocal(f.get-player-stat, %0, standard gear))), ulocal(f.count-ticks, ulocal(f.get-gear-without-zero-load-items, ulocal(f.get-player-stat, %0, other gear))))

&c.+gear [v(d.cg)]=$+gear:@pemit %#=ulocal(layout.subsection, gear, %#, %#, 1);

&c.+gear_player [v(d.cg)]=$+gear *:@assert isstaff(%#)={ @trigger me/tr.error=%#, Only staff can check another player's gear.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.subsection, gear, %qP, %#, 1);

&c.+gear/prove [v(d.cg)]=$+gear/prove *:@assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @trigger me/tr.pemit=%qP, ulocal(layout.subsection, gear, %#, %qP, 1), %#; @trigger me/tr.success=%#, You show your gear to [ulocal(f.get-name, %qP, %#)].;

&c.+load_set [v(d.cg)]=$+load *:@force %#=+stat/set Load=%0;

&c.+load_set2 [v(d.cg)]=$+load/set *:@force %#=+stat/set Load=%0;

&c.+gear/load_set [v(d.cg)]=$+gear/load *:@force %#=+stat/set Load=%0;

&c.+gear/load [v(d.cg)]=$+gear/load:@force %#=+gear

&c.+load [v(d.cg)]=$+load:@force %#=+gear;

&c.+gear/clear [v(d.cg)]=$+gear/clear:@assert gettimer(%#, wipe-gear)={ @trigger me/tr.message=%#, You are about to clear your gear of all marks. Are you sure? If yes%, type %ch+gear/clear%cn again within the next 10 minutes. The time is now [prettytime()].; @eval settimer(%#, wipe-gear, 600); }; @set %#=[setr(X, ulocal(f.get-stat-location-on-player, gear))]:[edit(xget(%#, %qX), %[X%], %[ %])]; @set %#=[setr(X, ulocal(f.get-stat-location-on-player, standard gear))]:[edit(xget(%#, %qX), %[X%], %[ %])]; @set %#=[setr(X, ulocal(f.get-stat-location-on-player, other gear))]:[edit(xget(%#, %qX), %[X%], %[ %])]; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, clears [poss(%#)] gear list of marks.), %#;

&c.+gear/mark [v(d.cg)]=$+gear/mark *:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to mark yet.; }; @assert cand(t(setr(I, ulocal(f.get-player-stat, %#, load))), t(setr(M, ulocal(f.get-max-player-load, %#, %qI))))={ @trigger me/tr.error=%#, You should pick your loadout first. +load <Light%, Normal%, Heavy%, or Encumbered>.; }; @assert cor(t(setr(G, ulocal(f.get-gear-list, %qL, %0, 0, setr(S, gear)))), t(setr(G, ulocal(f.get-gear-list, setr(L, ulocal(f.get-player-stat, %#, setr(S, standard gear))), %0, 0))), t(setr(G, ulocal(f.get-gear-list, setr(L, ulocal(f.get-player-stat, %#, setr(S, other gear))), %0, 0))))={ @trigger me/tr.error=%#, Could not find an unmarked piece of gear on your +gear list starting with '%0'.; }; @assert t(strlen(setr(O, ulocal(f.get-new-tick-cost, %qG))))={ @trigger me/tr.error=%#, This gear is not properly set up and cannot be marked. Please req/bug <which gear>=<more info> to let staff know what's up.; }; @assert lte(add(%qO, ulocal(f.get-player-load, %#)), %qM)={ @trigger me/tr.error=%#, Marking this item would take you over your current Loadout of %ch%qI%cn.; }; @assert strmatch(%qG, *%[ %]*)={ @trigger me/tr.error=%#, There are no boxes left on this gear to mark.; }; @set %#=ulocal(f.get-stat-location-on-player, %qS):[replace(%qL, ulocal(f.find-tickable, %qL, %0, 0), ulocal(f.tick-tickable, %qG), |, |)]; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, marks [poss(%#)] %ch[ulocal(f.get-gear-name, %qG, 1)]%cn %qS as present for this score.);

&c.+gear/unmark [v(d.cg)]=$+gear/unmark *:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to unmark yet.; }; @assert cor(t(setr(G, ulocal(f.get-gear-list, %qL, %0, 1, setr(S, gear)))), t(setr(G, ulocal(f.get-gear-list, setr(L, ulocal(f.get-player-stat, %#, setr(S, standard gear))), %0, 1))), t(setr(G, ulocal(f.get-gear-list, setr(L, ulocal(f.get-player-stat, %#, setr(S, other gear))), %0, 1))))={ @trigger me/tr.error=%#, Could not find a marked piece of gear on your +gear list starting with '%0'.; }; @assert strmatch(%qG, *%[X%]*)={ @trigger me/tr.error=%#, This gear is not properly set up and cannot be unmarked. Please req/bug <which gear>=<more info> to let staff know what's up.; }; @assert strmatch(%qG, *%[X%]*)={ @trigger me/tr.error=%#, There are no boxes left on this gear to unmark.; }; @set %#=ulocal(f.get-stat-location-on-player, %qS):[replace(%qL, ulocal(f.find-tickable, %qL, %0, 1), ulocal(f.untick-tickable, %qG), |, |)]; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, unmarks [poss(%#)] %ch[ulocal(f.get-gear-name, %qG, 0)]%cn %qS - it is no longer present for this score.);

&c.+gear/give [v(d.cg)]=$+gear/give *=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, Only staff can give gear out. Open a job to request gear.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert strmatch(%1, %[ %]*)={ @trigger me/tr.error=%#, Please use the format '%[ %] <name>' - for example '%[ %] %[ %] Example Gear' for a piece of gear that has a 2 load. If you want the gear to be 0 Load%, make sure to label it as %[ %] (0L) <gear name>.; }; @set %qP=[setr(X, ulocal(f.get-stat-location-on-player, other gear))]:[unionset(xget(%qP, %qX), %1, |, |)]; @trigger me/tr.success=%#, You grant [ulocal(f.get-name, %qP, %#)] [art(setr(G, ulocal(f.get-gear-name, %1)))] %qG.; @trigger me/tr.message=%qP, ulocal(f.get-name, %#, %qP) gives you a piece of gear: %qG.;

@set [v(d.cg)]/c.+gear/give=no_parse

&c.+gear/take [v(d.cg)]=$+gear/take *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, Only staff can give gear out. Open a job to request gear.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(L, ulocal(f.get-player-stat, %qP, other gear)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) doesn't have any gear to take yet.; }; @assert t(setr(G, ulocal(f.get-gear-list, %qL,, setq(S, other gear))))={ @trigger me/tr.error=%#, Could not find a piece of other gear on [ulocal(f.get-name, %qP, %#)]'s +gear list starting with '%1'. Other gear is the only kind of gear you can take from a player - anything else%, they're able to get back (or get another of) after the score is over.; }; @set %qP=ulocal(f.get-stat-location-on-player, other gear):[diffset(%qL, %qG, |, |)]; @pemit #12=%qL >> %qG >> [diffset(%qL, %qG, |, |)]; @trigger me/tr.success=%#, You take away [ulocal(f.get-name, %qP, %#)]'s [ulocal(f.get-gear-name, %qG)] gear.; @trigger me/tr.message=%qP, ulocal(f.get-name, %#, %qP) takes away your [ulocal(f.get-gear-name, %qG)] other gear.;

&c.+armor [v(d.cg)]=$+armor:@force %#=+health

&c.+armor/clear [v(d.cg)]=$+armor/clear:@set %#=[setr(X, ulocal(f.get-stat-location-on-player, armor))]:[setq(A, xget(%#, %qX))]0; @set %#=[setr(X, ulocal(f.get-stat-location-on-player, heavy armor))]:[setq(H, xget(%#, %qX))]0; @set %#=[setr(X, ulocal(f.get-stat-location-on-player, special armor))]:[setq(S, xget(%#, %qX))]0; @assert cor(t(%qA), t(%qH), t(%qS))={ @trigger me/tr.message=%#, Your armor is already clear of marks.; }; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, cat(clears, poss(%#), plural(add(t(%qA), t(%qH), t(%qS)), mark, marks), on, ulocal(layout.list, strcat(if(t(%qA), %chArmor%cn|), if(t(%qH), %chHeavy Armor%cn|), if(t(%qS), %chSpecial Armor%cn))) -, plural(add(t(%qA), t(%qH), t(%qS)), it is, they are), no longer marked used for this score.)), %#;

&c.+armor/mark [v(d.cg)]=$+armor/mark*:@assert t(setr(S, finditem(Armor|Heavy Armor|Special Armor, setr(T, switch(%0, %b*, trim(%0), * *, rest(%0), Armor)), |)))={ @trigger me/tr.error=%#, Could not find an armor type named '%qT'. Valid types are Armor%, Heavy Armor%, and Special Armor.; }; @break t(ulocal(f.get-player-stat, %#, %qS))={ @trigger me/tr.error=%#, Your %qS is already marked and cannot be marked again.; }; @set %#=ulocal(f.get-stat-location-on-player, %qS):1; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, marks [poss(%#)] %ch%qS%cn as used on this score.);

&c.+armor/unmark [v(d.cg)]=$+armor/unmark*:@assert t(setr(S, finditem(Armor|Heavy Armor|Special Armor|all, setr(T, switch(%0, %b*, trim(%0), * *, rest(%0), Armor)), |)))={ @trigger me/tr.error=%#, Could not find an armor type named '%qT'. Valid types are Armor%, Heavy Armor%, and Special Armor.; }; @break strmatch(%qT, all)={ @force %#=+armor/clear; }; @assert t(ulocal(f.get-player-stat, %#, %qS))={ @trigger me/tr.error=%#, Your %qS is not marked and cannot be unmarked.; }; @set %#=ulocal(f.get-stat-location-on-player, %qS):0; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, clears [poss(%#)] mark on %ch%qS%cn - it is no longer marked used for this score.);

