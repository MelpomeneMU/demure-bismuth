@@ TODO: Future functionality to entertain certain staffers who like reports: +xp/report. Top 10 advancements earned on grid, top 10 players with unspent advancements, top 10 crews by advancements...

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Error and success messages
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: track
@@ %1: value
@@ %2: player
@@ %3: caller
@@ %4: number of advancements, if any
&layout.move_track [v(d.cgf)]=if(strmatch(%2, %3), strcat(You move %1 Untracked XP to the %0 track., if(t(%4), cat(You have gained %4, plural(%4, Advancement, Advancements).))), cat(You move %1 of, ulocal(f.get-name, %2, %3)'s, Untracked XP to, poss(%2), %0 track., if(t(%4), cat(title(subj(%2)), plural(%2, has, have), gained %4, plural(%4, Advancement, Advancements).))))

&layout.add_track [v(d.cgf)]=if(strmatch(%2, %3), strcat(You add %1 XP to the %0 track., if(t(%4), cat(You have gained %4, plural(%4, Advancement, Advancements).))), cat(You add %1 XP to, ulocal(f.get-name, %2, %3)'s, %0 track., if(t(%4), cat(title(subj(%2)), plural(%2, has, have), gained %4, plural(%4, Advancement, Advancements).))))

&layout.spend_track [v(d.cgf)]=cat(You spend %1, plural(%1, Advancement, Advancements), from, ulocal(layout.whose-stat, %4, %1, %2, %3), %0 track.)

&layout.alert-spend_track [v(d.cgf)]=cat(ulocal(f.get-name, %3), spends %1, plural(%1, Advancement, Advancements), from, ulocal(layout.whose-stat, %4, %1, %2, %3), %0 track.)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +xp/award
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@


&c.+xp/award [v(d.cg)]=$+xp/award *=*:@break strmatch(%0, */*); @trigger me/tr.xp-award=%0, %1, %#, Untracked;

&c.+xp/award_tracked [v(d.cg)]=$+xp/award */*=*:@trigger me/tr.xp-award=%0, %2, %#, %1;

@@ %0: Player
@@ %1: Value
@@ %2: Caller
@@ %3: XP Track
&tr.xp-award [v(d.cg)]=@assert isstaff(%2)={ @trigger me/tr.error=%2, You must be staff to award XP to players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %2)))={ @trigger me/tr.error=%2, Could not find a player named '%0'.; }; @assert t(setr(T, finditem(setr(L, xget(%vD, d.xp_tracks)), %3, |)))={ @trigger me/tr.error=%2, '%3' is not a valid XP track. Valid tracks are [ulocal(layout.list, %qL)].; }; @assert isnum(%1)={ @trigger me/tr.error=%2, '%1' is not a number.; }; @eval setq(N, ulocal(f.get-name, %qP, %2)); @assert isapproved(%qP)={ @trigger me/tr.error=%2, %qN is not approved and cannot receive XP.; };  @assert cor(not(strmatch(%qT, Crew)), t(setr(C, ulocal(f.get-player-stat, %qP, crew object))))={ @trigger me/tr.error=%2, %qN doesn't currently have a crew set up and cannot receive Crew XP.; }; @assert cor(strmatch(%qT, Crew), not(ulocal(f.is_expert, %qP)))={ @trigger me/tr.error=%2, %qN is an Expert and cannot receive %qT XP.; }; @trigger me/tr.increase-track=%qT, %1, %qP, %2, add;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +xp
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+xp [v(d.cg)]=$+xp:@pemit %#=[ulocal(layout.xp, %#, %#)];

&c.+xp_player [v(d.cg)]=$+xp *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view player XP.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=[ulocal(layout.xp, %qP, %#)];

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +xp/track
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+xp/track [v(d.cg)]=$+xp/track *=*: @break strmatch(%0, */*); @trigger me/tr.xp-track=%0, %1, %#, %#; 

&c.+xp/track_player [v(d.cg)]=$+xp/track */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to move XP for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @trigger me/tr.xp-track=%1, %2, %qP, %#; 

@@ %0: track
@@ %1: value
@@ %2: player
@@ %3: actor
&tr.xp-track [v(d.cg)]=@assert t(setr(U, ulocal(f.get-xp, %2, untracked, total)))={ @trigger me/tr.error=%3, Could not find any untracked XP to track.; }; @assert cand(isnum(%1), gt(%1, 0), lte(%1, %qU))={ @trigger me/tr.error=%3, '%1' must be a number greater than 0 and less than %qU.; }; @assert t(setr(T, finditem(setr(L, setdiff(xget(%vD, d.xp_tracks), Untracked|Crew, |, |)), %0, |)))={ @trigger me/tr.error=%3, Could not find an XP track starting with '%0' to move this XP to. Valid tracks are [ulocal(layout.list, %qL)].; }; @set %2=ulocal(f.get-stat-location-on-player, xp.untracked.total):[sub(%qU, %1)]; @trigger me/tr.increase-track=%qT, %1, %2, %3, move;

@@ %0: track
@@ %1: value
@@ %2: player
@@ %3: actor
@@ %4: action
&tr.increase-track [v(d.cg)]=@eval setq(C, switch(%qT, Crew, ulocal(f.get-player-stat, %2, crew object), %2)); @eval setq(X, ulocal(f.get-xp, %qC, %0, total)); @eval setq(M, ulocal(f.get-xp, %qC, %0, max)); @eval setq(U, add(%1, ulocal(f.get-xp, %qC, %0, unspent))); @eval setq(A, ulocal(f.get-advancements, %qC, %0, total)); @eval setq(G, if(gt(%qM, 0), if(gt(%qU, %qM), div(%qU, %qM), eq(%qU, %qM)))); @set %qC=[ulocal(f.get-stat-location-on-player, xp.%0.total)]:[setr(V, add(%qX, %1))]; @set %qC=[ulocal(f.get-stat-location-on-player, advancements.%0.total)]:[if(t(%qG), add(%qA, %qG), %qA)]; @trigger me/tr.success=%3, ulocal(layout.%4_track, %0, %1, %2, %3, %qG);

th ulocal(v(d.cgf)/f.get-advancements, %#, insight, total)

@wipe me/_stat.locked
@wipe me/*xp*
@wipe me/*advan*
+stats/lock

@@ TODO: Write aliases for this one - move, shift, etc.

+xp/award wrench=12

+xp/track insight=2
+xp/track resolve=2
+xp/track prowess=2
+xp/track playbook=27
+xp/track crew=2
+xp/track untracked=2


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +adv/spend
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+adv/spend [v(d.cg)]=$+adv/spend */*=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to spend Advancements for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval if(not(t(setr(T, finditem(setr(L, xget(%vD, d.xp_tracks)), %1, |)))), setq(S, ulocal(f.is-stat, %1, %qP))); @assert cor(t(%qT), t(%qS))={ @trigger me/tr.error=%#, '%1' does not appear to be a stat or an XP track. Valid XP tracks are: [ulocal(layout.list, %qL)]. Valid stats are: [ulocal(layout.list, ulocal(f.list-stats, %1, %qP))]; }; @eval setq(T, if(cand(t(%qS), not(t(%qT))), case(1, ulocal(f.is-crew-stat, %qS), Crew, t(finditem(xget(%vD, d.actions.insight), %qS, |)), Insight, t(finditem(xget(%vD, d.actions.prowess), %qS, |)), Prowess, t(finditem(xget(%vD, d.actions.resolve), %qS, |)), Resolve, Playbook), %qT)); @assert t(%qT)={ @trigger me/tr.error=%#, Could not figure out what XP track the stat %qS is from. Something's wrong with the data. Tell a coder!; }; @eval setq(V, if(t(%qS), 1, %2)); @assert isnum(%qV)={ @trigger me/tr.error=%#, '%qV' is not a number.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert isapproved(%qP)={ @trigger me/tr.error=%#, %qN is not approved and cannot spend Advancements.; }; @assert cor(not(strmatch(%qT, Crew)), t(setr(C, ulocal(f.get-player-stat, %qP, crew object))))={ @trigger me/tr.error=%#, %qN doesn't currently have a crew set up and cannot spend Crew Advancements.; }; @assert cor(strmatch(%qT, Crew), not(ulocal(f.is_expert, %qP)))={ @trigger me/tr.error=%#, %qN is an Expert and cannot spend %qT Advancements.; }; @eval setq(C, if(strmatch(%qT, Crew), %qC, %qP)); @assert gte(ulocal(f.get-advancements, %qC, %qT, unspent), %qV)={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) doesn't have %qV unspent Advancements in %qT.; }; @eval setq(O, ulocal(f.get-player-stat, %qP, %qS)); @eval setq(U, if(ulocal(f.is-action, %qS), add(%qO, 1), %2)); @if t(%qS)={ @if ulocal(f.is-addable-stat, %qS)={ @trigger me/tr.add-stat=%qS, %qU, %qP, %#; }, { @trigger me/tr.set-stat=%qS, %qU, %qP, %#; }; }; @wait 1={ @assert cor(strmatch(%qO, ulocal(f.get-player-stat, %qP, %qS)), not(t(%qS)))={ @eval setq(X, ulocal(f.get-advancements, %qC, %qT, spent)); @set %qC=[ulocal(f.get-stat-location-on-player, advancements.%qT.spent)]:[add(%qX, %qV)]; @trigger me/tr.stat-setting-messages=ulocal(layout.spend_track, %qT, %qV, %qP, %#, %qS), ulocal(layout.alert-spend_track, %qT, %qV, %qP, %#, %qS), %qP, %#, %qS; }; @trigger me/tr.error=%#, Could not spend the XP because the stat doesn't appear to have gone through. If it did%, you may have to +adv/spend %qN/%qT=1%, but please check first.; };

&c.+adv/spend_nocount [v(d.cg)]=$+adv/spend */*: @break strmatch(%1, *=*); @force %#=+adv/spend %0/%1=1;

