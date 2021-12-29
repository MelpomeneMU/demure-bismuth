@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - target
@@ %1 - viewer
&layout.page1 [v(d.cgf)]=if(ulocal(f.is_expert, %0), ulocal(layout.simple, %0, %1), strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.actions, %0, %1), %r, ulocal(layout.abilities, %0, %1), %r, ulocal(layout.health, %0, %1), %r, ulocal(layout.pools, %0, %1), %r, ulocal(layout.xp_triggers, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1)))

&layout.page2 [v(d.cgf)]=if(ulocal(f.is_expert, %0), null(No second page.), strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.friends, %0, %1), %r, ulocal(layout.gear, %0, %1), %r, ulocal(layout.projects, %0, %1), %r, ulocal(layout.notes, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1)))

&layout.simple [v(d.cgf)]=strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.simple-bio, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&layout.simple-bio [v(d.cgf)]=strcat(multicol(iter(setdiff(xget(%vD, d.expert_bio), Look|Character Type, |, |), strcat(itext(0), :, %b, ulocal(f.get-player-stat-or-default, %0, itext(0), Not set)), |, |), * *, 0, |, %1), %r, divider(), %r, formattext(cat(Character Type:, ulocal(f.get-player-stat-or-default, %0, Character Type, Not set))), %r, formattext(cat(Look:, ulocal(f.get-player-stat-or-default, %0, Look, Not set))))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Rest of the sheet
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@


&layout.name [v(d.cgf)]=strcat(ulocal(f.get-name, %0, %1), if(isstaff(%1), strcat(%b, %(, %0, %))))

&layout.crew_name [v(d.cgf)]=header(if(t(%0), strcat(ulocal(f.get-player-stat-or-default, %0, Crew name, No crew name set), %b, %(, Tier, %b, ulocal(f.get-player-stat-or-zero, %0, Crew Tier), %), if(isstaff(%1), strcat(%b, %(, %0, %)))), No crew selected), %1)

&layout.crew_bio [v(d.cgf)]=strcat(multicol(iter(setdiff(xget(%vD, d.crew_bio), Lair|Crew Name, |, |), strcat(itext(0), :, %b, ulocal(f.get-player-stat-or-default, %0, itext(0), Not set)), |, |), * *, 0, |, %1), %r, formattext(cat(Lair:, ulocal(f.get-player-stat-or-default, %0, Lair, Not set))))

&layout.crew1 [v(d.cgf)]=strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.crew_name, %qC, %1), %r, if(cor(cand(member(%qC, %1), member(%0, %1)), not(t(%qC)), isapproved(%1), isstaff(%1)), strcat(ulocal(layout.crew_bio, %qC, %1), %r, ulocal(layout.crew_pools, %qC, %1), %r, ulocal(layout.crew-abilities, %qC, %1), %r, ulocal(layout.crew-contacts, %qC, %1), %r, ulocal(layout.crew-upgrades, %qC, %1), %r, ulocal(layout.crew-cohorts, %qC, %1), %r, ulocal(layout.crew_xp_triggers, %qC, %1)), strcat(formattext(Full crew sheet will become available once you are approved., 1, %1))))

&layout.crew2 [v(d.cgf)]=strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.crew_name, %qC, %1), %r, if(cor(cand(member(%qC, %1), member(%0, %1)), not(t(%qC)), isapproved(%1), isstaff(%1)), strcat(ulocal(layout.crew_bio, %qC, %1), %r, ulocal(layout.crew-map, %qC, %1), %r, ulocal(layout.crew-factions, %qC, %1), %r, ulocal(layout.crew-members, %qC, %1)), strcat(formattext(Full crew sheet will become available once you are approved., 1, %1))))

@@ TODO: Set up the maps correctly.
@@ TODO: Factions

&layout.crew_pools [v(d.cgf)]=strcat(divider(Pools, %0), %r, multicol(strcat(Hold:, |, Weak, |, Heat:, |, 0/9, |, Coin:, |, 0/4, |, Crew XP:, |, 0/10, |, Wanted Level:, |, 0/4, |, Vaults:, |, 0/12), * 6 * 5 * 5, 0, |, %1))
+sheet/crew

&layout.crew-abilities [v(d.cgf)]=strcat(divider(Crew Abilities, %1), %r, multicol(ulocal(f.get-player-stat, %0, Crew Abilities), * *, 0, |, %1))

@@ %0: crew object
@@ %1: cohort full name
&layout.cohort [v(d.cgf)]=strcat(setq(T, ulocal(f.get-player-stat-or-zero, %0, tier)), setq(C, ulocal(f.get-cohort-stat, %0, %1, cohort type)), setq(Y, ulocal(f.get-cohort-stat, %0, %1, types)), if(strmatch(setr(U, ulocal(f.get-player-stat, %0, Upgrades)), *Elite *), iter(%qY, if(strmatch(%qU, cat(* Elite, itext(0))), setq(Y, edit(%qY, itext(0), cat(Elite, itext(0))))), |)), setq(Y, sortby(f.sort-elite-last, %qY, |, |)), setq(F, trim(strcat(ulocal(f.get-cohort-stat, %0, %1, edges), |, ulocal(f.get-cohort-stat, %0, %1, flaws)), b, |)), setq(S, ulocal(f.get-cohort-stat, %0, %1, specialty)), %ch%cu%1%cn, %b\(, switch(%qC, Gang, %qC of, %qC), %b, itemize(if(strmatch(%qC, Expert), iter(%qY, mid(itext(0), 0, dec(strlen(itext(0)))), |, |), %qY), |), \), if(strmatch(%qC, Expert), strcat(|, Specialty:, %b, if(t(%qS), %qS, None yet.))), |, Edges & Flaws:, %b, if(t(%qF), itemize(%qF, |), None yet.), |, switch(%qC, Gang, cat(Scale:, %qT%,, Quality: %qT), cat(Quality:, inc(%qT))))

@@ TODO: Someday AFTER initial open, add Cohort Harm.

&layout.crew-cohorts [v(d.cgf)]=strcat(divider(Cohorts, %0, %1), %r, multicol(iter(ulocal(f.get-player-stat, %0, Cohorts), ulocal(layout.cohort, %0, itext(0)), |, |), *, 0, |, %1))

&layout.crew-factions [v(d.cgf)]=strcat(divider(Factions, %0, %1), %r, multicol(ulocal(f.get-player-stat, %0, Factions), * *, 0, |, %1))

&layout.crew-contacts [v(d.cgf)]=strcat(divider(Crew Contacts, %0, %1), setq(F, ulocal(f.get-player-stat, %0, favorite)), %r, multicol(iter(ulocal(f.get-player-stat, %0, Contacts), strcat(itext(0), switch(%qF, itext(0), %b%cg%(Favorite%))), |, |), * *, 0, |, %1))

&layout.crew-upgrades [v(d.cgf)]=strcat(divider(Upgrades, %0, %1), %r, setq(U, ulocal(f.get-player-stat, %0, Upgrades)), setq(M, ulocal(f.replace-upgrades, xget(%vD, strcat(d.upgrades., ulocal(f.get-player-stat, %0, Crew Type))), %qU)), setq(M, strcat(%qM, |, ulocal(f.get-extra-crew-upgrades, %qU, %qM))), setq(M, squish(trim(%qM, b, |), |)), setq(W, div(getremainingwidth(%1), 2)), multicol(fliplist(strcat(divider(Crew, %qW), |, %qM, |, divider(Quality, %qW), |, ulocal(f.replace-upgrades, xget(%vD, d.upgrades.quality), %qU), repeat(|, sub(12, add(words(%qM, |), 6))), |, divider(Lair, %qW), |, ulocal(f.replace-upgrades, xget(%vD, d.upgrades.lair), %qU), |, divider(Training, %qW), |, ulocal(f.replace-upgrades, xget(%vD, d.upgrades.training), %qU)), 2, |), * *, 0, |, %1))

&layout.crew-members [v(d.cgf)]=strcat(divider(Members, %1), %r, multicol(iter(ulocal(f.get-crew-members, %0), trim(cat(ulocal(f.get-name, itext(0), %1), if(t(member(itext(0), %0)), ansi(g, %(Statter%)), if(not(isapproved(itext(0))), ansi(ch, %(Provisional%)))), ulocal(f.get-crew_title, itext(0)))),, |), * *, 0, |, %1))

&layout.crew-map [v(d.cgf)]=strcat(divider(Holdings, %0, %1), %r, ulocal(layout.crew-map-format, %0, %1, ulocal(f.get-player-stat-or-default, %0, crew type, blank)))

&layout.crew-map-format [v(d.cgf)]=edit(formattext(edit(ulocal(layout.crew-map.%2, %0, %1), |, @), 0, %1), @, |)

&layout.bio [v(d.cgf)]=strcat(multicol(ulocal(layout.player-bio, %0, %1), * *, 0, |, %1), %r, formattext(cat(Look:, shortdesc(%0, %1))))

&layout.player-bio [v(d.cgf)]=iter(ulocal(f.get-layout-bio-stats, %0), strcat(itext(0), :, %b, ulocal(f.get-player-stat-or-default, %0, itext(0), Not set)), |, |)

&layout.actions [v(d.cgf)]=strcat(divider(Actions, %0), %r, multicol(ulocal(layout.player-actions, %0), * 1 * 1 * 1, 1, |, %1))

&layout.player-actions [v(d.cgf)]=iter(strcat(xget(%vD, d.attributes), |, fliplist(strcat(xget(%vD, d.actions.insight), |, xget(%vD, d.actions.prowess), |, xget(%vD, d.actions.resolve)), 3, |)), strcat(itext(0), if(lte(inum(0), 3), strcat(space(3), %(, 0, /, 6, %b, XP, %), |, ulocal(f.get-player-stat-or-zero, %0, itext(0))), strcat(|, ulocal(f.get-player-stat-or-zero, %0, itext(0))))), |, |)

&layout.abilities-title [v(d.cgf)]=strcat(Special Abilities %(, ulocal(f.get-player-stat-or-zero, %0, abilities XP), /8, %b, XP, %))

&layout.abilities [v(d.cgf)]=strcat(divider(ulocal(layout.abilities-title, %0, %1), %1), %r, multicol(ulocal(f.get-player-stat, %0, abilities), * *, 0, |, %1))

&layout.health [v(d.cgf)]=strcat(divider(Health, %1), setq(4, ulocal(layout.3health, %0, %1, 4, %2)), setq(3, ulocal(layout.3health, %0, %1, 3, %2)), setq(2, ulocal(layout.2health, %0, %1, 2, %2)), setq(1, ulocal(layout.2health, %0, %1, 1, %2)), if(t(%q4), strcat(%r, %q4)), if(t(%q3), strcat(%r, %q3)), if(t(%q2), strcat(%r, %q2)), if(t(%q1), strcat(%r, %q1)), if(not(cor(t(%q4), t(%q3), t(%q2), t(%q1))), strcat(%r, formattext(Unwounded, 0, %1))), if(t(%2), formattext(%b, 0, %1)))

&layout.3health [v(d.cgf)]=if(or(t(%3), t(setr(H, xget(%0, _health-%2)))), edit(multicol(strcat(setq(W, sub(getremainingwidth(%1), 13)), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, |, case(%2, 4, Catastrophic), |, %2, |, ulocal(layout.player-health, %0, %1, %qH, %qW), |, case(%2, 4, permanent, Need help), ||, #, repeat(@, %qW), #, |, case(%2, 4, consequences)), 1 * 13, 0, |, %1), _, %b, @, _, #, |))

&layout.player-health [v(d.cgf)]=strcat(#, center(mid(%2, 0, %3), %3, _), #)

&layout.2health [v(d.cgf)]=if(or(t(%3), t(setr(1, xget(%0, _health-%2-1))), t(setr(2, xget(%0, _health-%2-2)))), edit(multicol(strcat(setq(W, sub(div(sub(getremainingwidth(%1), 10), 2), 3)), |, _, repeat(@, %qW), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, |, #, center(__, %qW, _), #, ||, %2, |, ulocal(layout.player-health, %0, %1, %q1, %qW), |, ulocal(layout.player-health, %0, %1, %q2, %qW), |, case(%2, 2, -1d, Less effect), ||, #, repeat(@, %qW), #, |, #, repeat(@, %qW), #), 1 * * 13, 0, |, %1), _, %b, @, _, #, |))

&layout.pools [v(d.cgf)]=strcat(divider(Pools, %0), %r, multicol(strcat(Stress, |, 0/9, |, Trauma, |, 0/4, |, Healing, |, default(%0/_health-clock, 0), /4), * 5 * 5 * 5, 0, |, %1), %r, formattext(Traumas: None yet., 0, %1))

&layout.xp_triggers [v(d.cgf)]=strcat(divider(XP Triggers, %1), %r, formattext(strcat(* You, %b, ulocal(f.get-player-stat-or-default, %0, xp triggers, addressed a challenge with ______ or ______)., %r, * You roll a desperate action., %r, * You express your beliefs%, drives%, heritage%, or background., %r, * You struggled with issues from your vice or traumas during the session.), 0, %1))

&layout.crew_xp_triggers [v(d.cgf)]=strcat(divider(Crew XP Triggers, %1), %r, formattext(strcat(*, %b, ulocal(f.get-player-stat-or-default, %0, crew xp triggers, Select your crew type to show this information.), %r, * Contend with challenges above your current station., %r, * Bolster your crew's reputation or develop a new one., %r, * Express the goals%, drives%, inner conflict%, or essential nature of the crew.), 0, %1))

&layout.friends [v(d.cgf)]=strcat(divider(Friends, %1), setq(E, ulocal(f.get-player-stat, %0, rival)), setq(A, ulocal(f.get-player-stat, %0, ally)), %r, multicol(iter(ulocal(f.get-player-stat, %0, friends), strcat(itext(0), switch(itext(0), %qA, %b%cg%(Ally%), %qE, %b%cr%(Rival%))), |, |), * *, 0, |, %1))

&layout.gear [v(d.cgf)]=strcat(divider(Playbook gear, %1), %r, multicol(edit(iter(fliplist(ulocal(f.get-player-stat, %0, gear), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1), %r, ulocal(layout.other-gear, %0, %1, %2), %r, ulocal(layout.load-chart, %0, %1), if(t(%2), strcat(%r, ulocal(layout.standard-gear, %0, %1, %2))), %r, ulocal(layout.coin, %0, %1))

&layout.coin [v(d.cgf)]=strcat(divider(Coin and wealth, %1), %r, multicol(strcat(Coin:, |, ulocal(f.get-player-stat-or-zero, %0, coin), |, Stash:, |, setr(S, ulocal(f.get-player-stat-or-zero, %0, stash)), |, Lifestyle:, |, min(div(%qS, 10), 4)), * 2 * 2 * 1, 0, |, %1))

&layout.standard-gear [v(d.cgf)]=strcat(divider(Standard gear, %1), %r, multicol(edit(iter(fliplist(if(t(setr(G, ulocal(f.get-player-stat, %0, standard gear))), %qG, xget(%vD, d.standard_gear)), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1))

&layout.other-gear [v(d.cgf)]=strcat(divider(Other gear, %1), %r, setq(L, edit(iter(fliplist(ulocal(f.get-player-stat, %0, other gear), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn)), multicol(if(t(%qL), %qL, |), * *, 0, |, %1))

&layout.load-chart [v(d.cgf)]=strcat(formattext(%b, 0, %1), multicol(strcat(ulocal(f.get-player-load-list, %0), |, Your load:, |, if(t(setr(L, ulocal(f.get-player-stat, %0, load))), %qL, Unset)), 6 4 7 4 6 2 12 4 * 6, 0, |, %1))

&layout.load-desc [v(d.cgf)]=cat(ulocal(f.get-name, %0, %1), looks, switch(ulocal(f.get-player-stat, %0, load), Normal, like a scoundrel%, ready for trouble, Heavy, like an operative on a mission, Encumbered, overburdened and slow, like an ordinary%, law-abiding citizen).)

&layout.gear-item [v(d.cgf)]=switch(%0, %[*%]*, %0, cat(%[, %], %0))

&layout.projects [v(d.cgf)]=strcat(divider(Long-term projects, %1), %r, multicol(ulocal(f.get-player-projects, %0), *, 0, |, %1))

&layout.notes [v(d.cgf)]=strcat(divider(Notes, %1), %r, multicol(ulocal(f.get-player-notes, %0), *, 0, |, %1))

&layout.footer [v(d.cgf)]=strcat(Approved status and date, %,, %b, X advancements, %,, %b, Y XP)

&layout.subsection [v(d.cgf)]=strcat(ulocal(ulocal(f.get-stat-location, layout.%0), %1, %2), %r, footer(ulocal(layout.footer, %1, %2), %2))

&layout.room-emit [v(d.cgf)]=cat(alert(Game), ulocal(f.get-name, %0), %1)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew map layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Blank
&layout.crew-map.blank [v(d.cgf)]=strcat(strcat(%b, ______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, %r, |, space(6), | |, space(6), | |, space(6), | |, space(6), | |, space(6), |, %r, |, space(2), A1, space(2), | |, space(2), A2, space(2), | |, space(2), A3, space(2), | |, space(2), A4, space(2), | |, space(2), A5, space(2), |, %r, |______| |______| |______| |______| |______|), %r, strcat(%b, ______, space(3), ______, space(3), ___|__, space(3), ______, space(3), ______, %r, |, space(6), | |, space(6), | |, space(3),, space(2),  x| |, space(6), | |, space(6), |, %r, |, space(2), B1, space(2), | |, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), | |, space(2), B5, space(2), |, %r, |______| |______| |______| |______| |______|), %r, strcat(%b, ______, space(3), ______, space(3), ___|__, space(3), ______, space(3), ______, %r, |, space(6), | |, space(6), | |, space(6), | |, space(6), | |, space(6), |, %r, |, space(2), C1, space(2), | |, space(2), C2, space(2), | |, space(2), C3, space(2), | |, space(2), C4, space(2), | |, space(2), C5, space(2), |, %r, |______| |______| |______| |______| |______|, %r))

&layout.crew-map.smugglers [v(d.cgf)]=strcat(strcat(space(45), #A1: Turf%r%b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), #A2: Side Business, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #A3: Luxury Fence, %r, |, space(2), A1, space(2), |-|, space(2), A2, space(2), | |, space(2), A3, space(2), | |, space(2), A4, space(2), |-|, space(2), A5, space(2), | #A4: Vice Den, %r, |______| |______| |______| |______| |______| #A5: Tavern), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ______, space(2), #B1: Ancient Gate, %r, |, space(5), #| |, space(5), #| |, space(5), x| |, space(5), #| |, space(5), #| #B2: Turf, %r, |, space(2), B1, space(2), | |, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), |-|, space(2), B5, space(2), | #B4: Turf, %r, |______| |______| |______| |______| |______| #B5: Turf), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ______, space(2), #C1: Secret Routes, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #C2: Informants, %r, |, space(2), C1, space(2), |-|, space(2), C2, space(2), | |, space(2), C3, space(2), | |, space(2), C4, space(2), |-|, space(2), C5, space(2), | #C3: Fleet, %r, |______| |______| |______| |______| |______| #C4: Cover Operation, %r, space(45), #C5: Warehouse, %r))

&layout.crew-map.shadows [v(d.cgf)]=strcat(strcat(space(45), #A1: Interro. Chamber, %r, %b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), #A2: Turf, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #A3: Loyal Fence, %r, |, space(2), A1, space(2), |-|, space(2), A2, space(2), |-|, space(2), A3, space(2), | |, space(2), A4, space(2), |-|, space(2), A5, space(2), | #A4: Gambling Den, %r, |______| |______| |______| |______| |______| #A5: Tavern), %r, strcat(%b__|___, space(3), ______, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(2), #B1: Drug Den, %r, |, space(5), #| |, space(5), #| |, space(5), x| |, space(5), #| |, space(5), #| #B2: Informants, %r, |, space(2), B1, space(2), |-|, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), |-|, space(2), B5, space(2), | #B4: Turf, %r, |______| |______| |______| |______| |______| #B5: Lookouts), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ______, space(3), ___|__, space(2), #C1: Hagfish Farm, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #C2: Infirmary, %r, |, space(2), C1, space(2), |-|, space(2), C2, space(2), | |, space(2), C3, space(2), |-|, space(2), C4, space(2), |-|, space(2), C5, space(2), | #C3: Covert Drops, %r, |______| |______| |______| |______| |______| #C4: Turf, %r, space(45), #C5: Secret Pathways, %r))

&layout.crew-map.hawkers [v(d.cgf)]=strcat(strcat(space(45), #A1: Turf, %r, %b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), #A2: Personal Clothier, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #A3: Local Graft, %r, |, space(2), A1, space(2), |-|, space(2), A2, space(2), |-|, space(2), A3, space(2), | |, space(2), A4, space(2), |-|, space(2), A5, space(2), | #A4: Lookouts, %r, |______| |______| |______| |______| |______| #A5: Informants), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(2), #B1: Turf, %r, |, space(5), #| |, space(5), #| |, space(5), x| |, space(5), #| |, space(5), #| #B2: Turf, %r, |, space(2), B1, space(2), | |, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), |-|, space(2), B5, space(2), | #B4: Turf, %r, |______| |______| |______| |______| |______| #B5: Luxury Venue), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ______, space(2), #C1: Foreign Market, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #C2: Vice Den, %r, |, space(2), C1, space(2), |-|, space(2), C2, space(2), | |, space(2), C3, space(2), |-|, space(2), C4, space(2), |-|, space(2), C5, space(2), | #C3: Surplus Caches, %r, |______| |______| |______| |______| |______| #C4: Cover Operation, %r, , space(45), #C5: Cover Identities, %r))

&layout.crew-map.cult [v(d.cgf)]=strcat(strcat(space(45), #A1: Cloister, %r, %b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), #A2: Vice Den, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #A3: Offeratory, %r, |, space(2), A1, space(2), |-|, space(2), A2, space(2), |-|, space(2), A3, space(2), | |, space(2), A4, space(2), |-|, space(2), A5, space(2), | #A4: Ancient Obelisk, %r, |______| |______| |______| |______| |______| #A5: Ancient Tower), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ______, space(3), ___|__, space(2), #B1: Turf, %r, |, space(5), #| |, space(5), #| |, space(5), x| |, space(5), #| |, space(5), #| #B2: Turf, %r, |, space(2), B1, space(2), |-|, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), |-|, space(2), B5, space(2), | #B4: Turf, %r, |______| |______| |______| |______| |______| #B5: Turf), %r, strcat(%b______, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(2), #C1: Spirit Well, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #C2: Ancient Gate, %r, |, space(2), C1, space(2), |-|, space(2), C2, space(2), | |, space(2), C3, space(2), | |, space(2), C4, space(2), |-|, space(2), C5, space(2), | #C3: Sanctuary, %r, |______| |______| |______| |______| |______| #C4: Sacred Nexus, %r, , space(45), #C5: Ancient Altar, %r))

&layout.crew-map.assassins [v(d.cgf)]=strcat(strcat(space(45), #A1: Training Rooms, %r, %b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), #A2: Vice Den, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #A3: Fixer, %r, |, space(2), A1, space(2), |-|, space(2), A2, space(2), | |, space(2), A3, space(2), | |, space(2), A4, space(2), |-|, space(2), A5, space(2), | #A4: Informants, %r, |______| |______| |______| |______| |______| #A5: Hagfish Farm), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(2), #B1: Victim Trophies, %r, |, space(5), #| |, space(5), #| |, space(5), x| |, space(5), #| |, space(5), #| #B2: Turf, %r, |, space(2), B1, space(2), | |, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), |-|, space(2), B5, space(2), | #B4: Turf, %r, |______| |______| |______| |______| |______| #B5: Cover Operation), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ______, space(3), ___|__, space(2), #C1: Protection Racket, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #C2: Infirmary, %r, |, space(2), C1, space(2), |-|, space(2), C2, space(2), | |, space(2), C3, space(2), | |, space(2), C4, space(2), |-|, space(2), C5, space(2), | #C3: Envoy, %r, |______| |______| |______| |______| |______| #C4: Cover Identities, %r, , space(45), #C5: City Records, %r))

&layout.crew-map.bravos [v(d.cgf)]=strcat(strcat(space(45), #A1: Barracks, %r, %b______, space(3), ______, space(3), ______, space(3), ______, space(3), ______, space(2), #A2: Turf, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #A3: Terrorized Citizens, %r, |, space(2), A1, space(2), |-|, space(2), A2, space(2), |-|, space(2), A3, space(2), | |, space(2), A4, space(2), |-|, space(2), A5, space(2), | #A4: Informants, %r, |______| |______| |______| |______| |______| #A5: Protection Racket), %r, strcat(%b__|___, space(3), ______, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(2), #B1: Fighting Pits, %r, |, space(5), #| |, space(5), #| |, space(5), x| |, space(5), #| |, space(5), #| #B2: Turf, %r, |, space(2), B1, space(2), |-|, space(2), B2, space(2), |-| LAIR |-|, space(2), B4, space(2), |-|, space(2), B5, space(2), | #B4: Turf, %r, |______| |______| |______| |______| |______| #B5: Turf), %r, strcat(%b__|___, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(3), ___|__, space(2), #C1: Infirmary, %r, |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| |, space(5), #| #C2: Blue. Intimidation, %r, |, space(2), C1, space(2), |-|, space(2), C2, space(2), | |, space(2), C3, space(2), |-|, space(2), C4, space(2), |-|, space(2), C5, space(2), | #C3: Street Fence, %r, |______| |______| |______| |______| |______| #C4: Warehouses, %r, , space(45), #C5: Blue. Confederates, %r))

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

&check.scoundrel.friends [v(d.cgf)]=cand(t(ulocal(f.get-player-stat, %0, friends)), t(ulocal(f.get-player-stat, %0, ally)), t(ulocal(f.get-player-stat, %0, rival)))

&check.scoundrel.gear [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, gear))

&check.scoundrel.xp_triggers [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, xp triggers))

&check.crew.bio [v(d.cgf)]=not(ladd(iter(xget(%vD, d.crew_bio), not(hasattr(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |)))

&check.crew.abilities [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, crew abilities))
th ulocal(v(d.cgf)/f.get-player-stat, %#, crew abilities)

&check.crew.contacts [v(d.cgf)]=cand(t(ulocal(f.get-player-stat, %0, contacts)), t(ulocal(f.get-player-stat, %0, favorite)))

&check.crew.upgrades [v(d.cgf)]=eq(ulocal(f.count-upgrades, %0), 4)

&check.crew.xp_triggers [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, crew xp triggers))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CG error messages
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.pass [v(d.cgf)]=%ch%cg%[Pass%]

&layout.fail [v(d.cgf)]=%cr%[Needs work%]

&layout.test [v(d.cgf)]=cat(if(t(%0), %1, if(t(%2), %2, %1)), if(t(%0), ulocal(layout.pass), ulocal(layout.fail)))

&layout.cg-errors [v(d.cgf)]=strcat(header(Character generation instructions, %1), %r, if(ulocal(f.is_expert, %0), ulocal(layout.simple-cg-errors, %0, %1), ulocal(layout.full-cg-errors, %0, %1)), %r, footer(cg/on to join the Chargen channel and ask questions!))

&layout.simple-cg-errors [v(d.cgf)]=strcat(formattext(strcat(ulocal(layout.test, ulocal(check.simple.age, %0), +stat/set Age=<Young Adult%, Adult%, Mature%, or Elderly>), %r, ulocal(layout.test, ulocal(check.simple.look, %0), +stat/set Look=<Character's short description>), %r, ulocal(layout.test, ulocal(check.simple.desc, %0), @desc me=<Character's normal description>), %r, ulocal(layout.test, ulocal(check.simple.expert_type, %0), +stat/set Expert Type=<Character's expert type>), %r, ulocal(layout.test, ulocal(check.simple.character_type, %0), +stat/set Character Type=<Character's type>), %r, +stat/lock when you're done!), 0, %1))

&layout.crew-cg-errors [v(d.cgf)]=strcat(header(Crew creation instructions, %1), %r, formattext(strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.test, t(%qC), You have joined or created a crew., +crew/join <name> or +crew/create <name> to set your crew up.), %r, ulocal(layout.test, ulocal(check.crew.bio, %qC), Crew bio is all set up., Your crew bio is missing some information.), %r, ulocal(layout.test, ulocal(check.crew.abilities, %qC), You have one Crew Ability selected., You need to select one Crew Ability.), %r, ulocal(layout.test, ulocal(check.crew.contacts, %qC), You have Contacts and a Favorite., You need to set your Contacts and Favorite.), %r, ulocal(layout.test, ulocal(check.crew.upgrades, %qC), You have selected 4 Upgrades for your crew., You need to select 4 Upgrades for your crew.), %r, ulocal(layout.test, ulocal(check.crew.xp_triggers, %qC), You have selected your Crew XP Trigger., You must select a Crew XP Trigger.)), 0, %1), ulocal(layout.cg-commands, +crew/lock to submit to staff, %1), %r, footer(cg/on to join the Chargen channel and ask questions!, %1))

&layout.full-cg-errors [v(d.cgf)]=strcat(formattext(strcat(ulocal(layout.test, ulocal(check.scoundrel.bio, %0), You have all your bio fields set., Some of your bio fields %(not counting Crew%) are not set.), %r, ulocal(layout.test, ulocal(check.scoundrel.actions, %0), 7 action dots chosen., You need 7 action dots. You have [ulocal(f.get-total-player-actions, %0)].), %r, ulocal(layout.test, ulocal(check.scoundrel.abilities, %0), One ability selected., You need one ability. You have [ulocal(f.get-total-player-abilities, %0)].), %r, ulocal(layout.test, ulocal(check.scoundrel.friends, %0), You have friends%, an ally%, and a rival., You need friends%, an ally%, and a rival.), %r, ulocal(layout.test, ulocal(check.scoundrel.gear, %0), You have chosen your gear., You need gear!), %r, ulocal(layout.test, ulocal(check.scoundrel.xp_triggers, %0), You have chosen your XP triggers., You need to select your XP triggers.)), 0, %1), ulocal(layout.cg-commands, +stats/lock to submit to staff, %1))

&layout.cg-commands [v(d.cgf)]=strcat(divider(Commands), %r, multicol(+stat/set <stat>=<value>|+stat/set <stat>= to clear a stat|+stat/clear to start over|+sheet/all to see everything|%0, * *, 0, |, %1))

@@ TODO: If a staffer is looking at an unapproved sheet, @pemit them an extra layout which includes every "arbitrary text" field on the sheet so they can very quickly go over those for any unthematic stuff.
