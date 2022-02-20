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

The commands needed are:

+sharps - see your sharps and the last 10 gains/spends
+sharps <player>
+sharps/award <player>=<#> <reason>
+sharps/awardall <#>=<reason> - give everybody connected some sharps
+sharps/spend <player>=<#> <reason>

+noms - view your past 10 noms. If you want to save these, store them offline - they do get deleted once they're no longer visible!

+noms <player> - staff command to view all of a player's noms

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

+badge/show <badge> - show one of your badges alongside your name in the OOC rooms, defaults to your first badge if you have one.

+badges <name> - list all the player's badges and their descriptions (anyone can do this, this info is not private)

+badges/all - list all the badges and maybe some stats about who's got them

*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Changes to the global code to display badges
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Add a new "Badge" field that shows up in OOC rooms by default.

@edit [v(d.bd)]/d.allowed-who-fields=$, |Badge

@force me=@edit [v(d.bd)]/d.who-field-widths=$, %%b15

&d.default-room-fields [v(d.bd)]=Name|Idle|Badge|Short-desc

&f.get-badge [v(d.bf)]=default(%0/_public-badge, if(gte(setr(S, default(%0/_total-sharps, 0)), 10), strcat(%b, switch(%qS, >9, Noob, >25, Regular, >50, Seasoned, >75, Veteran, Ancient One))))

@@ Add Badges to +finger

@edit [v(d.bd)]/d.section.ooc_info=$, |Sharps|Public Badge|Badges

&f.get-sharps [v(d.bf)]=strcat(default(%0/_sharps, 0), /, setr(S, default(%0/_total-sharps, 0)), if(gte(%qS, 10), strcat(%b, %(, switch(%qS, >9, Noob, >25, Regular, >50, Seasoned, >75, Veteran, Ancient One), %))))

&f.get-public_badge [v(d.bf)]=xget(%0, _public-badge)

&f.get-badges [v(d.bf)]=itemize(remove(default(%0/_badges, None), default(%0/_public-badge, None), |, |), |)

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

@tel [v(d.sb)]=#2

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Daily code
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.sb)]=@trigger me/tr.clean-old-player-logs=_nom-;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Basic functions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: attribute
&f.get-badge-meaning [v(d.sb)]=trim(rest(rest(rest(rest(rest(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.)))), :), :))

&f.get-badge-name [v(d.sb)]=trim(first(rest(rest(rest(rest(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.)))), :), :))

&f.get-badge-creator [v(d.sb)]=trim(first(rest(rest(rest(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.)))), :))

&f.get-badge-creation-date [v(d.sb)]=extract(default(strcat(%vD, /, %0), Date Time AMPM Creator: None: No meaning given.), 1, 3)

&f.get-badge-status [v(d.sb)]=default(strcat(%vD, /, edit(%0, BADGE-, status-)), Active)

&f.get-badge-players [v(d.sb)]=default(strcat(%vD, /, edit(%0, BADGE-, players-)), None)

@@ %0: name
&f.find-badge-by-name [v(d.sb)]=first(iter(lattr(%vD/badge-*), if(strmatch(strip(ulocal(f.get-badge-name, itext(0))), strip(%0)*), itext(0))))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Sharps, badges, and noms views
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.sharps_and_badges [v(d.sb)]=strcat(header(cat(Sharps and badges for, ulocal(f.get-name, %0, %1)), %1), %r, multicol(strcat(Sharps:, %b, default(%0/_sharps, 0), |, Total sharps:, %b, default(%0/_total-sharps, 0), |, Public Badge:, %b, default(%0/_public-badge, None)), 18 18 *, 0, |, %1), if(not(strmatch(setr(B, default(%0/_badges, None)), None)), strcat(%r, divider(Badge meanings, %1), %r, formattext(iter(%qB, cat(itext(0):, ulocal(f.get-badge-meaning, ulocal(f.find-badge-by-name, itext(0)))), |, %r), 0, %1))), if(cand(cor(isstaff(%1), strmatch(%0, %1)), t(setr(L, ulocal(f.get-last-X-logs, %0, _nom-)))), strcat(%r, divider(Last 10 +noms, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), if(cand(cor(isstaff(%1), strmatch(%0, %1)), t(setr(L, ulocal(f.get-last-X-logs, %0, _sharps-)))), strcat(%r, divider(Last 10 sharps and badges logs, %1), %r, formattext(iter(%qL, ulocal(layout.log, xget(%0, itext(0))),, %r), 0, %1))), %r, footer(, %1))

&c.+sharps [v(d.sb)]=$+sharps:@pemit %#=ulocal(layout.sharps_and_badges, %#, %#)

&c.+sharp [v(d.sb)]=$+sharp:@force %#=+sharps;

&c.+badges [v(d.sb)]=$+badges:@force %#=+sharps;

&c.+noms [v(d.sb)]=$+noms:@force %#=+sharps;

&c.+sharps_player [v(d.sb)]=$+sharps *:@assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.sharps_and_badges, %qP, %#)

&c.+badges_player [v(d.sb)]=$+badges *:@force %#=+sharps %0;

&c.+noms_player [v(d.sb)]=$+noms *:@force %#=+sharps %0;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ All badges
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ TODO: Implement paging because this is probably going to be too large.

&layout.badges [v(d.sb)]=strcat(header(All badges, %1), formattext(iter(lattr(%vD/badge-*), cat(ulocal(f.get-badge-name, itext(0)):, ulocal(f.get-badge-meaning, itext(0)), %r - Players awarded:, ulocal(layout.list, ulocal(f.get-badge-players, itext(0))), %r - Created, ulocal(f.get-badge-creation-date, itext(0)), by, ulocal(f.get-badge-creator, itext(0)), %r - Status:, ulocal(f.get-badge-status, itext(0))),, %r), 0, %1), %r, footer(, %1))

&c.+badges/all [v(d.sb)]=$+badges/all: @pemit %#=ulocal(layout.badges, %#, %#);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge creation and destruction
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/create [v(d.sb)]=$+badge/create *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert not(t(ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is already a badge named %0.; }; @trigger me/tr.log=%vD, badge-, %#, %0: %1; @trigger me/tr.success=%#, You have created the badge '%0' with the following description: %1;

&c.+badge/destroy [v(d.sb)]=$+badge/destroy *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @wipe %vD/%qB; @wipe %vD/[edit(%qB, BADGE-, status-)]; @wipe %vD/[edit(%qB, BADGE-, players-)]; @trigger me/tr.success=%#, You destroy the badge %qN. This does not take it away from players that have it.; 

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Badge awarding and revoking/removing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/award [v(d.sb)]=$+badge/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %1)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert strmatch(ulocal(f.get-badge-status, %qB), Active)={ @trigger me/tr.error=%#, %qN is a retired badge - no one else may be awarded it.; }; @assert not(t(finditem(xget(%qP, _badges), %qN, |)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) already has the badge '%qN'.; }; @set %qP=_badges:[squish(trim(strcat(xget(%qP, _badges), |, %qN), b, |), |)]; @set %qP=_public-badge:[default(%qP/_public-badge, %qN)]; @set %vD=[edit(%qB, BADGE-, players-)]:[squish(trim(strcat(xget(%vD, edit(%qB, BADGE-, players-)), |, ulocal(f.get-name, %qP)), b, |), |)]; @trigger me/tr.success=%#, cat(You award, ulocal(f.get-name, %qP, %#), the %qN badge.); @trigger me/tr.log=%qP, _sharps-, %#, Awarded the %qN badge.; @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) awards you the %qN badge!, if(strmatch(xget(%qP, _public-badge), %qN), This badge has been set as your default public badge%, and will appear beside your name in the OOC rooms.), Here is your new badge's meaning:, ulocal(f.get-badge-meaning, %qB));

&c.+badge/awardall [v(d.sb)]=$+badge/awardall *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert strmatch(ulocal(f.get-badge-status, %qB), Active)={ @trigger me/tr.error=%#, %qN is a retired badge - no one else may be awarded it.; }; @assert gettimer(%#, badge-mass-award, %qN)={ @trigger me/tr.message=%#, You are about to award everyone connected the badge '%qN'. Are you sure? If yes%, type %ch+badge/awardall %0%cn again within 10 minutes. The time is now [prettytime()].; @eval settimer(%#, badge-mass-award, 600, %qN); }; @dolist search(EPLAYER=hasflag(##, connected))={ @force %#=+badge/award ##=%qN; };

&c.+badge/remove [v(d.sb)]=$+badge/remove *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %1)))={ @trigger me/tr.error=%#, There is no badge named %1.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert t(finditem(xget(%qP, _badges), %qN, |))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) doesn't have the badge '%qN'.; }; @set %qP=_badges:[remove(xget(%qP, _badges), %qN, |, |)]; @set %qP=_public-badge:[edit(xget(%qP, _public-badge), %qN,)]; @set %vD=[edit(%qB, BADGE-, players-)]:[remove(xget(%vD, edit(%qB, BADGE-, players-)), ulocal(f.get-name, %qP), |, |)]; @trigger me/tr.success=%#, cat(You remove, ulocal(f.get-name, %qP, %#)'s, %qN badge.); @trigger me/tr.log=%qP, _sharps-, %#, Removed the %qN badge.; @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) removes your %qN badge., if(not(t(xget(%qP, _public-badge))), Your public badge has been reset. +badge/show <badge> for one of your other badges to show something else.));

&c.+badge/revoke [v(d.sb)]=$+badge/revoke *=*: @force %#=+badge/remove %0=%1;

&c.+badge/rem [v(d.sb)]=$+badge/rem *=*: @force %#=+badge/remove %0=%1;

&c.+badge/removeall [v(d.sb)]=$+badge/removeall *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @assert gettimer(%#, badge-mass-remove, %qN)={ @trigger me/tr.message=%#, You are about to remove the badge '%qN' from everyone who has it. Are you sure? If yes%, type %ch+badge/removeall %0%cn again within 10 minutes. The time is now [prettytime()].; @eval settimer(%#, badge-mass-remove, 600, %qN); }; @dolist search(EPLAYER=t(member(xget(##, _badges), %qN, |)))={ @force %#=+badge/remove ##=%qN; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Retiring and reactivating badges
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+badge/retire [v(d.sb)]=$+badge/retire *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @set %vD=[edit(%qB, BADGE-, status-)]:[cat(Retired, prettytime(), by, ulocal(f.get-name, %#))]; @trigger me/tr.success=%#, You retire the badge %qN.;

&c.+badge/reactivate [v(d.sb)]=$+badge/reactivate *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage badges.; }; @assert t(setr(B, ulocal(f.find-badge-by-name, %0)))={ @trigger me/tr.error=%#, There is no badge named %0.; }; @eval setq(N, ulocal(f.get-badge-name, %qB)); @wipe %vD/[edit(%qB, BADGE-, status-)]; @trigger me/tr.success=%#, You reactivate the badge %qN.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Sharps awarding and spending
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+sharps/award [v(d.sb)]=$+sharps/award *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage sharps.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting these sharps was.; }; @assert cand(isint(%qV), gte(%qV, 1), lte(%qV, 100))={ @trigger me/tr.error=%#, Sharps amount must be an integer between 1 and 100.; }; @set %qP=_sharps:[add(xget(%qP, _sharps), %qV)]; @set %qP=_total-sharps:[add(xget(%qP, _total-sharps), %qV)]; @trigger me/tr.success=%#, cat(You award, ulocal(f.get-name, %qP, %#), %qV sharps for '%qR'.); @trigger me/tr.log=%qP, _sharps-, %#, Awarded %qV sharps for '%qR'.; @trigger me/tr.message=%qP, cat(ulocal(f.get-name, %#, %qP) awards you %qV sharps for '%qR'.);

&c.+sharps/awardall [v(d.sb)]=$+sharps/awardall *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage sharps.; }; @assert t(%1)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting these sharps was.; }; @assert cand(isint(%0), gte(%0, 1), lte(%0, 100))={ @trigger me/tr.error=%#, Sharps amount must be an integer between 1 and 100.; }; @assert gettimer(%#, sharp-mass-award, %0=%1)={ @trigger me/tr.message=%#, You are about to award everyone connected %0 sharps because '%1'. Are you sure? If yes%, type %ch+sharps/awardall %0=%1%cn again within 10 minutes. The time is now [prettytime()].; @eval settimer(%#, sharp-mass-award, 600, %0=%1); }; @dolist search(EPLAYER=hasflag(##, connected))={ @force %#=+sharps/award ##=%0 %1; };

&c.+sharps/spend [v(d.sb)]=$+sharps/spend *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to manage sharps.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(V, if(isint(first(%1)), first(%1), 0)); @eval strcat(setq(R, if(isint(first(%1)), rest(%1), %1)), setq(R, squish(trim(switch(%qR, for *, rest(%qR), %qR))))); @assert t(%qR)={ @trigger me/tr.error=%#, Can't figure out what your reason for granting these sharps was.; }; @assert cand(isint(%qV), gte(%qV, 1), lte(%qV, 100))={ @trigger me/tr.error=%#, Sharps amount must be an integer between 1 and 100.; }; @assert lte(%qV, setr(E, xget(%qP, _sharps)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) only has %qE sharps - %qV is too many.; }; @set %qP=_sharps:[sub(%qE, %qV)]; @trigger me/tr.success=%#, cat(You spend %qV of, ulocal(f.get-name, %qP, %#)'s, sharps for '%qR'.); @trigger me/tr.log=%qP, _sharps-, %#, Spent %qV sharps for '%qR'.; @trigger me/tr.message=%qP, ulocal(f.get-name, %#, %qP) spends %qV of your sharps for '%qR'.;

&c.+sharp/alias [v(d.sb)]=$+sharp/* *=*: @force %#=+sharps/%0 %1=%2;
