/*
+coin/withdraw <#>=<reason> - withdraw from your crew's coin stash. Players can only carry a max of 4 coins at once.

+coin/deposit <#> - deposit your personal coin into the crew's stash. Crews can only hold 4 coins at once, or 8 if they have Vault, or 16 if they have Vault 2.

+coin/deposit <player>=<#> - lets staff deposit brand new coin into a crew's bank? Might not code this...

+coin/award <player>=<#> - give a player coin. If a receiving player is already at full, overflow into Crew, then into Stash. Max coin to be given at once?
	- Wrench tried to give Bob 2 coins, but he already had 4, so we deposited 2 coins in the Hapless Heroes crew vault.
	- Wrench tried to give Bob 2 coins, but he already had 4. We tried to deposit 2 coins in the Hapless Heroes crew vault, but it was full. We deposited 2 coins in Bob's stash.
	- Wrench tried to give you 2 coins, but your coin purse, crew vault, and stash were all full.
	- Wrench gave you 2 coins.

TODO: Auto-DT-dispenser & log cleanups

+dt/+downtime
	+dt/recover <#>
	+dt/feed
	+dt/heat
	+dt/indulge or +dt/vice
	+dt/train <track>
	+dt/buy <#> - spend <#> coin to buy <#> downtime
	+dt/award <player>=<reason> (staff-only)
	+dt/award <player>=<#> <reason> (staff-only)
+health
	+harm <injury>
	+harm <#> <injury>
+stress/+trauma
	+stress/gain
	+stress/gain <#>
	+stress/clear
	+trauma/add <trauma>
+coin
* +coin/stash <#> - stash some of your coins
* +coin/unstash <#> - withdraw from your stash
*	+coin/withdraw <#> - withdraw coin from your crew's vault
*	+coin/deposit <#> - deposit coin into your crew's vault
	+coin/pay <name>=<#> - pay coin to another player
	+coin/award <player>=<#> <reason> (staff-only)
+heat
	+heat/gain
	+heat/gain <#>
+rep
	+rep/award <player>=<#> <reason>

*/
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Daily
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.cg)]=@dolist search(EPLAYER=t(lattr(##/_downtime-*)))={ @trigger me/tr.clean-old-downtimes=##; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.downtime [v(d.cgf)]=strcat(header(ulocal(f.get-name, %0, %1)'s downtime, %1), %r, formattext(strcat(Available:, %b, ulocal(f.get-player-stat-or-zero, %0, downtime), %r, Gaining:, %b, ulocal(f.get-player-downtime-per-week, %0), %b, per week, %b, +, %b, ulocal(f.get-player-downtime-per-score, %0), %b, per score, %r%r, Spend a downtime to:, %r%t, +dt/heat - reduce your crew's Heat, if(setr(S, not(ulocal(f.is_expert, %0))), strcat(%r%t, +dt/indulge - indulge your Vice and recover Stress)), %r%t, if(strmatch(ulocal(f.get-player-stat, %0, Playbook), Vampire), +dt/feed - feed to recover from Harm, strcat(+dt/recover <#> - roll <#> to recover from Harm, %r%t)), if(t(%qS), strcat(+dt/train <track> - train in an XP track (gains 1 XP), %r%t)), Acquire an Asset - open a job to do this, %r%t, Make progress on a long term project - open a job to do this), 0, %1), setq(L, ulocal(f.get-last-X-logs, %0, _downtime-)), if(t(%qL), strcat(%r, divider(Last 10 downtimes, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&layout.player-coin [v(d.cgf)]=strcat(ulocal(layout.coin, %0, %1), %r, ulocal(layout.crew-coin, ulocal(f.get-player-stat, %0, crew object), %1), setq(L, ulocal(f.get-last-X-logs, %0, _coin-)), if(t(%qL), strcat(%r, divider(Last 10 coin logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

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

&tr.clean-old-downtimes [v(d.cg)]=@eval setq(L, lattr(%0/_downtime-*)); @eval setq(L, setdiff(%qL, extract(revwords(%qL), 1, 20))) @assert t(%qL); @dolist %qL={ @assert gt(sub(secs(), unprettytime(extract(xget(%0, ##), 1, 2))), 604800); @wipe %0/##; };

&c.+dt/award [v(d.cg)]=$+dt/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isnum(first(%1)), first(%1), ulocal(f.get-player-downtime-per-score, %qP))); @eval strcat(setq(R, if(isnum(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this downtime was.; }; @assert cand(gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @set %qP=[setr(L, ulocal(f.get-stat-location-on-player, downtime))]:[add(xget(%qP, %qL), %qV)]; @trigger me/tr.log-downtime=%qP, %#, Awarded %qV downtime for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You award, ulocal(f.get-name, %qP, %#), %qV, downtime for '%qR'.), ulocal(f.get-name, %#, %qP) awards you %qV downtime for '%qR'., %qP, %#, Downtime;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Buying downtime
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt/buy [v(d.cg)]=$+dt/buy*: @eval setq(V, switch(%0, %b*, trim(%0), * *, rest(%0), 1)); @assert cand(isnum(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(C, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qC coin%, not enough to buy %qV downtime.; }; @set %#=[setr(L, ulocal(f.get-stat-location-on-player, downtime))]:[add(xget(%#, %qL), %qV)]; @set %#=[ulocal(f.get-stat-location-on-player, coin)]:[sub(%qC, %qV)]; @trigger me/tr.log-downtime=%#, %#, Bought %qV downtime with coin.; @trigger me/tr.log=%#, _coin-, %#, Spent %qV coin on downtime.; @trigger me/tr.success=%#, You buy %qV downtime for %qV coin. You now have [ulocal(f.get-player-stat, %#, downtime)] downtime and [ulocal(f.get-player-stat-or-zero, %#, coin)] coin.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Healing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.heal [v(d.cgf)]=squish(strcat(alert(Downtime), %b, ulocal(f.get-name, %0) spends 1 downtime to recover%, rolling %3 dice and getting, %b, %4., %b, capstr(subj(%0)), %b, plural(%0, adds, add) %ch%1%cn ticks to, %b, poss(%0), %b, healing clock%,, if(t(%2), cat(, removing, itemize(%ch%2%cn, |), and)), %b, setting the clock to, %b, default(%0/_health-clock, 0)/, ulocal(f.get-max-healing-clock, %0), ., %b, ulocal(layout.health-status, %0, %1, %2)))

&layout.feed [v(d.cgf)]=squish(strcat(alert(Downtime), %b, ulocal(f.get-name, %0) spends 1 downtime to feed%, adding %ch%1%cn ticks to, %b, poss(%0), %b, healing clock%,, if(t(%2), cat(, removing, itemize(%ch%2%cn, |), and)), %b, setting the clock to, %b, default(%0/_health-clock, 0)/, ulocal(f.get-max-healing-clock, %0), ., %b, ulocal(layout.health-status, %0, %1, %2)))

&c.+dt/recover [v(d.cg)]=$+dt/r*:@assert not(strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire))={ @trigger me/tr.error=%#, Vampires can't recover - they must %ch+dt/feed%cn instead.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Recovery costs one downtime%, and you don't have any left.; }; @eval setq(R, if(t(strlen(rest(%0))), trim(rest(%0)), 1)); @assert isnum(%qR)={ @trigger me/tr.error=%#, '%qR' must be a number.; }; @assert cand(gte(%qR, 0), lte(%qR, 10))={ @trigger me/tr.error=%#, %qR must be a number between 0 and 10.; }; @eval setq(L, ulocal(f.roll-to-heal, %qR)); @eval strcat(setq(E, first(%qL, |)), setq(L, rest(%qL, |))); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, The roll must return 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot recover.; }; @assert t(ulocal(f.get-harm-field, %#, 1))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences. You must open a job with staff to recover.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @eval setq(M, ulocal(f.get-max-healing-clock, %#)); @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), %qM)]; @eval setq(O, xget(%#, _health-1-1)); @eval setq(H, iter(extract(%qF, 1, div(%qT, %qM)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(setr(I, _health-1-1 _health-1-2 _health-2-1 _health-2-2 _health-3 _health-4), set(%#, strcat(itext(0), :, xget(%#, extract(%qI, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, if(not(strmatch(%qO, xget(%#, _health-1-1))), %qO), %qR, %qE), %#; @trigger me/tr.log-downtime=%#, %#, Spent 1 downtime to recover%, rolling %qE and adding %qL ticks to the healing clock.;

&c.+dt/feed [v(d.cg)]=$+dt/f*:@assert strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire)={ @trigger me/tr.error=%#, Non-vampires can't feed - they must %ch+dt/recover <#>%cn instead.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Feeding costs one downtime%, and you don't have any left.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot feed to heal.; }; @assert t(ulocal(f.get-harm-field, %#, 1))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences. You must open a job with staff to recover.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @eval setq(M, ulocal(f.get-max-healing-clock, %#)); @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), 4)), %qM)]; @eval setq(O, xget(%#, _health-1-1)); @eval setq(H, iter(extract(%qF, 1, div(%qT, %qM)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(setr(L, _health-1-1 _health-1-2 _health-2-1 _health-2-2 _health-3 _health-4), set(%#, strcat(itext(0), :, xget(%#, extract(%qL, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.feed, %#, 4, if(not(strmatch(%qO, xget(%#, _health-1-1))), %qO), %qR, %qE), %#; @trigger me/tr.log-downtime=%#, %#, Spent 1 downtime to feed%, adding 4 ticks to the healing clock.;

&c.+dt/heal [v(d.cg)]=$+dt/heal *:@force %#=+dt/recover %0;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stress commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.gain-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), gains %1 stress%, bringing, poss(%0), total to %2/%3., if(eq(%2, %3), cat(capstr(subj(%0)), plural(%0, is, are), out of the scene and must take a trauma before, subj(%0), can return to play.)))

&layout.reduce-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), spends 1 downtime to indulge, poss(%0), vice%, rolling %1 dice and getting %2., capstr(subj(%0)), plural(%0, recovers, recover), %3 stress%, bringing, poss(%0), total to %4/%5., if(t(%6), cat(capstr(subj(%0)), plural(%0, has, have) overindulged and a job has been opened with staff to handle the consequences of this overindulgence.)))

&layout.overindulge-job [v(d.cgf)]=cat(ulocal(f.get-name, %0), overindulged, poss(%0), vice of, ulocal(f.get-player-stat, %0, vice), by, %1, points.%R%R%TWhen you overindulge%, you make a bad call because of your vice - in acquiring it or while under its influence. To bring the effect of this bad decision into the game%, select an overindulgence from the list:%R%R%T- Attract Trouble. Select or roll an additional entanglement.%R%T- Brag about your exploits. +2 heat for your crew.%R%T- Lost. Your character vanishes for a few weeks. Play a different character until this one returns from their bender. When your character returns%, they've also healed any harm they had.%R%T- Tapped. Your current purveyor cuts you off. Find a new source for your vice.%R)

&layout.clear-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), clears a stress%, bringing, poss(%0), total to %1/%2.)

&c.+stress/gain_1 [v(d.cg)]=$+stress/gain:@force %#=+stress/gain 1;

&c.+stress/gain [v(d.cg)]=$+stress/gain *: @eval setq(M, ulocal(f.get-max-stress, %#)); @assert cand(isnum(%0), gt(%0, 0), lte(%0, %qM))={ @trigger me/tr.error=%#, '%0' must be a number between 1 and %qM.; }; @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @assert lte(setr(N, add(%qC, %0)), %qM)={ @trigger me/tr.error=%#, You have [sub(%qM, %qC)] stress remaining. %0 is too high.; }; @assert cor(lt(%qN, %qM), gettimer(%#, stress-limit, %0))={ @eval settimer(%#, stress-limit, 600, %0); @trigger me/tr.message=%#, Taking this stress would put you at your maximum of %qM stress. You will immediately be out of the scene and will have to take a trauma before you can return to play. Are you sure you want to take this stress? Hit %ch+stress/gain %0%cn within the next 10 minutes to confirm. The time is now [prettytime()].; }; @set %#=[ulocal(f.get-stat-location-on-player, stress)]:%qN; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.gain-stress, %#, %0, %qN, %qM), %#; @assert neq(%qN, %qM)={ @set %#=[ulocal(f.get-stat-location-on-player, needs trauma)]:1; };

&c.+stress/clear [v(d.cg)]=$+stress/clear: @eval setq(M, ulocal(f.get-max-stress, %#)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @assert gte(setr(N, dec(%qC)), 0)={ @trigger me/tr.error=%#, You have no stress to clear.; }; @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @set %#=[ulocal(f.get-stat-location-on-player, stress)]:%qN; @trigger me/tr.remit-or-pemit=%L, setr(A, ulocal(layout.clear-stress, %#, %qN, %qM)), %#; @cemit [xget(%vD, d.monitor-channel)]=%qA; @assert not(eq(%qC, %qM))={ @wipe %#/[ulocal(f.get-stat-location-on-player, needs trauma)]; };

&c.+trauma/add [v(d.cg)]=$+trauma/add *: @assert cor(t(ulocal(f.get-player-stat, %#, needs trauma)), cand(strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire), lt(words(ulocal(f.get-player-stat, %#, traumas), |), ulocal(f.get-max-trauma, %#))))={ @trigger me/tr.error=%#, You can't take a trauma yet. Go earn more stress!; }; @assert t(setr(T, finditem(setr(L, setdiff(xget(%vD, d.value.traumas), setr(U, ulocal(f.get-player-stat, %#, traumas)), |, |)), %0, |)))={ @trigger me/tr.error=%#, Could not find a trauma starting with '%0'. Available traumas are [ulocal(layout.list, %qL)].; }; @wipe %#/[ulocal(f.get-stat-location-on-player, needs trauma)]; @set %#=[ulocal(f.get-stat-location-on-player, Traumas)]:[trim(strcat(%qU, |, %qT), |, b)]; @set %#=[ulocal(f.get-stat-location-on-player, Stress)]:0; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, Traumas, %qT, %#, %#), ulocal(layout.staff-add-alert, Traumas, %qT, %#, %#), %#, %#, Traumas; @trigger me/tr.remit-or-pemit=%l, cat(alert(Trauma), ulocal(f.get-name, %#) takes a trauma and resets, poss(%#), stress level to 0.), %#;

&c.+dt/vice [v(d.cg)]=$+dt/vice:@force %#=+dt/indulge;

&c.+dt/indulge [v(d.cg)]=$+dt/indulge:@assert not(ulocal(f.is_expert, %#))={ @trigger me/tr.error=%#, You're an expert%, so you can't indulge your vice.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Indulging your Vice costs one downtime%, and you don't have any left.; }; @eval setq(M, ulocal(f.get-max-stress, %#)); @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @assert gt(%qC, 0)={ @trigger me/tr.error=%#, You currently don't have any stress to reduce.; }; @eval setq(L, ulocal(f.roll-to-indulge, setr(A, ulocal(f.get-lowest-attribute, %#)))); @eval strcat(setq(E, first(%qL, |)), setq(L, rest(%qL, |))); @set %#=[ulocal(f.get-stat-location-on-player, Stress)]:[if(lte(%qL, %qC), sub(%qC, %qL), 0)]; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.reduce-stress, %#, %qA, %qE, %qL, if(lte(%qL, %qC), sub(%qC, %qL), 0), %qM, gt(%qL, %qC)), %#; @trigger me/tr.log-downtime=%#, %#, cat(Rolled %qA to indulge vice%, getting %qE and reducing stress by %qL to, if(lte(%qL, %qC), sub(%qC, %qL), 0)/%qM., if(gt(%qL, %qC), You overindulged.)); @assert lte(%qL, %qC)={ @trigger %vA/trig_create=%#, xget(%vD, d.downtime-bucket), 1, cat(Overindulgence:, ulocal(f.get-name, %#)), ulocal(layout.overindulge-job, %#, sub(%qL, %qC)); };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Heat
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.gain-heat [v(d.cgf)]=cat(alert(Heat), ulocal(f.get-name, %0), gains %1 heat for, poss(%0), crew., Their total heat is now %2/9 and they have, ansi(case(%3, 4, hr, 3, hr, 2, hy, 1, hy, hg), %3), Wanted Levels.)

&layout.reduce-heat [v(d.cgf)]=cat(alert(Heat), ulocal(f.get-name, %0), spends 1 downtime and reduces the heat for, poss(%0), crew., The crew's total heat is now %1/9 and they have, ansi(case(%2, 4, hr, 3, hr, 2, hy, 1, hy, hg), %2), Wanted Levels.)

&c.+heat/gain_1 [v(d.cg)]=$+heat/gain:@force %#=+heat/gain 1;

&c.+heat/gain [v(d.cg)]=$+heat/gain *:@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't gain heat.; }; @assert cand(isnum(%0), gt(%0, 0), lte(%0, 9))={ @trigger me/tr.error=%#, '%0' must be a number between 1 and 9.; }; @eval setq(T, ulocal(f.get-player-stat-or-zero, %qC, Wanted Level)); @eval setq(O, ulocal(f.get-player-stat, %qC, Heat)); @assert lt(%qT, 4)={ @trigger me/tr.error=%#, You have reached your limit for all heat and wanted levels.; }; @assert lte(setr(N, add(%qO, %0)), 9)={ @trigger me/tr.error=%#, You have [sub(9, %qO)] heat remaining. %0 is too high.; }; @assert cor(lt(%qN, 9), gettimer(%#, heat-limit, %0))={ @eval settimer(%#, heat-limit, 600, %0); @trigger me/tr.message=%#, Taking this heat would clear your crew's heat%, but would give your crew a Wanted Level. Wanted Levels increase the danger of future scores. Are you sure you want to take this heat? Hit %ch+heat/gain %0%cn within the next 10 minutes to confirm. The time is now [prettytime()].; }; @eval strcat(setq(T, if(eq(%qN, 9), inc(%qT), %qT)), setq(N, if(eq(%qN, 9), 0, %qN))); @set %qC=[ulocal(f.get-stat-location-on-player, heat)]:%qN; @set %qC=[ulocal(f.get-stat-location-on-player, Wanted Level)]:%qT; @trigger me/tr.remit-or-pemit=%L, setr(M, ulocal(layout.gain-heat, %#, %0, %qN, %qT)), %#; @trigger me/tr.crew-emit=%qC, %qM;

&c.+dt/heat [v(d.cg)]=$+dt/heat:@assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Reducing your crew's Heat costs one downtime%, and you don't have any left.; }; @assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't reduce heat.; }; @assert gt(setr(F, ulocal(f.get-player-stat-or-zero, %qC, Heat)), 0)={ @trigger me/tr.error=%#, Your crew doesn't currently have any heat to reduce.; }; @set %qC=[ulocal(f.get-stat-location-on-player, heat)]:[dec(%qF)]; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @trigger me/tr.remit-or-pemit=%L, setr(M, ulocal(layout.reduce-heat, %#, dec(%qF), ulocal(f.get-player-stat-or-zero, %qC, Wanted Level))), %#; @trigger me/tr.crew-emit=%qC, %qM; @trigger me/tr.log-downtime=%#, %#, Reduced crew heat by 1.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Training
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt/train [v(d.cg)]=$+dt/train *:@assert not(ulocal(f.is_expert, %#))={ @trigger me/tr.error=%#, You're an expert%, so you can't train.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Training costs one downtime%, and you don't have any left.; }; @assert t(setr(T, finditem(setr(L, xget(%vD, d.xp_tracks)), %0, |)))={ @trigger me/tr.error=%#, '%0' is not a valid XP track. Valid tracks are [ulocal(layout.list, %qL)].; }; @assert not(gettimer(%#, train_%qT))={ @trigger me/tr.error=%#, You last trained your %qT less than a week ago. Wait until the timer expires to train %qT again. The timer will expire in [getremainingtime(%#, train_%qT)].; }; @eval settimer(%#, train_%qT, 604800); @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @trigger me/tr.increase-track=%qT, if(ulocal(f.has-list-stat, ulocal(f.get-player-stat, crew object), Upgrades, %qT), 2, 1), %#, %#, add, Spent downtime; @trigger me/tr.log-downtime=%#, %#, Trained %qT.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Reputation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.crew-rep [v(d.cgf)]=strcat(header(Crew Reputation, %1), %r, ulocal(layout.crew-rep-line, %0), setq(L, ulocal(f.get-last-X-logs, %0, _rep-, 10)), if(t(%qL), strcat(%r, divider(Last 10 Reputation logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&c.+rep [v(d.cg)]=$+rep:@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You aren't on a crew%, so you don't have a real rep.; }; @pemit %#=ulocal(layout.crew-rep, %qC, %#);

&c.+rep_staff [v(d.cg)]=$+rep *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; };@assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, cat(ulocal(f.get-name, %qP), isn't on a crew%, so, subj(%qP), plural(%qP, doesn't, don't) have a real rep.); }; @pemit %#=ulocal(layout.crew-rep, %qC, %#);

&c.+rep/award [v(d.cg)]=$+rep/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP) is not part of a crew and cannot gain rep.; }; @eval setq(V, if(isnum(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isnum(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this downtime was.; }; @eval setq(M, sub(ulocal(f.get-max-rep, %qC), setr(A, ulocal(f.get-player-stat, %qC, Rep)))); @assert t(%qM)={ @trigger me/tr.error=%#, This crew cannot receive any more rep - they need to buy up their Tier!; };  @assert cand(gt(%qV, 0), lte(%qV, %qM))={ @trigger me/tr.error=%#, %qV must be a number between 1 and %qM.; }; @set %qC=[ulocal(f.get-stat-location-on-player, rep)]:[add(%qA, %qV)]; @trigger me/tr.log=%qP, _rep-, %#, Awarded %qV rep for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You award, ulocal(f.get-name, %qP, %#), %qV, rep for '%qR'.), ulocal(f.get-name, %#, %qP) awards you %qV rep for '%qR'., %qP, %#, Rep; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) awards the crew +%qV rep for '%qR'.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Award Coin
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.coin-log [v(d.cgf)]=strcat(Awarded %0 coin for '%1'., if(t(%2), %b%2 coin overflowed into the crew vault.), if(t(%3), %b%3 coin overflowed into the stash.))

&layout.coin-awarded [v(d.cgf)]=cat(You award, ulocal(f.get-name, %0), %1, coin for '%2'., if(t(%3), %3 coin overflowed into the crew vault.), if(t(%4), %b%4 coin overflowed into the stash.))

&layout.coin-received [v(d.cgf)]=cat(ulocal(f.get-name, %0), awards you, %1, coin for '%2'., if(t(%3), %3 coin overflowed into the crew vault.), if(t(%4), %b%4 coin overflowed into your stash.))

&layout.coin-crew-overflow [v(d.cgf)]=cat(ulocal(f.get-name, %0), awards, ulocal(f.get-name, %1), %2 coin%, and %3 of, poss(%1), coin overflowed into the crew's coffers.)

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
&c.+coin/award [v(d.cg)]=$+coin/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isnum(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isnum(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this coin was.; }; @eval setq(M, ulocal(f.get-player-stat, %qP, Coin)); @eval setq(C, ulocal(f.get-player-stat, %qP, crew object)); @eval setq(X, if(t(%qC), ulocal(f.get-vault-max, %qC), 0)); @eval setq(Y, ulocal(f.get-player-stat-or-zero, %qC, crew coin)); @eval setq(S, ulocal(f.get-player-stat-or-zero, %qP, Stash)); @eval setq(A, %qV); @eval if(lte(add(%qM, %qA), 4), strcat(setq(D, add(%qM, %qA)), setq(E, 0), setq(F, 0), setq(A, 0)), strcat(setq(D, 4), setq(A, sub(%qA, sub(4, %qM))), if(lte(add(%qY, %qA), %qX), strcat(setq(E, add(%qY, %qA)), setq(F, 0), setq(A, 0)), strcat(setq(E, %qX), setq(A, sub(%qA, sub(%qX, %qY))), if(lte(add(%qS, %qA), 40), strcat(setq(F, add(%qS, %qA)), setq(A, 0)), strcat(setq(F, 40), setq(A, sub(%qA, sub(40, %qS))))))))); @assert eq(%qA, 0)={ @trigger me/tr.error=%#, Could not distribute %qV coin without %qA extra coin being lost. Please choose a lower number of coin.; }; @set %qP=[ulocal(f.get-stat-location-on-player, Coin)]:%qD; @set %qC=ulocal(f.get-stat-location-on-player, Crew Coin):%qE; @set %qP=[ulocal(f.get-stat-location-on-player, Stash)]:%qF; @trigger me/tr.log=%qP, _coin-, %#, ulocal(layout.coin-log, %qV, %qR, %qE, %qF); @trigger me/tr.stat-setting-messages=ulocal(layout.coin-awarded, %qP, %qV, %qR, %qE, %qF), ulocal(layout.coin-received, %#, %qV, %qR, %qE, %qF), %qP, %#, Coin; @if t(%qE)={ @trigger me/tr.crew-emit=%qC, ulocal(layout.coin-crew-overflow, %#, %qP, %qV, %qE); };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Paying coin to other players
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.coin-paid [v(d.cgf)]=cat(You pay, ulocal(f.get-name, %0, %1), %2 coin for '%3'. You now have %4 coin.)

&layout.coin-paid-received [v(d.cgf)]=cat(ulocal(f.get-name, %0, %1), pays you, %2 coin for '%3'. You now have %4 coin.)

&c.+coin/pay [v(d.cg)]=$+coin/pay *=*: @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(isapproved(%#), isapproved(%qP))={ @trigger me/tr.error=%#, You and your payee must be approved before you can give them coin.; }; @eval setq(V, if(isnum(first(%1)), first(%1), 0)); @assert not(strmatch(%#, %qP))={ @trigger me/tr.error=%#, You cannot pay yourself coin.; }; @eval strcat(setq(R, if(isnum(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for paying this coin was.; }; @assert cand(isnum(%qV), gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @assert gte(setr(C, ulocal(f.get-player-stat-or-zero, %#, coin)), %qV)={ @trigger me/tr.error=%#, You have %qC coin%, not enough to pay [ulocal(f.get-name, %qP, %#)] %qV.; }; @assert lte(add(setr(D, ulocal(f.get-player-stat-or-zero, %qP, coin)), %qV), 4)={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) can't receive %qV coin%, it won't fit in [poss(%qP)] pockets.; }; @eval setq(L, ulocal(f.get-stat-location-on-player, coin)); @set %qP=%qL:[add(%qD, %qV)]; @set %#=%qL:[sub(%qC, %qV)]; @trigger me/tr.log=%#, _coin-, %#, setr(M, Paid [ulocal(f.get-name, %qP, %#)] %qV coin for '%qR'.); @trigger me/tr.log=%qP, _coin-, %#, %qM; @trigger me/tr.stat-setting-messages=ulocal(layout.coin-paid, %qP, %#, %qV, %qR, ulocal(f.get-player-stat-or-zero, %#, coin)), ulocal(layout.coin-paid-received, %#, %qP, %qV, %qR, ulocal(f.get-player-stat-or-zero, %qP, coin)), %qP, %#, Coin; @cemit [xget(%vD, d.monitor-channel)]=[cat(prettytime(), ulocal(f.get-name, %#):, Paid, ulocal(f.get-name, %qP), %qV coin for '%qR'.)];
