/*

Commands:

+clocks - list all clocks on all players in your local area
+clock <clock> - see details about a clock
+clock <player>/<clock> - see details about a clock

+clock <clock>=<number of ticks> - start a new clock
+clock/create <clock>=<ticks> - same

+clock/destroy <clock> - get rid of a clock
+clocks/destroy all - get rid of all your clocks
+clocks/destroy complete - get rid of your completed clocks
+clock/delete - alias for destroy
+clock/nuke - same
+clock/clear <clock> - same
+clock/wipe <clock> - same
+clocks/clear - same
+clocks/wipe - same

Clocks are auto-destroyed about one day after they are completed.

+clock/tick <clock> - tick a clock once
+clock/tick <clock>=<#> - tick a clock # times

+clock/untick <clock> - untick a clock once
+clock/untick <clock>=<#> - untick a clock # times

+clock/set <clock>=<#> - set a clock to a specific number of ticks

+clock/reset <clock> - reset a clock
 
+clock/show <clock> - show the room a clock
+clock/show <clock>=<player> - show a player a clock

*/

@create Clocks=10
@set Clocks=SAFE INHERIT
@force me=@parent Clocks=[v(d.bf)]

@force me=&d.clocks me=[search(ETHING=t(member(name(##), Clocks, |)))]

@tel [v(d.clocks)]=[config(master_room)]

@@ =============================================================================
@@ Infrastructure
@@ =============================================================================

@@ Required to enable @daily.
@startup [v(d.clocks)]=@enable eventchecking;

@@ Auto-destroy clocks roughly one day after they are completed.
@@ My daily fires at 07:10:43 AM. No guarantee when yours will fire.
@daily [v(d.clocks)]=@dolist search(EPLAYER=t(ulocal(f.get-player-clocks, ##)))={ @eval iter(ulocal(f.get-player-clocks, setr(P, ##)), trigger(me/tr.destroy_clock, %qP, itext(0))); };

@@ =============================================================================
@@ Settings
@@ =============================================================================

@@ This may vary based on how big a game is. The more players in a scene, the more ticks a clock must have, or they'll all overwhelm it easily. 100 should cover most needs but I made it dynamic just in case.

&d.max_ticks [v(d.clocks)]=100

@@ %0 - ticks
@@ %1 - max
&d.ticked-clock-visual [v(d.clocks)]=ansi(ulocal(f.get-tick-color, %0, %1), #)

&d.unticked-clock-visual [v(d.clocks)]=:

&d.times-up-indicator [v(d.clocks)]=strcat(%[, ansi(rh, TIME'S UP!), %])

@@ =============================================================================
@@ Functions
@@ =============================================================================

@@ %0 - ticks
@@ %1 - max
&f.get-tick-color [v(d.clocks)]=case(1, gte(%0, ceil(mul(%1, .75))), r, gte(%0, ceil(mul(%1, .5))), y, g)

@@ %0 - player
&f.get-clocks [v(d.clocks)]=squish(trim(iter(lcon(loc(%0), CONNECT), if(t(ulocal(f.get-player-clocks, itext(0))), itext(0)))))

@@ %0 - player
&f.get-player-clocks [v(d.clocks)]=lattr(%0/_clock.*)

@@ %0 - player
@@ %1 - clock attribute
&f.get-time [v(d.clocks)]=first(xget(%0, %1), |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-ticks [v(d.clocks)]=extract(xget(%0, %1), 3, 1, |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-last-ticked [v(d.clocks)]=extract(xget(%0, %1), 2, 1, |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-max [v(d.clocks)]=extract(xget(%0, %1), 4, 1, |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-title [v(d.clocks)]=extract(xget(%0, %1), 5, 9999, |)

@@ %0 - player
@@ %1 - clock title
&f.find-clock-by-title [v(d.clocks)]=strcat(setq(T, iter(setr(A, ulocal(f.get-player-clocks, %0)), ulocal(f.get-title, %0, itext(0)),, |)), first(iter(%qT, if(t(strmatch(itext(0), %1*)), extract(%qA, inum(0), 1)), |)))

@@ %0 - player
@@ %1 - clock title
&f.find-any-clock-by-title [v(d.clocks)]=switch(%1, */*, if(t(setr(P, ulocal(f.find-player, first(%1, /)))), first(iter(ulocal(f.find-clock-by-title, %qP, rest(%1, /)), %qP/[itext(0)]))), first(iter(ulocal(f.get-clocks, %0), iter(ulocal(f.find-clock-by-title, itext(0), %1), itext(1)/[itext(0)]))))

@@ =============================================================================
@@ Layouts
@@ =============================================================================

@@ %0 - player
@@ %1 - clock title
@@ %2 - destination
&layout.share [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), shares the, %ch%1%cn, clock, if(strmatch(%2, loc(%0)), with the room, cat(with, itemize(iter(%2, ulocal(f.get-name, itext(0)),, |), |))):)

@@ %0 - player
@@ %1 - clock title
@@ %2 - amount to tick
@@ %3 - new ticks value
@@ %4 - max
&layout.tick [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), ticks, the, %ch%1%cn, clock by, ansi(case(1, lt(%2, 0), g, cor(gte(%2, ceil(mul(%4, .33))), gte(%3, round(mul(%4, .75), 0))), hr, n), %2).)

@@ %0 - player
@@ %1 - clock title
@@ %2 - new ticks value
@@ %3 - max
&layout.set [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), sets the, %ch%1%cn, clock to, ansi(case(1, eq(%2, 0), g, gte(%2, round(mul(%3, .75), 0)), hr, n), %2).)

@@ %0 - player
@@ %1 - clock title
@@ %2 - max
&layout.creation [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), created, the, %ch%1%cn, clock.)

@@ %0 - ticks
@@ %1 - max
&layout.clock-visual [v(d.clocks)]=strcat(setq(L, min(%0, %1)), setq(U, ulocal(d.unticked-clock-visual)), setq(R, udefault(d.tick-indicator-visual, %qX)), ulocal(d.start-clock-visual), iter(lnum(%qL), ulocal(d.ticked-clock-visual, inum(0), %1),, @@), repeat(%qU, sub(%1, %qL)), if(gte(%qL, %1), cat(,ulocal(d.times-up-indicator))))

@@ %0 - clock title
@@ %1 - ticks
@@ %2 - max
&layout.clock [v(d.clocks)]=strcat(alert(%0), center(strcat(%b%[, ansi(case(1, lte(%1, 0), g, gte(%1, round(mul(%2, .75), 0)), hr, n), %1), /, %2%]), 10), %b, ulocal(layout.clock-visual, %1, %2))

@@ %0 - viewing player
@@ %1 - player
@@ %2 - clock attribute
&layout.clock-details [v(d.clocks)]=strcat(header(ulocal(f.get-title, %1, %2), %0), strcat(setq(S, ulocal(f.get-time, %1, %2)), setq(O, ulocal(f.get-last-ticked, %1, %2)), %r, multicol(strcat(Clock|Ticks|Visual|, ulocal(f.get-title, %1, %2), |, setr(T, ulocal(f.get-ticks, %1, %2)), /, setr(M, ulocal(f.get-max, %1, %2)), |, ulocal(layout.clock-visual, %qT, %qM)), * 7 *, 1, |, %0), %r, formattext(strcat(%r, Created, %b, interval(%qS), %b, ago at, %b, prettytime(%qS), %b, by, %b, ulocal(f.get-name, %1, %0)., if(neq(%qS, %qO), cat(, Last ticked, interval(%qO), ago.))),, %0), %r, footer(, %0)))

@@ %0 - player viewing
@@ %1 - list of players with clocks on them
&layout.clocks [v(d.clocks)]=if(t(%1), strcat(header(Active clocks, %0), %r, multicol(strcat(Player|Clock|Ticks|Visual|, iter(%1, iter(ulocal(f.get-player-clocks, itext(0)), strcat(ulocal(f.get-name, itext(1)), |, ulocal(f.get-title, itext(1), itext(0)), |, setr(T, ulocal(f.get-ticks, itext(1), itext(0))), /, setr(M, ulocal(f.get-max, itext(1), itext(0))), |, ulocal(layout.clock-visual, %qT, %qM)),, |),, |)), 15 * 7 *, 1, |, %0), %r, footer(+clock <clock> for more, %0)), cat(alert(Clocks), There are no currently active clocks in your area.))

@@ =============================================================================
@@ Triggers
@@ =============================================================================

@@ %0 - player
@@ %1 - clock attribute
@@ %2 - if true, skip the time check.
&tr.destroy_clock [v(d.clocks)]=@assert t(strlen(setr(V, ulocal(f.get-ticks, %0, %1)))); @assert t(setr(M, ulocal(f.get-max, %0, %1))); @assert gte(%qV, %qM); @assert t(setr(L, ulocal(f.get-last-ticked, %0, %1))); @assert cor(t(%2), gte(sub(secs(), %qL), 86400)); @wipe %0/%1; @wipe %0/_clock-destroy.[edit(%1, _CLOCK.,)];

@@ Override the default message so it says it's from the Clocks system.
&tr.message [v(d.clocks)]=@pemit %0=cat(alert(Clocks), %1);

th ulocal(v(d.clocks)/f.get-max, %#, %#)

@@ =============================================================================
@@ Commands
@@ =============================================================================

@@ Viewing =====================================================================

&c.+clocks [v(d.clocks)]=$+clocks: @pemit %#=ulocal(layout.clocks, %#, ulocal(f.get-clocks, %#));

&c.+clock [v(d.clocks)]=$+clock *:@break strmatch(%0, *=*)={ @force %#=+clock/create %0; }; @assert t(setr(C, ulocal(f.find-any-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock in your area that starts with '%0'.; }; @eval strcat(setq(P, first(%qC, /)), setq(C, rest(%qC, /))); @pemit %#=ulocal(layout.clock-details, %#, %qP, %qC);

@@ Creating and destroying ====================================================

&c.+clock/create [v(d.clocks)]=$+clock/create *=*:@assert t(setr(D, v(d.max_ticks)))={ @trigger me/tr.error=%#, Could not get the maximum clock size. Fix the setting!; }; @break t(ulocal(f.find-clock-by-title, %#, %0))={ @trigger me/tr.error=%#, There is already a clock with a name like '%0'. Pick something different.; }; @assert cand(isint(%1), gte(%1, 2), lte(%1, %qD))={ @trigger me/tr.error=%#, Your '%0' clock's ticks must be a number between 2 and %qD.; }; @eval strcat(setq(C, 0), iter(ulocal(f.get-player-clocks, %#), if(gt(setr(T, edit(itext(0), _CLOCK.,)), %qC), setq(C, %qT))), setq(C, strcat(_clock., inc(%qC)))); @assert t(%qC)={ @trigger me/tr.error=%#, Could not figure out how to save your clock attribute.; }; @set %#=%qC:[secs()]|[secs()]|0|%1|%0; @trigger me/tr.remit-or-pemit=%L, strcat(ulocal(layout.creation, %#, %0, %1), %r, ulocal(layout.clock, %0, 0, %1)), %#;

&c.+clock/destroy [v(d.clocks)]=$+clock/destroy *:@eval setq(G, first(%0, =)); @assert cor(t(setr(C, ulocal(f.find-clock-by-title, %#, %qG))), switch(%qG, all, 1, complete, 1, 0))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%qG'%, and you didn't specify 'all' or 'complete'.; }; @assert cor(switch(%qG, all, 1, complete, 1, 0), cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))), t(strlen(setr(V, ulocal(f.get-ticks, %#, %qC))))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; }; @break switch(%qG, all, 1, complete, 1, 0)={ @assert t(setr(C, ulocal(f.get-player-clocks, %#)))={ @trigger me/tr.error=%#, You don't have any clocks to destroy.; }; @dolist %qC={ @trigger me/tr.destroy_clock=%#, ##, 1; }; @break cand(strmatch(%qG, all), t(ulocal(f.get-player-clocks, %#)))={ @assert gettimer(%#, destroy-all-clocks, rest(%0, =))={ @trigger me/tr.message=%#, All your completed clocks have been destroyed%, but you still have clocks remaining. To really destroy all your clocks%, including those with ticks remaining%, type '+clock/destroy %qG=YES' within 10 minutes to confirm. It is now [prettytime()].; @eval settimer(%#, destroy-all-clocks, 600, YES); }; @dolist %qC={ @wipe %#/##; @wipe %#/_clock-destroy.[edit(##, _CLOCK.,)]; }; @trigger me/tr.success=%#, All of your clocks have been destroyed!; }; @trigger me/tr.success=%#, Your completed clocks have been destroyed!; }; @break cand(lt(%qV, %qM), not(gettimer(%#, destroy-ticking-clock, %qC)))={ @trigger me/tr.message=%#, The %qN clock is still ticking. Are you sure you want to destroy it? Type '+clock/destroy %qG=YES' within 10 minutes to confirm. It is now [prettytime()].; @eval settimer(%#, destroy-ticking-clock, 600, %qC); }; @wipe %#/%qC; @trigger me/tr.success=%#, You successfully destroyed the %qM-tick %qN clock.;

&c.+clock/delete [v(d.clocks)]=$+clock/delete *: @force %#=+clock/destroy %0;

&c.+clock/nuke [v(d.clocks)]=$+clock/nuke *: @force %#=+clock/destroy %0;

&c.+clocks/delete [v(d.clocks)]=$+clocks/delete: @force %#=+clock/destroy all;

&c.+clocks/nuke [v(d.clocks)]=$+clocks/nuke: @force %#=+clock/destroy all;

&c.+clocks/destroy [v(d.clocks)]=$+clocks/destroy: @force %#=+clock/destroy all;

&c.+clocks/delete_all [v(d.clocks)]=$+clocks/delete *: @force %#=+clock/destroy %0;

&c.+clocks/nuke_all [v(d.clocks)]=$+clocks/nuke *: @force %#=+clock/destroy %0;

&c.+clocks/destroy_all [v(d.clocks)]=$+clocks/destroy *: @force %#=+clock/destroy %0;

&c.+clocks/clear [v(d.clocks)]=$+clocks/clear: @force %#=+clock/destroy all;

&c.+clocks/wipe [v(d.clocks)]=$+clocks/wipe: @force %#=+clock/destroy all;

&c.+clock/clear [v(d.clocks)]=$+clock/clear *: @force %#=+clock/destroy %0;

&c.+clock/wipe [v(d.clocks)]=$+clock/wipe *: @force %#=+clock/destroy %0;

@@ Managing ===================================================================

&c.+clock/set [v(d.clocks)]=$+clock/set *=*:@assert t(setr(C, ulocal(f.find-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%0'.; }; @assert t(setr(D, v(d.max_ticks)))={ @trigger me/tr.error=%#, Could not get the maximum clock size. Fix the setting!; }; @assert cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; }; @assert cand(isint(%1), gte(%1, 0), lte(%1, %qD))={ @trigger me/tr.error=%#, You must set your '%qN' clock to a number between 0 and %qD.; }; @set %#=%qC:[replace(replace(xget(%#, %qC), 3, %1, |, |), 2, secs(), |, |)]; @trigger me/tr.remit-or-pemit=%L, strcat(ulocal(layout.set, %#, %qN, %1, %qM), %r, ulocal(layout.clock, %qN, %1, %qM)), %#;

&c.+clock/reset [v(d.clocks)]=$+clock/reset *: @force %#=+clock/set %0=0;

&c.+clock/tick_amount [v(d.clocks)]=$+clock/tick *=*: @assert t(setr(C, ulocal(f.find-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%0'.; }; @assert t(setr(D, v(d.max_ticks)))={ @trigger me/tr.error=%#, Could not get the maximum clock size. Fix the setting!; }; @assert cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))), t(strlen(setr(V, ulocal(f.get-ticks, %#, %qC)))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; }; @assert cand(t(strlen(setr(L, sub(0, %qV)))), isint(%1), gte(%1, %qL), lte(%1, %qD))={ @trigger me/tr.error=%#, You must tick your '%qN' clock a number of ticks between %qL and %qD.; }; @assert cor(lt(%qV, %qM), lt(%1, 0))={ @trigger me/tr.error=%#, There are no ticks left on this clock to tick!; }; @set %#=%qC:[replace(replace(xget(%#, %qC), 3, add(%qV, %1), |, |), 2, secs(), |, |)]; @trigger me/tr.remit-or-pemit=%L, strcat(ulocal(layout.tick, %#, %qN, %1, add(%qV, %1), %qM), %r, ulocal(layout.clock, %qN, add(%qV, %1), %qM)), %#;

&c.+clock/tick [v(d.clocks)]=$+clock/tick *:@break strmatch(%0, *=*); @assert t(setr(C, ulocal(f.find-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%0'.; }; @assert t(setr(D, v(d.max_ticks)))={ @trigger me/tr.error=%#, Could not get the maximum clock size. Fix the setting!; }; @assert cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))), t(strlen(setr(V, ulocal(f.get-ticks, %#, %qC)))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; }; @assert lt(%qV, %qM)={ @trigger me/tr.error=%#, There are no ticks left on this clock to tick!; }; @set %#=%qC:[replace(replace(xget(%#, %qC), 3, inc(%qV), |, |), 2, secs(), |, |)]; @trigger me/tr.remit-or-pemit=%L, strcat(ulocal(layout.tick, %#, %qN, 1, inc(%qV), %qM), %r, ulocal(layout.clock, %qN, inc(%qV), %qM)), %#;

&c.+clock/untick_amount [v(d.clocks)]=$+clock/untick *=*: @force %#=+clock/tick %0=[if(lt(%1, 0), %1, sub(0, %1))];

&c.+clock/untick [v(d.clocks)]=$+clock/untick *:@break strmatch(%0, *=*); @force %#=+clock/tick %0=-1;

@@ Sharing ====================================================================

&c.+clock/show [v(d.clocks)]=$+clock/show *: @break strmatch(%0, *=*); @assert t(setr(C, ulocal(f.find-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%0'.; }; @assert cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))), t(strlen(setr(V, ulocal(f.get-ticks, %#, %qC)))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; }; @trigger me/tr.remit-or-pemit=%l, strcat(ulocal(layout.share, %#, %qN, %l), %r, ulocal(layout.clock, %qN, %qV, %qM)), %#;

&c.+clock/show_target [v(d.clocks)]=$+clock/show *=*: @assert t(setr(C, ulocal(f.find-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%0'.; }; @eval strcat(setq(P, iter(%1, ulocal(f.find-player, itext(0), %#))), iter(%qP, if(not(t(itext(0))), setq(E, %qE Could not find player '[extract(%1, inum(0), 1)]'.)))); @break t(%qE)={ @trigger me/tr.error=%#, squish(trim(%qE)); }; @eval iter(%qP, if(not(t(ulocal(filter.is_connected_player, itext(0)))), setq(E, cat(%qE, ulocal(f.get-name, itext(0), %#) is not connected.)))); @break t(%qE)={ @trigger me/tr.error=%#, squish(trim(%qE)); }; @assert t(%qP)={ @trigger me/tr.error=%#, Could not find a player named '%1'.; }; @assert cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))), t(strlen(setr(V, ulocal(f.get-ticks, %#, %qC)))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; }; @trigger me/tr.pemit=%qP %#, strcat(ulocal(layout.share, %#, %qN, %qP), %r, ulocal(layout.clock, %qN, %qV, %qM)), %#;

