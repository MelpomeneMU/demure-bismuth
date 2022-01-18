/*

+adv - view your log
+adv/crew - view your crew's advancements
+adv <player> - view their log
+adv/crew <player> - view their crew's advancements
+adv/log <player>=<note> - log an advancement-specific note
+adv/log <player>/<type>=<note> - for logging crew advancements

*/

@@ TODO: Future functionality to entertain certain staffers who like reports: +xp/report. Top 10 advancements earned on grid, top 10 players with unspent advancements, top 10 crews by advancements...

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Error and success messages
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: track
@@ %1: value
@@ %2: player
@@ %3: caller
@@ %4: number of advancements, if any
&layout.move_track [v(d.cgf)]=if(strmatch(%2, %3), strcat(You move %1 Untracked XP to the %0 track., if(t(%4), cat(, You have gained %4, plural(%4, Advancement, Advancements).))), cat(You move %1 of, ulocal(f.get-name, %2, %3)'s, Untracked XP to, poss(%2), %0 track., if(t(%4), cat(, title(subj(%2)), plural(%2, has, have), gained %4, plural(%4, Advancement, Advancements).))))

&layout.add_track [v(d.cgf)]=if(strmatch(%2, %3), strcat(You add %1 XP to the %0 track., if(t(%4), cat(, You have gained %4, plural(%4, Advancement, Advancements).))), cat(You add %1 XP to, ulocal(f.get-name, %2, %3)'s, %0 track., if(t(%4), cat(, title(subj(%2)), plural(%2, has, have), gained %4, plural(%4, Advancement, Advancements).))))

&layout.spend_track [v(d.cgf)]=cat(You spend %1, plural(%1, Advancement, Advancements), from, ulocal(layout.whose-stat, %4, %1, %2, %3), %0 track.)

&layout.alert-spend_track [v(d.cgf)]=cat(ulocal(f.get-name, %3), spends %1, plural(%1, Advancement, Advancements), from, ulocal(layout.whose-stat, %4, %1, %2, %3), %0 track.)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ XP screen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: player
@@ %1: track
&layout.xp_track [v(d.cgf)]=strcat(|, ansi(first(themecolors()), %1), |, ulocal(f.get-xp, %0, %1, total), |, ulocal(f.get-xp, %0, %1, current), /, ulocal(f.get-xp, %0, %1, max), |, ulocal(f.get-advancements, %0, %1, spent), /, ulocal(f.get-advancements, %0, %1, total))

@@ %0: player
@@ %1: unspent advancement count
@@ %2: is the player a scoundrel
&layout.xp_comments [v(d.cgf)]=squish(trim(strcat(if(t(%1), strcat(* You have %1 Untracked XP which needs to be moved onto a track.%r, space(3), %ch+xp/track <track>=<amount>%cn to move it to a useful place.)), if(%2, iter(setdiff(xget(%vD, d.xp_tracks), Untracked|Crew, |, |), if(t(setr(V, ulocal(f.get-advancements, %0, itext(0), unspent))), cat(%r*, You have %qV unspent, plural(%qV, Advancement, Advancements), in your, itext(0) track.)), |, @@))), b, %r), %r)

&layout.crew-xp_comments [v(d.cgf)]=if(t(setr(V, ulocal(f.get-advancements, %0, Crew, unspent))), cat(%r*, Your crew has %qV unspent, plural(%qV, Advancement, Advancements).))

&layout.xp [v(d.cgf)]=strcat(header(XP and Advancements, %1), %r, if(setr(S, not(ulocal(f.is_expert, %0))), strcat(multicol(strcat(|, ansi(first(themecolors())u, Total XP), |, ansi(first(themecolors())u, Current/Max XP), |, ansi(first(themecolors())u, Advancements Spent/\Total), ulocal(layout.xp_track, %0, Insight), ulocal(layout.xp_track, %0, Prowess), ulocal(layout.xp_track, %0, 	Resolve), ulocal(layout.xp_track, %0, Playbook), |, ansi(first(themecolors()), Untracked), |, setr(U, ulocal(f.get-xp, %0, Untracked, total)), setq(T, ulocal(layout.xp_comments, %0, %qU, %qS)), if(t(%qT), |||)), * 12 * 25, 0, |, %1), if(t(%qT), strcat(%r, formattext(%qT%r, 0, %1))))), setq(C, ulocal(f.get-player-stat, %0, crew object)), setq(T, ulocal(layout.crew-xp_comments, %qC)), multicol(strcat(|, ansi(first(themecolors())u, Total XP), |, ansi(first(themecolors())u, Current/Max XP), |, ansi(first(themecolors())u, Advancements Spent/\Total), ulocal(layout.xp_track, %qC, Crew)), * 12 * 25, 0, |, %1), if(t(%qT), strcat(formattext(%qT, 0, %1))), %r, footer(cat(ulocal(f.get-total-advancements, %0, spent), Advancements spent out of, ulocal(f.get-total-advancements, %0, total) total.), %1))

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

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +adv/spend
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+adv/spend [v(d.cg)]=$+adv/spend */*=*:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to spend Advancements for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @eval if(not(t(setr(T, finditem(setr(L, xget(%vD, d.xp_tracks)), %1, |)))), setq(S, ulocal(f.is-stat, %1, %qP))); @assert cor(t(%qT), t(%qS))={ @trigger me/tr.error=%#, '%1' does not appear to be a stat or an XP track. Valid XP tracks are: [ulocal(layout.list, %qL)]. Valid stats are: [ulocal(layout.list, ulocal(f.list-stats, %1, %qP))]; }; @eval setq(T, if(cand(t(%qS), not(t(%qT))), case(1, ulocal(f.is-crew-stat, %qS), Crew, t(finditem(xget(%vD, d.actions.insight), %qS, |)), Insight, t(finditem(xget(%vD, d.actions.prowess), %qS, |)), Prowess, t(finditem(xget(%vD, d.actions.resolve), %qS, |)), Resolve, Playbook), %qT)); @assert t(%qT)={ @trigger me/tr.error=%#, Could not figure out what XP track the stat %qS is from. Something's wrong with the data. Tell a coder!; }; @eval setq(V, if(t(%qS), 1, %2)); @assert isnum(%qV)={ @trigger me/tr.error=%#, '%qV' is not a number.; }; @eval setq(N, ulocal(f.get-name, %qP, %#)); @assert isapproved(%qP)={ @trigger me/tr.error=%#, %qN is not approved and cannot spend Advancements.; }; @assert cor(not(strmatch(%qT, Crew)), t(setr(C, ulocal(f.get-player-stat, %qP, crew object))))={ @trigger me/tr.error=%#, %qN doesn't currently have a crew set up and cannot spend Crew Advancements.; }; @assert cor(strmatch(%qT, Crew), not(ulocal(f.is_expert, %qP)))={ @trigger me/tr.error=%#, %qN is an Expert and cannot spend %qT Advancements.; }; @eval setq(C, if(strmatch(%qT, Crew), %qC, %qP)); @eval setq(O, ulocal(f.get-player-stat, %qP, %qS)); @eval setq(U, if(ulocal(f.is-action, %qS), add(%qO, 1), %2)); @eval if(strmatch(%qS, Upgrades), strcat(setq(Z, ulocal(f.tick-tickable, extract(%qO, ulocal(f.find-upgrade, %qO, %qU), 1, |))), if(not(t(%qZ)), setq(Z, ulocal(f.tick-tickable, extract(ulocal(f.get-upgrades-with-boxes), ulocal(f.find-upgrade, ulocal(f.get-upgrades-with-boxes), %qU), 1, |)))), setq(V, mul(.5, sub(ulocal(f.count-boxes, %qZ), ulocal(f.count-ticks, %qZ)))))); @assert gte(ulocal(f.get-advancements, %qC, %qT, unspent), %qV)={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) doesn't have %qV unspent Advancements in %qT.; }; @if t(%qS)={ @if ulocal(f.is-addable-stat, %qS)={ @trigger me/tr.add-stat=%qS, %qU, %qP, %#; }, { @trigger me/tr.set-stat=%qS, %qU, %qP, %#; }; }; @wait t(%qS)={ @assert cand(strmatch(%qO, ulocal(f.get-player-stat, %qP, %qS)), t(%qS))={ @eval setq(X, ulocal(f.get-advancements, %qC, %qT, spent)); @set %qC=[ulocal(f.get-stat-location-on-player, advancements.%qT.spent)]:[add(%qX, %qV)]; @trigger me/tr.stat-setting-messages=ulocal(layout.spend_track, %qT, %qV, %qP, %#, %qS), ulocal(layout.alert-spend_track, %qT, %qV, %qP, %#, %qS), %qP, %#, %qS; @trigger me/tr.log-advancement=%qC, %qT, ulocal(layout.advancement, %qT, %qU, %qS, %qC, %#), %#; }; @trigger me/tr.error=%#, Could not spend the XP because the stat doesn't appear to have gone through. If it did%, you may have to +adv/spend %qN/%qT=%qV%, but please check first.; }; 

&c.+adv/spend_nocount [v(d.cg)]=$+adv/spend */*: @break strmatch(%1, *=*); @force %#=+adv/spend %0/%1=1;

@@ %0: player being logged to
@@ %1: advancement type - player or crew
@@ %2: advancement note
@@ %3: logging player
&tr.log-advancement [v(d.cg)]=@set %0=[ulocal(f.get-next-id-attr, %0, ulocal(f.get-stat-location-on-player, strcat(switch(%1, c*, crew_), advancement_)))]:%2;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +adv/log
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.stat-advancement [v(d.cgf)]=cat(Purchased, ulocal(f.get-singular-stat-name, %2), ulocal(f.get-pretty-value, %2, %1, %3, %4).)

&layout.advancement [v(d.cgf)]=cat(first(prettytime()), if(isdbref(%1), ulocal(f.get-name, %1): %0, ulocal(layout.stat-advancement, %0, %1, %2, %3, %4)))

&layout.advancement_log [v(d.cgf)]=strcat(header(cat(Advancement log, -, ulocal(f.get-name, %0)), %1), %r, formattext(strcat(setq(A, iter(lattr(strcat(%0, /, ulocal(f.get-stat-location-on-player, advancement_, ), *)), xget(%0, itext(0)),, |)), if(t(%qA), %qA, No advancements yet.)), 0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&layout.crew_advancement_log [v(d.cgf)]=strcat(header(cat(Crew advancement log, -, ulocal(f.get-crew-name, %0)), %1), %r, formattext(strcat(setq(A, iter(lattr(strcat(%0, /, ulocal(f.get-stat-location-on-player, crew_advancement_), *)), xget(%0, itext(0)),, |)), if(t(%qA), %qA, No crew advancements yet.)), 0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&c.+adv [v(d.cg)]=$+adv:@pemit %#=ulocal(layout.advancement_log, %#, %#);

&c.+adv_player [v(d.cg)]=$+adv *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view player Advancements.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @break strmatch(%0, *=*); @pemit %#=ulocal(layout.advancement_log, %qP, %#);

&c.+adv/crew [v(d.cg)]=$+adv/crew:@pemit %#=ulocal(layout.crew_advancement_log, %#, %#);

&c.+adv/crew_player [v(d.cg)]=$+adv/crew *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view player Advancements.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @break strmatch(%0, *=*); @pemit %#=ulocal(layout.crew_advancement_log, %qP, %#);

&c.+adv/log_add [v(d.cg)]=$+ad v/log *=*:@break strmatch(%0, */*); @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to add to a player's Advancements log.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @trigger me/tr.log-advancement=%qP, player, ulocal(layout.advancement, %1, %#), %#; @trigger me/tr.success=%#, cat(You logged an advancement note on, ulocal(f.get-name, %qP, %#), stating: %1; );

&c.+adv/log_add_type [v(d.cg)]=$+adv/log */*=*:@break strmatch(%0, */*); @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to add to a player's Advancements log.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(setr(T, finditem(Crew|Player, %1, |)))={ @trigger me/tr.error=%#, '%1' is not a type of Advancement log entry. Available types are Player and Crew.; }; @trigger me/tr.log-advancement=%qP, %qT, ulocal(layout.advancement, %2, %#), %#; @trigger me/tr.success=%#, cat(You logged an advancement note on, ulocal(f.get-name, %qP, %#), stating: %2; );
