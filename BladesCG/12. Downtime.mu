/*

* You get one Downtime action per week automatically just for being an approved non-frozen character.
* You can accumulate as many Downtime actions as you want and spend them without restriction - you're basically saying you spent them in the past, flashbacks are an established part of the game, no need for wait times here.
* You get two Downtime actions per score.
* If your crew has All Hands, ALL PC Experts get one extra Downtime per week, and every Score the crew goes on, an NPC cohort can take a Downtime action that gets handled in the end-of-Score +request.  The PC experts can spend it any way they like, the NPC experts follow the rules for the special ability (only works for Acquire an Asset, reduce HEAT, or long-term project).
* You can buy a Downtime by spending 1 Coin.

+Downtime needs to be able to:

* Reduce Crew heat.
* Reduce PC stress via Vice indulgence.  Including possible overindulgence.
* Recover from Harm.
* Train in an XP track.

That's probably all we actually need CODE for, others will be +request-based.

Other systems that need or could use code that I'm thinking of:

* Heat: gaining unrestricted, losing usually just with Downtimes or +request.
* Stress: gaining unrestricted, losing usually just with Downtimes, but sometimes with Criticals on resistance.
* Harm: gaining unrestricted, losing with Downtimes.  Warning before taking level 4 harm, generate an automatic job to discuss permanent consequences or death with the player if they do take level 4 harm.  Warning before taking level 3 harm that will upgrade to level 4 harm.

TODO: Auto-gain of downtime - cronjob? @daily?

We have two kinds of coin, crew coin and personal coin. Both can be converted into downtime for a player at 1:1.

+coin - show you what you got (and how much your crew has), basically just a tiny @pemit.

+heat - show you what your crew's heat is at. Tiny @pemit.

+stress - show you what your stress is at. Tiny @pemit.

+downtime/+dt: show what you got and what you can use it for.

+cdt - cohort downtime (only applicable to crews with the All Hands ability) - might not code this

+coin/withdraw <#>=<reason> - withdraw from your crew's coin stash. Players can only carry a max of 4 coins at once.

+coin/deposit <#> - deposit your personal coin into the crew's stash. Crews can only hold 4 coins at once, or 8 if they have Vault, or 16 if they have Vault 2.

+coin/deposit <player>=<#> - lets staff deposit brand new coin into a crew's bank? Might not code this...

+coin/award <player>=<#> - give a player coin. If a receiving player is already at full, overflow into Crew, then into Stash. Max coin to be given at once?
	- Wrench tried to give Bob 2 coins, but he already had 4, so we deposited 2 coins in the Hapless Heroes crew vault.
	- Wrench tried to give Bob 2 coins, but he already had 4. We tried to deposit 2 coins in the Hapless Heroes crew vault, but it was full. We deposited 2 coins in Bob's stash.
	- Wrench tried to give you 2 coins, but your coin purse, crew vault, and stash were all full.
	- Wrench gave you 2 coins.

TODO: Consider /massaward flag for +dt and +coin.

+dt/award <player>=<#> - give player downtime actions.

+heat/gain - let a player gain one heat for their crew. Must roll over into wanted levels!

+heat/gain <#> - let a player gain <#> heat for their crew

+stress/gain <#> - spend <#> stress - emits that you have spent the stress.

+stress/gain <#>=<reason> - spend <#> stress for <reason> - will emit the reason.

+stress/clear - allow players who clear a stress from a crit to actually regain it. Emits to the monitor channel and the room.

+dt/+downtime
	+dt/recover <#>
	+dt/feed
*	+dt/buy <#> - spend <#> coin to buy downtime
*	+dt/heat
*	+dt/indulge
*	+dt/train <track>
	+dt/award <player>=<reason> (staff-only)
	+dt/award <player>=<#> <reason> (staff-only)
*+cdt
*	+cdt/heat
+health
	+harm <injury>
	+harm <#> <injury>
+stress
	+stress/gain
	+stress/gain <#>
	+stress/clear
+coin
*	+coin/award <player>=<#> <reason>
*	+coin/withdraw <#> - withdraw coin from your crew's vault
*	+coin/deposit <#> - deposit coin into your crew's vault
+heat
	+heat/gain
	+heat/gain <#>
+rep
*	+rep/award <player>=<#> <reason>

*/
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Daily
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.cg)]=@dolist search(EPLAYER=t(lattr(##/_downtime-*)))={ @trigger me/tr.clean-old-downtimes=##; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.downtime [v(d.cgf)]=strcat(header(ulocal(f.get-name, %0, %1)'s downtime, %1), %r, formattext(strcat(Available:, %b, ulocal(f.get-player-stat-or-zero, %0, downtime), %r, Gaining:, %b, ulocal(f.get-player-downtime-per-week, %0), /week, %b, +, %b, ulocal(f.get-player-downtime-per-score, %0), %b, per score, %r%r, Spend a downtime to:, %r%t, +dt/heat - reduce your crew's Heat, %r%t, +dt/indulge - indulge your Vice and recover Stress, %r%t, if(strmatch(ulocal(f.get-player-stat, %0, Playbook), Vampire), +dt/feed - feed to recover from your injuries, +dt/recover <#> - roll <#> to recover from Harm), %r%t, +dt/train <track> - train in an XP track (gains 1 XP), %r%t, Acquire an Asset - open a job to do this, %r%t, Make progress on a long term project - open a job to do this), 0, %1), setq(L, ulocal(f.get-last-X-logs, %0, _downtime-)), if(t(%qL), strcat(%r, divider(Last 10 downtimes, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&layout.heal [v(d.cgf)]=squish(strcat(alert(Downtime), %b, ulocal(f.get-name, %0) spends 1 downtime to recover%, rolling %3 dice and getting, %b, %4., %b, capstr(subj(%0)), %b, plural(%0, adds, add) %ch%1%cn ticks to, %b, poss(%0), %b, healing clock%,, if(t(%2), cat(, removing, itemize(%ch%2%cn, |), and)), %b, setting the clock to, %b, default(%0/_health-clock, 0)/, ulocal(f.get-max-healing-clock, %0), ., %b, ulocal(layout.health-status, %0, %1, %2)))

&layout.feed [v(d.cgf)]=squish(strcat(alert(Downtime), %b, ulocal(f.get-name, %0) spends 1 downtime to feed%, adding %ch%1%cn ticks to, %b, poss(%0), %b, healing clock%,, if(t(%2), cat(, removing, itemize(%ch%2%cn, |), and)), %b, setting the clock to, %b, default(%0/_health-clock, 0)/, ulocal(f.get-max-healing-clock, %0), ., %b, ulocal(layout.health-status, %0, %1, %2)))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ View Commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt [v(d.cg)]=$+dt:@pemit %#=ulocal(layout.downtime, %#, %#);

&c.+downtime [v(d.cg)]=$+downtime:@force %#=+dt;

&c.+dt_staff [v(d.cg)]=$+dt *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.downtime, %qP, %#);

&c.+downtime_staff [v(d.cg)]=$+downtime *:@force %#=+dt %0;

&c.+coin [v(d.cg)]=$+coin: @pemit %#=strcat(ulocal(layout.coin, %#, %#), ulocal(layout.crew-coin, %#, %#), %r, footer(, %#));

&c.+coin_staff [v(d.cg)]=$+coin *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=strcat(ulocal(layout.coin, %qP, %#), ulocal(layout.crew-coin, %qP, %#), %r, footer(, %#));

&c.+heat [v(d.cg)]=$+heat: @pemit %#=ulocal(layout.subsection, crew-heat, %#, %#);

&c.+heat_staff [v(d.cg)]=$+heat *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.subsection, crew-heat, %qP, %#);

&c.+stress [v(d.cg)]=$+stress: @pemit %#=ulocal(layout.subsection, stress, %#, %#);

&c.+stress_staff [v(d.cg)]=$+stress *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.subsection, stress, %qP, %#);

&c.+trauma [v(d.cg)]=$+trauma:@force %#=+stress

&c.+trauma_staff [v(d.cg)]=$+trauma *:@force %#=+stress %0

&c.+rep [v(d.cg)]=$+rep: @pemit %#=ulocal(layout.subsection, crew-rep, %#, %#);

&c.+rep_staff [v(d.cg)]=$+rep *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.subsection, crew-rep, %qP, %#);


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Modify commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&tr.log-downtime [v(d.cg)]=@trigger me/tr.log=%0, _downtime-, %1, %2;

&tr.clean-old-downtimes [v(d.cg)]=@eval setq(L, lattr(%0/_downtime-*)); @eval setq(L, setdiff(%qL, extract(revwords(%qL), 1, 20))) @assert t(%qL); @dolist %qL={ @assert gt(sub(secs(), unprettytime(extract(xget(%0, ##), 1, 2))), 604800); @wipe %0/##; };

&c.+dt/award [v(d.cg)]=$+dt/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isnum(first(%1)), first(%1), ulocal(f.get-player-downtime-per-score, %qP))); @eval strcat(setq(R, if(isnum(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting this downtime was.; }; @assert cand(gt(%qV, 0), lte(%qV, 10))={ @trigger me/tr.error=%#, %qV must be a number between 1 and 10.; }; @set %qP=[setr(L, ulocal(f.get-stat-location-on-player, downtime))]:[add(xget(%qP, %qL), %qV)]; @trigger me/tr.log-downtime=%qP, %#, Awarded %qV downtime for '%qR'.; @trigger me/tr.stat-setting-messages=cat(You award, ulocal(f.get-name, %qP, %#), %qV, downtime for '%qR'.), ulocal(f.get-name, %#, %qP) awards you %qV downtime for '%qR'., %qP, %#, Downtime;

@@ &c.+dt/log [v(d.cg)]=$+dt/log *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to modify a player's stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @trigger me/tr.log-downtime=%qP, %#, Note: %1; @trigger me/tr.stat-setting-messages=cat(You add the following note to, ulocal(f.get-name, %qP, %#)'s, downtime log:, %1), cat(ulocal(f.get-name, %#, %qP) adds the following note to your downtime log:, %1), %qP, %#, Downtime;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Healing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+dt/recover [v(d.cg)]=$+dt/r*:@assert not(strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire))={ @trigger me/tr.error=%#, Vampires can't recover - they must %ch+dt/feed%cn instead.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Recovery costs one downtime%, and you don't have any left.; }; @eval setq(R, if(t(strlen(rest(%0))), trim(rest(%0)), 1)); @assert isnum(%qR)={ @trigger me/tr.error=%#, '%qR' must be a number.; }; @assert cand(gte(%qR, 0), lte(%qR, 10))={ @trigger me/tr.error=%#, %qR must be a number between 0 and 10.; }; @eval setq(L, ulocal(f.roll-to-heal, %qR)); @eval strcat(setq(E, first(%qL, |)), setq(L, rest(%qL, |))); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, The roll must return 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot recover.; }; @assert t(ulocal(f.get-harm-field, %#, 1))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences. You must open a job with staff to recover.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @eval setq(M, ulocal(f.get-max-healing-clock, %#)); @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), %qM)]; @eval setq(O, xget(%#, _health-1-1)); @eval setq(H, iter(extract(%qF, 1, div(%qT, %qM)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(setr(I, _health-1-1 _health-1-2 _health-2-1 _health-2-2 _health-3 _health-4), set(%#, strcat(itext(0), :, xget(%#, extract(%qI, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, if(not(strmatch(%qO, xget(%#, _health-1-1))), %qO), %qR, %qE), %#; @trigger me/tr.log-downtime=%#, %#, Spent 1 downtime to recover%, rolling %qE and adding %qL ticks to the healing clock.;

&c.+dt/feed [v(d.cg)]=$+dt/f*:@assert strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire)={ @trigger me/tr.error=%#, Non-vampires can't feed - they must %ch+dt/recover <#>%cn instead.; }; @assert gt(setr(D, ulocal(f.get-player-stat, %#, downtime)), 0)={ @trigger me/tr.error=%#, Feeding costs one downtime%, and you don't have any left.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot feed to heal.; }; @assert t(ulocal(f.get-harm-field, %#, 1))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences. You must open a job with staff to recover.; }; @set %#=[ulocal(f.get-stat-location-on-player, downtime)]:[dec(%qD)]; @eval setq(M, ulocal(f.get-max-healing-clock, %#)); @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), 4)), %qM)]; @eval setq(O, xget(%#, _health-1-1)); @eval setq(H, iter(extract(%qF, 1, div(%qT, %qM)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(setr(L, _health-1-1 _health-1-2 _health-2-1 _health-2-2 _health-3 _health-4), set(%#, strcat(itext(0), :, xget(%#, extract(%qL, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.feed, %#, 4, if(not(strmatch(%qO, xget(%#, _health-1-1))), %qO), %qR, %qE), %#; @trigger me/tr.log-downtime=%#, %#, Spent 1 downtime to feed%, adding 4 ticks to the healing clock.;

&c.+dt/heal [v(d.cg)]=$+dt/heal *:@force %#=+dt/recover %0;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stress commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.gain-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), gains %1 stress%, bringing, poss(%0), total to %2/%3., if(eq(%2, %3), cat(capstr(subj(%0)), plural(%0, is, are), out of the scene and must take a trauma before, subj(%0), can return to play.)))

&layout.clear-stress [v(d.cgf)]=cat(alert(Stress), ulocal(f.get-name, %0), clears a stress%, bringing, poss(%0), total to %1/%2.)

&c.+stress/gain_1 [v(d.cg)]=$+stress/gain:@force %#=+stress/gain 1;

&c.+stress/gain [v(d.cg)]=$+stress/gain *: @eval setq(M, ulocal(f.get-max-stress, %#)); @assert cand(isnum(%0), gt(%0, 0), lte(%0, %qM))={ @trigger me/tr.error=%#, '%0' must be a number between 1 and %qM.; }; @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @assert lte(setr(N, add(%qC, %0)), %qM)={ @trigger me/tr.error=%#, You have [sub(%qM, %qC)] stress remaining. %0 is too high.; }; @assert cor(lt(%qN, %qM), gettimer(%#, stress-limit, %0))={ @eval settimer(%#, stress-limit, 600, %0); @trigger me/tr.message=%#, Taking this stress would put you at your maximum of %qM stress. You will immediately be out of the scene and will have to take a trauma before you can return to play. Are you sure you want to take this stress? Hit %ch+stress/gain %0%cn within the next 10 minutes to confirm. The time is now [prettytime()].; }; @set %#=[ulocal(f.get-stat-location-on-player, stress)]:%qN; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.gain-stress, %#, %0, %qN, %qM), %#; @assert neq(%qN, %qM)={ @set %#=[ulocal(f.get-stat-location-on-player, needs trauma)]:1; };

&c.+stress/clear [v(d.cg)]=$+stress/clear: @eval setq(M, ulocal(f.get-max-stress, %#)); @eval setq(C, ulocal(f.get-player-stat, %#, Stress)); @eval setq(X, ulocal(f.get-max-trauma, %#)); @eval setq(T, ulocal(f.get-player-stat, %#, Traumas)); @assert gte(setr(N, dec(%qC)), 0)={ @trigger me/tr.error=%#, You have no stress to clear.; }; @assert not(cand(gte(%qC, %qM), eq(words(%qT, |), %qX)))={ @trigger me/tr.error=%#, You have reached your limit for all stress and trauma.; }; @set %#=[ulocal(f.get-stat-location-on-player, stress)]:%qN; @trigger me/tr.remit-or-pemit=%L, setr(A, ulocal(layout.clear-stress, %#, %qN, %qM)), %#; @cemit [xget(%vD, d.monitor-channel)]=%qA; @assert not(eq(%qC, %qM))={ @wipe %#/[ulocal(f.get-stat-location-on-player, needs trauma)]; };

&c.+trauma/add [v(d.cg)]=$+trauma/add *: @assert cor(t(ulocal(f.get-player-stat, %#, needs trauma)), cand(strmatch(ulocal(f.get-player-stat, %#, Playbook), Vampire), lt(words(ulocal(f.get-player-stat, %#, traumas), |), ulocal(f.get-max-trauma, %#))))={ @trigger me/tr.error=%#, You can't take a trauma yet. Go earn more stress!; }; @assert t(setr(T, finditem(setr(L, setdiff(xget(%vD, d.value.traumas), setr(U, ulocal(f.get-player-stat, %#, traumas)), |, |)), %0, |)))={ @trigger me/tr.error=%#, Could not find a trauma starting with '%0'. Available traumas are [ulocal(layout.list, %qL)].; }; @wipe %#/[ulocal(f.get-stat-location-on-player, needs trauma)]; @set %#=[ulocal(f.get-stat-location-on-player, Traumas)]:[trim(strcat(%qU, |, %qT), |, b)]; @set %#=[ulocal(f.get-stat-location-on-player, Stress)]:0; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, Traumas, %qT, %#, %#), ulocal(layout.staff-add-alert, Traumas, %qT, %#, %#), %#, %#, Traumas; @trigger me/tr.remit-or-pemit=%l, cat(alert(Trauma), ulocal(f.get-name, %#) takes a trauma and resets, poss(%#), stress level to 0.), %#;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Heat
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.gain-heat [v(d.cgf)]=cat(alert(Heat), ulocal(f.get-name, %0), gains %1 heat for, poss(%0), crew., Their total heat is now %2/9 and they have, ansi(case(%3, 4, hr, 3, hr, 2, hy, 1, hy, hg), %3), Wanted Levels.)

&c.+heat/gain_1 [v(d.cg)]=$+heat/gain:@force %#=+heat/gain 1;

&c.+heat/gain [v(d.cg)]=$+heat/gain *:@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not in a crew and can't gain heat.; }; @assert cand(isnum(%0), gt(%0, 0), lte(%0, 9))={ @trigger me/tr.error=%#, '%0' must be a number between 1 and 9.; }; @eval setq(T, ulocal(f.get-player-stat-or-zero, %qC, Wanted Level)); @eval setq(O, ulocal(f.get-player-stat, %qC, Heat)); @assert lt(%qT, 4)={ @trigger me/tr.error=%#, You have reached your limit for all heat and wanted levels.; }; @assert lte(setr(N, add(%qO, %0)), 9)={ @trigger me/tr.error=%#, You have [sub(9, %qO)] heat remaining. %0 is too high.; }; @assert cor(lt(%qN, 9), gettimer(%#, heat-limit, %0))={ @eval settimer(%#, heat-limit, 600, %0); @trigger me/tr.message=%#, Taking this heat would clear your crew's heat%, but would give your crew a Wanted Level. Wanted Levels increase the danger of future scores. Are you sure you want to take this heat? Hit %ch+heat/gain %0%cn within the next 10 minutes to confirm. The time is now [prettytime()].; }; @eval strcat(setq(T, if(eq(%qN, 9), inc(%qT), %qT)), setq(N, if(eq(%qN, 9), 0, %qN))); @set %qC=[ulocal(f.get-stat-location-on-player, heat)]:%qN; @set %qC=[ulocal(f.get-stat-location-on-player, Wanted Level)]:%qT; @trigger me/tr.remit-or-pemit=%L, setr(M, ulocal(layout.gain-heat, %#, %0, %qN, %qT)), %#; @trigger me/tr.crew-emit=%qC, %qM;
