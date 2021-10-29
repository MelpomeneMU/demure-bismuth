/*

Commands:

+clocks - list all clocks on all players in your local area
+clock <clock> - see details about a clock

+clock <clock>=<number of ticks> - start a new clock
+clock/create <clock>=<ticks> - same

+clock/destroy <clock> - get rid of a clock
+clocks/destroy all - get rid of all your clocks
+clocks/destroy complete - get rid of your completed clocks

+clock/tick <clock> - tick a clock once
+clock/tick <clock>=<#> - tick a clock # times

+clock/untick <clock> - untick a clock once
+clock/untick <clock>=<#> - untick a clock # times

+clock/set <clock>=<#> - set a clock to a number between 0 and its max

+clock/clear <clock> - reset a clock
+clock/reset <clock> - same
+clock/wipe <clock> - same

+clock/show <clock> - show the room a clock
+clock/show <clock>=<player> - show a player a clock



th ulocal(v(d.clocks)/layout.creation, %#, Bluecoats arrive!, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 0, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 1, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 1, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 2, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 2, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 3, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 3, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 4, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 4, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 5, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 5, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 6, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 6, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 7, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 7, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 8, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 8, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 9, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 9, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 10, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 10, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 11, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 11, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 12, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 12, 12)

th ulocal(v(d.clocks)/layout.creation, %#, Pot boils over, 4)
th ulocal(v(d.clocks)/layout.clock, Pot boils over, 0, 4)
th ulocal(v(d.clocks)/layout.tick, %#, Pot boils over, 2, 2, 4)
th ulocal(v(d.clocks)/layout.clock, Pot boils over, 2, 4)
th ulocal(v(d.clocks)/layout.tick, %#, Pot boils over, -1, 1, 4)
th ulocal(v(d.clocks)/layout.clock, Pot boils over, 1, 4)
th ulocal(v(d.clocks)/layout.tick, %#, Pot boils over, 1, 2, 4)
th ulocal(v(d.clocks)/layout.clock, Pot boils over, 2, 4)
th ulocal(v(d.clocks)/layout.tick, %#, Pot boils over, 2, 4, 4)
th ulocal(v(d.clocks)/layout.clock, Pot boils over, 4, 4)

th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 3, 3, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 3, 12)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 4, 4, 12)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 4, 12)

th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 1, 1, 4)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 1, 4)
th ulocal(v(d.clocks)/layout.tick, %#, Bluecoats arrive!, 2, 2, 4)
th ulocal(v(d.clocks)/layout.clock, Bluecoats arrive!, 2, 4)

*/

@create Clocks=10
@set Clocks=SAFE INHERIT
@force me=@parent Clocks=[v(d.bf)]

@force me=&d.clocks me=[search(ETHING=t(member(name(##), Clocks, |)))]

@tel [v(d.clocks)]=#2

@@ %0 - player
&f.get-clocks [v(d.clocks)]=squish(trim(iter(lcon(loc(%0), CONNECT), if(t(lattr(itext(0)/_clock.*)), itext(0)))))

@@ %0 - player
&f.get-player-clocks [v(d.clocks)]=lattr(%0/_clock.*)

@@ %0 - player
@@ %1 - clock attribute
&f.get-time [v(d.clocks)]=first(xget(%0, %1), |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-ticks [v(d.clocks)]=extract(xget(%0, %1), 2, 1, |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-max [v(d.clocks)]=extract(xget(%0, %1), 3, 1, |)

@@ %0 - player
@@ %1 - clock attribute
&f.get-title [v(d.clocks)]=extract(xget(%0, %1), 4, 9999, |)

@@ %0 - player
@@ %1 - clock title
&f.find-clock-by-title [v(d.clocks)]=strcat(setq(T, iter(setr(A, ulocal(f.get-player-clocks, %0)), ulocal(f.get-title, %0, itext(0)),, |)), first(iter(%qT, if(t(strmatch(itext(0), %1*)), extract(%qA, inum(0), 1)), |, @@)))

@@ %0 - player
@@ %1 - clock title
&f.find-any-clock-by-title [v(d.clocks)]=first(iter(ulocal(f.get-clocks, %0), iter(ulocal(f.find-clock-by-title, itext(0), %1), itext(1)/[itext(0)]),, @@))

@@ %0 - player
@@ %1 - clock title
@@ %2 - amount to tick
@@ %3 - new ticks value
@@ %4 - max
&layout.tick [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), if(lt(%2, 0), unticks, ticks), the, %ch%1%cn, clock by, ansi(case(1, lt(%2, 0), g, cor(gte(%2, ceil(mul(%4, .33))), gte(%3, round(mul(%4, .75), 0))), r, n), %2).)

@@ %0 - player
@@ %1 - clock title
@@ %2 - new ticks value
@@ %3 - max
&layout.set [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), sets the, %ch%1%cn, clock to, ansi(case(1, eq(%2, 0), g, gte(%2, round(mul(%3, .75), 0)), r, n), %2).)

@@ %0 - player
@@ %1 - clock title
@@ %2 - max
&layout.creation [v(d.clocks)]=cat(alert(Clock), ulocal(f.get-name, %0), created, the, %ch%1%cn, clock.)

@@ %0 - ticks
@@ %1 - max
&layout.clock-visual [v(d.clocks)]=strcat(ansi(yh, repeat(~, dec(%0))), case(1, cand(gt(%0, 0), lt(%0, %1)), ansi(r, *), eq(%0, %1), ansi(r, *), eq(%0, 0),, ~), repeat(-, dec(sub(%1, %0))), if(lt(%0, %1), ansi(if(eq(%1, %0), r, n), !)), if(eq(%0, %1), %b%ch%crTime's up!%cn))

@@ %0 - clock title
@@ %1 - ticks
@@ %2 - max
&layout.clock [v(d.clocks)]=strcat(alert(%0), %b, rjust(%1, 2), /, %2, %b, -->, %b, ulocal(layout.clock-visual, %1, %2))

@@ %0 - player viewing
@@ %1 - list of players with clocks on them
&layout.clocks [v(d.clocks)]=if(t(%1), strcat(header(Active clocks, %0), %r, formattable(strcat(Clock|Ticks|Visual|, iter(ulocal(f.get-clocks, %#), iter(ulocal(f.get-player-clocks, itext(0)), strcat(ulocal(f.get-title, itext(1), itext(0)), |, setr(T, ulocal(f.get-ticks, itext(1), itext(0))), /, setr(M, ulocal(f.get-max, itext(1), itext(0))), |, ulocal(layout.clock-visual, %qT, %qM)),, |),, @@)), 3, 1, |, %0), %r, footer(+clock <clock> for more, %0)), cat(alert(Clocks), There are no currently active clocks in your area.))

&c.+clocks [v(d.clocks)]=$+clocks: @pemit %#=ulocal(layout.clocks, %#, ulocal(f.get-clocks, %#));

&c.+clock [v(d.clocks)]=$+clock *: @assert t(setr(C, ulocal(f.find-any-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock in your area that starts with '%0'.; }; @eval strcat(setq(P, first(%qC, /)), setq(C, rest(%qC, /))); @pemit %#=ulocal(layout.clock-details, %#, %qP, %qC);

&c.+clock/set [v(d.clocks)]=$+clock/set *=*: @assert t(setr(C, ulocal(f.find-clock-by-title, %#, %0)))={ @trigger me/tr.error=%#, Could not find a clock that starts with '%0'.; }; @assert cand(t(setr(M, ulocal(f.get-max, %#, %qC))), t(setr(N, ulocal(f.get-title, %#, %qC))))={ @trigger me/tr.error=%#, Could not get information about the specified clock.; };  @assert cand(isnum(%1), gte(%1, 0), lte(%1, %qM))={ @trigger me/tr.error=%#, You must set your '%qN' clock to a number between 0 and %qM.; }; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.set, %#, %qN, %1, %qM), %#; @set %#=%qC:[replace(xget(%#, %qC), 2, %1, |, |)];


&_clock.1 %#=1635477735|10|12|Bluecoats arrive!

&_clock.2 %#=1635477735|0|6|Pot boils over
