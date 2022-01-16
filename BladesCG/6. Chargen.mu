/*

+cg/approve Alice=Go have fun, you crazy kids!
+cg/unapprove <name>=Unapproved at player request.

+cg/reject Bob=Your name is Bobbitus Maximus. That's not in-theme. Please remove or change it and get back to us.
	- Unlocks their character
	- Shows them the notice at login or in a message if they're logged in

+cg/status - shows the status of your CG app

+cg/status <name> - shows their status and approval history if you're staff, and if not, just shows approved date.

+stat/set stat=value
+stat/set special ability=value
etc.

Cohort commands:

+cohort/create <name>=<cohort type> - makes a  cohort and sets you up as editing that cohort

+cohort/edit <name> - for editing a cohort you've already made

+cohort/set <stat>=<value>
+cohort/add <stat>=<value>
+cohort/remove <stat>=<value>

+cohort/destroy <name> - will ask "are you sure".

Staff Cohort commands:

+cohort/create <player>/<name>=<cohort type>

+cohort/edit <player>/<name>

+cohort/destroy <player>/<cohort>

Example Cohort setting:

First we decided we wanted a badass fashionista with a skill at hats:

+cohort/create Aramina the Bold=Rook
+cohort/set Specialty=Haberdasher
+cohort/add Edge=Independent
+cohort/add Edge=Tenacious
+cohort/add Flaw=Principled
+cohort/add Flaw=Unreliable

Then we decided to get some skulks:

+cohort/create The Sly Brothers=Skulks
+cohort/add Edge=Independent
+cohort/add Flaw=Principled

But that's not right, so we nuked them:

+cohort/destroy The Sly Brothers
+cohort/destroy The Sly Brothers=YES

We decided to focus on just one cohort:

+cohort/edit Aramina

Maybe make it an extra strong cohort, and a gang instead of an Expert:

+cohort/add Type=Rover
+cohort/set Cohort Type=Gang

Rename this Gang to something appropriate:

+cohort/set Name=Fog Kids

And we're done!

 .o:,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.{ Cohorts },.,.,.,.,.,.,.,.,.,.,.,.,.,.,.:o.
 . Fog Kids (Gang of Rooks and Rovers)                                       .
 . Edges & Flaws: Independent, Tenacious, Principled, and Unreliable         .
 . Scale: 0, Quality: 0                                                      .
 .o:,.,.,.,.,.,.,.,.,.,.,.,.,{ ................ }.,.,.,.,.,.,.,.,.,.,.,.,.,:o.

Factions:

+factions - full list
+faction/set <type>=<name>
+faction/pay <Hunting|Helped|Harmed>=<0|1|2>

TODO: Skip the blow-by-blow and replace with +rep/log

TODO: Give players a way to clear all their upgrades/friends/etc. (Probably not, this only really applies to staff because only staff can keep going after 4+ upgrades)

*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts specifically for CG messages
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&layout.whose-stat [v(d.cgf)]=case(1, ulocal(f.is-crew-stat, %0), ulocal(f.get-crew-name, %2)'s, strmatch(%2, %3), your, ulocal(f.get-name, %2, %3)'s)

&layout.who-statting [v(d.cgf)]=case(1, ulocal(f.is-crew-stat, %0), ulocal(f.get-crew-name, %2), strmatch(%2, %3), your, ulocal(f.get-name, %2, %3))

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - value to display
&layout.set-message [v(d.cgf)]=cat(You set, ulocal(layout.whose-stat, %0, %1, %2, %3), %ch%0%cn, to, case(1, t(%4), %4, t(strlen(%1)), %ch%1%cn, nothing).)

&layout.staff-set-alert [v(d.cgf)]=cat(ulocal(f.get-name, %3) sets, ulocal(layout.whose-stat, %0, %1, %2, %3), %ch%0%cn, to, case(1, t(%4), %4, t(strlen(%1)), %ch%1%cn, nothing).)

&layout.add-message [v(d.cgf)]=cat(You, if(t(%4), increase, add), art(%0), ulocal(f.get-singular-stat-name, %0), to, ulocal(layout.whose-stat, %0, %1, %2, %3), %0, list:, %1.)

&layout.remove-message [v(d.cgf)]=cat(You, if(t(%4), lower, remove), art(%0), ulocal(f.get-singular-stat-name, %0), from, ulocal(layout.whose-stat, %0, %1, %2, %3), %0, list:, %1.)

&layout.staff-add-alert [v(d.cgf)]=cat(ulocal(f.get-name, %3) adds, art(%0), ulocal(f.get-singular-stat-name, %0), to, ulocal(layout.whose-stat, %0, %1, %2, %3), %0, list:, %1.)

&layout.staff-remove-alert [v(d.cgf)]=cat(ulocal(f.get-name, %3) removes, art(%0), ulocal(f.get-singular-stat-name, %0), from, ulocal(layout.whose-stat, %0, %1, %2, %3), %0, list:, %1.)

&layout.bad-or-restricted-values [v(d.cgf)]=strcat('%1' is not a value for, %b, ulocal(f.get-singular-stat-name, %0), . Valid values are:, %b, ulocal(layout.list, ulocal(f.list-valid-values, %0, %2))., if(t(setr(R, ulocal(layout.list, ulocal(f.list-restricted-values, %0)))), %bRestricted values are: %qR.))

&layout.cannot-edit-stats [v(d.cgf)]=if(strmatch(%1, %2), Your %0 cannot be changed after you have locked your stats. You will need to open a job with staff., setr(N, ulocal(f.get-name, %1, %2))'s stats are currently locked. To edit them%, you must %ch+stat/unlock %qN%cn.)

&layout.crew-object-error [v(d.cgf)]=if(strmatch(%2, %3), You must +crew/join <Crew Name> or +crew/create <Crew Name> first., ulocal(f.get-name, %2, %3) must join a crew or create a crew first.)

&layout.cannot-edit-crew-stats [v(d.cgf)]=if(strmatch(%1, %2), Your crew stat %0 cannot be changed after the crew has been approved. You will need to open a job with staff., setr(N, ulocal(f.get-name, %1, %2))'s crew stats are currently locked. To edit them%, you must %ch+crew/unlock %qN%cn.)

&layout.player_does_not_have_stat [v(d.cgf)]=if(strmatch(%2, %3), You don't have the %0 '%1'., ulocal(layout.who-statting, %0, %1, %2, %3) does not have the %0 '%1'.)

&layout.remove_message [v(d.cgf)]=if(strmatch(%2, %3), You have successfully removed the %0 '%1'., cat(You have removed, ulocal(layout.whose-stat, %0, %1, %2, %3), '%1' %0.))

&layout.upgrade-max [v(d.cgf)]=cat(if(strmatch(%2, %3), Adding this upgrade would take you over 4 points of Upgrades. Remove some upgrades to rearrange your dots. You currently have %0 Upgrades., cat(Adding this upgrade would take, ulocal(layout.who-statting, %0, %1, %2, %3), over 4 points of Upgrades. Remove some upgrades to rearrange their dots. They currently have %0 Upgrades.)), Remember that Cohorts cost 2 Upgrades apiece%, and adding an additional Type to a Cohort costs another 2 Upgrades.)

&layout.cohort-max [v(d.cgf)]=if(strmatch(%2, %3), Creating this cohort would take you over 4 points of Upgrades. You currently have %0. Move some points around before you create this cohort., cat(Creating this cohort would take, ulocal(layout.who-statting, %0, %1, %2, %3), over 4 points of Upgrades. They currently have %0. Move some points around before you create this cohort.))


@@ TODO: Add all other "you" style error messages here (so you can swap them to player-style if it's a staffer doing the setting)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Commands - TODO: redo these!
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stats/lock [v(d.cg)]=$+stats/lock:@assert not(hasattr(%#, _stat.locked))={ @trigger me/tr.error=%#, Your stats are already locked.; };  @set %#=_stat.locked:[time()]; @dolist/delimit | [xget(%vD, d.stats-that-default)]={ @set %#=[ulocal(f.get-stat-location-on-player, ##)]:[ulocal(f.get-player-stat, %#, ##)]; }; @set %#=ulocal(f.get-stat-location-on-player, xp.insight.max):[setr(M, switch(setr(P, ulocal(f.get-player-stat, %#, Playbook)), Vampire, 8, 6))]; @set %#=ulocal(f.get-stat-location-on-player, xp.prowess.max):%qM; @set %#=ulocal(f.get-stat-location-on-player, xp.resolve.max):%qM; @set %#=ulocal(f.get-stat-location-on-player, xp.playbook.max):[switch(%qP, Vampire, 10, 8)]; @trigger me/tr.success=%#, You locked your stats.;

@@ TODO: Figure out how stats/lock and unlock interact with jobs.

@@ TODO: CAN players unlock their stats? maybe they shouldn't be able to!

&c.+stats/unlock [v(d.cg)]=$+stats/unlock*:@assert not(isapproved(%#))={ @assert cand(lte(sub(secs(), xget(%#, _stat.unlock-request)), 600), match(trim(%0), YES))={ @set %#=_stat.unlock-request:[secs()];@trigger me/tr.message=%#, Warning: You are currently approved. Unlocking your stats will remove your approval. You'll need to get approved again to go IC! Are you sure? If so, type +stats/unlock YES within the next 10 minutes. It is now [prettytime()].; }; @trigger me/tr.unlock_stats=%#; }; @trigger me/tr.unlock_stats=%#;

&tr.unlock_stats [v(d.cg)]=@set %0=_stat.locked:; @set %0=!APPROVED; @trigger me/tr.success=%0, You have unlocked your stats. You can't be approved until you lock them again. Happy editing!;

&c.+approve [v(d.cg)]=$+approve *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to approve people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert hasattr(%#, _stat.locked)={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) has not locked [poss(%qP)] stats yet and cannot be approved.; }; @set %qP=APPROVED; @set %qP=[ulocal(f.get-stat-location-on-player, approved date)]:[prettytime()]; @set %qP=[ulocal(f.get-stat-location-on-player, approved by)]:[ulocal(f.get-name, %#)] (%#); @trigger me/tr.success=%#, You approved [ulocal(f.get-name, %qP, %#)]. Be sure to let them know!;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +stat commands for staffers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stat/set_staff [v(d.cg)]=$+stat/set */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(t(%0), t(%1))={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @trigger me/tr.set-stat=%1, %2, %qP, %#;

&c.+stat/add_staff [v(d.cg)]=$+stat/add */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to add stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(t(%0), t(%1))={ @trigger me/tr.error=%#, You need to enter something to add.; }; @trigger me/tr.add-stat=%1, %2, %qP, %#;

&c.+stat/remove_staff [v(d.cg)]=$+stat/remove */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to remove stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={  @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(t(%0), t(%1))={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @trigger me/tr.add-stat=%1, %2, %qP, %#, 1;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +stat commands for players
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stat/set [v(d.cg)]=$+stat/set *=*: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @trigger me/tr.set-stat=%0, %1, %#, %#;

&c.+stat/add [v(d.cg)]=$+stat/add *=*: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to add.; }; @trigger me/tr.add-stat=%0, %1, %#, %#;

&c.+stat/remove [v(d.cg)]=$+stat/remove *=*: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @trigger me/tr.add-stat=%0, %1, %#, %#, 1;

&c.+stat/clear [v(d.cg)]=$+stat/clear*: @assert not(hasattr(%#, _stat.locked))={ @trigger me/tr.error=%#, You can't clear your stats once they're locked.; };  @assert cand(gettimer(%#, clear-request), match(trim(%0), YES))={ @eval settimer(%#, clear-request, 600); @trigger me/tr.message=%#, This will clear all of your stats. If you would like to continue%, type %ch+stat/clear YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %#/_stat.*; @trigger me/tr.success=%#, Your stats have been cleared.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Aliases for commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stat/del [v(d.cg)]=$+stat/del*:@force %#=+stat/remove [switch(%0, %b*, trim(%0), rest(%0))];

&c.+stat/rem [v(d.cg)]=$+stat/rem*:@break strmatch(%0, ove *); @force %#=+stat/remove [switch(%0, %b*, trim(%0), rest(%0))];

&c.+cohort/del [v(d.cg)]=$+cohort/del*:@force %#=+cohort/remove [switch(%0, %b*, trim(%0), rest(%0))];

&c.+cohort/rem [v(d.cg)]=$+cohort/rem*:@break strmatch(%0, ove *); @force %#=+cohort/remove [switch(%0, %b*, trim(%0), rest(%0))];

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stat-setting triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: message to give setter
@@ %1: message to give settee
@@ %2: settee
@@ %3: setter
@@ %4: stat we're setting
&tr.stat-setting-messages [v(d.cg)]=@trigger me/tr.success=%3, %0; @if ulocal(f.is-crew-stat, %4)={ @trigger me/tr.crew-emit=ulocal(f.get-player-stat, %2, crew object), %1; }, { @assert strmatch(%2, %3)={ @trigger me/tr.success=%2, %1; }; };

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - adding or removing
&tr.add-stat [v(d.cg)]=@eval [setq(A, ulocal(f.get-addable-stats, %3))]; @assert t(setr(S, ulocal(f.is-addable-stat, %0)))={ @trigger me/tr.error=%3, Cannot find '%0' as an [case(%4, 1, removable, addable)] stat. [case(%4, 1, Removable, Addable)] stats are: [ulocal(layout.list, %qA)]; }; @assert ulocal(f.is-allowed-to-edit-stat, %2, %3, %qS)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %2, %3); }; @assert cor(not(t(strlen(%1))), t(strlen(setr(V, ulocal(f.get-pretty-value, %qS, %1, %2, %3)))), cand(t(finditem(Friends|Contacts, %qS, |)), t(setr(V, %1))))={ @trigger me/tr.error=%3, ulocal(layout.bad-or-restricted-values, %qS, %1, %2, %3, ulocal(f.get-singular-stat-name, %qS)); }; @trigger me/tr.add-or-remove-[if(hasattr(me, strcat(tr.add-or-remove-, setr(T, ulocal(f.get-stat-location, %qS)))), %qT, stat)]=%qS, %qV, %2, %3, %4;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - adding or removing
&tr.add-or-remove-stat [v(d.cg)]=@assert ulocal(f.is-allowed-to-edit-stat, %2, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %1, %2, %3); }; @eval strcat(setq(E, ulocal(f.get-player-stat, %2, %0)), setq(I, ulocal(f.find-list-index, %qE, %1))); @if t(%4)={ @trigger me/tr.remove-final-stat=%0, %1, %2, %3, %qE, %qI; }, { @trigger me/tr.add-final-stat=%0, %1, %2, %3, %qE, %qI; };

&tr.add-final-stat [v(d.cg)]=@assert cor(not(t(%1)), not(t(%5)))={ @trigger me/tr.error=%3, Player already has the %0 '%1'.; }; @eval setq(E, trim(strcat(xget(%2, ulocal(f.get-stat-location-on-player, %0)), |, %1), b, |)); @eval setq(E, if(cand(not(t(%1)), eq(words(%qE, |), 1)),, %qE)); @eval setq(A, ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2)); @assert cor(not(t(%1)), not(strmatch(%0, Abilities)), eq(words(%qE, |), 1), %qA)={ @trigger me/tr.error=%3, Player already has a Special Ability. Please remove one before adding this one.; }; @assert cor(not(strmatch(%0, Friends)), lte(words(%qE, |), 5), %qA)={ @trigger me/tr.error=%3, Player already has 5 Friends - remove one before adding more.; }; @assert cor(not(strmatch(%0, Contacts)), lte(words(%qE, |), 6), %qA)={ @trigger me/tr.error=%3, This crew already has 6 Contacts - remove one before adding more.; }; @set %2=[ulocal(f.get-stat-location-on-player, %0)]:%qE; @assert t(%1)={ @trigger me/tr.stat-setting-messages=ulocal(layout.set-message, %0, %1, %2, %3), ulocal(layout.staff-set-alert, %0, %1, %2, %3), %2, %3, %0; }; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, %0, %1, %2, %3), ulocal(layout.staff-add-alert, %0, %1, %2, %3), %2, %3, %0;

&tr.remove-final-stat [v(d.cg)]=@assert t(%5)={ @trigger me/tr.error=%3, Player doesn't have the %0 '%1'.; }; @eval setq(V, extract(%4, %5, 1, |, |)); @eval setq(E, ldelete(%4, %5, |, |)); @set %2=[ulocal(f.get-stat-location-on-player, %0)]:%qE; @trigger me/tr.stat-setting-messages=ulocal(layout.remove-message, %0, %qV, %2, %3), ulocal(layout.staff-remove-alert, %0, %1, %2, %3), %2, %3, %0;

&tr.add-or-remove-upgrades [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, %0, %1, %2, %3); }; @eval strcat(setq(E, ulocal(f.get-player-stat, %qC, Upgrades)), setq(I, ulocal(f.find-upgrade, %qE, %1))); @if t(%4)={ @trigger me/tr.remove-upgrades=%0, %1, %qC, %3, %qE, %qI; }, { @trigger me/tr.add-upgrades=%0, %1, %qC, %3, %qE, %qI; };

&tr.add-upgrades [v(d.cg)]=@eval if(t(%5), strcat(setq(E, %4), setq(I, %5)), strcat(setq(U, ulocal(f.get-upgrades-with-boxes)), setq(M, ulocal(f.find-upgrade, %qU, %1)), setq(E, strcat(%4, |, extract(%qU, %qM, 1, |))), setq(E, trim(%qE, b, |)), setq(I, words(%qE, |)))); @assert cand(t(%qE), t(%qI))={ @trigger me/tr.error=%3, There was an issue figuring out which value to add.; }; @eval setq(N, ulocal(f.tick-tickable, extract(%qE, %qI, 1, |))); @eval setq(E, replace(%qE, %qI, %qN, |, |)); @eval setq(T, add(ulocal(f.count-ticks, %qE), ulocal(f.get-total-cohort-cost, %2))); @assert strmatch(%qE, \[X\]*)={ @trigger me/tr.error=%3, Could not tick the upgrade box.; }; @assert not(strmatch(%qE, %4))={ @trigger me/tr.error=%3, Cannot add %ch%1%cn - it is already added and has no additional boxes to mark.; }; @assert cor(ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2), lte(%qT, 4))={ @trigger me/tr.error=%3, ulocal(layout.upgrade-max, %qT, 0, %2, %3); }; @set %2=ulocal(f.get-stat-location-on-player, %0):%qE; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, Upgrades, %1, %2, %3, eq(words(%qE, |), words(%4, |))), ulocal(layout.staff-add-alert, Upgrades, %1, %2, %3), %2, %3, Upgrades;

&tr.remove-upgrades [v(d.cg)]=@assert t(%5)={ @trigger me/tr.error=%3, ulocal(layout.player_does_not_have_stat, Upgrade, %1, %2, %3); }; @eval strcat(setq(E, replace(%4, %5, ulocal(f.untick-tickable, extract(%4, %5, 1, |)), |, |)), setq(F, %qE)); @eval iter(%qE, if(not(strmatch(itext(0), \\\\[X\\\\]*)), setq(F, remove(%qF, itext(0), |, |))), |, |); @set [ulocal(f.get-player-stat, %2, crew object)]=ulocal(f.get-stat-location-on-player, %0):%qF; @trigger me/tr.stat-setting-messages=ulocal(layout.remove-message, Upgrades, %1, %2, %3, eq(words(%qE), words(%qF))), ulocal(layout.staff-remove-alert, Upgrades, %1, %2, %3), %2, %3, Upgrades;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&tr.set-stat [v(d.cg)]=@assert t(setr(S, ulocal(f.is-stat, %0, %2, %3)))={ @trigger me/tr.error=%3, '%0' does not appear to be a stat. Valid stats are: [ulocal(layout.list, ulocal(f.list-stats, %0, %2, %3))]; }; @assert cor(not(t(ulocal(f.is-addable-stat, %0))), t(finditem(xget(%vD, d.settable-addable-stats), %qS, |)))={ @force %3=+stat/add [if(not(strmatch(%2, %3)), %2/)]%0=%1; }; @assert ulocal(f.is-allowed-to-edit-stat, %2, %3, %qS)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %2, %3); }; @assert cor(not(t(strlen(%1))), t(strlen(setr(V, ulocal(f.get-pretty-value, %qS, %1, %2, %3)))))={ @trigger me/tr.error=%3, ulocal(layout.bad-or-restricted-values, %qS, %1, %2, %3, ulocal(f.get-singular-stat-name, %qS)); }; @trigger me/tr.set-[case(1, t(ulocal(f.is-action, %qS)), action, ulocal(f.is-crew-stat, %qS), crew-stat, ulocal(f.is-full-list-stat, %qS), full-list-stat, final-stat)]=%qS, %qV, %2, %3;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - value to display
&tr.set-final-stat [v(d.cg)]=@set %2=[ulocal(f.get-stat-location-on-player, %0)]:%1; @trigger me/tr.stat-setting-messages=ulocal(layout.set-message, %0, %1, %2, %3, %4), ulocal(layout.staff-set-alert, %0, %1, %2, %3, %4), %2, %3, %0;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&tr.set-action [v(d.cg)]=@assert strcat(setq(T, ulocal(f.get-total-player-actions, %2, %0)), cor(lte(add(%qT, %1), 7), ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2)))={ @trigger me/tr.error=%3, Setting your %0 to %1 would take you over 7 points of actions. Reduce your action total to move the dots around.; }; @trigger me/tr.set-final-stat=%0, %1, %2, %3;

&tr.set-crew-stat [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %2, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, %0, %1, %2, %3); }; @assert not(ulocal(f.is-full-list-stat, %0))={ @trigger me/tr.set-full-list-stat=%0, %1, %qC, %3; }; @trigger me/tr.set-final-stat=%0, %1, %qC, %3;

&tr.set-full-list-stat [v(d.cg)]=@trigger me/tr.set-final-stat=%0, setr(0, xget(%vD, strcat(d., ulocal(f.get-stat-location, %0), ., if(t(%1), %1)))), %2, %3, if(t(%1), the %ch%1%cn list: [ulocal(layout.list, %q0)]);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +cohorts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohorts [v(d.cg)]=$+cohorts:@pemit %#=ulocal(layout.subsection, crew-cohorts, %#, %#);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Create cohorts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/create [v(d.cg)]=$+cohort/create *=*: @break strmatch(%0, */*);@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %#, %#); }; @assert t(%0)={ @trigger me/tr.error=%#, You must enter a name for the new cohort.; }; @eval strcat(setq(V, ulocal(f.get-cohort-stat-pretty-value, Types, %1)), setq(T, switch(%1, *s, Gang, V*, Vehicle, Expert))); @assert cand(t(%qV), t(%qT))={ @trigger me/tr.error=%#, Couldn't figure out what kind of cohort to create. Options are: [ulocal(layout.list, ulocal(f.list-cohort-stat-pretty-values, Types))]. If you want to make an Expert instead of a Gang%, leave off the "s" at the end of the type.; }; @trigger me/tr.create-cohort=%0, %qV, %#, %#, %qT;

&c.+cohort/create_staff [v(d.cg)]=$+cohort/create */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to create cohorts for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert t(%1)={ @trigger me/tr.error=%#, You must enter a name for the new cohort.; }; @eval strcat(setq(V, ulocal(f.get-cohort-stat-pretty-value, Types, %2)), setq(T, switch(%2, *s, Gang, V*, Vehicle, Expert))); @assert cand(t(%qV), t(%qT))={ @trigger me/tr.error=%#, Couldn't figure out what kind of cohort to create. Options are: [ulocal(layout.list, ulocal(f.list-cohort-stat-pretty-values, Types))]. If you want to make an Expert instead of a Gang%, leave off the "s" at the end of the type.; }; @trigger me/tr.create-cohort=%1, %qV, %qP, %#, %qT;

@@ %0 - name
@@ %1 - type
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - gang or expert type
&tr.create-cohort [v(d.cg)]=@assert cand(valid(attrname, setr(L, ulocal(f.get-stat-location-on-player, cohort_type.%0))), lte(strlen(%qL), 60))={ @trigger me/tr.error=%3, The name '%0' cannot be translated into a valid attribute name%, which means it won't work. Please change the name or open a job with staff requesting a fix.; }; @assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %2, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, Cohort, %0, %2, %3); }; @eval setq(T, ulocal(f.count-upgrades, %qC)); @eval setq(A, ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2)); @assert cor(not(strmatch(%1, Vehicle)), not(t(finditem(iter(ulocal(f.get-player-stat, %0, Cohorts), ulocal(f.get-cohort-stat, %0, itext(0), Cohort Type), |, |), Vehicle, |))), %qA)={ @trigger me/tr.error=%3, Players may only have one Vehicle cohort.; }; @assert cor(not(strmatch(%1, Vehicle)), ulocal(f.has-list-stat, %qC, Crew Abilities, Like Part of the Family), %qA)={ @trigger me/tr.error=%3, Players must have the Crew Ability "Like Part of the Family" to take a Vehicle as a cohort.; }; @assert cor(not(strmatch(%1, Vehicle)), ulocal(f.has-list-stat, %qC, Upgrades, Vehicle), %qA)={ @trigger me/tr.error=%3, You must have the Upgrade "Vehicle" to take a Vehicle as a cohort.; }; @assert cor(lte(add(%qT, 2), 4), strmatch(%1, Vehicle), %qA)={ @trigger me/tr.error=%3, ulocal(layout.cohort-max, %qT, 0, %2, %3); }; @eval setq(E, xget(%2, ulocal(f.get-stat-location-on-player, Cohorts))); @assert not(member(%qE, %1, |))={ @trigger me/tr.error=%3, Player already has the Cohort '%1'.; }; @trigger me/tr.add-or-remove-stat=Cohorts, %0, %qC, %3, 0, Cohort; @set %qC=ulocal(f.get-stat-location-on-player, cohort_type.%0):%4; @set %qC=ulocal(f.get-stat-location-on-player, types.%0):%1; @set %3=_stat.cohort.editing:%qC/%0; @pemit %3=strcat(header(Cohort, %3), %r, multicol(ulocal(layout.cohort, %2, %0), *, 0, |, %3), %r, footer());


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Destroy cohorts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/destroy [v(d.cg)]=$+cohort/destroy *:@break strmatch(%0, */*); @assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %#, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %#, %#)={ @trigger me/tr.error=%#, You can't edit your crew once it's locked.; }; @assert t(setr(N, ulocal(f.find-cohort, %qC, first(%0, =))))={ @trigger me/tr.error=%#, Could not find a cohort matching '[first(%0, =)]' in your crew.; }; @assert cand(gettimer(%#, cohort-destroy, %qN), match(rest(%0, =), YES))={ @eval settimer(%#, cohort-destroy, 600, %qN); @trigger me/tr.message=%#, This will destroy your cohort '%ch%qN%cn'. If you would like to continue%, type %ch+cohort/destroy %qN=YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %#/_stat.*.[ulocal(f.get-stat-location, %qN)]; @trigger me/tr.add-or-remove-stat=Cohorts, %qN, %qC, %#, 1, Cohort;

&c.+cohort/destroy_staff [v(d.cg)]=$+cohort/destroy */*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to destroy a player's cohort.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %#, %qP)={ @trigger me/tr.error=%#, You can't edit your crew once it's locked.; }; @assert t(setr(N, ulocal(f.find-cohort, %qC, first(%1, =))))={ @trigger me/tr.error=%#, Could not find a cohort matching '[first(%1, =)]' in [ulocal(f.get-name, %qP, %#)]'s crew.; }; @assert cand(gettimer(%qP, cohort-destroy, %qN), match(rest(%1, =), YES))={ @eval settimer(%qP, cohort-destroy, 600, %qN); @trigger me/tr.message=%#, This will destroy [ulocal(f.get-player-stat, %qP, Crew Name)]'s cohort '%ch%qN%cn'. If you would like to continue%, type %ch+cohort/destroy [ulocal(f.get-name, %qP, %#)]/%qN=YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %qP/_stat.*.[ulocal(f.get-stat-location, %qN)]; @trigger me/tr.add-or-remove-stat=Cohorts, %qN, %qC, %#, 1, Cohort;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Cohort editing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/edit [v(d.cg)]=$+cohort/edit *:@break strmatch(%0, */*); @assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %#, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %#, %#)={ @trigger me/tr.error=%#, You can't edit your crew once it's locked.; }; @assert t(setr(N, ulocal(f.find-cohort, %qC, first(%0, =))))={ @trigger me/tr.error=%#, Could not find a cohort matching '[first(%0, =)]' in your crew.; }; @set %#=_stat.cohort.editing:%#/%qN; @trigger me/tr.success=%#, You are now editing the %ch[ulocal(f.get-player-stat, %qC, crew name)]%cn cohort '%ch%qN%cn'.; 

&c.+cohort/edit_staff [v(d.cg)]=$+cohort/edit */*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to edit a player's cohort.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %#, %qP)={ @trigger me/tr.error=%#, You can't edit your crew once it's locked.; }; @assert t(setr(N, ulocal(f.find-cohort, %qC, first(%1, =))))={ @trigger me/tr.error=%#, Could not find a cohort matching '[first(%1, =)]' in [ulocal(f.get-name, %qP, %#)]'s crew.; }; @set %#=_stat.cohort.editing:%qP/%qN; @trigger me/tr.success=%#, You are now editing the %ch[ulocal(f.get-player-stat, %qC, crew name)]%cn cohort '%ch%qN%cn'.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Set cohort stats - this turned out to be way more massive than expected...
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/set [v(d.cg)]=$+cohort/set *=*: @eval strcat(setq(E, xget(%#, _stat.cohort.editing)), setq(P, first(%qE, /)), setq(N, rest(%qE, /))); @assert cand(t(%qP), t(%qN))={ @trigger me/tr.error=%#, You are not currently editing a Cohort. Type %ch+cohort/edit <name>%cn first.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %#)={ @trigger me/tr.error=%#, You can't edit a crew once it's locked.; }; @assert t(ulocal(f.find-cohort, %qC, %qN))={ @trigger me/tr.error=%#, Could not find a Cohort matching '%qN' in %ch[ulocal(f.get-player-stat, %qC, Crew Name)]%cn. Did it get destroyed or renamed?; }; @assert t(setr(S, ulocal(f.find-cohort-stat-name, %0)))={ @trigger me/tr.error=%#, Could not find a Cohort stat named '%0'. Valid stats are: [ulocal(layout.list, xget(%vD, d.cohort.stats))].; }; @assert not(ulocal(f.is-addable-cohort-stat, %qS))={ @force %#=+cohort/add %qS=%1; }; @assert t(setr(V, ulocal(f.get-cohort-stat-pretty-value, %qS, %1)))={ @trigger me/tr.error=%#, '%1' is not a valid value for %qS. Valid values are [ulocal(layout.list, ulocal(f.list-cohort-stat-pretty-values, %qS))].; }; @assert cor(not(strmatch(%qS, Specialty)), strmatch(ulocal(f.get-cohort-stat, %qC, %qN, Cohort Type), Expert))={ @trigger me/tr.error=%#, Gangs cannot have Specialties. %ch+cohort/set Cohort Type=Expert%cn if you want this cohort to have a Specialty.; }; @assert cor(not(strmatch(%qS, Name)), cand(valid(attrname, setr(W, ulocal(f.get-stat-location-on-player, cohort_type.%1))), lte(strlen(%qW), 60)))={ @trigger me/tr.error=%#, The name '%1' cannot be translated into a valid attribute name%, which means it won't work. Please change the name or open a job with staff requesting a fix.; }; @assert cor(not(strmatch(%qS, Name)), not(t(setr(A, finditem(ulocal(f.get-player-stat, %qC, Cohorts), %1, |)))), not(strmatch(%qA, %1)))={ @trigger me/tr.error=%#, There is already a cohort named %qA.; }; @set %qC=ulocal(f.get-stat-location-on-player, %qS.%qN):%qV; @trigger me/tr.success=%#, You set the %ch[ulocal(f.get-player-stat, %qC, crew name)]%cn cohort %ch%qN%cn's %qS to %ch%qV%cn.; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) set the crew Cohort %ch%qN%cn's %qS to %ch%qV%cn.; @assert not(strmatch(%qS, Name))={ @set %#=_stat.cohort.editing:%qC/%1; @set %qC=[ulocal(f.get-stat-location-on-player, Cohorts)]:[replace(setr(L, ulocal(f.get-player-stat, %qC, Cohorts)), member(%qL, %qN, |), %1, |, |)]; @dolist lattr(strcat(%qC, /, ulocal(f.get-stat-location-on-player, *.%qN)))={ @mvattr %qC=##, ulocal(f.get-stat-location, strcat(extract(##, 1, 2, .), ., %1)); }; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Add Flaws, Edges, and Types to a cohort
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/add [v(d.cg)]=$+cohort/add *=*: @eval strcat(setq(E, xget(%#, _stat.cohort.editing)), setq(P, first(%qE, /)), setq(N, rest(%qE, /))); @assert cand(t(%qP), t(%qN))={ @trigger me/tr.error=%#, You are not currently editing a Cohort. Type %ch+cohort/edit <name>%cn first.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %#)={ @trigger me/tr.error=%#, You can't edit a crew once it's locked.; }; @assert t(ulocal(f.find-cohort, %qC, %qN))={ @trigger me/tr.error=%#, Could not find a Cohort matching '%qN' in %ch[ulocal(f.get-player-stat, %qC, Crew Name)]%cn. Did it get destroyed or renamed?; }; @assert t(setr(S, ulocal(f.find-cohort-stat-name, %0)))={ @trigger me/tr.error=%#, Could not find a Cohort stat named '%0'. Valid stats are: [ulocal(layout.list, xget(%vD, d.cohort.stats))].; }; @assert ulocal(f.is-addable-cohort-stat, %qS)={ @force %#=+cohort/set %qS=%1; }; @assert t(setr(V, ulocal(f.get-cohort-stat-pretty-value, %qS, %1, setr(O, ulocal(f.get-cohort-stat, %qC, %qN, cohort_type)))))={ @trigger me/tr.error=%#, '%1' is not a valid value for %qS. Valid values are [ulocal(layout.list, ulocal(f.list-cohort-stat-pretty-values, %qS, %qO))].; }; @assert cor(not(strmatch(%qS, Types)), not(strmatch(%qO, Vehicle)))={ @trigger me/tr.error=%#, Vehicles cannot have additional Types.; };  @eval setq(E, ulocal(f.get-cohort-stat, %qC, %qN, %qS)); @assert not(t(finditem(%qE, %qV, |)))={ @trigger me/tr.error=%#, '%qV' is already one of this Cohort's %qS.; };  @assert lte(inc(words(ulocal(f.get-cohort-stat, %qC, %qN, %qS), |)), 2)={ @trigger me/tr.error=%#, Adding %qV would take you over 2 %qS. Remove one or more existing %qS before adding a new one.; }; @eval setq(T, ulocal(f.count-upgrades, %qC)); @assert cor(not(strmatch(%qS, Types)), ulocal(f.is-allowed-to-break-stat-setting-rules, %#, %qC), lte(add(%qT, 2), 4))={ @trigger me/tr.error=%#, ulocal(layout.upgrade-max, %qT, 0, %qC, %#); }; @set %qC=[ulocal(f.get-stat-location-on-player, %qS.%qN)]:[trim(%qE|%qV, b, |)]; @trigger me/tr.success=%#, You add '%ch[if(cand(strmatch(%qS, Types), strmatch(ulocal(f.get-cohort-stat, %qC, %qN, cohort type), Expert)), mid(%qV, 0, dec(strlen(%qV))), %qV)]%cn' to %ch[ulocal(f.get-player-stat, %qC, crew name)]%cn cohort %ch%qN%cn's %qS.; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) added '%ch[if(cand(strmatch(%qS, Types), strmatch(ulocal(f.get-cohort-stat, %qC, %qN, cohort type), Expert)), mid(%qV, 0, dec(strlen(%qV))), %qV)]%cn' to the crew's Cohort %ch%qN%cn's %qS.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Remove Flaws, Edges, and Types from a cohort
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/remove [v(d.cg)]=$+cohort/remove *=*: @eval strcat(setq(E, xget(%#, _stat.cohort.editing)), setq(P, first(%qE, /)), setq(N, rest(%qE, /))); @assert cand(t(%qP), t(%qN))={ @trigger me/tr.error=%#, You are not currently editing a Cohort. Type %ch+cohort/edit <name>%cn first.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %#)={ @trigger me/tr.error=%#, You can't edit a crew once it's locked.; }; @assert t(ulocal(f.find-cohort, %qC, %qN))={ @trigger me/tr.error=%#, Could not find a Cohort matching '%qN' in %ch[ulocal(f.get-player-stat, %qC, Crew Name)]%cn. Did it get destroyed or renamed?; }; @assert t(setr(S, ulocal(f.find-cohort-stat-name, %0)))={ @trigger me/tr.error=%#, Could not find a Cohort stat named '%0'. Valid stats are: [ulocal(layout.list, xget(%vD, d.cohort.stats))].; }; @assert t(setr(V, ulocal(f.get-cohort-stat-pretty-value, %qS, %1, setr(O, ulocal(f.get-cohort-stat, %qC, %qN, cohort_type)))))={ @trigger me/tr.error=%#, '%1' is not a valid value for %qS. Valid values are [ulocal(layout.list, ulocal(f.list-cohort-stat-pretty-values, %qS, %qO))].; }; @assert ulocal(f.is-addable-cohort-stat, %qS)={ @force %#=+cohort/set %qS=%1; }; @eval setq(E, ulocal(f.get-cohort-stat, %qC, %qN, %qS)); @assert t(finditem(%qE, %qV, |))={ @trigger me/tr.error=%#, '%qV' is not one of this Cohort's %qS.; }; @assert gt(words(%qE, |), 1)={ @trigger me/tr.error=%#, Removing %qV would take the cohort down to no %qS. Add new %qS before you remove this one.; };  @set %qC=[ulocal(f.get-stat-location-on-player, %qS.%qN)]:[remove(%qE, %qV, |, |)]; @trigger me/tr.success=%#, You remove '%ch[if(cand(strmatch(%qS, Types), strmatch(ulocal(f.get-cohort-stat, %qC, %qN, cohort type), Expert)), mid(%qV, 0, dec(strlen(%qV))), %qV)]%cn' from %ch[ulocal(f.get-player-stat, %qC, crew name)]%cn cohort %ch%qN%cn's %qS.; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) removed '%ch[if(cand(strmatch(%qS, Types), strmatch(ulocal(f.get-cohort-stat, %qC, %qN, cohort type), Expert)), mid(%qV, 0, dec(strlen(%qV))), %qV)]%cn' from the crew's Cohort %ch%qN%cn's %qS.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Factions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+factions [v(d.cg)]=$+factions:@pemit %#=ulocal(layout.factions, %#, %#);

&c.+factions_player [v(d.cg)]=$+factions *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view a player's factions.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @pemit %#=ulocal(layout.subsection, crew-factions, %qC, %#);

&c.+fact [v(d.cg)]=$+fact*:@break strmatch(%0, ions*); @break strmatch(%0, ion/*); @force %#=+factions [switch(%0, %b*, trim(%0), rest(%0))];

@@ TODO: Decide if non-staff can +factions people. Remember that once it's publicly visible it becomes a vanity stat and people may pay a lot of attention to it.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +faction/set
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+faction/set [v(d.cg)]=$+faction/set *=*:@break strmatch(%0, */*); @trigger me/tr.faction-set=%0, %1, %#, %#;

&c.+faction/set_staff [v(d.cg)]=$+faction/set */*=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set a crew's factions.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @trigger me/tr.faction-set=%1, %2, %qP, %#;

&tr.faction-set [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %3)={ @trigger me/tr.error=%3, You can't edit a crew once it's locked.; }; @assert t(setr(Q, finditem(xget(%vD, d.faction.questions), %0, |)))={ @trigger me/tr.error=%3, '%0' is not a valid Faction Question. Faction Questions are: [ulocal(layout.list, xget(%vD, d.faction.questions))].; }; @assert cor(not(strmatch(%qQ, Hunting)), t(setr(H, ulocal(f.get-player-stat, %qC, hunting grounds))))={ @trigger me/tr.error=%3, You can't choose the faction that claims this crew's Hunting Grounds until the crew's Hunting Grounds are set.; }; @assert t(setr(F, finditem(setr(L, switch(%qQ, Hunting, xget(%vD, ulocal(f.get-stat-location, d.%qH.factions)), ulocal(f.get-all-factions))), %1, |)))={ @trigger me/tr.error=%3, '%1' is not a valid Faction. [if(lte(words(%qL, |), 10), cat(Available factions are, ulocal(layout.list, %qL).), You can view the list of factions with +factions.)]; }; @assert case(%qQ, Helped, not(strmatch(%qF, first(ulocal(f.get-player-stat, %qC, faction.harmed), |))), Harmed, not(strmatch(%qF, first(ulocal(f.get-player-stat, %qC, faction.helped), |))), 1)={ @trigger me/tr.error=%3, The faction who helped this crew cannot be the same faction that harmed the crew.; }; @assert case(%qQ, Friendly, not(strmatch(%qF, first(ulocal(f.get-player-stat, %qC, faction.unfriendly), |))), Unfriendly, not(strmatch(%qF, first(ulocal(f.get-player-stat, %qC, faction.friendly), |))), 1)={ @trigger me/tr.error=%3, The faction who is friendly to this crew cannot be the same faction that is unfriendly to them.; }; @eval setq(T, rest(ulocal(f.get-player-stat-or-default, %qC, faction.%qQ, |0), |)); @set %qC=[ulocal(f.get-stat-location-on-player, faction.%qQ)]:%qF|%qT; @wipe %qC/[ulocal(f.get-stat-location-on-player, Factions)]; @trigger me/tr.recalculate-factions=%qC; @trigger me/tr.success=%3, You set %ch[ulocal(f.get-player-stat, %qC, Crew Name)]%cn's %qQ faction to %ch%qF%cn. [if(t(member(Friendly|Unfriendly, %qQ, |)), if(t(%qT), This crew has an intensified relationship with this faction, This crew has a normal relationship with this faction), This crew has paid them %qT coin)] for a total status of [ulocal(f.get-faction-status, %qC, %qF)].; @trigger me/tr.crew-emit=%qC, ulocal(f.get-name, %#) sets the crew's %qQ faction to %ch%qF%cn. [if(t(member(Friendly|Unfriendly, %qQ, |)), if(t(%qT), This crew has an intensified relationship with this faction, This crew has a normal relationship with this faction), This crew has paid them %qT coin)] for a total status of [ulocal(f.get-faction-status, %qC, %qF)].;

&tr.recalculate-factions [v(d.cg)]=@eval setr(E, iter(xget(%vD, d.faction.questions), first(ulocal(f.get-player-stat, %0, strcat(faction., itext(0))), |), |, |)); @set %0=[ulocal(f.get-stat-location-on-player, Factions)]:[setunion(setr(L, stripansi(iter(%qE, cat(ulocal(f.get-faction-status, %0, itext(0)), itext(0)), |, |))), %qL, |)];

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +faction/pay
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+faction/pay [v(d.cg)]=$+faction/pay *=*:@break strmatch(%0, */*); @trigger me/tr.faction-pay=%0, %1, %#, %#;

&c.+faction/pay_staff [v(d.cg)]=$+faction/pay */*=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to edit a crew's factions.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @trigger me/tr.faction-pay=%0, %1, %qP, %#;

&c.+faction/boost [v(d.cg)]=$+faction/boost:@assert lte(rest(ulocal(f.get-player-stat, ulocal(f.get-player-stat, %#, crew object), strcat(faction., Friendly)), |), 0)={ @trigger me/tr.error=%#, You have already boosted your crew's relations with their Friendly and Unfriendly factions.; }; @trigger me/tr.faction-pay=Friendly, 1, %#, %#, You have increased this crew's reputation with their Friendly faction; @trigger me/tr.faction-pay=Unfriendly, -1, %#, %#, You have decreased this crew's reputation with their Unfriendly faction;

&c.+faction/boost_staff [v(d.cg)]=$+faction/boost *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to edit a crew's factions.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert lte(rest(ulocal(f.get-player-stat, ulocal(f.get-player-stat, %qP, crew object), strcat(faction., Friendly)), |), 0)={ @trigger me/tr.error=%#, You have already boosted this crew's relations with their Friendly and Unfriendly factions.; }; @trigger me/tr.faction-pay=Friendly, 1, %qP, %#, You have increased this crew's reputation with their Friendly faction; @trigger me/tr.faction-pay=Unfriendly, -1, %qP, %#, You have decreased this crew's reputation with their Unfriendly faction;

&c.+faction/unboost [v(d.cg)]=$+faction/unboost:@assert gt(rest(ulocal(f.get-player-stat, ulocal(f.get-player-stat, %#, crew object), strcat(faction., Friendly)), |), 0)={ @trigger me/tr.error=%#, Your crew's relations with their Friendly and Unfriendly factions are already unboosted.; }; @trigger me/tr.faction-pay=Friendly, 0, %#, %#, You have normalized this crew's reputation with their Friendly faction; @trigger me/tr.faction-pay=Unfriendly, 0, %#, %#, You have normalized this crew's reputation with their Unfriendly faction;

&c.+faction/unboost_staff [v(d.cg)]=$+faction/unboost *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to edit a crew's factions.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert gt(rest(ulocal(f.get-player-stat, ulocal(f.get-player-stat, %qP, crew object), strcat(faction., Friendly)), |), 0)={ @trigger me/tr.error=%#, This crew's relations with their Friendly and Unfriendly factions are already unboosted.; }; @trigger me/tr.faction-pay=Friendly, 0, %qP, %#, You have normalized this crew's reputation with their Friendly faction; @trigger me/tr.faction-pay=Unfriendly, 0, %qP, %#, You have normalized this crew's reputation with their Unfriendly faction;

&tr.faction-pay [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %3)={ @trigger me/tr.error=%3, You can't edit a crew once it's locked.; }; @assert t(setr(Q, finditem(setr(L, setdiff(xget(%vD, d.faction.questions), if(not(t(%4)), Friendly|Unfriendly), |)), %0, |)))={ @trigger me/tr.error=%3, '%0' is not a valid Faction Question that can be paid. Payable Faction Questions are: [ulocal(layout.list, %qL)].; }; @assert cor(not(strmatch(%qQ, Hunting)), t(setr(H, ulocal(f.get-player-stat, %qC, hunting grounds))))={ @trigger me/tr.error=%3, This crew can't pay the faction that claims their Hunting Grounds until they choose their Hunting Grounds.; }; @eval setq(T, ulocal(f.get-player-stat-or-default, %qC, faction.%qQ, |0)); @eval setq(F, first(%qT, |)); @assert t(%qF)={ @trigger me/tr.error=%3, The crew needs to set a %qQ faction before they can pay them.; }; @assert cand(isnum(%1), cor(gte(%1, 0), strmatch(%qQ, Unfriendly)), lte(%1, switch(%qQ, Hunting, 2, 1)))={ @trigger me/tr.error=%3, '%1' is not a valid amount to pay. This crew can pay [ulocal(layout.list, lnum(switch(%qQ, Hunting, 3, 2),, |), or)] Coin.; }; @assert lte(add(setr(X, ulocal(f.get-total-faction-coin, %qC, %qQ)), %1), 2)={ @trigger me/tr.error=%3, Your crew has 2 coin total. %qX of it has already been spent.; }; @set %qC=[ulocal(f.get-stat-location-on-player, faction.%qQ)]:[replace(%qT, 2, %1, |, |)]; @wipe %qC/[ulocal(f.get-stat-location-on-player, Factions)]; @trigger me/tr.recalculate-factions=%qC; @trigger me/tr.success=%3, if(t(%4), %4, You have paid your crew's %qQ faction%, %ch%qF%cn%, %1 coin) for a total status of [ulocal(f.get-faction-status, %qC, %qF)].; @trigger me/tr.crew-emit=%qC, if(t(%4), edit(%4, You have, ulocal(f.get-name, %3) has), ulocal(f.get-name, %3) has paid the crew's %qQ faction%, %ch%qF%cn%, %1 coin) for a total status of [ulocal(f.get-faction-status, %qC, %qF)].;


@@ TODO: Make it so that +faction/pay Unfriendly|Friendly just lower/raise intensity rather than costing coin or being rejected.
