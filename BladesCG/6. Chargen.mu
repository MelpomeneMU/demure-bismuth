@@ TODO: Hawkers' Silver Tongues ability gives you an extra dot of Sway, Command, or Consort and will allow you to bypass the default restrictions.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts for CG messages
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

&layout.cannot-edit-crew-stats [v(d.cgf)]=if(strmatch(%1, %2), Your crew stat %0 cannot be changed after the crew has been locked. You will need to open a job with staff., setr(N, ulocal(f.get-name, %1, %2))'s crew stats are currently locked. To edit them%, you must %ch+crew/unlock %qN%cn.)

&layout.player_does_not_have_stat [v(d.cgf)]=if(strmatch(%2, %3), You don't have the %0 '%1'., ulocal(layout.who-statting, %0, %1, %2, %3) does not have the %0 '%1'.)

&layout.remove_message [v(d.cgf)]=if(strmatch(%2, %3), You have successfully removed the %0 '%1'., cat(You have removed, ulocal(layout.whose-stat, %0, %1, %2, %3), '%1' %0.))

&layout.upgrade-max [v(d.cgf)]=cat(if(strmatch(%2, %3), Adding this upgrade would take you over 4 points of Upgrades. Remove some upgrades to rearrange your dots. You currently have %0 Upgrades., cat(Adding this upgrade would take, ulocal(layout.who-statting, %0, %1, %2, %3), over 4 points of Upgrades. Remove some upgrades to rearrange their dots. They currently have %0 Upgrades.)), Remember that Cohorts cost 2 Upgrades apiece%, and adding an additional Type to a Cohort costs another 2 Upgrades.)

&layout.cohort-max [v(d.cgf)]=if(strmatch(%2, %3), Creating this cohort would take you over 4 points of Upgrades. You currently have %0. Move some points around before you create this cohort., cat(Creating this cohort would take, ulocal(layout.who-statting, %0, %1, %2, %3), over 4 points of Upgrades. They currently have %0. Move some points around before you create this cohort.))

@@ TODO: Add all other "you" style error messages here (so you can swap them to player-style if it's a staffer doing the setting)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Lock and unlock
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.chargen-job [v(d.cgf)]=strcat(ulocal(f.get-name, %0) is ready to be approved., %r%r%b, Staff will be looking for:%R%T* Does your character fit into the theme OK?%R%T* Desc can't be underage.%R%T* Desc should be at least one (relevant) sentence long.%R%T* Anything missing? Any, %b, ulocal(layout.fail), %b, marks on the CG check?, %r%r%b, If you have any questions%, please add them to this job!)

&c.+stats/lock [v(d.cg)]=$+stats/lock:@assert not(hasattr(%#, _stat.locked))={ @trigger me/tr.error=%#, Your stats are already locked.; }; @assert gettimer(%#, stats-lock)={ @trigger me/tr.message=%#, You are about to lock your stats. This will create a job (or add to your existing job if you already have one) and make it so you cannot edit your character any more. Are you sure? If yes%, type %ch+stats/lock%cn again within the next 10 minutes. The time is now [prettytime()].; @eval settimer(%#, stats-lock, 600); }; @trigger me/tr.lock-stats=%#; @if cand(isdbref(setr(J, xget(%#, _chargen-job))), ulocal(f.can-add-to-job, %#, %qJ))={ @trigger %vA/trig_add=%qJ, cat(ulocal(f.get-name, %#) has locked, poss(%#), stats again.), %#, ADD; @trigger me/tr.success=%#, You locked your stats. A comment has been added to your CG job to let staff know to take another look.; @trigger %vA/trig_broadcast=%#, cat(CG:, name(%qJ):, ulocal(f.get-name, %#), locked, poss(%#) stats again.), ADD; }, { @trigger %vA/trig_create=%#, xget(%vG, d.CG-bucket), 1, ulocal(f.get-name, %#): Ready for approval, ulocal(layout.chargen-job, %#); @trigger me/tr.success=%#, You locked your stats. A job has been created with staff to examine your character. Type %ch+myjobs%cn to see it.; }

&tr.lock-stats [v(d.cg)]=@set %0=_stat.locked:[prettytime()]; @dolist/delimit | [xget(%vG, d.stats-that-default)]={ @set %0=[ulocal(f.get-stat-location-on-player, ##)]:[ulocal(f.get-player-stat, %0, ##)]; }; @set %0=ulocal(f.get-stat-location-on-player, xp.insight.max):[setr(M, switch(setr(P, ulocal(f.get-player-stat, %0, Playbook)), Vampire, 8, 6))]; @set %0=ulocal(f.get-stat-location-on-player, xp.prowess.max):%qM; @set %0=ulocal(f.get-stat-location-on-player, xp.resolve.max):%qM; @set %0=ulocal(f.get-stat-location-on-player, xp.playbook.max):[switch(%qP, Vampire, 10, 8)]; 

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Unlock stats
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stats/unlock [v(d.cg)]=$+stats/unlock *:@assert isstaff(%#)={ @trigger me/tr.error=%#, Only staff can unlock players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert hasattr(%qP, _stat.locked)={ @trigger me/tr.error=%#, %qN's stats are not currently locked and cannot be unlocked.; }; @assert gettimer(%#, unlock-%qP)={ @trigger me/tr.message=%#, You're about to unlock %qN's stats. This will put them back into CG and let them make changes according to CG rules. It will almost certainly mess up their sheet if they have any advancements. Are you sure? If so%, hit %ch+stats/unlock %qN%cn again within the next 10 minutes. The time is now [prettytime()].; @eval settimer(%#, unlock-%qP, 600); }; @trigger me/tr.unlock_stats=%qP, %#;

&tr.unlock_stats [v(d.cg)]=@set %0=_stat.locked:; @set %0=!APPROVED; @set %0=[ulocal(f.get-stat-location-on-player, approved date)]:; @set %0=[ulocal(f.get-stat-location-on-player, approved by)]:; @trigger me/tr.success=%1, cat(You have unlocked, ulocal(f.get-name, %0, %1)'s, stats.); @trigger me/tr.message=%0, ulocal(f.get-name, %1, %0) has unlocked your stats. You can't be approved until you lock them again. Happy editing!;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ App Log
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.app_log [v(d.cgf)]=strcat(header(cat(App log, -, ulocal(f.get-name, %0)), %1), %r, formattext(strcat(setq(A, iter(ulocal(f.get-last-X-logs, %0, _app-, 100), ulocal(layout.log, xget(%0, itext(0))),, |)), if(t(%qA), %qA, No app log entries yet.)), 0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&c.+app/log [v(d.cg)]=$+app/log:@pemit %#=ulocal(layout.app_log, %#, %#);

&c.+app/log_staff [v(d.cg)]=$+app/log *:@assert isstaff(%#)={ @trigger me/tr.error=%#, Only staff can view other players' app logs.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.app_log, %qP, %#);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Approval
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+approve [v(d.cg)]=$+approve *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to approve people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert hasattr(%qP, _stat.locked)={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) has not locked [poss(%qP)] stats yet and cannot be approved.; }; @assert t(%1)={ @trigger me/tr.error=%#, Please enter a reason for approval.; }; @trigger me/tr.approve-player=%qP, %#, %1; @trigger me/tr.success=%#, You approved [ulocal(f.get-name, %qP, %#)] with the comment '%1'.; @trigger me/tr.message=%qP, ulocal(f.get-name, %#, %qP) approved your character with the comment '%1'. Congratulations!; 

&tr.approve-player [v(d.cg)]=@trigger me/tr.lock-stats=%0; @set %0=APPROVED; @set %0=[ulocal(f.get-stat-location-on-player, approved date)]:[prettytime()]; @set %0=[ulocal(f.get-stat-location-on-player, approved by)]:[ulocal(f.get-name, %1)] (%1); @set %0=[ulocal(f.get-stat-location-on-player, frozen date)]:; @set %0=[ulocal(f.get-stat-location-on-player, frozen by)]:; @trigger me/tr.log=%0, _app-, %1, Approved with comment '%2'.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Unapproval
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+unapprove [v(d.cg)]=$+unapprove *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to unapprove people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert isapproved(%qP)={ @trigger me/tr.error=%#, %qN is not approved so cannot be unapproved.; }; @assert t(%1)={ @trigger me/tr.error=%#, Please enter a reason for unapproval. The player will see this message.; }; @trigger me/tr.unapprove-player=%qP, %#, %1; @trigger me/tr.success=%#, You unapproved [ulocal(f.get-name, %qP, %#)] with the comment '%1'.; @trigger me/tr.message=%qP, You have been unapproved by [ulocal(f.get-name, %#, %qP)] with the comment '%1'.; 

&tr.unapprove-player [v(d.cg)]=@set %0=!APPROVED; @set %0=[ulocal(f.get-stat-location-on-player, approved date)]:; @set %0=[ulocal(f.get-stat-location-on-player, approved by)]:; @trigger me/tr.log=%0, _app-, %1, Unapproved with comment '%2'.; @trigger me/tr.tel-unapproved-player=%0, %1;

&tr.tel-unapproved-player [v(d.cg)]=@if cand(not(default(d.allow-unapproved-players-IC, 0)), not(ulocal(f.is-location-ooc, loc(%0))))={ @trigger me/tr.travel_to_destination=v(d.ooc), %0, %1, sent by; };

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Freezing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+freeze_player [v(d.cg)]=$+freeze me=*:@break isstaff(%#)={ @trigger me/tr.error=%#, Staff are not allowed to self-freeze. Hit +staff/rem me if you want to freeze yourself.; }; @assert t(%0)={ @trigger me/tr.error=%#, Please enter a reason for freezing yourself. This reason will be logged to your +app/log.; }; @assert gettimer(%#, freeze-warning)={ @trigger me/tr.message=%#, You are about to freeze yourself. This will change your name to [strcat(edit(name(%#), %b, _), _, edit(%#, #,))] and mark you as frozen. Frozen characters are not permitted to RP. You will not be able to unfreeze without staff assistance. Are you sure? If yes%, type %ch+freeze me=%0%cn again within the next 10 minutes. The time is now [prettytime()].; @eval settimer(%#, freeze-warning, 600); }; @trigger me/tr.freeze-player=%#, %#, %0; @trigger me/tr.success=%#, Your character is now frozen. Good luck on your next character!; @trigger me/tr.monitor=%#, [cat(Froze, obj(%#)self because '%0'.)];

&c.+freeze [v(d.cg)]=$+freeze *=*:@break strmatch(%0, me); @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to unapprove and freeze people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert t(%1)={ @trigger me/tr.error=%#, Please enter a reason for freezing. The player will see this message.; }; @assert not(t(ulocal(f.get-player-stat, %qP, frozen date)))={ @trigger me/tr.error=%#, %qN is already frozen and cannot be frozen again. Did you mean +retire?; }; @trigger me/tr.unapprove-player=%qP, %#, %1; @trigger me/tr.freeze-player=%qP, %#, %1; @trigger me/tr.success=%#, You unapproved and froze [ulocal(f.get-name, %qP, %#)] with the comment '%1'.; @trigger me/tr.message=%qP, You have been unapproved and frozen by [ulocal(f.get-name, %#, %qP)] with the comment '%1'.;

&tr.freeze-player [v(d.cg)]=@set %0=[ulocal(f.get-stat-location-on-player, frozen date)]:[prettytime()]; @set %0=[ulocal(f.get-stat-location-on-player, frozen by)]:[ulocal(f.get-name, %1)] (%1); @name %0=strcat(edit(first(name(%0), _), %b, _), edit(%0, #, _)); @wipe %0/alias; @trigger me/tr.log=%0, _app-, %1, Unapproved and frozen with comment '%2'.; @trigger me/tr.tel-unapproved-player=%0, %1;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Unfreezing
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+unfreeze [v(d.cg)]=$+unfreeze *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to unfreeze people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert t(%1)={ @trigger me/tr.error=%#, Please enter a reason for unfreezing. The player will see this message.; }; @trigger me/tr.unfreeze-player=%qP, %#, %1; @trigger me/tr.success=%#, You unfroze [ulocal(f.get-name, %qP, %#)] with the comment '%1'. Note that unfreezing does not approve players for play - if you want to approve them%, type %ch+approve <player>=<reason>%cn.; @trigger me/tr.message=%qP, You have been unfrozen by [ulocal(f.get-name, %#, %qP)] with the comment '%1'. You can reclaim your name with %ch@name me=<name>%cn%, so long as another player hasn't taken it.;

&tr.unfreeze-player [v(d.cg)]=@set %0=[ulocal(f.get-stat-location-on-player, frozen date)]:; @set %0=[ulocal(f.get-stat-location-on-player, frozen by)]:; @trigger me/tr.log=%0, _app-, %1, Unfrozen with comment '%2'.;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Retirement
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+retire [v(d.cg)]=$+retire *=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to retire people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert isapproved(%qP)={ @trigger me/tr.error=%#, %qN is not approved so cannot be retired.; }; @assert t(%1)={ @trigger me/tr.error=%#, Please enter a reason for retirement. The player will see this message.; }; @assert gettimer(%#, retire-%qP)={ @trigger me/tr.message=%#, You are about to permanently retire %qN. The character cannot be restored. Are you sure? If yes%, type %ch+retire %0=%1%cn again within the next 10 minutes. The time is now [prettytime()].; @eval settimer(%#, retire-%qP, 600); }; @trigger me/tr.retire-player=%qP, %#, %1; @trigger me/tr.success=%#, You retired [ulocal(f.get-name, %qP, %#)] with the comment '%1'.;

&tr.retire-player [v(d.cg)]=@trigger me/tr.unapprove-player=%0, %1, %2; @set %0=[ulocal(f.get-stat-location-on-player, retired date)]:[prettytime()]; @set %0=[ulocal(f.get-stat-location-on-player, retired by)]:[ulocal(f.get-name, %1)] (%1); @trigger me/tr.log=%0, _app-, %1, Retired with comment '%2'.;

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

&c.+stats/clear [v(d.cg)]=$+stats/clear*: @assert not(hasattr(%#, _stat.locked))={ @trigger me/tr.error=%#, You can't clear your stats once they're locked.; }; @assert gettimer(%#, clear-request, if(t(trim(%0)), trim(%0), NO))={ @eval settimer(%#, clear-request, 600, YES); @trigger me/tr.message=%#, This will clear all of your stats and any crew stats you may have set on you. %(If you don't want to lose those%, +crew\/transfer <player> to give the crew to someone else before you +stats/clear.%) If you would like to continue%, type %ch+stat/clear YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %#/_stat.*; @trigger me/tr.success=%#, Your stats have been cleared.;

&c.+stat/find [v(d.cg)]=$+stat/find *: @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to find.; }; @trigger me/tr.find-stat=first(%0, =), rest(%0, =), %#;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Aliases for commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stats [v(d.cg)]=$+stats*:@break switch(%0, /clear*, 1, /lock, 1, /unlock *, 1, /fi*, 1, /sea*, 1, /set*, 1, 0)={ @force %#=+stat%0; }; @force %#=+sheet%0;

&c.+stat/del [v(d.cg)]=$+stat/del*:@force %#=+stat/remove [switch(%0, %b*, trim(%0), rest(%0))];

&c.+stat/rem [v(d.cg)]=$+stat/rem*:@break strmatch(%0, ove *); @force %#=+stat/remove [switch(%0, %b*, trim(%0), rest(%0))];

&c.+stat/search [v(d.cg)]=$+stat/sea*:@force %#=+stat/find [switch(%0, %b*, trim(%0), rest(%0))];

&c.+stat/fi [v(d.cg)]=$+stat/fi*:@break strmatch(%0, nd *); @force %#=+stat/find [switch(%0, %b*, trim(%0), rest(%0))];

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stat-finding
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ Default max list of items is 1000. Replace '1000' with something better if it becomes a problem.
&tr.find-stat [v(d.cg)]=@eval setq(D, 0); @assert cand(t(setr(S, ulocal(f.is-stat, %0, #1, #1))), not(gt(words(%0, *), 1)))={ @eval setq(R, xget(%vG, d.staff-only-stats)); @trigger me/tr.message=%2, strcat(Stats matching '%0' are:, %b, ulocal(layout.list, iter(finditems(ulocal(f.list-all-stats, %2), %0, |), if(t(member(%qR, itext(0), |)), ansi(xh, itext(0)[setq(D, 1)]), itext(0)), |, |),, 1000)., if(t(%qD), %bStats in %cx%chdark text%cn can only be set by staff.)); }; @eval setq(V, ulocal(f.list-values, %qS, %2)); @eval setq(R, ulocal(f.list-restricted-values, %qS, %2)); @trigger me/tr.message=%2, strcat(ulocal(f.get-singular-stat-name, %qS), %b, values, if(t(%1), %bwith '%1' in them):, %b, ulocal(layout.list, if(t(%qV), iter(finditems(%qV, %1, |), if(t(member(%qR, itext(0), |)), ansi(xh, itext(0)[setq(D, 1)]), itext(0)), |, |), any unrestricted text),, 1000)., if(t(%qD), %bValues in %cx%chdark text%cn are restricted.));

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stat-setting triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: message to give setter
@@ %1: message to give settee
@@ %2: settee
@@ %3: setter
@@ %4: stat we're setting
&tr.stat-setting-messages [v(d.cg)]=@if ulocal(f.is-crew-stat, %4)={ @trigger me/tr.crew-emit=ulocal(f.get-player-stat, %2, crew object), %1, %2; @assert strmatch(%2, %3)={ @trigger me/tr.success=%3, %0; }; }, { @trigger me/tr.success=%3, %0; @assert strmatch(%2, %3)={ @trigger me/tr.success=%2, %1; }; };

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - adding or removing
&tr.add-stat [v(d.cg)]=@eval [setq(A, ulocal(f.get-addable-stats, %3))]; @assert t(setr(S, ulocal(f.is-addable-stat, %0, %3)))={ @trigger me/tr.error=%3, Cannot find '%0' as an [case(%4, 1, removable, addable)] stat. [case(%4, 1, Removable, Addable)] stats are: [ulocal(layout.list, %qA)]; }; @assert ulocal(f.is-allowed-to-edit-stat, %3, %2, %qS)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %2, %3); }; @assert cor(not(t(strlen(%1))), t(strlen(setr(V, ulocal(f.get-pretty-value, %qS, %1, %2, %3)))), cand(t(finditem(Friends|Contacts, %qS, |)), t(setr(V, %1))))={ @trigger me/tr.error=%3, ulocal(layout.bad-or-restricted-values, %qS, %1, %2, %3, ulocal(f.get-singular-stat-name, %qS)); }; @trigger me/tr.add-or-remove-[if(hasattr(me, strcat(tr.add-or-remove-, setr(T, ulocal(f.get-stat-location, %qS)))), %qT, stat)]=%qS, %qV, %2, %3, %4;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - adding or removing
&tr.add-or-remove-stat [v(d.cg)]=@assert ulocal(f.is-allowed-to-edit-stat, %3, %2, %0)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-stats, %0, %1, %2, %3); }; @eval strcat(setq(E, ulocal(f.get-player-stat, %2, %0)), setq(I, ulocal(f.find-list-index, %qE, %1))); @if t(%4)={ @trigger me/tr.remove-final-stat=%0, %1, %2, %3, %qE, %qI; }, { @trigger me/tr.add-final-stat=%0, %1, %2, %3, %qE, %qI; };

&tr.add-final-stat [v(d.cg)]=@assert cor(not(t(%1)), not(t(%5)))={ @trigger me/tr.error=%3, Player already has the %0 '%1'.; }; @eval setq(C, if(ulocal(f.is-crew-stat, %0), ulocal(f.get-player-stat, %2, crew object), %2)); @eval setq(E, trim(strcat(xget(%qC, ulocal(f.get-stat-location-on-player, %0)), |, %1), b, |)); @eval setq(E, if(cand(not(t(%1)), eq(words(%qE, |), 1)),, %qE)); @eval setq(A, ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2)); @assert cor(not(t(%1)), not(strmatch(%0, Abilities)), eq(words(%qE, |), 1), %qA)={ @trigger me/tr.error=%3, Player already has a Special Ability. Please remove one before adding this one.; }; @assert cor(not(strmatch(%0, Friends)), lte(words(%qE, |), 5), %qA)={ @trigger me/tr.error=%3, Player already has 5 Friends - remove one before adding more.; }; @assert cor(not(strmatch(%0, Contacts)), lte(words(%qE, |), 6), %qA)={ @trigger me/tr.error=%3, This crew already has 6 Contacts - remove one before adding more.; }; @set %qC=[ulocal(f.get-stat-location-on-player, %0)]:%qE; @assert t(%1)={ @trigger me/tr.stat-setting-messages=ulocal(layout.set-message, %0, %1, %2, %3), ulocal(layout.staff-set-alert, %0, %1, %2, %3), %2, %3, %0; }; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, %0, %1, %2, %3), ulocal(layout.staff-add-alert, %0, %1, %2, %3), %2, %3, %0;

&tr.remove-final-stat [v(d.cg)]=@assert t(%5)={ @trigger me/tr.error=%3, Player doesn't have the %0 '%1'.; }; @eval setq(V, extract(%4, %5, 1, |, |)); @eval setq(E, ldelete(%4, %5, |, |)); @set %2=[ulocal(f.get-stat-location-on-player, %0)]:%qE; @trigger me/tr.stat-setting-messages=ulocal(layout.remove-message, %0, %qV, %2, %3), ulocal(layout.staff-remove-alert, %0, %1, %2, %3), %2, %3, %0;

&tr.add-or-remove-upgrades [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %3, %qC)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, %0, %1, %2, %3); }; @eval strcat(setq(E, ulocal(f.get-player-stat, %qC, Upgrades)), setq(I, ulocal(f.find-tickable, %qE, %1))); @if t(%4)={ @trigger me/tr.remove-upgrades=%0, %1, %qC, %3, %qE, %qI; }, { @trigger me/tr.add-upgrades=%0, %1, %qC, %3, %qE, %qI; };

&tr.add-upgrades [v(d.cg)]=@eval if(t(%5), strcat(setq(E, %4), setq(I, %5)), strcat(setq(U, ulocal(f.get-upgrades-with-boxes)), setq(M, ulocal(f.find-tickable, %qU, %1)), setq(E, strcat(%4, |, extract(%qU, %qM, 1, |))), setq(E, trim(%qE, b, |)), setq(I, words(%qE, |)))); @assert cand(t(%qE), t(%qI))={ @trigger me/tr.error=%3, There was an issue figuring out which value to add.; }; @eval setq(N, ulocal(f.tick-tickable, extract(%qE, %qI, 1, |))); @eval setq(E, replace(%qE, %qI, %qN, |, |)); @eval setq(T, add(ulocal(f.count-ticks, %qE), ulocal(f.get-total-cohort-cost, %2))); @assert strmatch(%qE, \[X\]*)={ @trigger me/tr.error=%3, Could not tick the upgrade box.; }; @assert not(strmatch(%qE, %4))={ @trigger me/tr.error=%3, Cannot add %ch%1%cn - it is already added and has no additional boxes to mark.; }; @assert cor(ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2), lte(%qT, 4))={ @trigger me/tr.error=%3, ulocal(layout.upgrade-max, sub(%qT, ulocal(f.count-ticks, %qN)), 0, %2, %3); }; @set %2=ulocal(f.get-stat-location-on-player, %0):%qE; @trigger me/tr.stat-setting-messages=ulocal(layout.add-message, Upgrades, %1, %2, %3, eq(words(%qE, |), words(%4, |))), ulocal(layout.staff-add-alert, Upgrades, %1, %2, %3), %2, %3, Upgrades;

&tr.remove-upgrades [v(d.cg)]=@assert t(%5)={ @trigger me/tr.error=%3, ulocal(layout.player_does_not_have_stat, Upgrade, %1, %2, %3); }; @eval strcat(setq(E, replace(%4, %5, ulocal(f.untick-tickable, extract(%4, %5, 1, |)), |, |)), setq(F, %qE)); @eval iter(%qE, if(not(strmatch(itext(0), \\\\[X\\\\]*)), setq(F, remove(%qF, itext(0), |, |))), |, |); @set [ulocal(f.get-player-stat, %2, crew object)]=ulocal(f.get-stat-location-on-player, %0):%qF; @trigger me/tr.stat-setting-messages=ulocal(layout.remove-message, Upgrades, %1, %2, %3, eq(words(%qE), words(%qF))), ulocal(layout.staff-remove-alert, Upgrades, %1, %2, %3), %2, %3, Upgrades;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&tr.set-stat [v(d.cg)]=@assert t(setr(S, ulocal(f.is-stat, %0, %2, %3)))={ @trigger me/tr.error=%3, '%0' does not appear to be a stat. Valid stats are: [ulocal(layout.list, ulocal(f.list-stats, %0, %2, %3))]; }; @assert cor(not(t(ulocal(f.is-addable-stat, %0, %3))), t(finditem(xget(%vG, d.settable-addable-stats), %qS, |)))={ @force %3=+stat/add [if(not(strmatch(%2, %3)), %2/)]%0=%1; }; @eval setq(I, ulocal(f.is-crew-stat, %qS)); @assert ulocal(f.is-allowed-to-edit-[if(%qI, crew, stat)], %3, %2, %qS)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-[if(%qI, crew-stats, stats)], %0, %2, %3); }; @assert cor(not(t(strlen(%1))), t(strlen(setr(V, ulocal(f.get-pretty-value, %qS, %1, %2, %3)))))={ @trigger me/tr.error=%3, ulocal(layout.bad-or-restricted-values, %qS, %1, %2, %3, ulocal(f.get-singular-stat-name, %qS)); }; @trigger me/tr.set-[case(1, t(ulocal(f.is-action, %qS)), action, %qI, crew-stat, ulocal(f.is-full-list-stat, %qS), full-list-stat, final-stat)]=%qS, %qV, %2, %3;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %4 - value to display
@@ %5 - different staff message (optional)
@@ %6 - different alert message (optional)
&tr.set-final-stat [v(d.cg)]=@set %2=[ulocal(f.get-stat-location-on-player, %0)]:%1; @trigger me/tr.stat-setting-messages=if(t(%5), %5, ulocal(layout.set-message, %0, %1, %2, %3, %4)), if(t(%6), %6, ulocal(layout.staff-set-alert, %0, %1, %2, %3, %4)), %2, %3, %0;

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
&tr.set-action [v(d.cg)]=@assert strcat(setq(T, ulocal(f.get-total-player-actions, %2, %0)), cor(lte(add(%qT, %1), 7), ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2)))={ @trigger me/tr.error=%3, Setting your %0 to %1 would take you over 7 points of actions. Reduce your action total to move the dots around.; }; @trigger me/tr.set-final-stat=%0, %1, %2, %3;

&tr.set-crew-stat [v(d.cg)]=@assert t(setr(C, ulocal(f.get-player-stat, %2, crew object)))={ @trigger me/tr.error=%3, ulocal(layout.crew-object-error, %0, %1, %2, %3); }; @assert ulocal(f.is-allowed-to-edit-crew, %3, %2)={ @trigger me/tr.error=%3, ulocal(layout.cannot-edit-crew-stats, %0, %1, %2, %3); }; @assert not(ulocal(f.is-full-list-stat, %0))={ @trigger me/tr.set-full-list-stat=%0, %1, %qC, %3; }; @trigger me/tr.set-final-stat=%0, %1, %qC, %3;

&tr.set-full-list-stat [v(d.cg)]=@trigger me/tr.set-final-stat=%0, setr(0, xget(%vG, strcat(d., ulocal(f.get-stat-location, %0), ., if(t(%1), %1)))), %2, %3, if(t(%1), the %ch%1%cn list: [ulocal(layout.list, %q0)]);
