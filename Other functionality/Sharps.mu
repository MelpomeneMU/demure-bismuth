/*
Sharps are a point system that rewards OOC good behavior, game stewardship, and acting in a way that makes the game fun for everyone. They can be awarded by staff for things like:

- GMing
- In celebration of a holiday
- Anything that makes the game better (useful builds, bug-finding, etc)

They can also be acquired by roleplaying with other players and getting +nominated.

Sharps can be used:
- To buy badges (more on these below)
- To buy advanced playbooks at character creation
- Any other rewards staff deems acceptable

Badges are earnable tags that go in your +finger for other players to see. Some badges are earned automatically, some are granted as prizes or memorabilia, and some are bought for street cred.

In addition, having a certain number of total Sharps gives you a badge for each level. Those are customizable below.

The commands needed are:

+sharps - see your sharps and badges and the last 10 gains/spends
+sharps <player> - only shows badge info unless you're staff or <player>
+sharps/award <player>=<#> <reason>
+sharps/awardall <#>=<reason> - give everybody connected some sharps
+sharps/spend <player>=<#> <reason>

+noms - view your past 10 noms. If you want to save these, store them offline - they do get deleted once they're no longer visible!

+noms <player> - staff command to view all of a player's noms

+noms/report - see who's nommed you and who you've nommed over all time
+noms/report <player> - staff command to view report on any player

+noms/global - see stats on everybody's +noms

+nom <player>=<reason> - nominate a player to receive Sharps. The first time you nominate someone, they get a full Sharp. After that, the benefits drop, but they never go so low as to be worthless. The receiving player will be told you nommed them and what you said, and your message will be added to their list of +noms, so be kind and encouraging. You can only +nom the same person once every 24 hours.

Old +noms that are no longer visible should get nuked after a while to save space on the player.

+badge/award <player>=<badge>
+badge/awardall <badge> - award everyone connected a badge
+badge/remove <player>=<badge>
+badge/removeall <badge> - remove a badge from everyone that has it

+badge/create <badge name>=<description>
+badge/retire <badge name> - it will be listed but cannot be awarded
+badge/reactivate <badge name> - un-retire it
+badge/destroy <badge name> - nukes it. Does not get rid of it on players.

+badges - list your badges

+badge/wear <badge> - display one of your badges alongside your name in the OOC rooms
+badge/unwear <badge> - remove that badge

+badge/hide <badge> - hide a badge you've earned
+badge/show <badge> - show a badge you've hidden

+badges <name> - list all the player's badges and their descriptions (anyone can do this, this info is not private)

+badges/all - list all the badges and maybe some stats about who's got them

+badges/info <badge> - get info about a particular badge

+name/title <player>=<title> - set a player's OOC title (presumably after they've spent Sharps) - staff-only

TODO: Add chart of costs?

TODO: Noms counts reset weekly.

TODO: Make +nom/anon and +nom/silent and let them be mixed.

TODO: Make noms reason optional.

TODO: Send +noms to a channel somewhere.

TODO: Prepare to include ascii art in badges, both in the names and the descriptions.

*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Object creation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@create Sharps n Badges Database <SBD>=10
@set SBD=SAFE OPAQUE

@create Sharps n Badges <SB>=10
@set SB=SAFE INHERIT OPAQUE

@force me=&d.sbd me=[search(ETHING=t(member(name(##), Sharps n Badges Database <SBD>, |)))]

@force me=&d.sb me=[search(ETHING=t(member(name(##), Sharps n Badges <SB>, |)))]

@force me=@parent [v(d.sbd)]=[v(d.bf)]

@force me=@parent [v(d.sb)]=[v(d.sbd)]

@force me=@set [v(d.sb)]=vD:[v(d.sbd)]

@tel [v(d.sbd)]=[v(d.sb)]

@tel [v(d.sb)]=[config(master_room)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Default Badges
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&sharpcount-1 [v(d.sbd)]=10

&sharpcount-2 [v(d.sbd)]=25

&sharpcount-3 [v(d.sbd)]=50

&sharpcount-4 [v(d.sbd)]=75

&sharpcount-5 [v(d.sbd)]=100

@force me=&badge-1 [v(d.sbd)]=[prettytime()] [moniker(%#)]: Petty criminal: Gained [xget(v(d.sbd), sharpcount-1)]+ Sharps!

@force me=&badge-2 [v(d.sbd)]=[prettytime()] [moniker(%#)]: Crook: Gained [xget(v(d.sbd), sharpcount-2)]+ Sharps!

@force me=&badge-3 [v(d.sbd)]=[prettytime()] [moniker(%#)]: Person of means: Gained [xget(v(d.sbd), sharpcount-3)]+ Sharps!

@force me=&badge-4 [v(d.sbd)]=[prettytime()] [moniker(%#)]: Nobility: Gained [xget(v(d.sbd), sharpcount-4)]+ Sharps!

@force me=&badge-5 [v(d.sbd)]=[prettytime()] [moniker(%#)]: Immortal Emperor: Gained [xget(v(d.sbd), sharpcount-5)]+ Sharps!

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Changes to the global code to display badges
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Add a new "Badge" field that shows up in OOC rooms by default.

@edit [v(d.bd)]/d.allowed-who-fields=$, |Badge

@force me=@edit [v(d.bd)]/d.who-field-widths=$, %%b15

&d.default-room-fields [v(d.bd)]=Name|Idle|Badge|Short-desc

@@ Add Badges to +finger

@edit [v(d.bd)]/d.section.ooc_info=$, |Worn Badge|Badges

@force me=&vS [v(d.bd)]=[v(d.sb)]

@@ Global display functions.

&f.get-badge [v(d.bf)]=xget(%0, _worn-badge)

&f.get-worn_badge [v(d.bf)]=xget(%0, _worn-badge)

&f.get-badges [v(d.bf)]=itemize(diffset(default(%0/_badges, None), strcat(default(%0/_worn-badge, None), |, xget(%0, _hidden-badges)), |, |), |)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ If you're using Job points, this will give the staffer who finishes the
@@ job a sharp and a job point.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@force me=&vY [v(JOB_GO)]=[v(d.sb)]

@force me=&vY [v(JOB_VC)]=[v(d.sb)]

@force me=&vY [v(d.jrs)]=[v(d.sb)]

&TRIG_POINTS [v(JOB_VC)]=@set %0=_job-points:[inc(default(%0/_job-points, 0))];@set %0=_total-sharps:[inc(default(%0/_total-sharps, 0))]; @set %0=_sharps:[inc(default(%0/_sharps, 0))]; @trigger %vZ/tr.log=%0, _sharps-, Jobs, Awarded 1 for '%1'.; @trigger %vY/tr.award-sharp-badges=%0, Jobs;

&HOOK_APR [v(JOB_VC)]=@trigger [v(VA)]/TRIG_LOG=%0,[v(VA)]; @trigger me/TRIG_POINTS=%1, cat(Approved job:, get(%0/TITLE));
&HOOK_DEL [v(JOB_VC)]=@trigger [v(VA)]/TRIG_LOG=%0,[v(VA)]; @trigger me/TRIG_POINTS=%1, cat(Deleted job:, get(%0/TITLE));
&HOOK_DNY [v(JOB_VC)]=@trigger [v(VA)]/TRIG_LOG=%0,[v(VA)]; @trigger me/TRIG_POINTS=%1, cat(Denied job:, get(%0/TITLE));
&HOOK_COM [v(JOB_VC)]=@trigger [v(VA)]/TRIG_LOG=%0,[v(VA)]; @trigger me/TRIG_POINTS=%1, cat(Completed job:, get(%0/TITLE));

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Daily code
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.sb)]=@trigger me/tr.clean-old-player-logs=_nom-; @trigger me/tr.wipe-weekly-nom-stats;

&tr.wipe-weekly-nom-stats [v(d.sb)]=@break gettimer(%vD, global-noms); @eval settimer(%vD, global-noms, 604795); @wipe %vD/global-noms-*; @set %vD=last-reset:[prettytime()]; @dolist search(EPLAYER=hasattr(##, _past-noms))={ @wipe ##/_past-noms; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Basic functions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&f.get-sharp-badge [v(d.sb)]=if(gte(setr(S, default(%0/_total-sharps, 0)), v(sharpcount-1)), ulocal(f.get-badge-name, switch(%qS, >[dec(v(sharpcount-5))], badge-5, >[dec(v(sharpcount-4))], badge-4, >[dec(v(sharpcount-3))], badge-3, >[dec(v(sharpcount-2))], badge-2, badge-1)))

@@ %0: attribute
&f.get-badge-meaning [v(d.sb)]=trim(rest(rest(rest(rest(rest(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.)))), :), :))

&f.get-badge-name [v(d.sb)]=trim(first(rest(rest(rest(rest(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.)))), :), :))

&f.get-badge-creator [v(d.sb)]=trim(first(rest(rest(rest(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.)))), :))

&f.get-badge-creation-date [v(d.sb)]=extract(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.), 1, 3)

&f.get-badge-status [v(d.sb)]=default(strcat(%vD, /, edit(%0, BADGE-, status-)), Active)

&f.get-badge-players [v(d.sb)]=default(strcat(%vD, /, edit(%0, BADGE-, players-)), if(t(setr(S, xget(%vD, edit(%0, BADGE-, sharpcount-)))), words(search(EPLAYER=gt(default(##/_total-sharps, 0), %qS))) players, None))

@@ %0: name
&f.find-badge-by-name [v(d.sb)]=if(t(%0), first(iter(lattr(%vD/badge-*), if(strmatch(strip(ulocal(f.get-badge-name, itext(0))), strip(%0)*), itext(0)))))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Sharps, badges, and noms views
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.sharps_and_badges [v(d.sb)]=strcat(header(cat(Badges for, ulocal(f.get-name, %0, %1)), %1), %r, if(cor(isstaff(%1), strmatch(%0, %1)), edit(multicol(strcat(Sharps:, %b, default(%0/_sharps, 0), |, Total sharps:, %b, default(%0/_total-sharps, 0), |, rjust(strcat(Worn Badge:, %b, if(t(setr(P, ulocal(f.get-badge, %0))), %qP, None)), sub(getremainingwidth(%#), 37), _)), 15 20 *, 0, |, %1), _, %b), formattext(cat(Worn badge:, if(t(setr(P, ulocal(f.get-badge, %0))), %qP, None)), 0, %1)), if(not(strmatch(setr(B, default(%0/_badges, None)), None)), strcat(%r, divider(Badges, %1), %r, formattext(iter(%qB, cat(*, itext(0):, ulocal(f.get-badge-meaning, ulocal(f.find-badge-by-name, itext(0)))), |, %r), 0, %1))), if(cand(cor(isstaff(%1), strmatch(%0, %1)), t(setr(L, ulocal(f.get-last-X-logs, %0, _sharps-)))), strcat(%r, divider(Last 10 sharps and badges logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&layout.noms [v(d.sb)]=strcat(header(cat(+noms for, ulocal(f.get-name, %0, %1)), %1), setq(L, ulocal(f.get-last-X-logs, %0, _nom-)), %r, formattext(if(t(%qL), iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), None yet.), 0, %1), %r, footer(, %1))

&layout.noms-report [v(d.sb)]=strcat(header(cat(+nom report for, ulocal(f.get-name, %0, %1)[if(t(setr(L, xget(%vD, last-reset))), %bsince %qL)]), %1), %r, divider(+noms given, %1), %r, multicol(if(t(setr(R, xget(%0, _past-noms))), strcat(Name|noms|Name|noms|Name|noms|, iter(%qR, strcat(setr(N, ulocal(f.get-name, first(itext(0), -), %1)), |, rest(itext(0), -)),, |)), None yet.), * 4 * 4 * 4, t(%qR), |, %1), divider(+noms received, %1), %r, multicol(if(t(setr(R, search(EPLAYER=strmatch(xget(##, _past-noms), %0-*)))), strcat(Name|noms|Name|noms|Name|noms|, iter(%qR, strcat(ulocal(f.get-name, itext(0), %1), |, rest(finditem(xget(itext(0), _past-noms), %0-), -)),, |)), None yet.),* 4 * 4 * 4, t(%qR), |, %1), %r, footer(, %1))

&layout.noms-global [v(d.sb)]=strcat(header(Global +noms stats[if(t(setr(L, xget(%vD, last-reset))), %bsince %qL)], %0), %r, divider(+noms given, %0), %r, multicol(if(t(setr(R, xget(%vD, global-noms-given))), strcat(Name|noms|Name|noms|Name|noms|, iter(%qR, strcat(setr(N, ulocal(f.get-name, first(itext(0), -), %1)), |, rest(itext(0), -)),, |)), None yet.), * 4 * 4 * 4, t(%qR), |, %1), %r, divider(+noms received, %0), %r, multicol(if(t(setr(R, xget(%vD, global-noms-received))), strcat(Name|noms|Name|noms|Name|noms|, iter(%qR, strcat(setr(N, ulocal(f.get-name, first(itext(0), -), %1)), |, rest(itext(0), -)),, |)), None yet.), * 4 * 4 * 4, t(%qR), |, %1), %r, footer(if(t(gettimer(%vD, global-noms)), cat(Reset in, getremainingtime(%vD, global-noms).), Reset once the @daily hits), %0))

&c.+sharps [v(d.sb)]=$+sharps:@pemit %#=ulocal(layout.sharps_and_badges, %#, %#)

&c.+sharp [v(d.sb)]=$+sharp:@force %#=+sharps;

&c.+badges [v(d.sb)]=$+badges:@force %#=+sharps;

&c.+sharps_player [v(d.sb)]=$+sharps *:@assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.sharps_and_badges, %qP, %#)

&c.+badges_player [v(d.sb)]=$+badges *:@force %#=+sharps %0;

&c.+noms [v(d.sb)]=$+noms:@pemit %#=ulocal(layout.noms, %#, %#)

&c.+noms_player [v(d.sb)]=$+noms *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view another player's +noms.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.noms, %qP, %#)

&c.+noms/report [v(d.sb)]=$+noms/report:@pemit %#=ulocal(layout.noms-report, %#, %#)

&c.+noms/report_player [v(d.sb)]=$+noms/report *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view another player's +noms.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.noms-report, %qP, %#)

&c.+noms/global [v(d.sb)]=$+noms/global:@pemit %#=ulocal(layout.noms-global, %#)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Aliases
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+nom/alias [v(d.sb)]=$+nom/*:@force %#=+noms/%0;

&c.+noms/alias [v(d.sb)]=$+noms/*:@break switch(%0, report, 1, global, 1, 0); @switch/first %0=r*, { @force %#=+noms/report; }, g*, { @force %#=+noms/global; }, { @pemit %#=error(); };

&c.+sharp/alias [v(d.sb)]=$+sharp/*: @force %#=+sharps/%0;

&c.+sharps/alias [v(d.sb)]=$+sharps/*:@break switch(first(%0), awardall, 1, award, 1, spend, 1, 0); @eval setq(A, switch(%0, * *, rest(%0))); @assert strmatch(%qA, *=*)={ @pemit %#=error(); }; @switch/first %0=aa*, { @force %#=+sharps/awardall %qA; }, a*, { @force %#=+sharps/award %qA; }, s*, { @force %#=+sharps/spend %qA; }, { @pemit %#=error(); };

&c.+badge/alias [v(d.sb)]=$+badge/*:@break switch(first(%0), award, 1, awardall, 1, remove, 1, removeall, 1, create, 1, retire, 1, reactivate, 1, destroy, 1, show, 1, hide, 1, wear, 1, unwear, 1, info, 1, 0); @eval setq(A, switch(%0, * *, rest(%0))); @switch/first 1=strmatch(%qA, *=*), { @switch/first %0=a*, { @force %#=+badge/award %qA; }, r*, { @force %#=+badge/remove %qA; }, d*, { @force %#=+badge/remove %qA; }, c*, { @force %#=+badge/create %qA; }, { @pemit %#=error(); }; }, t(%qA), { @switch/first %0=a*, { @force %#=+badge/awardall %qA; }, i*, { @force %#=+badge/info %qA; }, rem*, { @force %#=+badge/removeall %qA; }, ret*, { @force %#=+badge/retire %qA; }, rea*, { @force %#=+badge/reactivate %qA; }, d*, { @force %#=+badge/destroy %qA; }, s*, { @force %#=+badge/show %qA; }, h*, { @force %#=+badge/hide %qA; }, w*, { @force %#=+badge/wear %qA; }, u*, { @force %#=+badge/unwear %qA; }, { @pemit %#=error(); }; }, { @force %#=+badges/%0; };

&c.+badges/alias [v(d.sb)]=$+badges/*:@break switch(%0, all, 1, 0); @eval setq(A, switch(%0, * *, rest(%0))); @switch/first %0=a*, { @force %#=+badges/all; }, i*, { @assert t(%qA)={ @pemit %#=error(); }; @force %#=+badge/info %qA; }, { @pemit %#=error(); };

&c.+nom_alias [v(d.sb)]=$+nom *: @break strmatch(%0, *=*); @force %#=+noms %0;

&c.+sharp_alias [v(d.sb)]=$+sharp *: @force %#=+sharps %0;

&c.+badge_alias [v(d.sb)]=$+badge *: @force %#=+badges %0;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge info
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.badges [v(d.sb)]=strcat(header(All badges, %1), %r, edit(multicol(iter(lattr(%vD/badge-*), strcat(switch(ulocal(f.get-badge-status, itext(0)), R*, %ch%cxR%cn, _), |, ulocal(f.get-badge-name, itext(0))),, |), 1 * 1 * 1 *, 0, |, %1), _, %b), %r, footer(, %1))

&layout.badge [v(d.sb)]=strcat(header(ulocal(f.get-badge-name, %0), %1), %r, formattext(strcat(Meaning:, %b, ulocal(f.get-badge-meaning, %0), %r%r, if(isstaff(%1), strcat(Players:, %b, ulocal(layout.list, ulocal(f.get-badge-players, %0)), %r)), Status:, %b, ulocal(f.get-badge-status, %0), %r, Created, %b, ulocal(f.get-badge-creation-date, %0), %b, by, %b, ulocal(f.get-badge-creator, %0)), 0, %1), %r, footer(, %1))

&c.+badges/all [v(d.sb)]=$+badges/all: @pemit %#=ulocal(layout.badges, %#, %#);

&c.+badge/info [v(d.sb)]=$+badge/info *: @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @pemit %#=ulocal(layout.badge, %qB, %#);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge creation and destruction
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/create [v(d.sb)]=$+badge/create *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert not(t(ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is already a badge named %0.; }; @trigger me/tr.log=%vD, badge-, %#, %0: %1; @trigger me/tr.success=%#, You have created the badge '%0' with the following description: %1;

&c.+badge/destroy [v(d.sb)]=$+badge/destroy *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert gettimer(%#, destroy-badge, %qN)={ @eval settimer(%#, destroy-badge, 600, %qN); @trigger me/tr.message=%#, You are about to destroy badge %qN. This will not remove it from players - for that you must use +badge/removeall %qN. Are you sure you wish to destroy this badge? If so%, type %ch+badge/destroy %0%cn again within the next 10 minutes. The time is now [prettytime()].; }; @wipe %vD/%qB; @wipe %vD/[edit(%qB, BADGE-, status-)]; @wipe %vD/[edit(%qB, BADGE-, players-)]; @trigger me/tr.success=%#, You destroy the badge %qN. This does not take it away from players that have it.; 

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge awarding and revoking/removing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/award [v(d.sb)]=$+badge/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %1)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert strmatch(ulocal(f.get-badge-status, %qB), Active)={ @trigger me/tr.error=%#, %qN is a retired badge - no one else may be awarded it.; }; @assert not(t(finditem(xget(%qP, _badges), %qN, |)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) already has the badge '%qN'.; }; @set %qP=_badges:[squish(trim(strcat(xget(%qP, _badges), |, %qN), b, |), |)]; @set %vD=[edit(%qB, BADGE-, players-)]:[squish(trim(strcat(xget(%vD, edit(%qB, BADGE-, players-)), |, ulocal(f.get-name, %qP)), b, |), |)]; @trigger me/tr.success=%#, cat(You award, ulocal(f.get-name, %qP, %#), the %qN badge.); @trigger me/tr.log=%qP, _sharps-, %#, Awarded the %qN badge.; @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) awards you the %qN badge! You can wear it with %ch+badge/wear %qN%cn. Here is your new badge's meaning:, ulocal(f.get-badge-meaning, %qB));

&c.+badge/awardall [v(d.sb)]=$+badge/awardall *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert strmatch(ulocal(f.get-badge-status, %qB), Active)={ @trigger me/tr.error=%#, %qN is a retired badge - no one else may be awarded it.; }; @assert gettimer(%#, badge-mass-award, %qN)={ @trigger me/tr.message=%#, You are about to award everyone connected the badge '%qN'. Are you sure? If yes%, type %ch+badge/awardall %0%cn again within 10 minutes. The time is now [prettytime()].; @eval settimer(%#, badge-mass-award, 600, %qN); }; @dolist search(EPLAYER=hasflag(##, connected))={ @force %#=+badge/award ##=%qN; };

&c.+badge/remove [v(d.sb)]=$+badge/remove *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %1)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert t(finditem(xget(%qP, _badges), %qN, |))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) doesn't have the badge '%qN'.; }; @assert gettimer(%#, remove-%qP, %qN)={ @trigger me/tr.message=%#, You are about to remvoe the badge %qN from [ulocal(f.get-name, %qP, %#)]. Are you sure? If so%, type %ch+badge/remove %0=%1%cn again within the next 10 minutes. The time is now [prettytime()].; @eval settimer(%#, remove-%qP, 600, %qN); }; @set %qP=_badges:[remove(xget(%qP, _badges), %qN, |, |)]; @set %qP=_worn-badge:[edit(xget(%qP, _worn-badge), %qN,)]; @set %vD=[edit(%qB, BADGE-, players-)]:[remove(xget(%vD, edit(%qB, BADGE-, players-)), ulocal(f.get-name, %qP), |, |)]; @trigger me/tr.success=%#, cat(You remove, ulocal(f.get-name, %qP, %#)'s, %qN badge.); @trigger me/tr.log=%qP, _sharps-, %#, Removed the %qN badge.; @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) removes your %qN badge., if(not(t(ulocal(f.get-badge, %qP))), Your worn badge has been reset. +badge/wear <badge> to wear one of your other badges.));

&c.+badge/removeall [v(d.sb)]=$+badge/removeall *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert gettimer(%#, badge-mass-remove, %qN)={ @trigger me/tr.message=%#, You are about to remove the badge '%qN' from everyone who has it. Are you sure? If yes%, type %ch+badge/removeall %0%cn again within 10 minutes. The time is now [prettytime()].; @eval settimer(%#, badge-mass-remove, 600, %qN); }; @dolist search(EPLAYER=t(member(xget(##, _badges), %qN, |)))={ @force %#=+badge/remove ##=%qN; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Retiring and reactivating badges
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/retire [v(d.sb)]=$+badge/retire *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @set %vD=[edit(%qB, BADGE-, status-)]:[cat(Retired, prettytime(), by, ulocal(f.get-name, %#))]; @trigger me/tr.success=%#, You retire the badge %qN.;

&c.+badge/reactivate [v(d.sb)]=$+badge/reactivate *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @wipe %vD/[edit(%qB, BADGE-, status-)]; @trigger me/tr.success=%#, You reactivate the badge %qN.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge wearing/unwearing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/wear [v(d.sb)]=$+badge/wear *:; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert t(finditem(xget(%#, _badges), %qN, |))={ @trigger me/tr.error=%#, You don't have the badge '%qN'.; }; @set %#=_worn-badge:%qN; @trigger me/tr.success=%#, You wear your %qN badge so that it will show up in the OOC rooms.;

&c.+badge/unwear [v(d.sb)]=$+badge/unwear *:; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert t(finditem(xget(%#, _badges), %qN, |))={ @trigger me/tr.error=%#, You don't have the badge '%qN'.; }; @set %#=_worn-badge:; @trigger me/tr.success=%#, You take off your %qN badge so that it won't show up in the OOC rooms.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge showing and hiding
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/hide [v(d.sb)]=$+badge/hide *:@assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert t(finditem(xget(%#, _badges), %qN, |))={ @trigger me/tr.error=%#, You don't have the badge '%qN'.; }; @assert not(member(xget(%#, _hidden-badges), %qN, |))={ @trigger me/tr.error=%#, You're already hiding your %qN badge.; }; @set %#=_hidden-badges:[unionset(xget(%#, _hidden-badges), %qN, |, |)]; @trigger me/tr.success=%#, You hide your %qN badge from +badges.; @if strmatch(xget(%#, _worn-badge), %qN)={ @force %qN=+unwear %qN; };

&c.+badge/show [v(d.sb)]=$+badge/show *:@assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert t(finditem(xget(%#, _badges), %qN, |))={ @trigger me/tr.error=%#, You don't have the badge '%qN'.; }; @assert t(member(xget(%#, _hidden-badges), %qN, |))={ @trigger me/tr.error=%#, You're not hiding your %qN badge.; }; @set %#=_hidden-badges:[diffset(xget(%#, _hidden-badges), %qN, |, |)]; @trigger me/tr.success=%#, You unhide your %qN badge from +badges.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Sharps awarding and spending
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: player
@@ %1: setter, if any
&tr.award-sharp-badges [v(d.sb)]=@assert t(setr(B, ulocal(f.get-sharp-badge, %0))); @assert not(t(finditem(setr(O, xget(%0, _badges)), %qB, |))); @set %0=_badges:[unionset(%qO, %qB, |, |)]; @trigger me/tr.message=%0, You earned the %qB badge%, meaning: [setr(M, ulocal(f.get-badge-meaning, ulocal(f.find-badge-by-name, %qB)))]; @trigger me/tr.message=%1, ulocal(f.get-name, %0, %1) has earned the %qB badge%, meaning: %qM; @trigger me/tr.log=%0, _sharps-, %1, Awarded the %qB badge for gaining sharps.;

&c.+sharps/award [v(d.sb)]=$+sharps/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage sharps.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting these sharps was.; }; @assert cand(isint(%qV), gte(%qV, 1), lte(%qV, 100))={ @trigger me/tr.error=%#, Sharps amount must be an integer between 1 and 100.; }; @set %qP=_sharps:[add(xget(%qP, _sharps), %qV)]; @set %qP=_total-sharps:[add(xget(%qP, _total-sharps), %qV)]; @trigger me/tr.success=%#, cat(You award, ulocal(f.get-name, %qP, %#), %qV sharps for '%qR'.); @trigger me/tr.log=%qP, _sharps-, %#, Awarded %qV sharps for '%qR'.; @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) awards you %qV sharps for '%qR'.); @trigger me/tr.award-sharp-badges=%qP, %#;

&c.+sharps/awardall [v(d.sb)]=$+sharps/awardall *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage sharps.; }; @assert t(%1)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting these sharps was.; }; @assert cand(isint(%0), gte(%0, 1), lte(%0, 100))={ @trigger me/tr.error=%#, Sharps amount must be an integer between 1 and 100.; }; @assert gettimer(%#, sharp-mass-award, %0=%1)={ @trigger me/tr.message=%#, You are about to award everyone connected %0 sharps because '%1'. Are you sure? If yes%, type %ch+sharps/awardall %0=%1%cn again within 10 minutes. The time is now [prettytime()].; @eval settimer(%#, sharp-mass-award, 600, %0=%1); }; @dolist search(EPLAYER=hasflag(##, connected))={ @force %#=+sharps/award ##=%0 %1; };

&c.+sharps/spend [v(d.sb)]=$+sharps/spend *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage sharps.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting these sharps was.; }; @assert cand(isint(%qV), gte(%qV, 1), lte(%qV, 100))={ @trigger me/tr.error=%#, Sharps amount must be an integer between 1 and 100.; }; @assert lte(%qV, setr(E, xget(%qP, _sharps)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) only has %qE sharps - %qV is too many.; }; @set %qP=_sharps:[sub(%qE, %qV)]; @trigger me/tr.success=%#, cat(You spend %qV of, ulocal(f.get-name, %qP, %#)'s, sharps for '%qR'.); @trigger me/tr.log=%qP, _sharps-, %#, Spent %qV sharps for '%qR'.; @trigger me/tr.message=%qP, ulocal(f.get-name, %#, %qP) spends %qV of your sharps for '%qR'.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Nominate other players
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: nommer
@@ %1: nommee
&f.get-total-past-noms [v(d.sb)]=rest(finditem(xget(%0, _past-noms), %1-), -)

&f.get-global-noms [v(d.sb)]=rest(finditem(xget(%vD, global-noms-%1), %0-), -)

&f.calc-nom-sharps [v(d.sb)]=switch(ulocal(f.get-total-past-noms, %0, %1), <1, 1, <2, .5, <5, .25, .1)

&c.+nom_player [v(d.sb)]=$+nom *=*: @assert isapproved(%#)={ @trigger me/tr.error=%#, You must be approved to hand out +noms.; };  @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert not(strmatch(%qP, %#))={ @trigger me/tr.error=%#, You can't +nom yourself.; }; @assert t(%1)={ @trigger me/tr.error=%#, Could not figure out the reason you want to +nom this person.; }; @assert not(gettimer(%#, nom-%qP))={ @trigger me/tr.error=%#, You can't +nom the same person more than once per day. You will be able to +nom this person again in [getremainingtime(%#, nom-%qP)].; }; @assert t(setr(S, ulocal(f.calc-nom-sharps, %#, %qP)))={ @trigger me/tr.error=%#, Could not figure out how many sharps to award.; };  @trigger me/tr.log=%qP, _nom-, %#, %1; @trigger me/tr.log=%qP, _sharps-, %#, cat(Awarded %qS, plural(%qS, sharp, sharps) with a +nom.); @set %qP=_total-sharps:[add(%qS, xget(%qP, _total-sharps))]; @eval setq(L, ulocal(f.get-total-past-noms, %#, %qP)); @set %qP=_sharps:[add(%qS, xget(%qP, _sharps))]; @set %#=_past-noms:[setunion(setdiff(xget(%#, _past-noms), %qP-%qL), %qP-[inc(%qL)])]; @eval setq(G, ulocal(f.get-global-noms, %#, given)); @set %vD=global-noms-given:[setunion(setdiff(xget(%vD, global-noms-given), %#-%qG), %#-[inc(%qG)])]; @eval setq(R, ulocal(f.get-global-noms, %qP, received)); @set %vD=global-noms-received:[setunion(setdiff(xget(%vD, global-noms-received), %qP-%qR), %qP-[inc(%qR)])]; @eval settimer(%#, nom-%qP, 86400); @trigger me/tr.success=%#, cat(You +nom, ulocal(f.get-name, %qP, %#), for %qS Sharps with the following comment: %1); @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) +noms you for %qS Sharps with the following comment: %1); 

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ A sharps reward: +name/title <player>=<title>
@@ Requires Channels.mu if you want it to set up their comtitle on Public too.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.public-channel [v(d.sbd)]=Public

&c.+name/title [v(d.sb)]=$+name/title *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, Only staff can set up a player's name/title.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @set %qP=_name-highlights:%1; @trigger me/tr.set-public-channel-comtitle=%qP, %1; @trigger me/tr.success=%#, You set [ulocal(f.get-name, %qP, %#)]'s name highlight to '%1'.; @trigger me/tr.message=%qP, ulocal(f.get-name, %#, %qP) sets your name highlight to '%1'.;

&tr.set-public-channel-comtitle [v(d.sb)]=@eval u(%vH/f.get-channel-by-name-error, %0, xget(%vD, d.public-channel)); @break t(%qE); @if setr(S, not(t(member(xget(%qN, bypass-comtitle-restrictions), %0))))={ @set %qN=bypass-comtitle-restrictions:[setunion(xget(%qN, bypass-comtitle-restrictions), %0)]; }; @force %0=+channel/title %qT=%1; @if %qS={ @wait 1={ @set %qN=bypass-comtitle-restrictions:[setdiff(xget(%qN, bypass-comtitle-restrictions), %0)]; }; };

@set [v(d.sb)]/c.+name/title=no_parse
