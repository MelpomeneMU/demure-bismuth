/*

TODO: Future functionality to entertain certain staffers who like reports: +xp/report. Top 10 advancements earned on grid, top 10 players with unspent advancements, top 10 crews by advancements...

Advancement:

Player goes on Scores, earns insight XP, prowess XP, resolve XP, playbook XP and crew XP.
Desperate rolls grant a player XP in a specific insight, prowess, or resolve track.
Player must decide where they want any non-Desperate XP to go.
Player Trains, using one Downtime action, and gains +1 XP in a track, or +2 in a track that's supported by an upgrade on their crew sheet.

Thought about individual "request XP" commands but discarded them because they would result in a lot of spam for staffers which would all come in at once right after someone completed a score. Plus, a lot of them would be irrelevant without logs and other info that would be annoying to remember to type mid-scene. Better to group it all at once into a single request. In Blades, you don't get XP outside of Scores.

req/xp Score of the Century=<log link> - goes to the wiki which has a template that is formatted to make it easy for staff to turn it into a series of commands to reward people as appropriate.

Staffer grants the requested XP entering the commands, then notifies the player by approving the job.

+xp/award player/track=<amount> -- this presumes we know where they want that XP. Relevant for Crew and insight/prowess/resolve XP.
+xp/award player=<amount> -- player gets the XP and can distribute it.

Player receives the XP and must distribute any un-tracked XP to the correct track.

+xp/shift <track>=<#> <-- move untracked XP to a specific track. Once there it cannot be shifted again without staff help.

+xp/shift <player>/<track>=<#> - staff version

Player reaches the end of an XP track.
The track resets to 0.
The player's Unspent insight/prowess/resolve/playbook/crew Advances track increments by 1.

Player requests an advance.
Staffer verifies the advance is allowed.
Code verifies the advance is allowed.
	Insight/prowess/resolve can only be spent on their relevant Action stats.
	Action stats cannot go past:
		3 normally
		4 if they have Mastery or are a Vampire
	All other stats can usually be taken only once (verify this)
Staffer advances the requested stat.
	Code advance:
		+xp/spend Player/Hunt=1
	Manual advance:
		+stat/add player/Advances=Advanced Sword Training
		+xp/spend Player/Playbook=1
The player's Unspent insight/prowess/resolve/playbook/crew Advances track decrements by 1 (or .5 in the case of playbook upgrades)
The player's Spent insight/prowess/resolve/playbook/crew Advances track increments by 1 (or .5 in the case of playbook upgrades)
Staffer notifies player their advance has been given by approving the job.

Tracks:
	Insight
	Prowess
	Resolve
	Playbook
	Crew

For each track:
	Total Track XP
	Track length
	Current XP Total (Total Track XP % Track Length)
	Spent Advancements
	Total Advancements
	Unspent Advancements (Total Advancements - Spent Advancements)

*/

&c.+xp/award [v(d.cg)]=$+xp/award *=*:@break strmatch(%0, */*); @trigger me/tr.xp-award=%0, %1, %#, Untracked;

&c.+xp/award_tracked [v(d.cg)]=$+xp/award */*=*:@trigger me/tr.xp-award=%0, %2, %#, %1;

@@ %0: Player
@@ %1: Value
@@ %2: Caller
@@ %3: XP Track
&tr.xp-award [v(d.cg)]=@assert isstaff(%2)={ @trigger me/tr.error=%2, You must be staff to add stats for players.; }; @assert t(setr(P, ulocal(f.find-player, %0, %2)))={ @trigger me/tr.error=%2, Could not find a player named '%0'.; }; @assert t(setr(T, finditem(setr(L, xget(%vD, d.xp_tracks)), %3, |)))={ @trigger me/tr.error=%2, '%3' is not a valid XP track. Valid tracks are [ulocal(layout.list, %qL)].; }; @assert isnum(%1)={ @trigger me/tr.error=%2, '%1' is not a number.; }; @eval setq(N, ulocal(f.get-name, %qP, %2)); @assert isapproved(%qP)={ @trigger me/tr.error=%2, %qN is not approved and cannot receive XP.; };  @assert cor(not(strmatch(%qT, Crew)), t(setr(C, ulocal(f.get-player-stat, %qP, crew object))))={ @trigger me/tr.error=%2, %qN doesn't currently have a crew set up and cannot receive Crew XP.; }; @assert cor(strmatch(%qT, Crew), not(ulocal(f.is_expert, %qP)))={ @trigger me/tr.error=%2, %qN is an Expert and cannot receive %qT XP.; }; @eval setq(C, switch(%qT, Crew, %qC, %qP)); @eval setq(X, ulocal(f.get-xp, %qC, %qT, total)); @eval setq(M, ulocal(f.get-xp, %qC, %qT, max)); @eval setq(A, if(not(strmatch(%qT, Untracked)), ulocal(f.get-advancements, %qC, %qT, total))); @set %qC=[ulocal(f.get-stat-location-on-player, xp.%qT.total)]:[setr(V, add(%qX, %1))]; @set %qC=[ulocal(f.get-stat-location-on-player, advancements.%qT.total)]:[if(setr(G, cand(not(strmatch(%qT, Untracked)), cor(gt(add(mod(%qX, %qM), %1), %qM), eq(mod(%qV, %qM), 0)))), inc(%qA), %qA)]; @trigger me/tr.success=%2, You grant %qN %1 XP in [poss(%qP)] %qT XP track.[if(%qG, cat(, title(subj(%qP)), plural(%qP, has, have), gained an Advancement.))];

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ +xp
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+xp [v(d.cg)]=$+xp:@pemit %#=[ulocal(layout.xp, %#, %#)];
