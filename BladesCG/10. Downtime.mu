/*
+dt/+downtime
	+dt/recover <#>
	+dt/feed
	+dt/heat
	+dt/indulge or +dt/vice
	+dt/train <track>
	+dt/spend <#>=<reason>
	+dt/buy <#> - spend <#> coin to buy <#> downtime
	+dt/award <player>=<reason> (staff-only)
	+dt/award <player>=<#> <reason> (staff-only)
	+dt/spend <player>=<#> <reason> (staff-only)
+health
	+harm <injury>
	+harm <#> <injury>
	+harm/clear <player> (staff-only) - clear player's harm completely
+stress/+trauma
	+stress/gain
	+stress/gain <#>
	+stress/clear
	+trauma/add <trauma>
+coin
	+coin/stash <#> - stash some of your coins
	+coin/unstash <#> - withdraw from your stash
	+coin/withdraw <#> - withdraw coin from your crew's vault
	+coin/deposit <#> - deposit coin into your crew's vault
	+coin/pay <name>=<#> - pay coin to another player
	+coin/spend <#>=<reason> - spend coin for <reason>
	+coin/award <player>=<#> <reason> (staff-only)
	+coin/spend <player>=<#> <reason> (staff-only)
	+coin/deposit <player>=<#> <reason> (staff-only) - award crew coin
	+coin/withdraw <player>=<#> <reason> (staff-only) - withdraw crew coin
+heat
	+heat/gain
	+heat/gain <#>
+rep
	+rep/award <player>=<#> <reason>

TODO: Maybe add reason fields to stress and heat, and add actual logging for them?
*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Daily
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.cg)]=@dolist xget(%vD, d.logs-to-clear)={ @trigger me/tr.clean-old-player-logs=##; }; @trigger me/tr.award-downtime;

&tr.award-downtime [v(d.cg)]=@break gettimer(%!, award-downtime); @dolist search(EPLAYER=isapproved(##))={ @trigger me/tr.award-player-downtime=##; }; @eval settimer(%!, award-downtime, 604800);

&tr.award-player-downtime [v(d.cg)]=@set %0=[ulocal(f.get-stat-location-on-player, downtime)]:[add(ulocal(f.get-player-stat, %0, downtime), setr(A, ulocal(f.get-player-downtime-per-week, %0)))]; @trigger me/tr.log=%0, _downtime-, Auto, Awarded %qA weekly auto-downtime.; @trigger me/tr.success=%0, Received %qA auto-downtime for the week.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.downtime [v(d.cgf)]=strcat(header(ulocal(f.get-name, %0, %1)'s downtime, %1), %r, formattext(strcat(Available:, %b, ulocal(f.get-player-stat-or-zero, %0, downtime), %r, Gaining:, %b, ulocal(f.get-player-downtime-per-week, %0), %b, per week, %b, +, %b, ulocal(f.get-player-downtime-per-score, %0), %b, per score, %r%r, Spend a downtime to:, %r%t, +dt/heat - reduce your crew's Heat, if(setr(S, not(ulocal(f.is_expert, %0))), strcat(%r%t, +dt/indulge - indulge your Vice and recover Stress)), %r%t, if(strmatch(ulocal(f.get-player-stat, %0, Playbook), Vampire), +dt/feed - feed to recover from Harm, strcat(+dt/recover <#> - roll <#> to recover from Harm, %r%t)), if(t(%qS), strcat(+dt/train <track> - train in an XP track (gains XP), %r%t)), Acquire an Asset - open a job to do this, %r%t, Make progress on a long term project - open a job to do this), 0, %1), setq(L, ulocal(f.get-last-X-logs, %0, _downtime-)), if(t(%qL), strcat(%r, divider(Last 10 downtimes, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&layout.player-coin [v(d.cgf)]=strcat(ulocal(layout.coin, %0, %1), %r, ulocal(layout.crew-coin, ulocal(f.get-player-stat, %0, crew object), %1), setq(L, ulocal(f.get-last-X-logs, %0, _coin-)), if(t(%qL), strcat(%r, divider(Last 10 coin logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), setq(L, ulocal(f.get-last-X-logs, setr(C, ulocal(f.get-player-stat, %0, crew object)), _crew-coin-)), if(t(%qL), strcat(%r, divider(Last 10 crew coin logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%qC, itext(0))),, %r), 0, %1))), %r, footer(, %1))

@@ TODO: Add a comment to +coin for each of the special abilities that grant a CREW coin with each Score.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ View Commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt [v(d.cg)]=$+dt:@pemit %#=ulocal(layout.downtime, %#, %#);

&c.+downtime [v(d.cg)]=$+downtime:@force %#=+dt;

&c.+dt_staff [v(d.cg)]=$+dt *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.downtime, %qP, %#);

&c.+downtime_staff [v(d.cg)]=$+downtime *:@force %#=+dt %0;

&c.+coin [v(d.cg)]=$+coin: @pemit %#=ulocal(layout.player-coin, %#, %#);

&c.+coin_staff [v(d.cg)]=$+coin *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.player-coin, %qP, %#);

&c.+heat [v(d.cg)]=$+heat: @pemit %#=ulocal(layout.subsection, crew-heat, %#, %#);

&c.+heat_staff [v(d.cg)]=$+heat *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.subsection, crew-heat, %qP, %#);

&c.+stress [v(d.cg)]=$+stress: @pemit %#=ulocal(layout.subsection, stress, %#, %#);

&c.+stress_staff [v(d.cg)]=$+stress *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.subsection, stress, %qP, %#);

&c.+trauma [v(d.cg)]=$+trauma:@force %#=+stress

&c.+trauma_staff [v(d.cg)]=$+trauma *:@force %#=+stress %0

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Award downtime
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&tr.log-downtime [v(d.cg)]=@trigger me/tr.log=%0, _downtime-, %1, %2;

&c.+dt/award [v(d.cg)]=$+dt/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), ulocal(f.get-player-downtime-per-score, %qP))); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this downtime was.; }; @assert cand(gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @set %qP=[setr(L, ulocal(f.get-stat-location-on-player, downtime))]:[add(xget(%qP, %qL), %qV)]; @trigger me/tr.log-downtime=%qP, %#, Awarded %qV downtime for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You award, ulocal(f.get-name, %qP, %#), %qV, downtime for '%qR'.), ulocal(f.get-name, %#, %qP) awards you %qV downtime for '%qR'., %qP, %#, Downtime;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Buying downtime
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt/buy [v(d.cg)]=$+dt/buy*: @eval setq(V, switch(%0, %b*, trim(%0), * *, rest(%0), 1)); @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(C, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qC coin%, not enough to buy %qV downtime.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[add(ulocal(f.get-player-stat-or-zero, %#, downtime), %qV)]; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[sub(%qC, %qV)]; @trigger me/tr.log-downtime=%#, %#, Bought %qV downtime with coin.; @trigger me/tr.log=%#, _coin-, %#, Spent %qV coin on downtime.; @trigger me/tr.success=%#, You buy %qV downtime for %qV coin. You now have [ulocal(f.get-player-stat, %#, downtime)] downtime and [ulocal(f.get-player-stat-or-zero, %#, coin)] coin.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Healing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.heal [v(d.cgf)]=squish(strcat(alert(Downtime), %b, ulocal(f.get-name, %0) spends 1 downtime to recover%, rolling %3 dice and getting, %b, %4., %b, capstr(subj(%0)), %b, plural(%0, adds, add) %ch%1%cn ticks to, %b, poss(%0), %b, healing clock%,, if(t(%2), cat(, removing, itemize(%ch%2%cn, |), and)), %b, setting the clock to, %b, default(%0/_health-clock, 0)/, ulocal(f.get-max-healing-clock, %0), ., %b, ulocal(layout.health-status, %0, %1, %2)))

&layout.feed [v(d.cgf)]=squish(strcat(alert(Downtime), %b, ulocal(f.get-name, %0) spends 1 downtime to feed%, adding %ch%1%cn ticks to, %b, poss(%0), %b, healing clock%,, if(t(%2), cat(, removing, itemize(%ch%2%cn, |), and)), %b, setting the clock to, %b, default(%0/_health-clock, 0)/, ulocal(f.get-max-healing-clock, %0), ., %b, ulocal(layout.health-status, %0, %1, %2)))

&c.+dt/recover [v(d.cg)]=$+dt/r*:@assert not(strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire))={ @trigger me/tr.error=%#, Vampires can't recover - they must %ch+dt/feed%cn instead.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Recovery costs one downtime%, and you don't have any left.; }; @eval setq(R, if(t(strlen(rest(%0))), trim(rest(%0)), 1)); @assert isint(%qR)={ @trigger me/tr.error=%#, '%qR' must be a number.; }; @assert cand(gte(%qR, 0), lte(%qR, 10))={ @trigger me/tr.error=%#, %qR must be a number between 0 and 10.; }; @eval setq(L, ulocal(f.roll-to-heal, %qR)); @eval strcat(setq(E, first(%qL, |)), setq(L, rest(%qL, |))); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, The roll must return 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot recover.; }; @assert t(ulocal(f.get-harm-field, %#, 1))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences. You must open a job with staff to recover.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @eval setq(M, ulocal(f.get-max-healing-clock, %#)); @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), %qM)]; @eval setq(O, xget(%#, _health-1-1)); @eval setq(H, iter(extract(%qF, 1, div(%qT, %qM)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(setr(I, _health-1-1 _health-1-2 _health-2-1 _health-2-2 _health-3 _health-4), set(%#, strcat(itext(0), :, xget(%#, extract(%qI, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, if(not(strmatch(%qO, xget(%#, _health-1-1))), %qO), %qR, %qE), %#; @trigger me/tr.log-downtime=%#, %#, Spent 1 downtime to recover%, rolling %qE and adding %qL ticks to the healing clock.;

&c.+dt/feed [v(d.cg)]=$+dt/f*:@assert strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire)={ @trigger me/tr.error=%#, Non-vampires can't feed - they must %ch+dt/recover <#>%cn instead.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Feeding costs one downtime%, and you don't have any left.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot feed to heal.; }; @assert t(ulocal(f.get-harm-field, %#, 1))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences. You must open a job with staff to recover.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @eval setq(M, ulocal(f.get-max-healing-clock, %#)); @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), 4)), %qM)]; @eval setq(O, xget(%#, _health-1-1)); @eval setq(H, iter(extract(%qF, 1, div(%qT, %qM)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(setr(L, _health-1-1 _health-1-2 _health-2-1 _health-2-2 _health-3 _health-4), set(%#, strcat(itext(0), :, xget(%#, extract(%qL, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.feed, %#, 4, if(not(strmatch(%qO, xget(%#, _health-1-1))), %qO), %qR, %qE), %#; @trigger me/tr.log-downtime=%#, %#, Spent 1 downtime to feed%, adding 4 ticks to the healing clock.;

&c.+dt/heal [v(d.cg)]=$+dt/heal *:@force %#=+dt/recover %0;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stress commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: player
@@ %1: message
&tr.alert-to-monitor [v(d.cg)]=@cemit [xget(%vD, d.monitor-channel)]=[cat(ansi(xh, extract(prettytime(), 1, 2, /)), ansi(<#777777>, rest(prettytime())), ulocal(f.get-name, %0):, %1)];

&layout.gain-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), gains %1 stress%, bringing, poss(%0), total to %2/%3., if(eq(%2, %3), cat(capstr(subj(%0)), plural(%0, is, are), out of the scene and must take a trauma before, subj(%0), can return to play.)))

&layout.reduce-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), spends 1 downtime to indulge, poss(%0), vice%, rolling %1 dice and getting %2., capstr(subj(%0)), plural(%0, recovers, recover), %3 stress%, bringing, poss(%0), total to %4/%5., if(t(%6), cat(capstr(subj(%0)), plural(%0, has, have) overindulged and a job has been opened with staff to handle the consequences of this overindulgence.)))

&layout.overindulge-job [v(d.cgf)]=cat(ulocal(f.get-name, %0), overindulged, poss(%0), vice of, ulocal(f.get-player-stat, %0, vice), by, %1, points.%R%R%TWhen you overindulge%, you make a bad call because of your vice - in acquiring it or while under its influence. To bring the effect of this bad decision into the game%, select an overindulgence from the list:%R%R%T- Attract Trouble. Select or roll an additional entanglement.%R%T- Brag about your exploits. +2 heat for your crew.%R%T- Lost. Your character vanishes for a few weeks. Play a different character until this one returns from their bender. When your character returns%, they've also healed any harm they had.%R%T- Tapped. Your current purveyor cuts you off. Find a new source for your vice.%R)

&layout.clear-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), clears a stress%, bringing, poss(%0), total to %1/%2.)

&c.+stress/gain_1 [v(d.cg)]=$+stress/gain:@force %#=+stress/gain 1;

&c.+stress/gain [v(d.cg)]=$+stress/gain *: @eval setq(M, ulocal(f.get-max-stress, %#)); @assert cand(isint(%0), gt(%0, 0), lte(%0, %qM))={ @trigger me/tr.error=%#, '%0' must be a number between 1 and %qM.; }; @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @assert lte(setr(N, add(%qC, %0)), %qM)={ @trigger me/tr.error=%#, You have [sub(%qM, %qC)] stress remaining. %0 is too high.; }; @assert cor(lt(%qN, %qM), gettimer(%#, stress-limit, %0))={ @eval settimer(%#, stress-limit, 600, %0); @trigger me/tr.message=%#, Taking this stress would put you at your maximum of %qM stress. You will immediately be out of the scene and will have to take a trauma before you can return to play. Are you sure you want to take this stress? Hit %ch+stress/gain %0%cn within the next 10 minutes to confirm. The time is now [prettytime()].; }; @set %#=[ulocal(f.get-stat-location-on-player, stress)]:%qN; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.gain-stress, %#, %0, %qN, %qM), %#;  @trigger me/tr.alert-to-monitor=%#, Gained %0 stress.; @assert neq(%qN, %qM)={ @set %#=[ulocal(f.get-stat-location-on-player, needs trauma)]:1; };

&c.+stress/clear [v(d.cg)]=$+stress/clear: @eval setq(M, ulocal(f.get-max-stress, %#)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @assert gte(setr(N, dec(%qC)), 0)={ @trigger me/tr.error=%#, You have no stress to clear.; }; @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @set %#=[ulocal(f.get-stat-location-on-player, stress)]:%qN; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.clear-stress, %#, %qN, %qM), %#; @trigger me/tr.alert-to-monitor=%#, Cleared a stress.; @assert not(eq(%qC, %qM))={ @wipe %#/[ulocal(f.get-stat-location-on-player, needs trauma)]; };

&c.+trauma/add [v(d.cg)]=$+trauma/add *: @assert cor(t(ulocal(f.get-player-stat, %#, needs trauma)), cand(strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire), lt(words(ulocal(f.get-player-stat, %#, traumas), |), ulocal(f.get-max-trauma, %#))))={ @trigger me/tr.error=%#, You can't take a trauma yet. Go earn more stress!; }; @assert t(setr(T, finditem(setr(L, setdiff(xget(%vD, d.value.traumas), setr(U, ulocal(f.get-player-stat, %#, traumas)), |, |)), %0, |)))={ @trigger me/tr.error=%#, Could not find a trauma starting with '%0'. Available traumas are [ulocal(layout.list, %qL)].; }; @wipe %#/[ulocal(f.get-stat-location-on-player, needs trauma)]; @set %#=[ulocal(f.get-stat-location-on-player, Traumas)]:[trim(strcat(%qU, |, %qT), |, b)]; @set %#=[ulocal(f.get-stat-location-on-player, Stress)]:0; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, Traumas, %qT, %#, %#), ulocal(layout.staff-add-alert, Traumas, %qT, %#, %#), %#, %#, Traumas; @trigger me/tr.remit-or-pemit=%l, cat(alert(Trauma), ulocal(f.get-name, %#) takes a trauma and resets, poss(%#), stress level to 0.), %#;

&c.+dt/vice [v(d.cg)]=$+dt/vice:@force %#=+dt/indulge;

&c.+dt/indulge [v(d.cg)]=$+dt/indulge:@assert not(ulocal(f.is_expert, %#))={ @trigger me/tr.error=%#, You're an expert%, so you can't indulge your vice.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Indulging your Vice costs one downtime%, and you don't have any left.; }; @eval setq(M, ulocal(f.get-max-stress, %#)); @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @assert gt(%qC, 0)={ @trigger me/tr.error=%#, You currently don't have any stress to reduce.; }; @eval setq(L, ulocal(f.roll-to-indulge, setr(A, ulocal(f.get-lowest-attribute, %#)))); @eval strcat(setq(E, first(%qL, |)), setq(L, rest(%qL, |))); @set %#=[ulocal(f.get-stat-location-on-player, Stress)]:[if(lte(%qL, %qC), sub(%qC, %qL), 0)]; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.reduce-stress, %#, %qA, %qE, %qL, if(lte(%qL, %qC), sub(%qC, %qL), 0), %qM, gt(%qL, %qC)), %#; @trigger me/tr.log-downtime=%#, %#, cat(Rolled %qA to indulge vice%, getting %qE and reducing stress by %qL to, if(lte(%qL, %qC), sub(%qC, %qL), 0)/%qM., if(gt(%qL, %qC), You overindulged.)); @assert lte(%qL, %qC)={ @trigger %vA/trig_create=%#, xget(%vD, d.downtime-bucket), 1, cat(Overindulgence:, ulocal(f.get-name, %#)), ulocal(layout.overindulge-job, %#, sub(%qL, %qC)); };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Heat
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.gain-heat [v(d.cgf)]=cat(alert(Heat), ulocal(f.get-name, %0), gains %1 heat for, poss(%0), crew., Their total heat is now %2/9 and they have, ansi(case(%3, 4, hr, 3, hr, 2, hy, 1, hy, hg), %3), Wanted Levels.)

&layout.reduce-heat [v(d.cgf)]=cat(alert(Heat), ulocal(f.get-name, %0), spends 1 downtime and reduces the heat for, poss(%0), crew., The crew's total heat is now %1/9 and they have, ansi(case(%2, 4, hr, 3, hr, 2, hy, 1, hy, hg), %2), Wanted Levels.)

&c.+heat/gain_1 [v(d.cg)]=$+heat/gain:@force %#=+heat/gain 1;

&c.+heat/gain [v(d.cg)]=$+heat/gain *:@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't gain heat.; }; @assert cand(isint(%0), gt(%0, 0), lte(%0, 9))={ @trigger me/tr.error=%#, '%0' must be a number between 1 and 9.; }; @eval setq(T, ulocal(f.get-player-stat-or-zero, %qC, Wanted Level)); @eval setq(O, ulocal(f.get-player-stat, %qC, Heat)); @assert lt(%qT, 4)={ @trigger me/tr.error=%#, You have reached your limit for all heat and wanted levels.; }; @assert lte(setr(N, add(%qO, %0)), 9)={ @trigger me/tr.error=%#, You have [sub(9, %qO)] heat remaining. %0 is too high.; }; @assert cor(lt(%qN, 9), gettimer(%#, heat-limit, %0))={ @eval settimer(%#, heat-limit, 600, %0); @trigger me/tr.message=%#, Taking this heat would clear your crew's heat%, but would give your crew a Wanted Level. Wanted Levels increase the danger of future scores. Are you sure you want to take this heat? Hit %ch+heat/gain %0%cn within the next 10 minutes to confirm. The time is now [prettytime()].; }; @eval strcat(setq(T, if(eq(%qN, 9), inc(%qT), %qT)), setq(N, if(eq(%qN, 9), 0, %qN))); @set %qC=[ulocal(f.get-stat-location-on-player, heat)]:%qN; @set %qC=[ulocal(f.get-stat-location-on-player, Wanted Level)]:%qT; @trigger me/tr.remit-or-pemit=%L, setr(M, ulocal(layout.gain-heat, %#, %0, %qN, %qT)), %#; @trigger me/tr.crew-emit=%qC, %qM;

&c.+dt/heat [v(d.cg)]=$+dt/heat:@assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Reducing your crew's Heat costs one downtime%, and you don't have any left.; }; @assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't reduce heat.; }; @assert gt(setr(F, ulocal(f.get-player-stat-or-zero, %qC, Heat)), 0)={ @trigger me/tr.error=%#, Your crew doesn't currently have any heat to reduce.; }; @set %qC=[ulocal(f.get-stat-location-on-player, heat)]:[dec(%qF)]; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @trigger me/tr.remit-or-pemit=%L, setr(M, ulocal(layout.reduce-heat, %#, dec(%qF), ulocal(f.get-player-stat-or-zero, %qC, Wanted Level))), %#; @trigger me/tr.crew-emit=%qC, %qM; @trigger me/tr.log-downtime=%#, %#, Reduced crew heat by 1.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Training
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt/train [v(d.cg)]=$+dt/train *:@assert not(ulocal(f.is_expert, %#))={ @trigger me/tr.error=%#, You're an expert%, so you can't train.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Training costs one downtime%, and you don't have any left.; }; @assert t(setr(T, finditem(setr(L, setdiff(xget(%vD, d.xp_tracks), Crew|Untracked, |, |)), %0, |)))={ @trigger me/tr.error=%#, '%0' is not a valid XP track. Valid tracks are [ulocal(layout.list, %qL)].; }; @assert not(gettimer(%#, train_%qT))={ @trigger me/tr.error=%#, You last trained your %qT less than a week ago. Wait until the timer expires to train %qT again. The timer will expire in [getremainingtime(%#, train_%qT)].; }; @eval settimer(%#, train_%qT, 604800); @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @trigger me/tr.increase-track=%qT, if(ulocal(f.has-list-stat, ulocal(f.get-player-stat, crew object), Upgrades, %qT), 2, 1), %#, %#, add, Spent downtime; @trigger me/tr.log-downtime=%#, %#, Trained %qT.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Spending downtime
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt/spend [v(d.cg)]=$+dt/spend *=*:@break cand(not(isint(%0)), isstaff(%#)); @eval setq(D, ulocal(f.get-player-stat, %#, downtime)); @assert cand(isint(%0), gt(%0, 0), lte(%0, %qD))={ @trigger me/tr.error=%#, %0 must be a number between 1 and your current downtime%, %qD.; }; @assert t(%1)={ @trigger me/tr.error=%#, You must specify a reason for spending this downtime.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[sub(%qD, %0)]; @trigger me/tr.log-downtime=%#, %#, Spent %0 for '%1'.; @trigger me/tr.success=%#, You spend %0 downtime for '%1'.; @trigger me/tr.alert-to-monitor=%#, Spent %0 downtime for '%1'.;

&c.+dt/spend_staff [v(d.cg)]=$+dt/spend *=*:@break isint(%0); @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(D, ulocal(f.get-player-stat, %qP, downtime)); @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for spending this downtime was.; }; @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, %qD))={ @trigger me/tr.error=%#, %qV must be a number between 1 and the player's current downtime%, %qD.; }; @set %qP=[ulocal(f.get-stat-location-on-player, downtime)]:[sub(%qD, %qV)]; @trigger me/tr.log-downtime=%qP, %#, Spent %qV for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You spend %qV of, ulocal(f.get-name, %qP, %#)'s downtime for '%qR'.), cat(ulocal(f.get-name, %#, %qP) spends %qV of your downtime for '%qR'. You now have, ulocal(f.get-player-stat, %qP, downtime) downtime.), %qP, %#, Downtime;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Reputation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.crew-rep [v(d.cgf)]=strcat(header(Crew Reputation, %1), %r, ulocal(layout.crew-rep-line, %0), setq(L, ulocal(f.get-last-X-logs, %0, _rep-, 10)), if(t(%qL), strcat(%r, divider(Last 10 Reputation logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&c.+rep [v(d.cg)]=$+rep:@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You aren't on a crew%, so you don't have a real rep.; }; @pemit %#=ulocal(layout.crew-rep, %qC, %#);

&c.+rep_staff [v(d.cg)]=$+rep *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; };@assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, cat(ulocal(f.get-name, %qP), isn't on a crew%, so, subj(%qP), plural(%qP, doesn't, don't) have a real rep.); }; @pemit %#=ulocal(layout.crew-rep, %qC, %#);

&c.+rep/award [v(d.cg)]=$+rep/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP) is not part of a crew and cannot gain rep.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this downtime was.; }; @eval setq(M, sub(ulocal(f.get-max-rep, %qC), setr(A, ulocal(f.get-player-stat, %qC, Rep)))); @assert t(%qM)={ @trigger me/tr.error=%#, This crew cannot receive any more rep - they need to buy up their Tier!; };  @assert cand(gt(%qV, 0), lte(%qV, %qM))={ @trigger me/tr.error=%#, %qV must be a number between 1 and %qM.; }; @set %qC=[ulocal(f.get-stat-location-on-player, rep)]:[add(%qA, %qV)]; @trigger me/tr.log=%qP, _rep-, %#, Awarded %qV rep for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You award, ulocal(f.get-name, %qP, %#), %qV, rep for '%qR'.), ulocal(f.get-name, %#, %qP) awards you %qV rep for '%qR'., %qP, %#, Rep; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) awards the crew +%qV rep for '%qR'.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Award Coin
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.coin-log [v(d.cgf)]=strcat(Awarded %0 coin for '%1'., if(t(%2), %b%2 coin overflowed into the crew vault.), if(t(%3), %b%3 coin overflowed into the stash.))

&layout.coin-awarded [v(d.cgf)]=cat(You award, ulocal(f.get-name, %0), %1, coin for '%2'., if(t(%3), %3 coin overflowed into the crew vault.), if(t(%4), %b%4 coin overflowed into the stash.))

&layout.coin-received [v(d.cgf)]=cat(ulocal(f.get-name, %0), awards you, %1, coin for '%2'., if(t(%3), %3 coin overflowed into the crew vault.), if(t(%4), %b%4 coin overflowed into your stash.))

&layout.coin-crew-overflow [v(d.cgf)]=cat(ulocal(f.get-name, %0), awards, ulocal(f.get-name, %1), %2 coin%, and %3 of, poss(%1), coin overflowed into the crew's vault.)

&layout.coin-crew-overflow-log [v(d.cgf)]=cat(Awarded, ulocal(f.get-name, %1), %2 coin%, and %3 of, poss(%1), coin overflowed into the crew's vault.)

@@ V: Value to deposit
@@ C: Crew object
@@ M: Current coin on player
@@ X: Max in crew vault
@@ Y: Current crew vault
@@ S: Current in stash
@@ D: Amount to put on the player
@@ E: Amount to put with the crew
@@ F: Amount to put in the player's stash
@@ A: Remaining to disburse
&c.+coin/award [v(d.cg)]=$+coin/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this coin was.; }; @eval setq(M, ulocal(f.get-player-stat, %qP, Coin)); @eval setq(C, ulocal(f.get-player-stat, %qP, crew object)); @eval setq(X, if(t(%qC), ulocal(f.get-vault-max, %qC), 0)); @eval setq(Y, ulocal(f.get-player-stat-or-zero, %qC, crew coin)); @eval setq(S, ulocal(f.get-player-stat-or-zero, %qP, Stash)); @eval setq(A, %qV); @eval if(lte(add(%qM, %qA), 4), strcat(setq(D, add(%qM, %qA)), setq(E, %qY), setq(F, %qS), setq(A, 0)), strcat(setq(D, 4), setq(A, sub(%qA, sub(4, %qM))), if(lte(add(%qY, %qA), %qX), strcat(setq(E, add(%qY, %qA)), setq(F, %qS), setq(A, 0)), strcat(setq(E, %qX), setq(A, sub(%qA, sub(%qX, %qY))), if(lte(add(%qS, %qA), 40), strcat(setq(F, add(%qS, %qA)), setq(A, 0)), strcat(setq(F, 40), setq(A, sub(%qA, sub(40, %qS))))))))); @assert eq(%qA, 0)={ @trigger me/tr.error=%#, Could not distribute %qV coin without %qA extra coin being lost. Please choose a lower number of coin.; }; @set %qP=[ulocal(f.get-stat-location-on-player, Coin)]:%qD; @set %qC=ulocal(f.get-stat-location-on-player, Crew Coin):%qE; @set %qP=[ulocal(f.get-stat-location-on-player, Stash)]:%qF; @trigger me/tr.log=%qP, _coin-, %#, ulocal(layout.coin-log, %qV, %qR, sub(%qE, %qY), sub(%qF, %qS)); @trigger me/tr.stat-setting-messages=ulocal(layout.coin-awarded, %qP, %qV, %qR, sub(%qE, %qY), sub(%qF, %qS)), ulocal(layout.coin-received, %#, %qV, %qR, sub(%qE, %qY), sub(%qF, %qS)), %qP, %#, Coin; @if t(sub(%qE, %qY))={ @trigger me/tr.log=%qC, _crew-coin-, %qC, ulocal(layout.coin-crew-overflow-log, %#, %qP, %qV, sub(%qE, %qY)); @trigger me/tr.crew-emit=%qC, ulocal(layout.coin-crew-overflow, %#, %qP, %qV, sub(%qE, %qY)); };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Paying coin to other players
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.coin-paid [v(d.cgf)]=cat(You pay, ulocal(f.get-name, %0, %1), %2 coin for '%3'. You now have %4 coin.)

&layout.coin-paid-received [v(d.cgf)]=cat(ulocal(f.get-name, %0, %1), pays you, %2 coin for '%3'. You now have %4 coin.)

&c.+coin/pay [v(d.cg)]=$+coin/pay *=*: @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(isapproved(%#), isapproved(%qP))={ @trigger me/tr.error=%#, You and your payee must be approved before you can give them coin.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @assert not(strmatch(%#, %qP))={ @trigger me/tr.error=%#, You cannot pay yourself coin.; }; @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for paying this coin was.; }; @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(C, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qC coin%, not enough to pay [ulocal(f.get-name, %qP, %#)] %qV.; }; @assert lte(add(setr(D, ulocal(f.get-player-stat-or-zero, %qP, coin)), %qV), 4)={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) can't receive %qV coin%, it won't fit in [poss(%qP)] pockets.; }; @eval setq(L, ulocal(f.get-stat-location-on-player, coin)); @set %qP=%qL:[add(%qD, %qV)]; @set %#=%qL:[sub(%qC, %qV)]; @trigger me/tr.log=%#, _coin-, %#, Paid [ulocal(f.get-name, %qP, %#)] %qV coin for '%qR'.; @trigger me/tr.log=%qP, _coin-, %#, Received %qV coin from [ulocal(f.get-name, %#, %qP)] for '%qR'.; @trigger me/tr.stat-setting-messages=ulocal(layout.coin-paid, %qP, %#, %qV, %qR, ulocal(f.get-player-stat-or-zero, %#, coin)), ulocal(layout.coin-paid-received, %#, %qP, %qV, %qR, ulocal(f.get-player-stat-or-zero, %qP, coin)), %qP, %#, Coin; @trigger me/tr.alert-to-monitor=%#, cat(Paid, ulocal(f.get-name, %qP), %qV coin for '%qR'.);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Spending coin
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+coin/spend [v(d.cg)]=$+coin/spend *=*:@break cand(not(isint(%0)), isstaff(%#)); @eval setq(V, %0); @eval setq(R, %1); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for paying this coin was.; }; @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(C, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qC coin%, not enough to spend %qV.; }; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[sub(%qC, %qV)]; @trigger me/tr.log=%#, _coin-, %#, Spent %qV coin for '%qR'.; @trigger me/tr.remit-or-pemit=%l, cat(alert(Coin), ulocal(f.get-name, %#), spent %qV coin for '%qR'.), %#;  @trigger me/tr.alert-to-monitor=%#, Spent %qV coin for '%qR'.;

&c.+coin/spend_staff [v(d.cg)]=$+coin/spend *=*:@break isint(%0); @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for spending this player's coin was.; }; @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(C, ulocal(f.get-player-stat-or-zero, %qP, coin)), %qV)={ @trigger me/tr.error=%#, This player has %qC coin%, not enough to spend %qV.; }; @set %qP=[ulocal(f.get-stat-location-on-player, coin)]:[sub(%qC, %qV)]; @trigger me/tr.log=%qP, _coin-, %#, Spent %qV coin for '%qR'.; @trigger me/tr.stat-setting-messages=cat(Spent %qV of, ulocal(f.get-name, %qP, %#)'s coin for '%qR'.), cat(ulocal(f.get-name, %#, %qP) spent %qV of your coin for '%qR'. You now have, ulocal(f.get-player-stat-or-zero, %qP, coin), coin.), %qP, %#, Coin;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stashing and unstashing coin
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+coin/stash [v(d.cg)]=$+coin/stash*: @eval setq(V, switch(%0, %b*, trim(%0), * *, rest(%0), 1)); @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(O, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qO coin%, not enough to stash %qV coin.; }; @assert lte(add(setr(S, ulocal(f.get-player-stat-or-zero, %#, stash)), %qV), 40)={ @trigger me/tr.error=%#, You have can only stash 40 coin and you already have %qS. %qV more won't fit.; }; @set %#=[ulocal(f.get-stat-location-on-player, stash)]:[add(%qS, %qV)]; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[sub(%qO, %qV)]; @trigger me/tr.log=%#, _coin-, %#, Stashed %qV coin.; @trigger me/tr.success=%#, You stash %qV coin. You now have [ulocal(f.get-player-stat-or-zero, %#, coin)] coin and [ulocal(f.get-player-stat, %#, stash)] stash.;

&c.+coin/unstash [v(d.cg)]=$+coin/unstash*: @eval setq(V, switch(%0, %b*, trim(%0), * *, rest(%0), 1)); @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 4))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 4.; }; @assert gte(setr(S, ulocal(f.get-player-stat-or-zero, %#, stash)), mul(%qV, 2))={ @trigger me/tr.error=%#, You have %qS in your stash%, not enough to unstash %qV coin. You need [mul(%qV, 2)].; }; @assert lte(add(setr(O, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV), 4)={ @trigger me/tr.error=%#, Your pockets aren't big enough to hold more than 4 coin. You already have %qO coin. Spend some to make room for %qV more.; }; @assert t(gettimer(%#, unstash, %qV))={ @eval settimer(%#, unstash, 600, %qV); @trigger me/tr.message=%#, Unstashing coin costs double what you want to withdraw. If you continue%, you will be unstashing [mul(%qV, 2)] but will receive only %qV coin. Are you sure? If so%, hit %ch+coin/unstash %qV%cn again within the next 10 minutes. The time is now [prettytime()].; }; @set %#=[ulocal(f.get-stat-location-on-player, stash)]:[sub(%qS, mul(%qV, 2))]; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[add(%qO, %qV)]; @trigger me/tr.log=%#, _coin-, %#, Unstashed %qV coin. This cost [mul(%qV, 2)] stash.; @trigger me/tr.success=%#, You unstash %qV coin. This cost [mul(%qV, 2)] stash. You now have [ulocal(f.get-player-stat-or-zero, %#, coin)] coin and [ulocal(f.get-player-stat-or-zero, %#, stash)] stash.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Depositing crew coin
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+coin/deposit [v(d.cg)]=$+coin/deposit*:@break cand(strmatch(%0, *=*), isstaff(%#)); @assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't deposit coin.; }; @eval setq(V, switch(%0, %b*, trim(%0), * *, rest(%0), 1)); @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(O, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qO coin%, not enough to deposit %qV coin.; }; @assert lte(add(setr(S, ulocal(f.get-player-stat-or-zero, %qC, crew coin)), %qV), setr(M, ulocal(f.get-vault-max, %qC)))={ @trigger me/tr.error=%#, Your crew's vault can't take another %qV coin - they already have %qS and the vault can only hold %qM.; }; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[sub(%qO, %qV)]; @set %qC=[ulocal(f.get-stat-location-on-player, crew coin)]:[add(%qS, %qV)]; @trigger me/tr.log=%#, _coin-, %#, Deposited %qV coin into the crew vault.; @trigger me/tr.log=%qC, _crew-coin-, %#, Deposited %qV coin.; @trigger me/tr.success=%#, You deposit %qV coin into your crew's vault. You now have [ulocal(f.get-player-stat-or-zero, %#, coin)] coin and your crew has [ulocal(f.get-player-stat, %qC, crew coin)].; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) deposits %qV coin into the crew's vault.;

&c.+coin/deposit_staff [v(d.cg)]=$+coin/deposit *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to change a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, %qN is not in a crew and can't receive crew coin.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this crew coin was.; }; @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 16))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 16.; }; @assert lte(add(setr(S, ulocal(f.get-player-stat-or-zero, %qC, crew coin)), %qV), setr(M, ulocal(f.get-vault-max, %qC)))={ @trigger me/tr.error=%#, This crew's vault can't take another %qV coin - they already have %qS and the vault can only hold %qM.; }; @set %qC=[ulocal(f.get-stat-location-on-player, crew coin)]:[add(%qS, %qV)]; @trigger me/tr.log=%qC, _crew-coin-, %#, Awarded %qV crew coin for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You award, ulocal(f.get-name, %qP, %#)'s crew, %qV, crew coin for '%qR'.), ulocal(f.get-name, %#) awards your crew %qV crew coin for '%qR'., %qP, %#, Crew Coin;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Withdrawing crew coin
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+coin/withdraw [v(d.cg)]=$+coin/withdraw*:@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't withdraw coin.; }; @eval setq(V, switch(%0, %b*, trim(%0), * *, rest(%0), 1)); @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 4))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 4.; }; @assert lte(add(setr(O, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV), 4)={ @trigger me/tr.error=%#, Your pockets can only hold 4 coin and you already have %qO. You can't withdraw %qV from your crew's vault.; }; @assert gte(setr(S, ulocal(f.get-player-stat-or-zero, %qC, crew coin)), %qV)={ @trigger me/tr.error=%#, Your crew doesn't have %qV coin to withdraw in their vault - they only have %qS.; }; @set %qC=[ulocal(f.get-stat-location-on-player, crew coin)]:[sub(%qS, %qV)]; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[add(%qO, %qV)]; @trigger me/tr.log=%#, _coin-, %#, Withdrew %qV coin from the crew vault.; @trigger me/tr.log=%qC, _crew-coin-, %#, Withdrew %qV coin.; @trigger me/tr.success=%#, You withdraw %qV coin from the crew vault. You now have [ulocal(f.get-player-stat-or-zero, %#, coin)] coin and the crew has [ulocal(f.get-player-stat-or-zero, %qC, crew coin)] in the vault.;

&c.+coin/withdraw_staff [v(d.cg)]=$+coin/withdraw *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to change a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, %qN is not in a crew and can't receive crew coin.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for withdrawing this crew coin was.; }; @assert cand(isint(%qV), gt(%qV, 0), lte(%qV, 16))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 16.; }; @assert gte(setr(S, ulocal(f.get-player-stat-or-zero, %qC, crew coin)), %qV)={ @trigger me/tr.error=%#, This crew doesn't have %qV coin - they only have %qS in their vault.; }; @set %qC=[ulocal(f.get-stat-location-on-player, crew coin)]:[sub(%qS, %qV)]; @trigger me/tr.log=%#, _crew-coin-, %#, Took %qV crew coin for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You take %qV crew coin from, ulocal(f.get-name, %qP, %#)'s crew for '%qR'.), ulocal(f.get-name, %#) takes %qV crew coin from your crew's vault for '%qR'., %qP, %#, Crew Coin;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +heal and +harm
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@


&f.get-harm-field [v(d.cgf)]=case(%1, 3, if(hasattr(%0, _health-4), #-1 DEAD CHARACTER, if(hasattr(%0, _health-3), _health-4, _health-3)), case(strcat(hasattr(%0, _health-%1-1), hasattr(%0, _health-%1-2)), 00, _health-%1-1, 10, _health-%1-2, ulocal(f.get-harm-field, %0, add(%1, 1))))

&f.get-highest-health-level [v(d.cgf)]=trim(iter(4 3 2-2 2-1 1-2 1-1, if(hasattr(%0, _health-[itext(0)]), strcat(_health-, itext(0)))))

&layout.harm [v(d.cgf)]=cat(alert(Health), ulocal(f.get-name, %0), inflicted a, %chlevel %1%cn, harm on, obj(%0)self, called, %ch%2%cn., ulocal(layout.health-status, %0, %1, %2))

&layout.harm-text [v(d.cgf)]=if(hasattr(%0, _health-%1), cat(indent()-, xget(%0, _health-%1), strcat(%(, Level, %b, first(%1, -), %,, %b, switch(%1, 4, catastrophic%, permanent consequences, 3, needs help or to spend stress to act, 2*, -1 die to related rolls, less effect in related rolls), %))))

&layout.health-status [v(d.cgf)]=strcat(setq(H, squish(trim(iter(4 3 2-2 2-1 1-2 1-1, ulocal(layout.harm-text, %0, itext(0)),, |), b, |), |)), cat(capstr(subj(%0)), if(t(%qH), strcat(plural(%0, is, are), %b, suffering from the following ailments:, %r, edit(%qH, |, %r)), plural(%0, is, are) perfectly healthy.)))

&c.+health [v(d.cg)]=$+health:@pemit %#=ulocal(layout.subsection, health, %#, %#, 1)

&c.+harm [v(d.cg)]=$+harm *:@eval setq(L, if(isint(first(edit(%0, L,))), strcat(first(edit(%0, L,)), setq(D, rest(%0))), if(isint(last(edit(%0, L,))), strcat(last(edit(%0, L,)), setq(D, revwords(rest(revwords(%0))))), strcat(1, setq(D, %0))))); @assert t(match(1 2 3, %qL))={ @trigger me/tr.error=%#, You can only suffer a level 1%, 2%, or 3 harm.; }; @assert t(%qD)={ @trigger me/tr.error=%#, You must enter a description of the harm.; }; @assert t(setr(F, ulocal(f.get-harm-field, %#, %qL)))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences.; }; @assert cor(not(strmatch(%qF, _health-4)), gettimer(%#, health-doom, %qD))={ @eval settimer(%#, health-doom, 600, %qD); @trigger me/tr.message=%#, Taking this level of harm will have catastrophic%, permanent consequences for your character. Are you sure? If yes%, send %ch+harm %0%cn again within 10 minutes. The time is now [prettytime()].; }; @set %#=%qF:%qD; @set %#=_health-clock:[setq(C, xget(%#, _health-clock))]; @if t(%qC)={ @trigger me/tr.message=%#, Because you have taken harm%, your healing clock has been reset from %qC to 0.; }; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.harm, %#, %qL, %qD), %#; @trigger me/tr.alert-to-monitor=%#, Takes a L%qL harm called '%qD'.; @assert t(ulocal(f.get-harm-field, %#, %qL))={ @trigger me/tr.remit-or-pemit=%L, cat(alert(Health), ulocal(f.get-name, %#) has taken all available levels of harm and has suffered catastrophic%, permanent consequences.), %#; @trigger %vA/trig_create=%#, xget(%vD, d.characters-bucket), 1, cat(Max Harm:, ulocal(f.get-name, %#)), cat(ulocal(f.get-name, %#), has taken the maximum possible level of harm and this will have catastrophic consequences%, such as limb loss or sudden death.); };

&c.+harm/clear [v(d.cg)]=$+harm/clear *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to change a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %qP))))={ @trigger me/tr.error=%#, %qN isn't currently wounded and cannot have harm cleared.; }; @wipe %qP/_health-1-*; @wipe %qP/_health-2-*; @wipe %qP/_health-3; @wipe %qP/_health-4; @trigger me/tr.stat-setting-messages=Cleared %qN's injuries completely., ulocal(f.get-name, %#, %qP) clears your injuries completely., %qP, %#, Health;

&c.+hurt [v(d.cg)]=$+hurt *: @force %#=+harm %0;

&c.+heal [V(d.cg)]=$+heal*:@break strmatch(%0, th); @trigger me/tr.error=%#, Healing costs downtime. +dt/recover <#> to spend downtime and roll to heal.;

