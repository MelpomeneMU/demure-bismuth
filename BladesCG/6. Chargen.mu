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

+cohort/create <name>=Gang of <gang type>
+cohort/create <name>=Expert <expert type>

+cohort/add <name>/Type=<value>
+cohort/add <name>/Edge=<value>
+cohort/add <name>/Flaw=<value>

+cohort/remove - same syntax as +cohort/add

+cohort/destroy <name> - will ask "are you sure".

Staff Cohort commands:

+cohort/create <player>/<name>=<same as above>
+cohort/add <player>/<cohort stat>=<value>
+cohort/remove <player>/<cohort stat>=<value>
+cohort/destroy <player>/<cohort>

Example Cohort setting:

+cohort/create Aramina the Bold=Expert Medic
+cohort/add Aramina/Type=Haberdasher
+cohort/add Aramina/Edge=Independent
+cohort/add Aramina/Edge=Tenacious
+cohort/add Aramina/Flaw=Principled
+cohort/add Aramina/Flaw=Unreliable

+cohort/create The Sly Brothers=Gang of Skulks
+cohort/add The Sly/Edge=Independent
+cohort/add The Sly/Flaw=Principled

+cohort/create The Hatter Boys=Gang of Rovers
+cohort/add The Hat/Type=Thugs
+cohort/add The Hat/Edge=Ten
+cohort/add The Hat/Flaw=Savage

*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts specifically for CG messages
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - value to display
&layout.set-message [v(d.cgf)]=if(strmatch(%2, %3), cat(You set your, %ch%0%cn, to, case(1, t(%4), %4, t(strlen(%1)), %ch%1%cn, nothing).), cat(You set, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2, %3)'s), %ch%0%cn, to, case(1, t(%4), t(strlen(%1)), %ch%1%cn, nothing).))

&layout.staff-set-alert [v(d.cgf)]=cat(ulocal(f.get-name, %3) sets, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2)'s), %ch%0%cn, to, case(1, t(%4), %4, t(strlen(%1)), %ch%1%cn, nothing).)

&layout.add-message [v(d.cgf)]=if(strmatch(%2, %3), cat(You, if(t(%4), increase, add), art(%0), %0: %ch%1%cn.), cat(You, if(t(%4), increase, add), art(%0), %0, to, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2)'s), %0, list:, %1.))

&layout.remove-message [v(d.cgf)]=if(strmatch(%2, %3), cat(You, if(t(%4), lower, remove), art(%0), %0: %ch%1%cn.), cat(You, if(t(%4), lower, remove), art(%0), %0, from, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2)'s), %0, list:, %1.))

&layout.staff-add-alert [v(d.cgf)]=cat(ulocal(f.get-name, %3) adds, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2)'s), %ch%1%cn, %0.)

&layout.staff-remove-alert [v(d.cgf)]=cat(ulocal(f.get-name, %3) removes, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2)'s), %ch%1%cn, %0.)

&layout.bad-or-restricted-values [v(d.cgf)]=strcat('%1' is not a value for %0. Valid values are:, %b, itemize(ulocal(f.list-valid-values, %0, %2), |)., if(t(setr(R, itemize(ulocal(f.list-restricted-values, %0), |))), %bRestricted values are: %qR.))

&layout.cannot-edit-stats [v(d.cgf)]=if(strmatch(%1, %2), Your %0 cannot be changed after you have locked your stats. You will need to open a job with staff., setr(N, ulocal(f.get-name, %1, %2))'s stats are currently locked. To edit them%, you must %ch+stat/unlock %qN%cn.)

&layout.crew-object-error [v(d.cgf)]=if(strmatch(%2, %3), You must +crew/join <Crew Name> or +crew/create <Crew Name> first., ulocal(f.get-name, %2, %3) must join a crew or create a crew first.)

&layout.cannot-edit-crew-stats [v(d.cgf)]=if(strmatch(%1, %2), Your crew stat %0 cannot be changed after the crew has been approved. You will need to open a job with staff., setr(N, ulocal(f.get-name, %1, %2))'s crew stats are currently locked. To edit them%, you must %ch+crew/unlock %qN%cn.)

&layout.player_does_not_have_stat [v(d.cgf)]=if(strmatch(%2, %3), You don't have the %0 '%1'., if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2, %3)) does not have the %0 '%1'.)

&layout.remove_message [v(d.cgf)]=if(strmatch(%2, %3), You have successfully removed the %0 '%1'., cat(You have removed, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), ulocal(f.get-name, %2, %3)'s), '%1' %0.))

&layout.upgrade-max [v(d.cgf)]=cat(if(strmatch(%2, %3), Adding this upgrade would take you over 4 points of Upgrades. Remove some upgrades to rearrange your dots. You currently have %0 Upgrades., cat(Adding this upgrade would take, ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), over 4 points of Upgrades. Remove some upgrades to rearrange their dots. They currently have %0 Upgrades.)), Remember that Cohorts cost 2 Upgrades apiece%, and adding an additional Type to a Cohort costs another 2 Upgrades.)

&layout.cohort-max [v(d.cgf)]=if(strmatch(%2, %3), Creating this cohort would take you over 4 points of Upgrades. You currently have %0. Move some points around before you create this cohort., cat(Creating this cohort would take, ulocal(f.get-player-stat, ulocal(f.get-player-stat, %2, crew object), crew name), over 4 points of Upgrades. They currently have %0. Move some points around before you create this cohort.))


@@ TODO: Add all other "you" style error messages here (so you can swap them to player-style if it's a staffer doing the setting)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Commands - TODO: redo these!
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stats/lock [v(d.cg)]=$+stats/lock: @set %#=_stat.locked:[time()]; @trigger me/tr.success=%#, You locked your stats and added yourself to staff's list;

@@ TODO: During lock, take any Default Values that are blank (but show up on the sheet) and actually put them on the player.

@@ TODO: Calculate number of advances (if we allow higher-than-CG characters) and stick them on the sheet.

@@ TODO: Figure out how stats/lock and unlock interact with jobs.

&c.+stats/unlock [v(d.cg)]=$+stats/unlock*:@assert not(isapproved(%#))={ @assert cand(lte(sub(secs(), xget(%#, _stat.unlock-request)), 600), match(trim(%0), YES))={ @set %#=_stat.unlock-request:[secs()];@trigger me/tr.message=%#, Warning: You are currently approved. Unlocking your stats will remove your approval. You'll need to get approved again to go IC! Are you sure? If so, type +stats/unlock YES within the next 10 minutes. It is now [prettytime()].; }; @trigger me/tr.unlock_stats=%#; }; @trigger me/tr.unlock_stats=%#;

&tr.unlock_stats [v(d.cg)]=@set %0=_stat.locked:; @set %0=!APPROVED; @trigger me/tr.success=%0, You have unlocked your stats. You can't be approved until you lock them again. Happy editing!;

&c.+approve [v(d.cg)]=$+approve *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to approve people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @set %qP=APPROVED; @trigger me/tr.success=%#, You approved [ulocal(f.get-name, %qP, %#)]. Be sure to let them know!;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +stat commands for staffers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stat/set_staff [v(d.cg)]=$+stat/set */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(t(%0), t(%1))={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @trigger me/tr.set-stat=%0, %1, %qP, %#;

&c.+stat/add_staff [v(d.cg)]=$+stat/add */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to add stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(t(%0), t(%1))={ @trigger me/tr.error=%#, You need to enter something to add.; }; @trigger me/tr.add-stat=%0, %1, %qP, %#;

&c.+stat/remove_staff [v(d.cg)]=$+stat/remove */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to remove stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={  @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert cand(t(%0), t(%1))={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @trigger me/tr.add-stat=%0, %1, %qP, %#, 1;

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

&c.+stats/clear [v(d.cg)]=$+stats/clear*:@force %#=+stat/clear%0

&c.+stat/del [v(d.cg)]=$+stat/del*:@force %#=+stat/remove [if(strmatch(trim(%0), * *), rest(%0), trim(%0))];

&c.+stat/rem [v(d.cg)]=$+stat/rem*:@break strmatch(%0, ove *); @force %#=+stat/remove [if(strmatch(trim(%0), * *), rest(%0), trim(%0))];

 
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stat-setting triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - adding or removing
&tr.add-stat [v(d.cg)]=@eval [setq(A, ulocal(f.get-addable-stats, %2, %3))]; @assert t(setr(S, finditem(%qA, %0, |)))={ @trigger me/tr.error=%3, Cannot find '%0' as an [case(%4, 1, removable, addable)] stat. [case(%4, 1, Removable, Addable)] stats are: [itemize(%qA, |)]; }; @assert ulocal(f.is-allowed-to-edit-stat, %2, %3, %qS)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %2, %3); }; @assert cor(not(t(strlen(%1))), t(setr(V, ulocal(f.get-pretty-value, %qS, %1, %2, %3))))={ @trigger me/tr.error=%3, ulocal(layout.bad-or-restricted-values, %qS, %1, %2, %3); }; @trigger me/tr.add-or-remove-[if(hasattr(me, strcat(tr.add-or-remove-, setr(T, ulocal(f.get-stat-location, %qS)))), %qT, stat)]=%qS, %qV, %2, %3, %4;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - adding or removing
@@ %5 - the text to pass into the error and success messages
&tr.add-or-remove-stat [v(d.cg)]=@assert ulocal(f.is-allowed-to-edit-stat, %2, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %1, %2, %3); }; @eval strcat(setq(E, ulocal(f.get-player-stat, %2, %0)), setq(I, ulocal(f.find-list-index, %qE, %1))); @if t(%4)={ @trigger me/tr.remove-final-stat=%0, %1, %2, %3, %qE, %qI, %5; }, { @trigger me/tr.add-final-stat=%0, %1, %2, %3, %qE, %qI, %5; };

&tr.add-final-stat [v(d.cg)]=@assert not(t(%5))={ @trigger me/tr.error=%3, Player already has the %0 '%1'.; }; @eval setq(E, trim(%4|%1, b, |)); @set %2=[ulocal(f.get-stat-location-on-player, %0)]:%qE; @trigger me/tr.success=%2, ulocal(layout.add-message, if(t(%6), %6, %0), %1, %2, %3); @assert strmatch(%2, %3)={ @cemit xget(%vD, d.log-staff-statting-to-channel)=ulocal(layout.staff-add-alert, if(t(%6), %6, %0), %1, %2, %3); };

&tr.remove-final-stat [v(d.cg)]=@assert t(%5)={ @trigger me/tr.error=%3, Player doesn't have the %0 '%1'.; }; @eval setq(E, ldelete(%4, %5, |, |)); @set %2=[ulocal(f.get-stat-location-on-player, %0)]:%qE; @trigger me/tr.success=%2, ulocal(layout.remove-message, if(t(%6), %6, %0), %1, %2, %3); @assert strmatch(%2, %3)={ @cemit xget(%vD, d.log-staff-statting-to-channel)=ulocal(layout.staff-remove-alert, if(t(%6), %6, %0), %1, %2, %3); };

&tr.add-or-remove-upgrades [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %qC, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, %0, %1, %2, %3); }; @eval strcat(setq(E, ulocal(f.get-player-stat, %2, Upgrades)), setq(I, ulocal(f.find-upgrade, %qE, %1))); @if t(%4)={ @trigger me/tr.remove-upgrades=%0, %1, %qC, %3, %qE, %qI; }, { @trigger me/tr.add-upgrades=%0, %1, %qC, %3, %qE, %qI; };

&tr.add-upgrades [v(d.cg)]=@eval if(t(%5), strcat(setq(E, %4), setq(I, %5)), strcat(setq(U, ulocal(f.get-upgrades-with-boxes)), setq(M, ulocal(f.find-upgrade, %qU, %1)), setq(E, strcat(%4, |, extract(%qU, %qM, 1, |))), setq(E, trim(%qE, b, |)), setq(I, words(%qE, |)))); @assert cand(t(%qE), t(%qI))={ @trigger me/tr.error=%3, There was an issue figuring out which value to add.; }; @eval setq(T, ulocal(f.count-upgrades, %2)); @eval setq(N, ulocal(f.tick-tickable, extract(%qE, %qI, 1, |))); @eval setq(E, replace(%qE, %qI, %qN, |, |)); @assert strmatch(%qE, \[X\]*)={ @trigger me/tr.error=%3, Could not tick the upgrade box.; }; @assert not(strmatch(%qE, %4))={ @trigger me/tr.error=%3, Cannot add %ch%1%cn - it is already added and has no additional boxes to mark.; }; @assert cor(ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2), lte(add(ulocal(f.count-ticks, %qN), %qT), 4))={ @trigger me/tr.error=%3, ulocal(layout.upgrade-max, %qT, 0, %2, %3); }; @set %2=ulocal(f.get-stat-location-on-player, %0):%qE; @trigger me/tr.success=%3, ulocal(layout.add-message, Upgrade, %1, %2, %3, eq(words(%qE, |), words(%4, |))); @assert strmatch(%2, %3)={ @cemit xget(%vD, d.log-staff-statting-to-channel)=ulocal(layout.staff-add-alert, Upgrade, %1, %2, %3); };

&tr.remove-upgrades [v(d.cg)]=@assert t(%5)={ @trigger me/tr.error=%3, ulocal(layout.player_does_not_have_stat, Upgrade, %1, %2, %3); }; @eval strcat(setq(E, replace(%4, %5, ulocal(f.untick-tickable, extract(%4, %5, 1, |)), |, |)), setq(F, %qE)); @eval iter(%qE, if(not(strmatch(itext(0), \\\\[X\\\\]*)), setq(F, remove(%qF, itext(0), |, |))), |, |); @set [ulocal(f.get-player-stat, %2, crew object)]=ulocal(f.get-stat-location-on-player, %0):%qF; @trigger me/tr.success=%3, ulocal(layout.remove-message, Upgrade, %1, %2, %3, eq(words(%qE), words(%qF))); @assert strmatch(%2, %3)={ @cemit xget(%vD, d.log-staff-statting-to-channel)=ulocal(layout.staff-remove-alert, Upgrade, %1, %2, %3, eq(words(%qE, |), words(%qF, |))); };

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&tr.set-stat [v(d.cg)]=@assert t(setr(S, ulocal(f.is-stat, %0, %2)))={ @trigger me/tr.error=%3, '%0' does not appear to be a stat.; }; @assert ulocal(f.is-allowed-to-edit-stat, %2, %3, %qS)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %2, %3); }; @assert cor(not(t(strlen(%1))), t(setr(V, ulocal(f.get-pretty-value, %qS, %1, %2, %3))))={ @trigger me/tr.error=%3, ulocal(layout.bad-or-restricted-values, %qS, %1, %2, %3); }; @trigger me/tr.set-[case(1, t(ulocal(f.is-action, %qS)), action, ulocal(f.is-crew-stat, %qS), crew-stat, ulocal(f.is-full-list-stat, %qS), full-list-stat, final-stat)]=%qS, %qV, %2, %3;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - value to display
&tr.set-final-stat [v(d.cg)]=@set %2=[ulocal(f.get-stat-location-on-player, %0)]:%1; @trigger me/tr.success=%2, ulocal(layout.set-message, %0, %1, %2, %3, %4); @assert strmatch(%2, %3)={ @cemit xget(%vD, d.log-staff-statting-to-channel)=ulocal(layout.staff-set-alert, %0, %1, %2, %3, %4); };

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&tr.set-action [v(d.cg)]=@pemit %3=Test;@assert strcat(setq(T, ulocal(f.get-total-player-actions, %2, %0)), lte(add(%qT, %1), 7))={ @trigger me/tr.error=%3, Setting your %0 to %1 would take you over 7 points of actions. Reduce your action total to move the dots around.; }; @trigger me/tr.set-final-stat=%0, %1, %2, %3; 

&tr.set-crew-stat [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %2, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, %0, %1, %2, %3); }; @assert not(ulocal(f.is-full-list-stat, %0))={ @trigger me/tr.set-full-list-stat=%0, %1, %qC, %3; }; @trigger me/tr.set-final-stat=%0, %1, %qC, %3;

&tr.set-full-list-stat [v(d.cg)]=@trigger me/tr.set-final-stat=%0, setr(0, xget(%vD, strcat(d., ulocal(f.get-stat-location, %0), ., if(t(%1), %1)))), %2, %3, if(t(%1), the %ch%1%cn list: [itemize(%q0, |)]);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Create cohorts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/create [v(d.cg)]=$+cohort/create *=*: @break strmatch(%0, */*);@assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %#, %#); }; @assert t(%0)={ @trigger me/tr.error=%#, You must enter a name for the new cohort.; }; @assert t(setr(T, switch(%1, Gang of *, Gang, Expert *, Expert)))={ @trigger me/tr.error=%#, Your Cohort Type must be in the format '%chGang of <type>%cn' or '%chExpert <type>%cn' For example: +cohort/create The Testing Gang=Gang of Skulks; }; @eval setq(V, switch(%1, Expert *, rest(%1), Gang of *, extract(%1, 3, 1))); @assert t(%qV)={ @trigger me/tr.error=%#, Could not figure out what you meant by '%1'; }; @assert cor(strmatch(%qT, Expert), t(setr(V, ulocal(f.get-cohort-stat-pretty-value, Gang Types, %qV))))={ @trigger me/tr.error=%#, Gang Type must be one of the following: [itemize(xget(%vD, d.cohort.gang_types), |)].; }; @trigger me/tr.create-cohort=%0, %qV, %#, %#, %qT;

&c.+cohort/create_staff [v(d.cg)]=$+cohort/create */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to create cohorts for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert t(%1)={ @trigger me/tr.error=%#, You must enter a name for the new cohort.; }; @assert t(setr(T, switch(%2, Gang of *, Gang, Expert *, Expert)))={ @trigger me/tr.error=%#, The Cohort Type must be in the format '%chGang of <type>%cn' or '%chExpert <type>%cn' For example: +cohort/create The Testing Gang=Gang of Skulks; }; @eval setq(V, switch(%2, Expert *, rest(%2), Gang of *, extract(%2, 3, 1))); @assert t(%qV)={ @trigger me/tr.error=%#, Could not figure out what you meant by '%2'; }; @assert cor(strmatch(%qT, Expert), t(setr(V, ulocal(f.get-cohort-stat-pretty-value, Gang Types, %qV))))={ @trigger me/tr.error=%#, Gang Type must be one of the following: [itemize(xget(%vD, d.cohort.gang_types), |)].; }; @trigger me/tr.create-cohort=%0, %qV, %qP, %#, %qT;

@@ %0 - name
@@ %1 - type
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - gang or expert type
&tr.create-cohort [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %2, %3)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, Cohort, %0, %2, %3); }; @eval setq(T, ulocal(f.count-upgrades, %qC)); @assert lte(add(%qT, 2), 4)={ @trigger me/tr.error=%3, ulocal(layout.cohort-max, %qT, 0, %2, %3); }; @eval setq(E, xget(%2, ulocal(f.get-stat-location-on-player, Cohorts))); @assert not(member(%qE, %1, |))={ @trigger me/tr.error=%3, Player already has the Cohort '%1'.; }; @trigger me/tr.add-or-remove-stat=Cohorts, %0, %qC, %3, 0, Cohort; @set %qC=ulocal(f.get-stat-location-on-player, cohort_type.%0):%4; @set %qC=ulocal(f.get-stat-location-on-player, types.%0):%1;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Destroy cohorts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+cohort/destroy [v(d.cg)]=$+cohort/destroy *:@break strmatch(%0, */*); @assert t(setr(C, ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %#, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %#, %#)={ @trigger me/tr.error=%#, You can't edit your crew once it's locked.; }; @assert t(setr(N, ulocal(f.find-cohort, %qC, first(%0, =))))={ @trigger me/tr.error=%#, Could not find a cohort matching '[first(%0, =)]' in your crew.; }; @assert cand(gettimer(%#, cohort-destroy, %qN), match(rest(%0, =), YES))={ @eval settimer(%#, cohort-destroy, 600, %qN); @trigger me/tr.message=%#, This will destroy your cohort '%ch%qN%cn'. If you would like to continue%, type %ch+cohort/destroy %qN=YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %#/_stat.*.[ulocal(f.get-stat-location, %qN)]; @trigger me/tr.add-or-remove-stat=Cohorts, %qN, %qC, %#, 1, Cohort;

&c.+cohort/destroy_staff [v(d.cg)]=$+cohort/destroy */*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to destroy a player's cohort.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(C, ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(layout.crew-object-error, %0, %1, %qP, %#); }; @assert ulocal(f.is-allowed-to-edit-crew, %#, %qP)={ @trigger me/tr.error=%#, You can't edit your crew once it's locked.; }; @assert t(setr(N, ulocal(f.find-cohort, %qC, first(%1, =))))={ @trigger me/tr.error=%#, Could not find a cohort matching '[first(%1, =)]' in [ulocal(f.get-name, %qP, %#)]'s crew.; }; @assert cand(gettimer(%qP, cohort-destroy, %qN), match(rest(%1, =), YES))={ @eval settimer(%qP, cohort-destroy, 600, %qN); @trigger me/tr.message=%#, This will destroy [ulocal(f.get-player-stat, %qP, Crew Name)]'s cohort '%ch%qN%cn'. If you would like to continue%, type %ch+cohort/destroy [ulocal(f.get-name, %qP, %#)]/%qN=YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %qP/_stat.*.[ulocal(f.get-stat-location, %qN)]; @trigger me/tr.add-or-remove-stat=Cohorts, %qN, %qC, %#, 1, Cohort;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Add Flaws, Edges, and Types to a cohort
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

