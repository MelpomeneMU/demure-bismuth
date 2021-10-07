@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - target
@@ %1 - viewer
&layout.page1 [v(d.cgf)]=if(hasattr(%0, _stat.expert_type), ulocal(layout.simple, %0, %1), strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.actions, %0, %1), %r, ulocal(layout.abilities, %0, %1), %r, ulocal(layout.health, %0, %1), %r, ulocal(layout.pools, %0, %1), %r, ulocal(layout.xp_triggers, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1)))

&layout.page2 [v(d.cgf)]=if(hasattr(%0, _stat.expert_type), ulocal(layout.simple, %0, %1), strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.friends, %0, %1), %r, ulocal(layout.gear, %0, %1), %r, ulocal(layout.projects, %0, %1), %r, ulocal(layout.notes, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1)))

&layout.simple [v(d.cgf)]=strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.simple-bio, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&layout.simple-bio [v(d.cgf)]=multicol(strcat(Name, |, ulocal(f.get-player-stat, %0, name), |, Crew, |, ulocal(f.get-player-stat, %0, crew), |, Expert Type, |, ulocal(f.get-player-stat, %0, expert type), |, Character Type, |, ulocal(f.get-player-stat, %0, character type), |, Look, |, ulocal(f.get-player-stat, %0, look)), 20 *, 0, |, %1)
+sheet

&layout.pass [v(d.cgf)]=%ch%cg%[Pass%]

&layout.fail [v(d.cgf)]=%cr%[Needs work%]

&layout.test [v(d.cgf)]=strcat(%b, if(t(%0), ulocal(layout.pass), ulocal(layout.fail)))


@@ Tests:
/*
Need 7 points of abilities. (Not restricted by playbook, should it be?)
Need all the bio fields.
Need a crew sheet.
Need 5 friends
Need gear
Need 

*/

&layout.cg-errors [v(d.cgf)]=strcat(header(Character generation instructions, %1), %r, if(hasattr(%0, _stat.expert_type), ulocal(layout.simple-cg-errors, %0, %1), ulocal(layout.full-cg-errors, %0, %1)), %r, footer(cg/on to join the Chargen channel and ask questions!))

&layout.simple-cg-errors [v(d.cgf)]=strcat(formattext(strcat(+stat/set Look=<Character's short description>, ulocal(layout.test, ulocal(check.simple.look, %0)), %r, @desc me=<Character's normal description>, ulocal(layout.test, ulocal(check.simple.desc, %0)), %r, +stat/set Expert Type=<Character's expert type>, ulocal(layout.test, ulocal(check.simple.expert_type, %0)), %r, +stat/set Character Type=<Character's type>, ulocal(layout.test, ulocal(check.simple.character_type, %0)), %r, +stat/lock when you're done!), 0, %1))

&check.simple.look [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, look))
&check.simple.desc [v(d.cgf)]=hasattr(%0, desc)
&check.simple.expert_type [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, expert type))
&check.simple.character_type [v(d.cgf)]=t(ulocal(f.get-player-stat, %0, character type))

&layout.full-cg-errors [v(d.cgf)]=strcat(formattext(strcat(- You get 7 action dots. You have, %b, setr(A, ulocal(f.get-total-player-actions, %0))., ulocal(layout.test, eq(%qA, 7)), %r, - You get one special ability. You have%b, setr(A, ulocal(f.get-total-player-abilities, %0))., ulocal(layout.test, eq(%qA, 1)), %r, - Fill out all the bio fields. You have%b, setr(A, ulocal(f.get-remaining-bio-fields, %0)) remaining., ulocal(layout.test, eq(%qA, 0)), %r, setq(A, words(ulocal(f.get-player-stat, %0, friends), |)), if(eq(%qA, 0), - You have no friends. You need 5., - Choose 5 friends.), ulocal(layout.test, eq(%qA, 5)), %r, setq(A, words(ulocal(f.get-player-stat, %0, gear), |)), if(eq(%qA, 0), - You need gear., - Choose your gear.), ulocal(layout.test, gt(%qA, 0))), 0, %1), %r, divider(Commands), %r, multicol(+stat/set <stat>=<value>|+stat/add <stat>|+stat/remove <stat>|+stat/choose <stat>=<value>, * *, 0, |, %1))

&layout.name [v(d.cgf)]=strcat(ulocal(f.get-name, %0, %1), if(isstaff(%1), strcat(%b, %(, %0, %))))

&layout.crew_name [v(d.cgf)]=header(if(t(%0), strcat(name(%0), if(isstaff(%1), strcat(%b, %(, %0, %)))), No crew selected), %1)

&layout.crew_bio [v(d.cgf)]=strcat(multicol(iter(remove(xget(%vD, d.crew_bio), Lair, |), strcat(itext(0), :, %b, default(strcat(%0, /, ulocal(f.get-stat-location-on-player, itext(0))), Not set)), |, |), * * *, 0, |, %1), %r, formattext(cat(Lair:, ulocal(f.get-player-stat, %0, lair))))

&layout.crew [v(d.cgf)]=strcat(setq(C, ulocal(f.get-player-stat, %0, crew object)), ulocal(layout.crew_name, %qC, %1), %r, ulocal(layout.crew_bio, %qC, %1))
+sheet/crew

&layout.bio [v(d.cgf)]=strcat(multicol(ulocal(layout.player-bio, %0, %1), * * *, 0, |, %1), %r, formattext(cat(Look:, shortdesc(%0, %1))))

&layout.player-bio [v(d.cgf)]=iter(ulocal(f.get-layout-bio-stats, %0), strcat(itext(0), :, %b, default(strcat(%0, /, ulocal(f.get-stat-location-on-player, itext(0))), Not set)), |, |)

&layout.actions [v(d.cgf)]=strcat(divider(Actions, %0), %r, multicol(ulocal(layout.player-actions, %0), * 1 * 1 * 1, 1, |, %1))

&layout.player-actions [v(d.cgf)]=iter(strcat(xget(%vD, d.attributes), |, fliplist(strcat(xget(%vD, d.actions.insight), |, xget(%vD, d.actions.prowess), |, xget(%vD, d.actions.resolve)), 3, |)), strcat(itext(0), if(lte(inum(0), 3), strcat(space(3), %(, 0, /, 6, %b, XP, %), |, ulocal(f.get-player-attribute, %0, itext(0))), strcat(|, ulocal(f.get-player-action, %0, itext(0))))), |, |)

&layout.abilities-title [v(d.cgf)]=strcat(Special Abilities %(, default(%0/_abilities-xp, 0), /8, %b, XP, %))

&layout.abilities [v(d.cgf)]=strcat(divider(ulocal(layout.abilities-title, %0, %1), %1), %r, multicol(ulocal(f.get-player-stat, %0, abilities), * *, 0, |, %1))

&layout.health [v(d.cgf)]=strcat(divider(Health, %1), setq(3, ulocal(layout.3health, %0, %1, %2)), setq(2, ulocal(layout.2health, %0, %1, 2, %2)), setq(1, ulocal(layout.2health, %0, %1, 1, %2)), if(t(%q3), strcat(%r, %q3)), if(t(%q2), strcat(%r, %q2)), if(t(%q1), strcat(%r, %q1)), if(not(cor(t(%q3), t(%q2), t(%q1))), strcat(%r, formattext(Unwounded, 0, %1))), if(t(%2), formattext(%b, 0, %1)))

&layout.3health [v(d.cgf)]=if(or(t(%2), t(setr(H, xget(%0, _health-3)))), edit(multicol(strcat(setq(W, sub(getremainingwidth(%1), 13)), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, ||, 3, |, ulocal(layout.player-health, %0, %1, %qH, %qW), |, Need help, ||, #, repeat(@, %qW), #), 1 * 13, 0, |, %1), _, %b, @, _, #, |))

&layout.player-health [v(d.cgf)]=strcat(#, center(mid(%2, 0, %3), %3, _), #)

&layout.2health [v(d.cgf)]=if(or(t(%3), t(setr(1, xget(%0, _health-%2-1))), t(setr(2, xget(%0, _health-%2-2)))), edit(multicol(strcat(setq(W, sub(div(sub(getremainingwidth(%1), 10), 2), 3)), |, _, repeat(@, %qW), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, |, #, center(__, %qW, _), #, ||, %2, |, ulocal(layout.player-health, %0, %1, %q1, %qW), |, ulocal(layout.player-health, %0, %1, %q2, %qW), |, case(%2, 2, -1d, Less effect), ||, #, repeat(@, %qW), #, |, #, repeat(@, %qW), #), 1 * * 13, 0, |, %1), _, %b, @, _, #, |))


&layout.pools [v(d.cgf)]=strcat(divider(Pools, %0), %r, multicol(strcat(Stress, |, 0/9, |, Trauma, |, 0/4, |, Healing, |, default(%0/_health-clock, 0), /4), * 5 * 5 * 5, 0, |, %1), %r, formattext(Traumas: None yet., 0, %1))

&layout.xp_triggers [v(d.cgf)]=strcat(divider(XP Triggers, %1), %r, formattext(strcat(* You, %b, default(%0/_stat.xp_triggers, addressed a challenge with ______ or ______)., %r, * You roll a desperate action., %r, * You express your beliefs%, drives%, heritage%, or background., %r, * You struggled with issues from your vice or traumas during the session.), 0, %1))

&layout.friends [v(d.cgf)]=strcat(divider(Friends, %1), setq(E, ulocal(f.get-player-stat, %0, rival)), setq(A, ulocal(f.get-player-stat, %0, ally)), %r, multicol(iter(ulocal(f.get-player-stat, %0, friends), strcat(case(1, t(member(%qA, itext(0), |)), %ch%cg%(Ally%)%cn%b, t(member(%qE, itext(0), |)), %cr%(Rival%)%cn%b,), itext(0)), |, |), * *, 0, |, %1))

&layout.gear [v(d.cgf)]=strcat(divider(Playbook gear, %1), %r, multicol(edit(iter(fliplist(ulocal(f.get-player-stat, %0, gear), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1), %r, ulocal(layout.other-gear, %0, %1, %2), %r, ulocal(layout.load-chart, %0, %1), if(t(%2), strcat(%r, ulocal(layout.standard-gear, %0, %1, %2))), %r, ulocal(layout.coin, %0, %1))

&layout.coin [v(d.cgf)]=strcat(divider(Coin and wealth, %1), %r, multicol(strcat(Coin:, |, ulocal(f.get-player-stat-or-zero, %0, coin), |, Stash:, |, setr(S, ulocal(f.get-player-stat-or-zero, %0, stash)), |, Lifestyle:, |, min(div(%qS, 10), 4)), * 2 * 2 * 1, 0, |, %1))

&layout.standard-gear [v(d.cgf)]=strcat(divider(Standard gear, %1), %r, multicol(edit(iter(fliplist(if(t(setr(G, ulocal(f.get-player-stat, %0, standard gear))), %qG, xget(%vD, d.standard_gear)), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1))

&layout.other-gear [v(d.cgf)]=strcat(divider(Other gear, %1), %r, setq(L, edit(iter(fliplist(ulocal(f.get-player-stat, %0, other gear), 2, |), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn)), multicol(if(t(%qL), %qL, |), * *, 0, |, %1))

&layout.load-chart [v(d.cgf)]=strcat(formattext(%b, 0, %1), multicol(strcat(ulocal(f.get-player-load-list, %0), |, Your load:, |, ulocal(f.get-player-stat, %0, load)), 6 4 7 4 6 2 12 4 * 6, 0, |, %1))

&layout.load-desc [v(d.cgf)]=cat(ulocal(f.get-name, %0, %1), looks, switch(ulocal(f.get-player-stat, %0, load), Normal, like a scoundrel%, ready for trouble, Heavy, like an operative on a mission, Encumbered, overburdened and slow, like an ordinary%, law-abiding citizen).)

&layout.gear-item [v(d.cgf)]=switch(%0, %[*%]*, %0, cat(%[, %], %0))

&layout.projects [v(d.cgf)]=strcat(divider(Long-term projects, %1), %r, multicol(ulocal(f.get-player-projects, %0), *, 0, |, %1))

&layout.notes [v(d.cgf)]=strcat(divider(Notes, %1), %r, multicol(ulocal(f.get-player-notes, %0), *, 0, |, %1))

&layout.footer [v(d.cgf)]=strcat(Approved status and date, %,, %b, X advancements, %,, %b, Y XP)

&layout.subsection [v(d.cgf)]=strcat(ulocal(ulocal(f.get-stat-location, layout.%0), %1, %2, %3), %r, footer(ulocal(layout.footer, %1, %2), %2))

&layout.room-emit [v(d.cgf)]=cat(alert(Game), ulocal(f.get-name, %0), %1)

@@ %0 - screen
@@ %1 - target
@@ %2 - viewer
&layout.choose [v(d.cgf)]=strcat(header(cat(Choose your, if(t(%0), %0, CG section)), %2), %r, setq(M, ulocal(layout.choose_list, ulocal(f.get-choice-list, %0, %1))), setq(N, words(%qM, |)), setq(N, add(div(%qN, 10), t(mod(%qN, 10)))), setq(R, ulocal(f.list-restricted-values, %0, %1)), setq(T, xget(%vD, ulocal(f.get-stat-location, d.choose.note.%0))), setq(A, xget(%vD, ulocal(f.get-stat-location, d.choose.afterword.%0))), formattext(%qT%b, t(%qT), %2), edit(multicol(if(gt(%qN, 1), fliplist(%qM, %qN, |), %qM), repeat(*%b, %qN), 0, |, %2), _, %b), %r, formattext(If you're stuck for choices%, choose "Random" to have the chooser pick one for you., 1, %2), , if(t(%qR), formattext(strcat(indent(), The following are restricted and are not currently available:%b, itemize(%qR, |), ., %r), 0, %1)), if(t(%qA), formattext(%qA%b, 1, %2)), %r, footer(+stat/choose <#> to choose, %2))

&layout.choose_list [v(d.cgf)]=strcat(setq(N, 0), iter(%0, strcat(___, setr(N, inum(0)).%b, itext(0)), |, |), |, ___, inc(%qN). Random)

