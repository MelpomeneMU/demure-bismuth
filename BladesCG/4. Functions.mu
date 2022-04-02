@@ %0: player doing the editing
@@ %1: player being edited
&f.is-allowed-to-break-stat-setting-rules [v(d.cgf)]=cand(isstaff(%0), not(strmatch(%1, %0)))

@@ For debug/testing:
@@ &f.is-allowed-to-break-stat-setting-rules [v(d.cgf)]=isstaff(%0)

@@ %0: player doing the editing
@@ %1: player being edited
@@ %2: stat to be edited
&f.is-allowed-to-edit-stat [v(d.cgf)]=cor(not(hasattr(%1, if(ulocal(f.is-crew-stat, %2), _stat.crew_locked, _stat.locked))), t(member(xget(%vD, d.stats_editable_after_chargen), %2, |)), ulocal(f.is-allowed-to-break-stat-setting-rules, %0, %1))

@@ %0: player doing the editing
@@ %1: crew object being edited
&f.is-allowed-to-edit-crew [v(d.cgf)]=cor(not(hasattr(%1, _stat.crew_locked)), ulocal(f.is-allowed-to-break-stat-setting-rules, %0, %1))

&f.get-crew-name [v(d.cgf)]=ulocal(f.get-player-stat-or-default, ulocal(f.get-player-stat, %0, crew object), crew name, No crew yet)

&f.get-singular-stat-name [v(d.cgf)]=switch(%0, Abilities, Special Ability, Crew Abilities, Crew Ability, *s, reverse(rest(reverse(%0), s)), %0)

&f.get-abilities [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.abilities), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

&f.get-upgrades-with-boxes [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.upgrades), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

@@ %0 - list of player's upgrades
@@ %1 - list of player's expected crew upgrades
&f.get-extra-crew-upgrades [v(d.cgf)]=strcat(setq(S, setq(R,)), null(iter(d.upgrades.lair d.upgrades.quality d.upgrades.training, setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), setq(S, squish(trim(%qS|%1, b, |), |)), null(iter(%0, if(not(t(ulocal(f.find-tickable, %qS, trim(last(itext(0), \]))))), setq(R, strcat(%qR, |, itext(0)))), |, |)), squish(trim(%qR, b, |), |))

&f.get-upgrades [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.upgrades), setq(S, strcat(%qS, |, iter(xget(%vD, itext(0)), trim(last(itext(0), \])), |, |))))), squish(trim(%qS, b, |), |))

@@ %0: A list of standardized upgrades
@@ %1: A list of the player's upgrades
&f.replace-upgrades [v(d.cgf)]=strcat(setq(F, %0), null(iter(%1, if(t(setr(I, ulocal(f.find-tickable, %0, trim(last(itext(0), \]))))), setq(F, replace(%qF, %qI, itext(0), |, |))), |, |)), %qF)

&f.get-vault-max [v(d.cgf)]=if(ulocal(f.has-list-stat, %0, Upgrades, Vault), add(case(ulocal(f.count-ticks, strcat(setq(E, ulocal(f.get-player-stat, %0, Upgrades)), setq(I, ulocal(f.find-tickable, %qE, Vault)), extract(%qE, %qI, 1, |))), 1, 4, 12), 4), 4)

&f.get-addable-stats [v(d.cgf)]=xget(%vD, if(isstaff(%1), d.addable-stats, d.cg-addable-stats))

&f.get-choice-list [v(d.cgf)]=strcat(setq(0, if(t(%0), remove(ulocal(f.list-valid-values, %0, %1), any unrestricted text, |), ulocal(f.get-choices, %1))), case(1, t(member(xget(%vD, d.playbook-stats), %0, |)), setdiff(%q0, ulocal(f.list-restricted-values, Playbook, %1), |), t(member(xget(%vD, d.crew-type-stats), %0, |)), setdiff(%q0, ulocal(f.list-restricted-values, Crew Type, %1), |), %q0))

@@ %0: player
&f.get-choices [v(d.cgf)]=strcat(squish(trim(iter(ulocal(f.get-player-bio-fields, %0), if(hasattr(%vD, strcat(d.value., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |), |, xget(%vD, d.choose-sections))

&f.get-choosable-stats [v(d.cgf)]=xget(%vD, d.choosable-stats)

&f.is-stat [v(d.cgf)]=strcat(setq(N, ulocal(f.resolve-stat-name, %0)), finditem(ulocal(f.list-stats, %0, %1, %2), %qN, |))

&f.is-addable-stat [v(d.cgf)]=strcat(setq(N, ulocal(f.resolve-stat-name, %0)), finditem(ulocal(f.get-addable-stats, %0, %1), %qN, |))

&f.list-stats [v(d.cgf)]=strcat(setq(D, if(ulocal(f.is-allowed-to-break-stat-setting-rules, %2, %1),, xget(%vD, d.staff-only-stats))), diffset(ulocal(f.get-stats, %1), %qD, |, |), |, diffset(ulocal(f.get-choosable-stats, %1), %qD, |, |), |, diffset(ulocal(f.list-crew-stats, %1), %qD, |, |))

&f.is-full-list-stat [v(d.cgf)]=t(finditem(xget(%vD, d.stats-where-player-gets-entire-list), %0, |))

&f.get-field-note [v(d.cgf)]=itemize(default(strcat(%vD, /, d.value., ulocal(f.get-stat-location, %0)), switch(%0, Name, Your full IC name, Alias, Your street alias, Look, Your short-desc, No limits, Vice Purveyor, A specific business or individual who helps you fulfill your Vice. This is free-text.)), |, or)

&f.get-layout-bio-stats [v(d.cgf)]=strcat(setq(L, ulocal(f.get-player-bio-fields, %0)), null(iter(xget(%vD, d.manual-bio-stats), setq(L, remove(%qL, itext(0), |)), |)), %qL)

&f.get-player-bio-fields [v(d.cgf)]=if(ulocal(f.is_expert, %0), xget(%vD, d.expert_bio), strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(F, xget(%vD, d.bio)), setq(F, strcat(%qF, |, xget(%vD, d.bio.%qP))), setq(F, setdiff(%qF, xget(%vD, d.bio.%qP.exclude), |, |)), squish(trim(%qF, b, |), |)))

&f.get-player-abilities [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(F, default(%vD/d.abilities.[edit(%qP, %b, _)], ulocal(f.get-abilities))), squish(trim(%qF, b, |), |))

&f.get-player-crew-abilities [v(d.cgf)]=strcat(setq(O, xget(%0, ulocal(f.get-stat-location-on-player, crew object))), setq(T, ulocal(f.get-player-stat, %qO, crew type)), setq(F, default(%vD/d.crew_abilities.[edit(%qT, %b, _)], ulocal(f.get-crew-abilities))), squish(trim(%qF, b, |), |))

&f.get-player-notes [v(d.cgf)]=iter(lattr(%0/_note.*), itext(0),, |)

&f.get-player-projects [v(d.cgf)]=iter(lattr(%0/_project.*), itext(0),, |)

&f.is_expert [v(d.cgf)]=not(t(ulocal(f.get-player-stat, %0, playbook)))

&f.get-playbook-default [v(d.cgf)]=strcat(setq(F, if(cand(t(%0), switch(%1, XP Triggers, 1, Friends, 1, Gear, 1, Abilities, 1, 0)), xget(%vD, strcat(d., ulocal(f.get-stat-location, %1), ., %0)))), if(switch(%1, Abilities, 1, 0), first(%qF, |), %qF))

&f.get-crew-default [v(d.cgf)]=strcat(setq(F, if(strmatch(%1, Favorite), ulocal(f.get-first-default, %2, Contacts), if(cand(t(%0), switch(%1, Crew XP Triggers, 1, Crew Abilities, 1, Contacts, 1, Favorite, 1, 0)), xget(%vD, strcat(d., ulocal(f.get-stat-location, %1), ., %0))))), if(switch(%1, Crew Abilities, 1, Favorite, 1, 0), first(%qF, |), %qF))

&f.get-first-default [v(d.cgf)]=first(ulocal(f.get-player-stat, %0, %1), |)

&f.get-last-default [v(d.cgf)]=strcat(setq(L, ulocal(f.get-player-stat, %0, %1)), last(diffset(%qL, first(%qL, |), |, |), |))

@@ %0: Player
@@ %1: Stat name
@@ %2: Is crew stat
@@ %3: Crew object
&f.get-stat-default [v(d.cgf)]=if(%2, ulocal(f.get-crew-default, xget(%3, ulocal(f.get-stat-location-on-player, Crew Type)), %1, %3), switch(%1, Ally, ulocal(f.get-first-default, %0, Friends), Rival, ulocal(f.get-last-default, %0, Friends), Standard Gear, xget(%vD, d.standard_gear), ulocal(f.get-playbook-default, xget(%0, ulocal(f.get-stat-location-on-player, Playbook)), %1)))

&f.get-crew-abilities [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.crew_abilities), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

&f.is-crew-stat [v(d.cgf)]=cor(cand(t(setr(S, finditem(ulocal(f.list-crew-stats), %0, |))), strmatch(%qS, %0)), t(member(xget(%vD, d.map-list), %0, |)))

&f.list-crew-stats [v(d.cgf)]=strcat(xget(%vD, d.crew_bio), |, xget(%vD, d.crew-stats))

&f.resolve-stat-name [v(d.cgf)]=strcat(setq(0, setq(1,)), null(iter(lattr(%vD/d.alias.*), if(cand(not(t(%q0)), t(finditem(setr(1, xget(%vD, itext(0))), %0, |))), setq(0, last(%q1, |))))), if(t(%q0), %q0, %0))

@@ %0: Player
@@ %1: Stat name
&f.get-player-stat [v(d.cgf)]=if(t(setr(V, xget(%0, ulocal(f.get-stat-location-on-player, %1)))), %qV, strcat(setq(N, ulocal(f.resolve-stat-name, %1)), setq(O, xget(%0, ulocal(f.get-stat-location-on-player, crew object))), setq(I, ulocal(f.is-crew-stat, %qN)), if(cand(not(strmatch(%qO, %0)), %qI), ulocal(f.get-player-stat, %qO, %qN), strcat(setq(V, xget(%0, ulocal(f.get-stat-location-on-player, %qN))), if(cand(t(%qV), if(switch(%qN, Rival, 1, Ally, 1, Favorite, 1, 0), t(finditem(ulocal(f.list-valid-values, %qN, %0), %qV, |)), 1)), %qV, ulocal(f.get-stat-default, %0, %qN, %qI, %qO))))))

th ulocal(v(d.cgf)/f.get-player-stat, %#, crew object)

&f.get-player-stat-or-zero [v(d.cgf)]=ulocal(f.get-player-stat-or-default, %0, %1, 0)

@@ Done this way because udefault() won't return the default unless f.get-player-stat doesn't exist, and we need to get the default in the case of nothing on the player instead.
&f.get-player-stat-or-default [v(d.cgf)]=if(t(strlen(setr(0, ulocal(f.get-player-stat, %0, %1)))), %q0, %2)

&f.get-random-name-and-job [v(d.cgf)]=strcat(pickrand(xget(%vD, d.random.name), |), %,%b, art(setr(J, pickrand(xget(%vD, d.random.job), |))), %b, %qJ)

&f.convert-stat-to-title [v(d.cgf)]=title(edit(lcstr(last(%0, .)), _, %b))

&f.get-stat-location [v(d.cgf)]=edit(%0, %b, _)

&f.get-stat-location-on-player [v(d.cgf)]=switch(%0, Look, short-desc, Name, d.ic_full_name, Alias, d.street_alias, edit(%0, %b, _, ^, _stat.))

&f.get-stats [v(d.cgf)]=squish(trim(strcat(xget(%vD, d.scoundrel-stats), |, setdiff(ulocal(f.get-player-bio-fields, %0), Crew, |, |), |, setdiff(xget(%vD, d.expert_bio), Crew, |, |), |, if(t(ulocal(f.get-player-stat, %0, crew object)), ulocal(f.get-crew-stats))), b, |), |)

&f.get-crew-stats [v(d.cgf)]=xget(%vD, d.crew_bio)|Favorite

&f.has-crew-stats [v(d.cgf)]=strcat(setq(0, iter(ulocal(f.get-crew-stats)|crew*|cohort*|contacts|upgrades, ulocal(f.get-stat-location-on-player, itext(0)), |)), setq(0, iter(%q0, if(t(member(itext(0), *)), lattr(strcat(%0, /, itext(0))), itext(0)))), setq(0, setdiff(%q0, ulocal(f.get-stat-location-on-player, Crew Name))), t(ladd(iter(%q0, hasattr(%0, itext(0))))))

&f.get-crew-members [v(d.cgf)]=if(t(%0), search(EPLAYER=t(member(ulocal(f.get-player-stat, ##, crew object), %0))))

&f.get-total-player-abilities [v(d.cgf)]=words(ulocal(f.get-player-stat, %0, abilities), |)

&f.get-total-player-actions [v(d.cgf)]=ladd(iter(ulocal(f.list-actions), if(not(member(%1, itext(0))), ulocal(f.get-player-stat-or-zero, %0, itext(0))), |))

&f.get-valid-value [v(d.cgf)]=if(t(setr(S, ulocal(f.list-values, %0, %2))), finditem(%qS, %1, |), %1)

&f.is-action [v(d.cgf)]=finditem(ulocal(f.list-actions), %0, |)

&f.is-attribute [v(d.cgf)]=finditem(xget(%vD, d.attributes), %0, |)

&f.get-player-attribute [v(d.cgf)]=ladd(iter(xget(%vD, d.actions.%1), t(ulocal(f.get-player-stat-or-zero, %0, itext(0))), |,))

&f.list-actions [v(d.cgf)]=xget(%vD, d.actions)

&f.list-restricted-values [v(d.cgf)]=xget(%vD, if(ulocal(f.is-action, %0), d.restricted.action, ulocal(f.get-stat-location, d.restricted.%0)))

&f.list-sheet-sections [v(d.cgf)]=xget(%vD, d.sheet-sections)

&f.list-valid-values [v(d.cgf)]=strcat(setq(R, ulocal(f.list-values, %0, %1)), null(iter(ulocal(f.list-restricted-values, %0), setq(R, remove(%qR, itext(0), |)), |)), if(member(%qR, *, |), strcat(setq(R, remove(%qR, *, |)), setq(R, strcat(%qR, |, any unrestricted text)))), %qR)

&f.get-full-list-stat-values [v(d.cgf)]=iter(lattr(strcat(%vD, /, d., ulocal(f.get-stat-location, %0), ., *)), title(lcstr(last(itext(0), .))),, |)

&f.list-values [v(d.cgf)]=case(1, t(ulocal(f.is-action, %0)), xget(%vD, d.value.action), ulocal(f.is-full-list-stat, %0), ulocal(f.get-full-list-stat-values, %0, %1), strmatch(Ally, %0), remove(ulocal(f.get-player-stat, %1, friends), ulocal(f.get-player-stat, %1, rival), |), strmatch(Rival, %0), remove(ulocal(f.get-player-stat, %1, friends), ulocal(f.get-player-stat, %1, ally), |), strmatch(Favorite, %0), ulocal(f.get-player-stat, %1, contacts), strmatch(Abilities, %0), ulocal(f.get-abilities), t(finditem(Crew Ability|Crew Abilities, %0, |)), ulocal(f.get-crew-abilities), strmatch(%0, Upgrade*), ulocal(f.get-upgrades), xget(%vD, ulocal(f.get-stat-location, d.value.%0)))

@@ These expect a tickable stat, in one of the following formats:
@@  [ ] Stat name here
@@  [ ] [ ] [ ] Stat name here
@@  [ ]-[ ] Stat name here
@@  [X] [ ] Stat name here
@@  [ ]-[ ] Stat name here [ ] Other stat here
@@ Number of boxes doesn't matter, nor does whether the boxes are checked.
@@ A box is "ticked" when it has an X in it. Otherwise it is unticked.

&f.is-tickable-type [v(d.cgf)]=cor(strmatch(%0, %[ %]*), strmatch(%0, %[X%]*))

&f.count-ticks [v(d.cgf)]=if(gt(setr(0, words(%0, \[X\])), 0), dec(%q0), 0)

&f.count-boxes [v(d.cgf)]=add(ulocal(f.count-ticks, %0), if(gt(setr(0, words(%0, \\[ \\])), 0), dec(%q0), 0))

@@ %0: any tickable list
@@ %1: 0 for unticked, 1 for ticked results, blank for all
&f.get-list-without-ticks [v(d.cgf)]=strcat(setq(0, edit(%0, %[ %], %[_%])), case(%1,,, setq(0, iter(%q0, if(strmatch(itext(0), strcat(*%[, case(%1, 0, _, X), %]*)), itext(0)), |, |))), iter(%q0, trim(iter(itext(0), if(strmatch(itext(0), %[*%]),, itext(0)))), |, |))

@@ %0: any tickable list
@@ %1: item to find
@@ %2: 0 for unticked, 1 for ticked results, blank for all
@@ Result: The list position of the item matching that value (including partial matches like "Heavy" for heavy armor)
&f.find-tickable [v(d.cgf)]=if(t(setr(R, first(trim(iter(setr(L, ulocal(f.get-list-without-ticks, %0, %2)), if(strmatch(itext(0), %1*), inum(0)), |, |), b, |), |))), %qR, first(trim(iter(%qL, if(strmatch(itext(0), *%1*), inum(0)), |, |), b, |), |))

@@ %0: crew object
&f.count-upgrades [v(d.cgf)]=add(ulocal(f.count-ticks, ulocal(f.get-player-stat, %0, Upgrades)), ulocal(f.get-total-cohort-cost, %0))

@@ If %0 matches conjoined ticks, tick all of them
@@ If %0 matches separated ticks, tick only the FIRST unticked
@@ If %0 matches separate conjoined ticks, tick only the first unticked set
@@ If there are no tickable slots, return it unchanged
&f.tick-tickable [v(d.cgf)]=strcat(setq(0, \[ \]), setq(1, edit(%q0, %b, X)), setq(2, edit(%q0, %b, _)), setq(3, edit(%0, %q0, %q2)), setq(4, 1), edit(iter(%q3, if(cand(%q4, strmatch(itext(0), %q2*)), strcat(edit(itext(0), %q2, %q1), setq(4, 0)), itext(0))), %q2, %q0))

@@ If %0 matches conjoined ticks, untick all of them
@@ If %0 matches separated ticks, untick only the LAST ticked
@@ If there are no untickable slots, return it unchanged
&f.untick-tickable [v(d.cgf)]=strcat(setq(0, \[X\]), setq(1, edit(%q0, %[X%], %[_%])), setq(2, edit(%q0, %b, _, %]%b%[, %]_%[)), setq(3, edit(%0, %q0, %q2)), setq(4, 1), edit(revwords(edit(iter(revwords(%q3), if(cand(%q4, strmatch(itext(0), %q2*)), strcat(edit(itext(0), %q2, %q1), setq(4, 0)), itext(0))), %q2, %q0)), _, %b))

@@ %0: A tickable item
@@ Returns: The amount of additional ticks this item will have if ticked.
&f.get-new-tick-cost [v(d.cgf)]=if(strmatch(%0, *%(0L%)*), 0, sub(ulocal(f.count-ticks, ulocal(f.tick-tickable, %0)), ulocal(f.count-ticks, %0)))

@@ %0 - stat
@@ %1 - value
@@ %2 - player
@@ %3 - player doing the setting
@@ %1 must be a valid value AND
@@ 	Must not be a restricted value OR
@@  Player must be approved
@@  Setter must be allowed to break stat-setting rules
@@  Actions may not advance to 4 unless the player's crew has Mastery or the player is a vampire.
@@ Returns the "pretty" value - AKA "Bodyguard" instead of "bod".
&f.get-pretty-value [v(d.cgf)]=if(cand(t(strlen(setr(0, ulocal(f.get-valid-value, %0, %1, %2)))), cor(not(finditem(ulocal(f.list-restricted-values, %0), %q0, |)), ulocal(f.is-allowed-to-break-stat-setting-rules, %3, %2), cand(isapproved(%2), case(1, t(ulocal(f.is-action, %0)), lte(%1, ulocal(f.get-max-action, %2)), strmatch(%0, Stress), ulocal(f.get-max-stress, %2), strmatch(%0, Traumas), ulocal(f.get-max-trauma, %2), 1)))), %q0)

&f.get-max-action [v(d.cgf)]=if(cor(ulocal(f.has-list-stat, ulocal(f.get-player-stat, %0, crew object), Upgrades, Mastery), strmatch(ulocal(f.get-player-stat, %0, Playbook), Vampire)), 4, 3)

&f.get-max-stress [v(d.cgf)]=if(ulocal(f.has-list-stat, ulocal(f.get-player-stat, %0, crew object), Upgrades, Steady), 10, 9)

&f.get-max-trauma [v(d.cgf)]=if(ulocal(f.has-list-stat, ulocal(f.get-player-stat, %0, crew object), Upgrades, Hardened), 5, 4)


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
&f.has-list-stat [v(d.cgf)]=switch(%1, Upgrades, t(ulocal(f.find-tickable, ulocal(f.get-player-stat, %0, %1), switch(%2, *\]*, trim(last(%2, \])), %2))), Factions, t(finditem(iter(ulocal(f.get-player-stat, %0, %1), rest(itext(0)), |, |), if(isnum(first(%2)), rest(%2), %2), |)), t(finditem(ulocal(f.get-player-stat, %0, %1), %2, |)))

&f.get-lifestyle [v(d.cgf)]=div(ulocal(f.get-player-stat, %0, Stash), 10)

&f.get-lifestyle-desc [v(d.cgf)]=case(ulocal(f.get-lifestyle, %0), 4, Fine, 3, Modest, 2, Meager, Poor soul)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ XP functions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: player
@@ %1: track - insight, prowess, resolve, playbook, crew
@@ %2: unspent, spent, or total (unspent is derived, total and spent are tracked)
&f.get-advancements [v(d.cgf)]=strcat(setq(P, switch(%1, c*, ulocal(f.get-player-stat, %0, crew object), %0)), if(switch(%2, s*, 1, t*, 1, 0), ulocal(f.get-player-stat-or-zero, %qP, advancements.%1.%2), sub(ulocal(f.get-player-stat-or-zero, %qP, advancements.%1.total), ulocal(f.get-player-stat-or-zero, %qP, advancements.%1.spent))))

@@ %0: player
@@ %1: track - insight, prowess, resolve, playbook, crew, untracked
@@ %2: current, max, or total (current is derived, total and max are tracked)
&f.get-xp [v(d.cgf)]=strcat(setq(P, switch(%1, c*, ulocal(f.get-player-stat, %0, crew object), %0)), if(switch(%2, m*, 1, t*, 1, 0), ulocal(f.get-player-stat-or-zero, %qP, xp.%1.%2), max(mod(ulocal(f.get-player-stat-or-zero, %qP, xp.%1.total), ulocal(f.get-player-stat-or-zero, %qP, xp.%1.max)), 0)))

@@ %0: player
@@ %1: total, spent, or unspent
&f.get-total-advancements [v(d.cgf)]=ladd(iter(setdiff(xget(%vD, d.xp_tracks), Crew|Untracked, |, |), ulocal(f.get-advancements, %0, itext(0), %1), |))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Downtimes
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&f.is-expert-with-all-hands [v(d.cgf)]=cand(ulocal(f.is_expert, %0), ulocal(f.has-list-stat, ulocal(f.get-player-stat, %0, crew object), Crew Abilities, All Hands))

&f.get-player-downtime-per-week [v(d.cgf)]=case(1, ulocal(f.is-expert-with-all-hands, %0), 2, 1)

&f.get-player-downtime-per-score [v(d.cgf)]=case(1, ulocal(f.is-expert-with-all-hands, %0), 3, 2)

@@ %0 - number of dice
@@ Output: Roll|Result
@@ Result: 1-3: 1; 4-5: 2; 6: 3; crit: 5
@@ Registers: D: Roll results; S: Successes; M: Mixed; F: Failures; H: Highest; L: Lowest; R: the number rolled.
&f.roll-to-heal [v(d.cgf)]=strcat(setq(S, setr(M, setr(F, setr(H, 0)))), setq(L, 6), setq(D, iter(switch(%0, 0, 1 2, lnum(%0)), strcat(setr(R, die(1, 6)), case(1, gte(%qR, 6), setq(S, inc(%qS)), gte(%qR, 4), setq(M, inc(%qM)), setq(F, inc(%qF))), if(gt(%qR, %qH), setq(H, %qR)), if(lt(%qR, %qL), setq(L, %qR))))), ulocal(f.colorize-die-roll, %qD, %0), |, case(1, eq(%0, 0), case(1, gt(%qL, 5), 3, gt(%qL, 3), 2, 1), gt(%qS, 1), 5, t(%qS), 3, t(%qM), 2, 1))

&f.get-lowest-attribute [v(d.cgf)]=min(ulocal(f.get-player-attribute, %0, Insight), ulocal(f.get-player-attribute, %0, Prowess), ulocal(f.get-player-attribute, %0, Resolve))

@@ %0 - dice to roll
@@ Output: Roll|Single numeric result
@@ Registers: D: Roll results; S: Successes; M: Mixed; F: Failures; H: Highest; L: Lowest; R: the number rolled.
&f.roll-to-indulge [v(d.cgf)]=strcat(setq(S, setr(M, setr(F, setr(H, 0)))), setq(L, 6), setq(D, iter(switch(%0, 0, 1 2, lnum(%0)), strcat(setr(R, die(1, 6)), case(1, gte(%qR, 6), setq(S, inc(%qS)), gte(%qR, 4), setq(M, inc(%qM)), setq(F, inc(%qF))), if(gt(%qR, %qH), setq(H, %qR)), if(lt(%qR, %qL), setq(L, %qR))))), ulocal(f.colorize-die-roll, %qD, %0), |, if(eq(%0, 0), %qL, %qH))

@@ %0: the results
@@ %1: the number of dice rolled
&f.colorize-die-roll [v(d.cgf)]=if(t(%1), iter(%0, ansi(case(itext(0), 6, ch, 5, hg, 4, hg, xh), itext(0))), edit(%0, lmin(%0), ansi(hg, lmin(%0))))

&f.get-max-healing-clock [v(d.cgf)]=if(ulocal(f.has-list-stat, %0, Abilities, Vigorous), 3, 4)

&f.get-max-rep [v(d.cgf)]=max(sub(12, ulocal(f.get-turf, %0)), 6)

&f.get-turf [v(d.cgf)]=add(if(ulocal(f.has-list-stat, %0, Crew Abilities, Fiends), ulocal(f.get-player-stat-or-zero, %0, Wanted Level), 0), if(ulocal(f.has-list-stat, %0, Crew Abilities, Accord), ladd(iter(ulocal(f.get-player-stat, %0, Factions), gt(first(itext(0)), 2), |)), 0), ladd(iter(ulocal(f.get-mapped-turf-list, %0), t(ulocal(f.mark-map, %0, itext(0))))), ladd(iter(ulocal(f.get-player-stat, %0, Claims), strmatch(itext(0), *Turf*), |)))

&f.get-mapped-turf-list [v(d.cgf)]=switch(ulocal(f.get-player-stat, %0, Crew Type), Assassins, B2 B4, Bravos, A2 B2 B4 B5, Cult, B1 B2 B4 B5, Hawkers, A1 B1 B2 B4, Shadows, A2 B4 C4, Smugglers, A1 B2 B4 B5)

&f.get-map-key [v(d.cgf)]=default(strcat(%0, /, ulocal(f.get-stat-location-on-player, Map %1)), extract(xget(%vD, strcat(d.map., ulocal(f.get-player-stat, %0, Crew Type))), switch(%1, A*, rest(%1, A), B*, add(5, if(gt(setr(I, rest(%1, B)), 2), -1, 0), %qI), add(9, rest(%1, C))), 1, |))

&f.get-map-h-join [v(d.cgf)]=edit(mid(strip(edit(xget(%vD, strcat(d.map-h-joins., ulocal(f.get-player-stat, %0, Crew Type))), %b, _), ABC12345), dec(switch(%1, A*, rest(%1, A), B*, add(5, rest(%1, B)), add(10, rest(%1, C)))), 1), _, %b)

&f.get-map-v-join [v(d.cgf)]=mid(xget(%vD, strcat(d.map-v-joins., ulocal(f.get-player-stat, %0, Crew Type))), dec(switch(%1, A*, rest(%1, A), B*, add(5, rest(%1, B)), add(10, rest(%1, C)))), 1)

@@ %0: crew object
@@ %1: stat name
&f.has-mapped-stat [v(d.cgf)]=t(ladd(cat(iter(xget(%vD, d.map-list), strmatch(ulocal(f.get-player-stat, %0, itext(0)), %1), |), iter(ulocal(f.get-player-stat, %0, Claims), strmatch(itext(0), %1), |))))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: player dbref
@@ %1: crew object
&f.is-crew-member [v(d.cgf)]=t(member(ulocal(f.get-player-stat, %0, crew object), %1))

&f.days-since-joined-crew [v(d.cgf)]=div(sub(secs(), xget(%0, last(lattr(%0/_crew-join-%1-*)))), 86400)

&f.is-founding-member [v(d.cgf)]=cand(ulocal(f.is-crew-member, %0, %1), if(t(setr(D, ulocal(f.get-player-stat, %1, crew approved date))), lt(unprettytime(xget(%0, last(lattr(%0/_crew-join-%1-*)))), unprettytime(%qD)), 1))

&f.is-probationary-member [v(d.cgf)]=cand(ulocal(f.is-crew-member, %0, %1), not(ulocal(f.is-founding-member, %0, %1)), if(ulocal(f.is-crew-approved, %1), lt(ulocal(f.days-since-joined-crew, %0, %1), xget(%vD, d.crew-probationary-period)), 0))

&f.is-full-member [v(d.cgf)]=cand(ulocal(f.is-crew-member, %0, %1), cor(ulocal(f.is-founding-member, %0, %1), not(ulocal(f.is-probationary-member, %0, %1))))

&f.is-idle-member [v(d.cgf)]=cand(ulocal(f.is-crew-member, %0, %1), gt(ulocal(f.days-since-last-connected, %0), xget(%vD, d.crew-idle-before-bootable)), not(strmatch(%0, %1)))

&f.is-crew-approved [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, crew approved date))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Jobs
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0: player
@@ %1: number of job or job dbref
&f.can-add-to-job [v(d.cgf)]=cand(not(hasflag(%0, GUEST)), cor(isdbref(setr(J, %1)), isdbref(setr(J, ulocal(%vA/fn_find-job, %1)))), cor(cand(ulocal(%vA/is_public, %qJ), t(match(xget(%qJ, opened_by), %0))), ulocal(%vA/fn_myaccesscheck, parent(%qJ), %0, %qJ)), not(hasattr(%qJ, locked)))
