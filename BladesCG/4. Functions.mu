@@ %0: player doing the editing
@@ %1: player being edited
&f.is-allowed-to-break-stat-setting-rules [v(d.cgf)]=cand(isstaff(%0), not(strmatch(%1, %0)))

@@ %0: player doing the editing
@@ %1: player being edited
@@ %2: stat to be edited
&f.is-allowed-to-edit-stat [v(d.cgf)]=cor(not(hasattr(%1, _stat.locked)), t(member(xget(%vD, d.stats_editable_after_chargen), %2, |)), ulocal(f.is-allowed-to-break-stat-setting-rules, %0, %1))

@@ %0: player doing the editing
@@ %1: crew object being edited
&f.is-allowed-to-edit-crew [v(d.cgf)]=cor(not(hasattr(%1, _crew.locked)), ulocal(f.is-allowed-to-break-stat-setting-rules, %0, %1))

&f.get-abilities [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.abilities), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

&f.get-upgrades-with-boxes [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.upgrades), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

@@ %0 - list of player's upgrades
@@ %1 - list of player's expected crew upgrades
&f.get-extra-crew-upgrades [v(d.cgf)]=strcat(setq(S, setq(R,)), null(iter(d.upgrades.lair d.upgrades.quality d.upgrades.training, setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), setq(S, squish(trim(%qS|%1, b, |), |)), null(iter(%0, if(not(t(ulocal(f.find-upgrade, %qS, trim(last(itext(0), \]))))), setq(R, strcat(%qR, |, itext(0)))), |, |)), squish(trim(%qR, b, |), |))

&f.get-upgrades [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.upgrades), setq(S, strcat(%qS, |, iter(xget(%vD, itext(0)), trim(last(itext(0), \])), |, |))))), squish(trim(%qS, b, |), |))

@@ %0 - any upgrades list with boxes
@@ %1 - upgrade to find
&f.find-upgrade [v(d.cgf)]=first(trim(iter(%0, if(strmatch(trim(last(itext(0), \])), %1*), inum(0)), |, |), b, |), |)

@@ %0: A list of standardized upgrades
@@ %1: A list of the player's upgrades
&f.replace-upgrades [v(d.cgf)]=strcat(setq(F, %0), null(iter(%1, if(t(setr(I, ulocal(f.find-upgrade, %0, trim(last(itext(0), \]))))), setq(F, replace(%qF, %qI, itext(0), |, |))), |, |)), %qF)

&f.get-addable-stats [v(d.cgf)]=xget(%vD, if(isstaff(%1), d.addable-stats, d.cg-addable-stats))

&f.get-choice-list [v(d.cgf)]=strcat(setq(0, if(t(%0), remove(ulocal(f.list-valid-values, %0, %1), any unrestricted text, |), ulocal(f.get-choices, %1))), case(1, t(member(xget(%vD, d.playbook-stats), %0, |)), setdiff(%q0, ulocal(f.list-restricted-values, Playbook, %1), |), t(member(xget(%vD, d.crew-type-stats), %0, |)), setdiff(%q0, ulocal(f.list-restricted-values, Crew Type, %1), |), %q0))

@@ %0: player
&f.get-choices [v(d.cgf)]=strcat(squish(trim(iter(ulocal(f.get-player-bio-fields, %0), if(hasattr(%vD, strcat(d.value., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |), |, xget(%vD, d.choose-sections))

&f.get-choosable-stats [v(d.cgf)]=xget(%vD, d.choosable-stats)

&f.is-stat [v(d.cgf)]=strcat(setq(N, ulocal(f.resolve-stat-name, %0)), finditem(ulocal(f.list-stats, %0, %1), %qN, |))

&f.is-addable-stat [v(d.cgf)]=strcat(setq(N, ulocal(f.resolve-stat-name, %0)), finditem(ulocal(f.get-addable-stats, %0, %1), %qN, |))

&f.list-stats [v(d.cgf)]=strcat(ulocal(f.get-stats, %1), |, ulocal(f.get-choosable-stats, %1), |, ulocal(f.list-crew-stats, %1))

&f.is-full-list-stat [v(d.cgf)]=t(finditem(xget(%vD, d.stats-where-player-gets-entire-list), %0, |))

&f.get-field-note [v(d.cgf)]=itemize(default(strcat(%vD, /, d.value., ulocal(f.get-stat-location, %0)), switch(%0, Name, Your full IC name, Alias, Your street alias, Look, Your short-desc, No limits)), |, or)

&f.get-layout-bio-stats [v(d.cgf)]=strcat(setq(L, ulocal(f.get-player-bio-fields, %0)), null(iter(xget(%vD, d.manual-bio-stats), setq(L, remove(%qL, itext(0), |)), |)), %qL)

&f.get-player-bio-fields [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(E, xget(%0, ulocal(f.get-stat-location-on-player, Expert Type))), if(t(%qE), xget(%vD, d.expert_bio), strcat(setq(F, xget(%vD, d.bio)), setq(F, strcat(%qF, |, xget(%vD, d.bio.%qP))), setq(F, setdiff(%qF, xget(%vD, d.bio.%qP.exclude), |, |)), squish(trim(%qF, b, |), |))))

&f.get-player-abilities [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(F, default(%vD/d.abilities.[edit(%qP, %b, _)], ulocal(f.get-abilities))), squish(trim(%qF, b, |), |))

&f.get-player-crew-abilities [v(d.cgf)]=strcat(setq(O, xget(%0, ulocal(f.get-stat-location-on-player, crew object))), setq(T, ulocal(f.get-player-stat, %qO, crew type)), setq(F, default(%vD/d.crew_abilities.[edit(%qT, %b, _)], ulocal(f.get-crew-abilities))), squish(trim(%qF, b, |), |))

&f.get-player-notes [v(d.cgf)]=iter(lattr(%0/_note.*), itext(0),, |)

&f.get-player-projects [v(d.cgf)]=iter(lattr(%0/_project.*), itext(0),, |)

&f.is_expert [v(d.cgf)]=t(ulocal(f.get-player-stat, expert type))

&f.get-playbook-default [v(d.cgf)]=strcat(setq(F, if(cand(t(%0), switch(%1, XP Triggers, 1, Friends, 1, Gear, 1, Abilities, 1, 0)), xget(%vD, strcat(d., ulocal(f.get-stat-location, %1), ., %0)))), if(switch(%1, Abilities, 1, 0), first(%qF, |), %qF))

&f.get-crew-default [v(d.cgf)]=strcat(setq(F, if(strmatch(%1, Favorite), ulocal(f.get-list-default, %2, %1, Contacts), if(cand(t(%0), switch(%1, Crew XP Triggers, 1, Crew Abilities, 1, Contacts, 1, Favorite, 1, 0)), xget(%vD, strcat(d., ulocal(f.get-stat-location, %1), ., %0))))), if(switch(%1, Crew Abilities, 1, Favorite, 1, 0), first(%qF, |), %qF))

&f.get-list-default [v(d.cgf)]=strcat(setq(F, ulocal(f.get-player-stat, %0, %2)), first(%qF, |))

@@ %0: Player
@@ %1: Stat name
@@ %2: Is crew stat
@@ %3: Crew object
&f.get-stat-default [v(d.cgf)]=if(%2, ulocal(f.get-crew-default, xget(%3, ulocal(f.get-stat-location-on-player, Crew Type)), %1, %3), ulocal(f.get-playbook-default, xget(%0, ulocal(f.get-stat-location-on-player, Playbook)), %1))

&f.get-crew-abilities [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.crew_abilities), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

&f.is-crew-stat [v(d.cgf)]=t(finditem(ulocal(f.list-crew-stats), %0, |))

&f.list-crew-stats [v(d.cgf)]=strcat(xget(%vD, d.crew_bio), |, xget(%vD, d.crew-stats))

&f.resolve-stat-name [v(d.cgf)]=strcat(setq(0, setq(1,)), null(iter(lattr(%vD/d.alias.*), if(cand(not(t(%q0)), t(finditem(setr(1, xget(%vD, itext(0))), %0, |))), setq(0, last(%q1, |))))), if(t(%q0), %q0, %0))

@@ %0: Player
@@ %1: Stat name
&f.get-player-stat [v(d.cgf)]=strcat(setq(N, ulocal(f.resolve-stat-name, %1)), setq(O, xget(%0, ulocal(f.get-stat-location-on-player, crew object))), setq(I, ulocal(f.is-crew-stat, %qN)), if(cand(not(strmatch(%qO, %0)), %qI), ulocal(f.get-player-stat, %qO, %qN), strcat(setq(V, xget(%0, ulocal(f.get-stat-location-on-player, %qN))), if(cand(t(%qV), if(switch(%qN, Rival, 1, Ally, 1, Favorite, 1, 0), t(finditem(ulocal(f.list-valid-values, %qN, %0), %qV, |)), 1)), %qV, ulocal(f.get-stat-default, %0, %qN, %qI, %qO)))))

&f.get-player-stat-or-zero [v(d.cgf)]=ulocal(f.get-player-stat-or-default, %0, %1, 0)

@@ Done this way because udefault() won't return the default unless f.get-player-stat doesn't exist, and we need to get the default in the case of nothing on the player instead.
&f.get-player-stat-or-default [v(d.cgf)]=if(t(strlen(setr(0, ulocal(f.get-player-stat, %0, %1)))), %q0, %2)

&f.get-random-name-and-job [v(d.cgf)]=strcat(pickrand(xget(%vD, d.random.name), |), %,%b, art(setr(J, pickrand(xget(%vD, d.random.job), |))), %b, %qJ)

&f.get-stat-location [v(d.cgf)]=edit(%0, %b, _)

&f.get-stat-location-on-player [v(d.cgf)]=switch(%0, Look, short-desc, Name, d.ic_full_name, Alias, d.street_alias, edit(%0, %b, _, ^, _stat.))

&f.get-stats [v(d.cgf)]=strcat(setq(S, xget(%vD, d.actions)|Load|Special Ability), squish(trim(strcat(%qS, |, setdiff(ulocal(f.get-player-bio-fields, %0), Crew, |, |), |, setdiff(xget(%vD, d.expert_bio), Crew, |, |), |, if(t(ulocal(f.get-player-stat, %0, crew object)), ulocal(f.get-crew-stats))), b, |), |))

&f.get-crew-stats [v(d.cgf)]=xget(%vD, d.crew_bio)|Favorite

&f.has-crew-stats [v(d.cgf)]=strcat(setq(0, iter(ulocal(f.get-crew-stats)|crew*|cohort*|contacts|upgrades, ulocal(f.get-stat-location-on-player, itext(0)), |)), setq(0, iter(%q0, if(t(member(itext(0), *)), lattr(strcat(%0, /, itext(0))), itext(0)))), setq(0, setdiff(%q0, ulocal(f.get-stat-location-on-player, Crew Name))), t(ladd(iter(%q0, hasattr(%0, itext(0))))))

&f.get-crew-members [v(d.cgf)]=if(t(%0), search(EPLAYER=t(member(ulocal(f.get-player-stat, ##, crew object), %0))))

&f.get-total-player-abilities [v(d.cgf)]=words(ulocal(f.get-player-stat, %0, abilities), |)

&f.get-total-player-actions [v(d.cgf)]=ladd(iter(ulocal(f.list-actions), if(not(member(%1, itext(0))), ulocal(f.get-player-stat-or-zero, %0, itext(0))), |))

&f.get-valid-value [v(d.cgf)]=if(t(setr(S, ulocal(f.list-values, %0, %2))), finditem(%qS, %1, |), %1)

&f.is-action [v(d.cgf)]=finditem(ulocal(f.list-actions), %0, |)

&f.is-attribute [v(d.cgf)]=finditem(xget(%vD, d.attributes), %0, |)

&f.list-actions [v(d.cgf)]=xget(%vD, d.actions)

&f.list-restricted-values [v(d.cgf)]=xget(%vD, if(ulocal(f.is-action, %0), d.restricted.action, ulocal(f.get-stat-location, d.restricted.%0)))

&f.list-sheet-sections [v(d.cgf)]=xget(%vD, d.sheet-sections)

&f.list-valid-values [v(d.cgf)]=strcat(setq(R, ulocal(f.list-values, %0, %1)), null(iter(ulocal(f.list-restricted-values, %0), setq(R, remove(%qR, itext(0), |)), |)), if(member(%qR, *, |), strcat(setq(R, remove(%qR, *, |)), setq(R, strcat(%qR, |, any unrestricted text)))), %qR)

&f.get-full-list-stat-values [v(d.cgf)]=iter(lattr(strcat(%vD, /, d., ulocal(f.get-stat-location, %0), ., *)), title(lcstr(last(itext(0), .))),, |)

&f.list-values [v(d.cgf)]=case(1, t(ulocal(f.is-action, %0)), xget(%vD, d.value.action), ulocal(f.is-full-list-stat, %0), ulocal(f.get-full-list-stat-values, %0, %1), t(finditem(Ally, %0, |)), remove(ulocal(f.get-player-stat, %1, friends), ulocal(f.get-player-stat, %1, rival), |), t(finditem(Rival, %0, |)), remove(ulocal(f.get-player-stat, %1, friends), ulocal(f.get-player-stat, %1, ally), |), t(finditem(Favorite, %0, |)), ulocal(f.get-player-stat, %1, contacts), strmatch(Abilities, %0), ulocal(f.get-abilities), t(finditem(Crew Ability|Crew Abilities, %0, |)), ulocal(f.get-crew-abilities), strmatch(%0, Upgrade*), ulocal(f.get-upgrades), xget(%vD, ulocal(f.get-stat-location, d.value.%0)))

@@ These expect a tickable stat, in one of the following formats:
@@  [ ] Stat name here
@@  [ ] [ ] [ ] Stat name here
@@  [ ]-[ ] Stat name here
@@  [X] [ ] Stat name here
@@ Number of boxes doesn't matter, nor does whether the boxes are checked.
@@ A box is "ticked" when it has an X in it. Otherwise it is unticked.

&f.is-tickable-type [v(d.cgf)]=cor(strmatch(%0, %[ %]*), strmatch(%0, %[X%]*))

&f.count-ticks [v(d.cgf)]=if(gt(setr(0, words(%0, \[X\])), 0), dec(%q0), 0)

@@ %0: crew object
&f.count-upgrades [v(d.cgf)]=add(ulocal(f.count-ticks, ulocal(f.get-player-stat, %0, Upgrades)), ulocal(f.get-total-cohort-cost, %0))

@@ If %0 matches conjoined ticks, tick all of them
@@ If %0 matches separated ticks, tick only the FIRST unticked
@@ If there are no tickable slots, return it unchanged
&f.tick-tickable [v(d.cgf)]=strcat(setq(0, \[ \]), setq(1, edit(%q0, %b, X)), switch(%0, %q0-*, edit(%0, %q0, %q1), *%q0*, strcat(first(%0, %q0), %q1, rest(%0, %q0)), %0))

@@ If %0 matches conjoined ticks, untick all of them
@@ If %0 matches separated ticks, untick only the LAST ticked
@@ If there are no untickable slots, return it unchanged
&f.untick-tickable [v(d.cgf)]=strcat(setq(0, \[X\]), setq(1, edit(%q0, X, %b)), switch(%0, %q0-*, edit(%0, %q0, %q1), %q0*, replace(%0, dec(words(%0, %q0)), %q1), %0))

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %1 must be a valid value AND
@@ 	Must not be a restricted value OR
@@ 	Player must be staff and must not be setting their own stats
@@ Returns the "pretty" value - AKA "Bodyguard" instead of "bod".
&f.get-pretty-value [v(d.cgf)]=if(cand(t(strlen(setr(0, ulocal(f.get-valid-value, %0, %1, %2)))), cor(not(finditem(ulocal(f.list-restricted-values, %0), %q0, |)), cand(isstaff(%3), not(strmatch(%2, %3))))), %q0)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Cohort functions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: crew object
@@ %1: cohort name
@@ %2: stat to get
&f.get-cohort-stat [v(d.cgf)]=xget(%0, ulocal(f.get-stat-location-on-player, %2.%1))

&f.get-cohort-upgrade-cost [v(d.cgf)]=add(2, mul(dec(words(ulocal(f.get-cohort-stat, %0, %1, types), |)), 2))

@@ %0: player
@@ They get a free Cohort for Like Part of the Family, but it has to be a Vehicle.
&f.get-total-cohort-cost [v(d.cgf)]=ladd(iter(ulocal(f.get-player-stat, %0, Cohorts), sub(ulocal(f.get-cohort-upgrade-cost, %0, itext(0)), if(ulocal(f.has-list-stat, %0, Crew Abilities, Like Part of the Family), if(t(finditem(iter(ulocal(f.get-player-stat, %0, Cohorts), ulocal(f.get-cohort-stat, %0, itext(0), Cohort Type), |, |), Vehicle, |)), 2, 0), 0)), |,))

&f.find-cohort-stat-name [v(d.cgf)]=finditem(xget(%vD, d.cohort.stats), %0, |)

&f.is-addable-cohort-stat [v(d.cgf)]=t(member(xget(%vD, d.cohort.addable_stats), %0, |))

@@ %0: crew object
@@ %1: cohort name to find
&f.find-cohort [v(d.cgf)]=finditem(ulocal(f.get-player-stat, %0, Cohorts), %1, |)

@@ %0: stat name - edges, cohort types, etc.
@@ %1: value being offered
@@ %2: cohort type (Vehicle, gang, etc)
&f.get-cohort-stat-pretty-value [v(d.cgf)]=if(t(setr(0, ulocal(f.list-cohort-stat-pretty-values, %0, %2))), finditem(%q0, %1, |), %1)

@@ %0: stat name - edges, cohort types, etc.
@@ %1: cohort type (Vehicle, gang, etc)
&f.list-cohort-stat-pretty-values [v(d.cgf)]=xget(%vD, strcat(d.value., if(strmatch(%1, Vehicle), vehicle_), ulocal(f.get-stat-location, %0)))

@@ %0: list to search in
@@ %1: text we're looking for
&f.find-list-index [v(d.cgf)]=first(iter(%0, if(strmatch(itext(0), %1*), inum(0)), |))

@@ For sorting "Elite Rooks|Rovers" into "Rovers|Elite Rooks" so that it doesn't look like the Rovers are Elite too.
&f.sort-elite-last [v(d.cgf)]=case(1, cand(strmatch(%0, Elite *), strmatch(%1, Elite *)), comp(%0, %1), strmatch(%0, Elite *), 1, strmatch(%1, Elite *), -1, comp(%0, %1))

@@ %0: crew object
@@ %1: position on the map, ex A3
@@ %2: 1 if this is a key mark
&f.mark-map [v(d.cgf)]=if(t(ulocal(f.get-player-stat, %0, Map %1)), if(%2, +, X), %b)

@@ TODO: Finish faction status

@@ %0: list
@@ %1: word to find
&f.get-item-by-second-word [v(d.cgf)]=first(iter(%0, if(strmatch(rest(itext(0)), %1*), itext(0)), |, |), |)

@@ %0: crew object
@@ %1: faction
&f.get-faction-status [v(d.cgf)]=strcat(setq(L, ulocal(f.get-player-stat, %0, Factions)), if(t(setr(D, ulocal(f.get-item-by-second-word, %qL, %1))), ulocal(f.get-faction-status-color, first(%qD)), strcat(setq(I, 0), setq(H, ulocal(f.get-player-stat, %0, faction.hunting)), setq(E, ulocal(f.get-player-stat, %0, faction.helped)), setq(A, ulocal(f.get-player-stat, %0, faction.harmed)), setq(F, ulocal(f.get-player-stat, %0, faction.friendly)), setq(U, ulocal(f.get-player-stat, %0, faction.unfriendly)), if(strmatch(%1, first(%qH, |)), setq(I, add(dec(%qI), rest(%qH, |)))), if(strmatch(%1, first(%qE, |)), setq(I, add(inc(%qI), rest(%qE, |)))), if(strmatch(%1, first(%qA, |)), setq(I, add(sub(%qI, 2), rest(%qA, |)))), if(strmatch(%1, first(%qF, |)), setq(I, add(inc(%qI), rest(%qF, |)))), if(strmatch(%1, first(%qU, |)), setq(I, add(dec(%qI), rest(%qU, |)))), ulocal(f.get-faction-status-color, %qI))))

&f.get-faction-status-color [v(d.cgf)]=switch(edit(%0, +,), >3, %ch%cg+#$, >0, %cc+#$, 0, +0, >-2, %ch%cy#$, %cr%ch#$)

&f.get-all-factions [v(d.cgf)]=iter(xget(%vD, d.factions), xget(%vD, itext(0)),, |)

@@ %0: Crew object
@@ %1: Optional - question to skip
&f.get-total-faction-coin [v(d.cgf)]=ladd(iter(xget(%vD, d.faction.questions), if(not(t(member(%1|Friendly|Unfriendly, itext(0), |))), rest(ulocal(f.get-player-stat, %0, strcat(faction., itext(0))), |)), |))

@@ %0: player
@@ %1: stat list to look on
@@ %2: stat to look for
&f.has-list-stat [v(d.cgf)]=switch(%1, Upgrades, t(ulocal(f.find-upgrade, ulocal(f.get-player-stat, %0, %1), switch(%2, *\]*, trim(last(%2, \])), %2))), Faction, t(finditem(iter(ulocal(f.get-player-stat, %0, %1), rest(itext(0)), |, |), if(isnum(first(%2)), rest(%2), %1))), t(finditem(ulocal(f.get-player-stat, %0, %1), %2, |)))
