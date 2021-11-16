/*
 =[ Characterrs awaiting approval ]===========================================
 Alice: Akorosi Academic Cutter - Last: Request for approval submitted.
 Bob: Apothecary Shop owner - Last: Bob, your Name is still Bobbitus Maximu...
 =============================================================================

+cg/who - who's in chargen and their status. Staff-restricted? Includes everyone on in the last 30 days.

+cg/approvable - who's locked and ready for approval.

+cg/check Alice

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

*/


&c.+stats/lock [v(d.cg)]=$+stats/lock: @set %#=_stat.locked:[time()]; @trigger me/tr.success=%#, You locked your stats and added yourself to staff's list;

&c.+stats/unlock [v(d.cg)]=$+stats/unlock*:@assert not(isapproved(%#))={ @assert cand(lte(sub(secs(), xget(%#, _stat.unlock-request)), 600), match(trim(%0), YES))={ @set %#=_stat.unlock-request:[secs()];@trigger me/tr.message=%#, Warning: You are currently approved. Unlocking your stats will remove your approval. You'll need to get approved again to go IC! Are you sure? If so, type +stats/unlock YES within the next 10 minutes. It is now [prettytime()].; }; @trigger me/tr.unlock_stats=%#; }; @trigger me/tr.unlock_stats=%#;

&tr.unlock_stats [v(d.cg)]=@set %0=_stat.locked:; @set %0=!APPROVED; @trigger me/tr.success=%0, You have unlocked your stats. You can't be approved until you lock them again. Happy editing!;

&c.+approve [v(d.cg)]=$+approve *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to approve people.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @set %qP=APPROVED; @trigger me/tr.success=%#, You approved [ulocal(f.get-name, %qP, %#)]. Be sure to let them know!;


&c.+stat/set [v(d.cg)]=$+stat/set *=*: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @trigger me/tr.set-stat=%0, %1, %#;

&tr.set-stat [v(d.cg)]=@assert t(setr(S, finditem(ulocal(f.get-stats, %2), %0, |)))={ @trigger me/tr.choose-section=%0, %1, %2; }; @assert cor(not(t(strlen(%1))), cand(t(strlen(setr(V, ulocal(f.get-valid-value, %qS, %1, %2)))), not(member(ulocal(f.list-restricted-values, %qS), %qV, |))))={ @trigger me/tr.error=%2, '%1' is not a value for %qS. Valid values are: [itemize(ulocal(f.list-valid-values, %qS, %2), |)].[if(t(setr(R, itemize(ulocal(f.list-restricted-values, %qS), |))), %bRestricted values are: %qR.)]; }; @assert cor(not(isapproved(%2)), member(xget(%vD, d.stats_editable_after_chargen), %qS, |))={ @assert not(isnum(%qV))={ @force %2={ +xp/buy %qS; }; }; @trigger me/tr.error=%2, %qS cannot be changed after you are approved. You will need to either %ch+xp/buy%cn or open a job with staff.; }; @assert if(ulocal(f.is-action, %qS), strcat(setq(T, ulocal(f.get-total-player-actions, %2, %qS)), lte(add(%qT, %qV), 7)), 1)={ @trigger me/tr.error=%2, Setting your %qS to %qV would take you over 7 points of actions. Reduce your action total to move the dots around.; }; @set %2=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @trigger me/tr.success=%2, You set your %ch%qS%cn to [if(t(%qV), %ch%qV%cn, nothing)].;

&tr.choose-section [v(d.cg)]=@assert t(setr(S, finditem(ulocal(f.get-choosable-stats, %2), %0, |)))={ @trigger me/tr.error=%2, if(strmatch(%0, Crew*), You must +crew/join <Crew Name> or +crew/create <Crew Name> first., Could not find a choosable stat that starts with '%0'.); }; @assert cor(not(t(strlen(%1))), cand(t(strlen(setr(C, ulocal(f.get-valid-value, %qS, %1, %2)))), not(member(ulocal(f.list-restricted-values, %qS), %qC, |))))={ @trigger me/tr.error=%2, '%1' is not a value for %qS. Valid values are: [itemize(ulocal(f.list-valid-values, %qS, %2), |)].[if(t(setr(R, itemize(ulocal(f.list-restricted-values, %qS), |))), %bRestricted values are: %qR.)]; }; @assert cor(not(isapproved(%2)), member(xget(%vD, d.stats_editable_after_chargen), %qS, |))={ @trigger me/tr.error=%2, %qS cannot be changed after you are approved. You will need to open a job with staff.; }; @assert cor(not(t(strlen(setr(V, %1)))), t(setr(V, switch(%qS, Rival, %qC, Ally, %qC, Special Ability, finditem(%qC, %1, |), xget(%vD, strcat(d., ulocal(f.get-stat-location, %qS.%qC)))))))={ @trigger me/tr.error=%2, %qS is not set up for %qC.; }; @set %2=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @assert not(t(member(Rival|Ally|Special Ability, %qS, |)))={ @trigger me/tr.success=%2, You set your %ch%qS%cn to [if(t(%qV), %ch%qV%cn, nothing)].; };  @trigger me/tr.success=%2, You set your %ch%qS%cn to [if(t(%qC), the %ch%qC%cn list: %ch[itemize(%qV, |, and, ;)]%cn, nothing)].;


&c.+stat/clear [v(d.cg)]=$+stat/clear*: @assert not(isapproved(%#))={ @trigger me/tr.error=%#, You can't clear your stats once you're approved.; };  @assert cand(lte(sub(secs(), xget(%#, _stat.clear-request)), 600), match(trim(%0), YES))={ @set %#=_stat.clear-request:[secs()]; @trigger me/tr.message=%#, This will clear all of your stats. If you would like to continue%, type %ch+stat/clear YES%cn within the next 10 minutes. It is now [prettytime()].; }; @wipe %#/_stat.*; @trigger me/tr.success=%#, Your stats have been cleared.;


&c.+stat/set_staff [v(d.cg)]=$+stat/set */*=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set other players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @trigger me/tr.set-stat_staff=%1, %2, %qP, %#;

@@ REDO THESE!!!

&tr.set-stat_staff [v(d.cg)]=@assert t(setr(S, finditem(ulocal(f.get-stats, %2), %0, |)))={ @trigger me/tr.choose-section_staff=%0, %1, %2, %3;  }; @assert t(strlen(setr(V, ulocal(f.list-values, %qS, %2))))={ @trigger me/tr.error=%3, '%1' is not a value for %qS. Valid values are: [itemize(%qC, |)].; }; @set %2=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %3) set [ulocal(f.get-name, %2)]'s %ch%qS%cn to %ch%qV%cn.; @trigger me/tr.success=%3, You set [ulocal(f.get-name, %2, %3)]'s %ch%qS%cn to %ch%qV%cn.;

&tr.choose-section_staff [v(d.cg)]=@assert t(setr(S, finditem(ulocal(f.get-choosable-stats, %2), %0, |)))={ @trigger me/tr.error=%3, Could not find a choosable stat that starts with '%0'.; }; @assert t(strlen(setr(C, ulocal(f.list-values, %qS, %2))))={ @trigger me/tr.error=%3, '%1' is not a value for %qS. Valid values are: [itemize(%qC, |)].; }; @assert t(setr(V, switch(%qS, Rival, %qC, Ally, %qC, Special Ability, finditem(%qC, %1, |), xget(%vD, strcat(d., ulocal(f.get-stat-location, %qS.%qC))))))={ @trigger me/tr.error=%3, %qS is not set up for %qC.; }; @set %2=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @assert not(t(member(Rival|Ally|Special Ability, %qS, |)))={ @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %2) set [ulocal(f.get-name, %2, %3)]'s %ch%qS%cn to %ch%qV%cn.; @trigger me/tr.success=%3, You set [ulocal(f.get-name, %2, %3)]'s %ch%qS%cn to %ch%qV%cn.; }; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %2) set [ulocal(f.get-name, %2, %3)]'s %ch%qS%cn to [if(t(%qC), the %ch%qC%cn list: %ch[itemize(%qV, |, and, ;)]%cn, nothing)].; @trigger me/tr.success=%3, You set [ulocal(f.get-name, %2, %3)]'s %ch%qS%cn to the %ch%qC%cn list: %ch[itemize(%qV, |, and, ;)]%cn.;

@@ Definitely rewrite these too.

&c.+stat/add_staff [v(d.cg)]=$+stat/add */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set other players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(%1)={ @trigger me/tr.error=%#, You need to enter something to add.; }; @assert t(%2)={ @trigger me/tr.error=%#, You need to enter something to add.; }; @assert t(setr(S, finditem(ulocal(f.get-addable-stats), %1, |)))={ @trigger me/tr.error=%#, Could not find an addable stat that starts with '%1'.; }; @assert t(setr(V, finditem(setr(F, ulocal(f.list-values, %qS, %qP)), %2, |)))={ @trigger me/tr.error=%#, Could not find a %qS that starts with '%2'. Valid %qS values are: [itemize(%qF, |)].; }; @assert not(t(finditem(setr(L, ulocal(f.get-player-stat, %qP, %qS)), %qV, |)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) already has a %qS called '%qV'.; }; @set %qP=[ulocal(f.get-stat-location-on-player, %qS)]:[trim(strcat(%qL, |, %qV), b, |)]; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %#) added the %qS %ch%qV%cn to [ulocal(f.get-name, %qP)]'s character sheet.; @trigger me/tr.success=%#, You added the %qS %ch%qV%cn to [ulocal(f.get-name, %qP, %#)]'s character sheet.;

&c.+stat/remove_staff [v(d.cg)]=$+stat/remove */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set other players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(%1)={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @assert t(%2)={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @assert t(setr(S, finditem(ulocal(f.get-addable-stats), %1, |)))={ @trigger me/tr.error=%#, Could not find a removable stat that starts with '%1'.; }; @assert t(setr(V, finditem(setr(L, ulocal(f.get-player-stat, %qP, %qS)), %2, |)))={ @trigger me/tr.error=%#, Could not find a %qS on [ulocal(f.get-name, %qP, %#)] that starts with '%2'. [capstr(poss(%qP))] %qS stats are: [itemize(%qL, |)].; }; @set %qP=[ulocal(f.get-stat-location-on-player, %qS)]:[trim(remove(%qL, %qV, |, |), b, |)]; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %#) removed the %qS %ch%qV%cn from [ulocal(f.get-name, %qP)]'s character sheet.; @trigger me/tr.success=%#, You removed the %qS %ch%qV%cn from [ulocal(f.get-name, %qP, %#)]'s character sheet.;
