@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ General layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.room-emit [v(d.cgf)]=cat(alert(Game), ulocal(f.get-name, %0), %1)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Entire sheets
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - target
@@ %1 - viewer
&layout.page1 [v(d.cgf)]=if(ulocal(f.is_expert, %0), ulocal(layout.simple, %0, %1), strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.actions, %0, %1), %r, ulocal(layout.abilities, %0, %1), %r, ulocal(layout.health, %0, %1), %r, ulocal(layout.stress, %0, %1), %r, ulocal(layout.xp_triggers, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1)))

&layout.page2 [v(d.cgf)]=if(ulocal(f.is_expert, %0), null(No second page.), strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.friends, %0, %1), %r, ulocal(layout.gear, %0, %1), %r, ulocal(layout.projects, %0, %1), %r, ulocal(layout.notes, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1)))

&layout.simple [v(d.cgf)]=strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.simple-bio, %0, %1), %r, ulocal(layout.coin, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Subsections
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.name [v(d.cgf)]=strcat(ulocal(f.get-name, %0, %1), if(isstaff(%1), strcat(%b, %(, %0, %))))

&layout.bio [v(d.cgf)]=strcat(multicol(ulocal(layout.player-bio, %0, %1), * *, 0, |, %1), %r, formattext(cat(Look:, shortdesc(%0, %1))))

&layout.simple-bio [v(d.cgf)]=strcat(multicol(iter(setdiff(xget(%vD, d.expert_bio), Look|Character Type, |, |), strcat(itext(0), :, %b, ulocal(f.get-player-stat-or-default, %0, itext(0), Not set)), |, |), * *, 0, |, %1), %r, divider(, %1), %r, formattext(cat(Character Type:, ulocal(f.get-player-stat-or-default, %0, Character Type, Not set))), %r, formattext(cat(Look:, ulocal(f.get-player-stat-or-default, %0, Look, Not set))))

&layout.player-bio [v(d.cgf)]=iter(ulocal(f.get-layout-bio-stats, %0), strcat(itext(0), :, %b, ulocal(f.get-player-stat-or-default, %0, itext(0), Not set)), |, |)

&layout.actions [v(d.cgf)]=strcat(divider(Actions, %1), %r, multicol(ulocal(layout.player-actions, %0), * 1 2 * 1 2 * 1, 1, |, %1))

&layout.player-actions [v(d.cgf)]=iter(strcat(xget(%vD, d.attributes), |, fliplist(strcat(xget(%vD, d.actions.insight), ||, xget(%vD, d.actions.prowess), ||, xget(%vD, d.actions.resolve)), 3, |)), strcat(itext(0), if(lte(inum(0), 3), strcat(space(3), %(, ulocal(f.get-xp, %0, itext(0), current), /, ulocal(f.get-xp, %0, itext(0), max), %b, XP, %), |, ulocal(f.get-player-attribute, %0, itext(0)), if(lte(inum(0), 2), |)), strcat(|, ulocal(f.get-player-stat-or-zero, %0, itext(0)), if(neq(mod(inum(0), 3), 0), |)))), |, |)

&layout.abilities-title [v(d.cgf)]=strcat(Special Abilities %(, ulocal(f.get-xp, %0, playbook, current), /, ulocal(f.get-xp, %0, playbook, max), %b, XP, %))

&layout.abilities [v(d.cgf)]=strcat(divider(ulocal(layout.abilities-title, %0, %1), %1), %r, multicol(ulocal(f.get-player-stat, %0, abilities), * *, 0, |, %1))

&layout.health [v(d.cgf)]=strcat(divider(Health, %1), setq(4, ulocal(layout.3health, %0, %1, 4, %2)), setq(3, ulocal(layout.3health, %0, %1, 3, %2)), setq(2, ulocal(layout.2health, %0, %1, 2, %2)), setq(1, ulocal(layout.2health, %0, %1, 1, %2)), if(t(%q4), strcat(%r, %q4)), if(t(%q3), strcat(%r, %q3)), if(t(%q2), strcat(%r, %q2)), if(t(%q1), strcat(%r, %q1)), %r, formattext(strcat(if(cor(t(%q4), t(%q3), t(%q2), t(%q1)), strcat(%r, space(3))), Healing clock:, %b, default(%0/_health-clock, 0), /, ulocal(f.get-max-healing-clock, %0)), 0, %1), if(t(%2), formattext(%b, 0, %1)))

&layout.3health [v(d.cgf)]=if(or(t(%3), t(setr(H, xget(%0, _health-%2)))), edit(multicol(strcat(setq(W, sub(getremainingwidth(%1), 17)), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, |, case(%2, 4, Catastrophic), |, %2, |, ulocal(layout.player-health, %0, %1, %qH, %qW), |, case(%2, 4, permanent, Need help), ||, #, repeat(@, %qW), #, |, case(%2, 4, consequences)), 1 * 13, 0, |, %1), _, %b, @, _, #, |))

&layout.player-health [v(d.cgf)]=strcat(#, center(mid(%2, 0, %3), %3, _), #)

&layout.2health [v(d.cgf)]=if(or(t(%3), t(setr(1, xget(%0, _health-%2-1))), t(setr(2, xget(%0, _health-%2-2)))), edit(multicol(strcat(setq(W, sub(div(sub(getremainingwidth(%1), 14), 2), 3)), |, _, repeat(@, %qW), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, |, #, center(__, %qW, _), #, ||, %2, |, ulocal(layout.player-health, %0, %1, %q1, %qW), |, ulocal(layout.player-health, %0, %1, %q2, %qW), |, case(%2, 2, -1d, Less effect), ||, #, repeat(@, %qW), #, |, #, repeat(@, %qW), #), 1 * * 13, 0, |, %1), _, %b, @, _, #, |))

&layout.stress [v(d.cgf)]=strcat(divider(Stress, %1), %r, multicol(strcat(Stress:, |, ulocal(f.get-player-stat-or-default, %0, Stress, 0), /, ulocal(f.get-max-stress, %0), |, Traumas:, |, words(ulocal(f.get-player-stat, %0, Traumas), |), /, setr(M, ulocal(f.get-max-trauma, %0))), * 5 * 5, 0, |, %1), %r, formattext(cat(Traumas:, ulocal(layout.list, setr(T, ulocal(f.get-player-stat-or-default, %0, Traumas, None yet.))), if(cand(t(setr(N, ulocal(f.get-player-stat, %0, needs trauma))), lt(words(%qT, |), %qM)), cat(%r%rNew trauma required. +trauma/add <choice> from the following list:, ulocal(layout.list, setdiff(xget(%vD, d.value.traumas), %qT, |, |))), if(t(%qN), %r%rNo more room for trauma. This character cannot play until this is resolved.))), 0, %1))

&layout.xp_triggers [v(d.cgf)]=strcat(divider(XP Triggers, %1), %r, formattext(strcat(* You, %b, ulocal(f.get-player-stat-or-default, %0, xp triggers, addressed a challenge with ______ or ______)., %r, * You roll a desperate action., %r, * You express your beliefs%, drives%, heritage%, or background., %r, * You struggled with issues from your vice or traumas during the session.), 0, %1))

&layout.friends [v(d.cgf)]=strcat(divider(Friends, %1), setq(E, ulocal(f.get-player-stat, %0, rival)), setq(A, ulocal(f.get-player-stat, %0, ally)), %r, multicol(iter(ulocal(f.get-player-stat, %0, friends), strcat(itext(0), switch(itext(0), %qA, %b%cg%(Ally%), %qE, %b%cr%(Rival%))), |, |), * *, 0, |, %1))

&layout.gear [v(d.cgf)]=strcat(divider(Playbook gear, %1), %r, multicol(edit(iter(fliplist(ulocal(f.get-player-stat, %0, gear), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1), %r, ulocal(layout.other-gear, %0, %1, %2), %r, ulocal(layout.load-chart, %0, %1), if(t(%2), strcat(%r, ulocal(layout.standard-gear, %0, %1, %2))), %r, ulocal(layout.coin, %0, %1))

&layout.coin [v(d.cgf)]=strcat(divider(Coin and wealth, %1), %r, multicol(strcat(Coin:, |, ulocal(f.get-player-stat-or-zero, %0, coin), /4, |, Stash:, |, ulocal(f.get-player-stat-or-zero, %0, stash)/40, |, Lifestyle:, |, ulocal(f.get-lifestyle-desc, %0), %b, %(, ulocal(f.get-lifestyle, %0), %)), 15 5 * 5 * 15, 0, |, %1))

&layout.standard-gear [v(d.cgf)]=strcat(divider(Standard gear, %1), %r, multicol(edit(iter(fliplist(if(t(setr(G, ulocal(f.get-player-stat, %0, standard gear))), %qG, xget(%vD, d.standard_gear)), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1))

&layout.other-gear [v(d.cgf)]=strcat(divider(Other gear, %1), %r, setq(L, edit(iter(fliplist(ulocal(f.get-player-stat, %0, other gear), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn)), multicol(if(t(%qL), %qL, |), * *, 0, |, %1))

&layout.load-chart [v(d.cgf)]=strcat(formattext(%b, 0, %1), multicol(strcat(ulocal(f.get-player-load-list, %0), |, Your load:, |, if(t(setr(L, ulocal(f.get-player-stat, %0, load))), %qL, Unset)), 6 4 7 4 6 2 12 4 * 6, 0, |, %1))

&layout.load-desc [v(d.cgf)]=cat(ulocal(f.get-name, %0, %1), looks, switch(ulocal(f.get-player-stat, %0, load), Normal, like a scoundrel%, ready for trouble, Heavy, like an operative on a mission, Encumbered, overburdened and slow, like an ordinary%, law-abiding citizen).)

&layout.gear-item [v(d.cgf)]=switch(%0, %[*%]*, %0, cat(%[, %], %0))

&layout.projects [v(d.cgf)]=strcat(divider(Long-term projects, %1), %r, multicol(ulocal(f.get-player-projects, %0), *, 0, |, %1))

&layout.notes [v(d.cgf)]=strcat(divider(Notes, %1), %r, multicol(ulocal(f.get-player-notes, %0), *, 0, |, %1))

&layout.footer [v(d.cgf)]=strcat(if(isapproved(%0), cat(Approved, ulocal(f.get-player-stat, %0, approved date)), if(t(setr(R, ulocal(f.get-player-stat, %0, retired date))), Retired %qR, Unapproved)), %,, %b, setr(A, add(ulocal(f.get-advancements, %0, Insight, spent), ulocal(f.get-advancements, %0, Prowess, spent), ulocal(f.get-advancements, %0, Resolve, spent), ulocal(f.get-advancements, %0, Playbook, spent))), %b, plural(%qA, Advancement, Advancements))

&layout.crew_footer [v(d.cgf)]=strcat(if(t(setr(D, ulocal(f.get-player-stat, %0, crew approved date))), cat(Approved, %qD), Unapproved), %,, %b, setr(A, ulocal(f.get-advancements, %0, Crew, spent)), %b, plural(%qA, Advancement, Advancements))

&layout.subsection [v(d.cgf)]=strcat(ulocal(ulocal(f.get-stat-location, layout.%0), %1, %2), %r, footer(ulocal(strcat(layout., switch(%0, crew*, crew_), footer), switch(%0, crew*, ulocal(f.get-player-stat, %1, crew object), %1), %2), %2))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew sheet
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.crew_name [v(d.cgf)]=header(if(t(%0), strcat(ulocal(f.get-player-stat-or-default, %0, Crew name, No crew name set), %b, %(, Tier, %b, ulocal(f.get-player-stat-or-zero, %0, Crew Tier), %), if(isstaff(%1), strcat(%b, %(, %0, %)))), No crew selected), %1)

@@ TODO: Consider revamping the crew bio. It's so multi-liney...

&layout.crew-rep-line [v(d.cgf)]=formattext(strcat(Reputation:, %b, ulocal(f.get-player-stat-or-default, %0, Reputation, Not set), %b, %(, ulocal(f.get-player-stat-or-zero, %0, Rep), /, ulocal(f.get-max-rep, %0), %)), 0, %1)

&layout.crew_bio [v(d.cgf)]=strcat(multicol(iter(setdiff(xget(%vD, d.crew_bio), Lair|Crew Name|Hunting Grounds|Reputation, |, |), strcat(itext(0), :, %b, ulocal(f.get-player-stat-or-default, %0, itext(0), Not set)), |, |), * *, 0, |, %1), %r, ulocal(layout.crew-rep-line, %0), %r, formattext(strcat(Hunting Grounds:, %b, ulocal(f.get-player-stat-or-default, %0, Hunting Grounds, Not set), %b, \[, first(ulocal(f.get-player-stat-or-default, %0, faction.hunting, +faction/set Hunting=<faction> to select|), |), \], %r, Lair:, %b, ulocal(f.get-player-stat-or-default, %0, Lair, Not set)), 0, %1))

&layout.crew1 [v(d.cgf)]=strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.crew_name, %qC, %1), %r, ulocal(layout.crew_bio, %qC, %1), %r, ulocal(layout.crew-heat, %qC, %1), %r, ulocal(layout.crew-coin, %qC, %1), %r, ulocal(layout.crew-abilities, %qC, %1), %r, ulocal(layout.crew-upgrades, %qC, %1), %r, ulocal(layout.crew-xp_triggers, %qC, %1))

&layout.crew2 [v(d.cgf)]=strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.crew_name, %qC, %1), %r, ulocal(layout.crew-map, %qC, %1), %r, ulocal(layout.crew-cohorts, %qC, %1), %r, ulocal(layout.crew-contacts, %qC, %1), %r, ulocal(layout.crew-factions, %qC, %1), %r, ulocal(layout.crew-members, %qC, %1))

&layout.crew-coin [v(d.cgf)]=strcat(multicol(strcat(Crew Coin:, |, ulocal(f.get-player-stat-or-zero, %0, crew coin), /, ulocal(f.get-vault-max, %0)), 15 5 * 5 * 15, 0, |, %1))

&layout.crew-heat [v(d.cgf)]=strcat(divider(Heat and Wanted Levels, %1), %r, multicol(strcat(Heat:, |, ulocal(f.get-player-stat-or-zero, %0, heat), /, ulocal(f.get-player-stat-or-default, %0, max heat, 9), |, Wanted Level:, |, ulocal(f.get-player-stat-or-zero, %0, wanted level), /4, |, Hold:, |, ulocal(f.get-player-stat-or-default, %0, hold, Strong)), 15 5 * 5 * 8, 0, |, %1))

&layout.crew-abilities [v(d.cgf)]=strcat(divider(Crew Abilities, %1), %r, multicol(ulocal(f.get-player-stat, %0, Crew Abilities), * *, 0, |, %1))

@@ %0: crew object
@@ %1: cohort full name
&layout.cohort [v(d.cgf)]=strcat(setq(T, ulocal(f.get-player-stat-or-zero, %0, tier)), setq(C, ulocal(f.get-cohort-stat, %0, %1, cohort type)), setq(Y, ulocal(f.get-cohort-stat, %0, %1, types)), if(strmatch(setr(U, ulocal(f.get-player-stat, %0, Upgrades)), *Elite *), iter(%qY, if(strmatch(%qU, cat(* Elite, itext(0)*)), setq(Y, edit(%qY, itext(0), cat(Elite, itext(0))))), |)), setq(Y, sortby(f.sort-elite-last, %qY, |, |)), setq(F, trim(strcat(ulocal(f.get-cohort-stat, %0, %1, edges), |, ulocal(f.get-cohort-stat, %0, %1, flaws)), b, |)), setq(S, ulocal(f.get-cohort-stat, %0, %1, specialty)), %ch%cu%1%cn, %b\(, switch(%qC, V*, %qC, strcat(switch(%qC, Gang, %qC of, %qC), %b, itemize(if(strmatch(%qC, Expert), iter(%qY, mid(itext(0), 0, dec(strlen(itext(0)))), |, |), %qY), |))), \), if(strmatch(%qC, Expert), strcat(|, Specialty:, %b, if(t(%qS), %qS, None yet.))), |, Edges & Flaws:, %b, if(t(%qF), itemize(%qF, |), None yet.), |, switch(%qC, Gang, cat(Scale:, %qT%,, Quality: %qT), cat(Quality:, inc(%qT))))

@@ TODO: Someday AFTER initial open, add Cohort Harm.

&layout.crew-cohorts [v(d.cgf)]=strcat(divider(Cohorts, %1), %r, multicol(iter(ulocal(f.get-player-stat, %0, Cohorts), ulocal(layout.cohort, %0, itext(0)), |, |), *, 0, |, %1))

&layout.crew-factions [v(d.cgf)]=strcat(divider(Factions, %1), %r, multicol(ulocal(f.get-player-stat, %0, Factions), * *, 0, |, %1))

&layout.crew-contacts [v(d.cgf)]=strcat(divider(Crew Contacts, %1), setq(F, ulocal(f.get-player-stat, %0, favorite)), %r, multicol(iter(ulocal(f.get-player-stat, %0, Contacts), strcat(itext(0), switch(%qF, itext(0), %b%cg%(Favorite%))), |, |), * *, 0, |, %1))

&layout.crew-upgrades [v(d.cgf)]=strcat(divider(Upgrades, %1), %r, setq(U, ulocal(f.get-player-stat, %0, Upgrades)), setq(M, ulocal(f.replace-upgrades, xget(%vD, strcat(d.upgrades., ulocal(f.get-player-stat, %0, Crew Type))), %qU)), setq(M, strcat(%qM, |, ulocal(f.get-extra-crew-upgrades, %qU, %qM))), setq(M, squish(trim(%qM, b, |), |)), setq(L, xget(%vD, d.upgrades.lair)), setq(T, xget(%vD, d.upgrades.training)), setq(Q, xget(%vD, d.upgrades.quality)), setq(W, getremainingwidth(%1, 2)), multicol(fliplist(strcat(divider(Crew, %qW), |, %qM, |, divider(Quality, %qW), |, ulocal(f.replace-upgrades, %qQ, %qU), repeat(|, sub(add(words(%qL, |), words(%qT, |)), add(words(%qM, |), words(%qQ, |)))), |, divider(Lair, %qW), |, ulocal(f.replace-upgrades, %qL, %qU), |, divider(Training, %qW), |, ulocal(f.replace-upgrades, %qT, %qU)), 2, |), * *, 0, |, %1))

&layout.crew-members [v(d.cgf)]=strcat(divider(Members, %1), %r, multicol(iter(ulocal(f.get-crew-members, %0), trim(cat(ulocal(f.get-name, itext(0), %1), case(1, ulocal(f.is-founding-member, itext(0), %0), ansi(cg, %(Founder%)), ulocal(f.is-probationary-member, itext(0), %0), ansi(ch, %(Probationary%))), ulocal(f.get-crew_title, itext(0)))),, |), * *, 0, |, %1))

&layout.crew-map [v(d.cgf)]=strcat(divider(Holdings, %1), %r, ulocal(layout.crew-map-format, %0, %1, universal), if(t(setr(U, ulocal(f.get-player-stat, %0, Claims))), strcat(%r, divider(Unmapped Claims, %1), %r, multicol(%qU, * *, 0, |, %1))))

@@ TODO: Separate crew sheet for Jail Claims.

&layout.crew-map-format [v(d.cgf)]=edit(formattext(edit(ulocal(layout.crew-map.%2, %0, %1), |, @), 0, %1), @, |)

&layout.crew-xp_triggers [v(d.cgf)]=strcat(divider(strcat(Crew XP, %b, %(, ulocal(f.get-xp, %0, Crew, unspent), /10, %)), %1), %r, formattext(strcat(*, %b, ulocal(f.get-player-stat-or-default, %0, crew xp triggers, Select your crew type to show this information.), %r, * Contend with challenges above your current station., %r, * Bolster your crew's reputation or develop a new one., %r, * Express the goals%, drives%, inner conflict%, or essential nature of the crew.), 0, %1))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew maps
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.map-a-line [v(d.cgf)]=strcat(space(5), ulocal(f.mark-map, %0, A1), | |, space(5), ulocal(f.mark-map, %0, A2), | |, space(5), ulocal(f.mark-map, %0, A3), | |, space(5), ulocal(f.mark-map, %0, A4), | |, space(5), ulocal(f.mark-map, %0, A5), |, %b, ulocal(f.mark-map, %0, A3, 1))

&layout.map-b-line [v(d.cgf)]=strcat(space(5), ulocal(f.mark-map, %0, B1), | |, space(5), ulocal(f.mark-map, %0, B2), | |, space(5), X| |, space(5), ulocal(f.mark-map, %0, B4), | |, space(5), ulocal(f.mark-map, %0, B5), |, %b, ulocal(f.mark-map, %0, B2, 1))

&layout.map-c-line [v(d.cgf)]=strcat(space(5), ulocal(f.mark-map, %0, C1), | |, space(5), ulocal(f.mark-map, %0, C2), | |, space(5), ulocal(f.mark-map, %0, C3), | |, space(5), ulocal(f.mark-map, %0, C4), | |, space(5), ulocal(f.mark-map, %0, C5), |, %b, ulocal(f.mark-map, %0, C2, 1))

&layout.crew-map.universal [v(d.cgf)]=strcat(strcat(space(45), ulocal(f.mark-map, %0, A1, 1), A1:, %b, ulocal(f.get-map-key, %0, A1), %r%b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), ulocal(f.mark-map, %0, A2, 1), A2:, %b, ulocal(f.get-map-key, %0, A2), %r, |, ulocal(layout.map-a-line, %0), A3:, %b, ulocal(f.get-map-key, %0, A3), %r, |, space(2), A1, space(2), |, ulocal(f.get-map-h-join, %0, A1), |, space(2), A2, space(2), |, ulocal(f.get-map-h-join, %0, A2), |, space(2), A3, space(2), |, ulocal(f.get-map-h-join, %0, A3), |, space(2), A4, space(2), |, ulocal(f.get-map-h-join, %0, A4), |, space(2), A5, space(2), |, %b, ulocal(f.mark-map, %0, A4, 1), A4:, %b, ulocal(f.get-map-key, %0, A4), %r, |______| |______| |______| |______| |______|, %b, ulocal(f.mark-map, %0, A5, 1), A5:, %b, ulocal(f.get-map-key, %0, A5)), %r, strcat(%b__, ulocal(f.get-map-v-join, %0, A1), ___, space(3), ___, ulocal(f.get-map-v-join, %0, A2), __, space(3), ___, ulocal(f.get-map-v-join, %0, A3), __, space(3), ___, ulocal(f.get-map-v-join, %0, A4), __, space(3), ___, ulocal(f.get-map-v-join, %0, A5), __, space(2), ulocal(f.mark-map, %0, B1, 1), B1:, %b, ulocal(f.get-map-key, %0, B1), %r, |, ulocal(layout.map-b-line, %0), B2:, %b, ulocal(f.get-map-key, %0, B2), %r, |, space(2), B1, space(2), |, ulocal(f.get-map-h-join, %0, B1), |, space(2), B2, space(2), |, ulocal(f.get-map-h-join, %0, B2), | LAIR |, ulocal(f.get-map-h-join, %0, B3), |, space(2), B4, space(2), |, ulocal(f.get-map-h-join, %0, B4), |, space(2), B5, space(2), |, %b, ulocal(f.mark-map, %0, B4, 1), B4:, %b, ulocal(f.get-map-key, %0, B4), %r, |______| |______| |______| |______| |______|, %b, ulocal(f.mark-map, %0, B5, 1), B5:, %b, ulocal(f.get-map-key, %0, B5)), %r, strcat(%b__, ulocal(f.get-map-v-join, %0, B1), ___, space(3), ___, ulocal(f.get-map-v-join, %0, B2), __, space(3), ___, ulocal(f.get-map-v-join, %0, B3), __, space(3), ___, ulocal(f.get-map-v-join, %0, B4), __, space(3), ___, ulocal(f.get-map-v-join, %0, B5), __, space(2), ulocal(f.mark-map, %0, C1, 1), C1:, %b, ulocal(f.get-map-key, %0, C1), %r, |, ulocal(layout.map-c-line, %0), C2:, %b, ulocal(f.get-map-key, %0, C2), %r, |, space(2), C1, space(2), |, ulocal(f.get-map-h-join, %0, C1), |, space(2), C2, space(2), |, ulocal(f.get-map-h-join, %0, C2), |, space(2), C3, space(2), |, ulocal(f.get-map-h-join, %0, C3), |, space(2), C4, space(2), |, ulocal(f.get-map-h-join, %0, C4), |, space(2), C5, space(2), |, %b, ulocal(f.mark-map, %0, C3, 1), C3:, %b, ulocal(f.get-map-key, %0, C3), %r, |______| |______| |______| |______| |______|, %b, ulocal(f.mark-map, %0, C4, 1), C4:, %b, ulocal(f.get-map-key, %0, C4), %r, space(45), ulocal(f.mark-map, %0, C5, 1), C5:, %b, ulocal(f.get-map-key, %0, C5)))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CG checks
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&check.simple.age [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, Age))

&check.simple.look [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, look))

&check.simple.desc [v(d.cgf)]=hasattr(%0, desc)

&check.simple.expert_type [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, expert type))

&check.simple.character_type [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, character type))

&check.scoundrel.crew [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, crew object))

&check.scoundrel.actions [v(d.cgf)]=eq(ulocal(f.get-total-player-actions, %0), 7)

&check.scoundrel.abilities [v(d.cgf)]=eq(ulocal(f.get-total-player-abilities, %0), 1)

&check.scoundrel.bio [v(d.cgf)]=not(ladd(iter(remove(ulocal(f.get-player-bio-fields, %0), Crew, |), not(hasattr(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |)))

&check.scoundrel.friends [v(d.cgf)]=cand(t(setr(F, ulocal(f.get-player-stat, %0, friends))), eq(words(%qF, |), 5), t(ulocal(f.get-player-stat, %0, ally)), t(ulocal(f.get-player-stat, %0, rival)))

&check.scoundrel.gear [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, gear))

&check.scoundrel.xp_triggers [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, xp triggers))

&check.crew.bio [v(d.cgf)]=not(ladd(iter(xget(%vD, d.crew_bio), not(hasattr(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |)))

&check.crew.abilities [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, crew abilities))

&check.crew.contacts [v(d.cgf)]=cand(t(setr(C, ulocal(f.get-player-stat, %0, contacts))), eq(words(%qC, |), 6), t(ulocal(f.get-player-stat, %0, favorite)))

&check.crew.upgrades [v(d.cgf)]=eq(ulocal(f.count-upgrades, %0), 4)

&check.crew.xp_triggers [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, crew xp triggers))

&check.faction_status_limits [v(d.cgf)]=eq(ladd(iter(ulocal(f.get-player-stat, %0, factions), cat(setq(W, stripansi(ulocal(f.get-faction-status, %0, rest(itext(0))))), lt(%qW, -3), gt(%qW, 3)), |)), 0)

&check.faction_questions_answered [v(d.cgf)]=cand(t(ulocal(f.get-player-stat, %0, faction.hunting)), t(ulocal(f.get-player-stat, %0, faction.helped)), t(ulocal(f.get-player-stat, %0, faction.harmed)), t(ulocal(f.get-player-stat, %0, faction.friendly)), t(ulocal(f.get-player-stat, %0, faction.unfriendly)))

&check.cohort-flaws-balance [v(d.cgf)]=eq(ladd(iter(ulocal(f.get-player-stat, %0, Cohorts), neq(words(ulocal(f.get-cohort-stat, %0, itext(0), Edges), |), words(ulocal(f.get-cohort-stat, %0, itext(0), Flaws), |)), |,)), 0)

&check.cohort-edges-count [v(d.cgf)]=eq(ladd(iter(ulocal(f.get-player-stat, %0, Cohorts), cat(setq(W, words(ulocal(f.get-cohort-stat, %0, itext(0), Edges), |)), lt(%qW, 1), gt(%qW, 2)), |,)), 0)

&check.like-part-of-the-family-cohort [v(d.cgf)]=if(ulocal(f.has-list-stat, %0, Crew Abilities, Like Part of the Family), cand(ulocal(f.has-list-stat, %0, Upgrades, Vehicle), t(finditem(iter(ulocal(f.get-player-stat, %0, Cohorts), ulocal(f.get-cohort-stat, %0, itext(0), Cohort Type), |, |), Vehicle, |))), 1)

&check.vehicle-without-crew-ability [v(d.cgf)]=if(not(ulocal(f.has-list-stat, %0, Crew Abilities, Like Part of the Family)), not(t(finditem(iter(ulocal(f.get-player-stat, %0, Cohorts), ulocal(f.get-cohort-stat, %0, itext(0), Cohort Type), |, |), Vehicle, |))), 1)


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CG error messages
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.pass [v(d.cgf)]=%ch%cg%[Pass%]

&layout.fail [v(d.cgf)]=%cr%[Needs work%]

&layout.test [v(d.cgf)]=cat(*, if(t(%0), %1, if(t(%2), %2, %1)), if(t(%0), ulocal(layout.pass), ulocal(layout.fail)))

@@ Show this error only if the test fails.
&layout.test-line [v(d.cgf)]=if(not(t(%0)), cat(%r*, %1, ulocal(layout.fail)))

&layout.cg-errors [v(d.cgf)]=strcat(header(Character generation instructions, %1), %r, if(ulocal(f.is_expert, %0), ulocal(layout.simple-cg-errors, %0, %1), ulocal(layout.full-cg-errors, %0, %1)), %r, footer(cg/on to join the Chargen channel and ask questions!))

&layout.simple-cg-errors [v(d.cgf)]=strcat(formattext(strcat(* You're an Expert right now. If you'd rather be a Scoundrel%, type +stat/set Playbook=<yours>., %r, ulocal(layout.test, ulocal(check.simple.age, %0), +stat/set Age=<Young Adult%, Adult%, Mature%, or Elderly>), %r, ulocal(layout.test, ulocal(check.simple.look, %0), +stat/set Look=<Character's short description>), %r, ulocal(layout.test, ulocal(check.simple.desc, %0), @desc me=<Character's normal description>), %r, ulocal(layout.test, ulocal(check.simple.expert_type, %0), +stat/set Expert Type=<Character's expert type>), %r, ulocal(layout.test, ulocal(check.simple.character_type, %0), +stat/set Character Type=<Character's type>), %r, +stat/lock when you're done!), 0, %1))

&layout.crew-cg-errors [v(d.cgf)]=strcat(header(Crew creation instructions, %1), %r, formattext(strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.test, ulocal(check.crew.bio, %qC), Set all your crew's bio fields.), %r, ulocal(layout.test, ulocal(check.crew.abilities, %qC), Select one Crew Ability.), %r, ulocal(layout.test, ulocal(check.crew.contacts, %qC), Choose 6 Contacts and a Favorite.), %r, ulocal(layout.test, ulocal(check.crew.upgrades, %qC), Select 4 points of Upgrades.), ulocal(layout.test-line, ulocal(check.cohort-edges-count, %qC), Pick 1-2 Edges and Flaws for your Cohorts.), ulocal(layout.test-line, ulocal(check.cohort-flaws-balance, %qC), Cohort Edges and Flaws should balance one for one: one Edge = one Flaw.), ulocal(layout.test-line, ulocal(check.like-part-of-the-family-cohort, %qC), You have Like Part of the Family. Take the Vehicle Upgrade and create a Cohort with the Vehicle Type.), ulocal(layout.test-line, ulocal(check.vehicle-without-crew-ability, %qC), Having a Vehicle Cohort without the Crew Ability "Like Part of the Family" is not allowed.), %r, ulocal(layout.test, ulocal(check.faction_questions_answered, %qC), Answer 5 faction questions.), ulocal(layout.test-line, ulocal(check.faction_status_limits, %qC), You're at less than -3 or greater than +3 to a faction. Shift your factions around.), %r, ulocal(layout.test, ulocal(check.crew.xp_triggers, %qC), Select a Crew XP Trigger.)), 0, %1), ulocal(layout.cg-commands, +crew/all to see everything|+cohort/create <name>=<type>|+faction/set <question>=<faction>|+cohort/set <stat>=<value>|+faction/pay <question>=<amount>|+crew/lock to submit to staff|+faction/boost or unboost, %1), %r, footer(cg/on to join the Chargen channel and ask questions!, %1))

&layout.full-cg-errors [v(d.cgf)]=strcat(formattext(strcat(ulocal(layout.test, ulocal(check.scoundrel.bio, %0), You have all your bio fields set., Some of your bio fields %(not counting Crew%) are not set.), ulocal(layout.test-line, ulocal(check.simple.desc, %0), @desc me=<Character's normal description>), %r, ulocal(layout.test, ulocal(check.scoundrel.actions, %0), 7 action dots chosen., You need 7 action dots. You have [ulocal(f.get-total-player-actions, %0)].), %r, ulocal(layout.test, ulocal(check.scoundrel.abilities, %0), One ability selected., You need one ability. You have [ulocal(f.get-total-player-abilities, %0)].), %r, ulocal(layout.test, ulocal(check.scoundrel.friends, %0), You need 5 friends%, an ally%, and a rival.), %r, ulocal(layout.test, ulocal(check.scoundrel.gear, %0), You have chosen your gear., You need gear!), %r, ulocal(layout.test, ulocal(check.scoundrel.xp_triggers, %0), You have chosen your XP triggers., You need to select your XP triggers.)), 0, %1), ulocal(layout.cg-commands, +sheet/all to see everything|+stats/lock to submit to staff, %1))

&layout.cg-commands [v(d.cgf)]=strcat(divider(Commands, %1), %r, multicol(+stat/set <stat>=<value>|+stat/set <stat>= to clear a stat|+stat/clear to start over|%0, * *, 0, |, %1))

@@ TODO: If a staffer is looking at an unapproved sheet, @pemit them an extra layout which includes every "arbitrary text" field on the sheet so they can very quickly go over those for any unthematic stuff.
