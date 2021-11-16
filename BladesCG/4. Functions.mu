@@ %0 - screen
@@ %1 - target

&f.get-abilities [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.abilities), setq(S, strcat(%qS, |, xget(%vD, itext(0)))))), squish(trim(%qS, b, |), |))

&f.get-addable-stats [v(d.cgf)]=xget(%vD, d.addable-stats)

&f.get-choice-list [v(d.cgf)]=if(t(%0), remove(ulocal(f.list-valid-values, %0, %1), any unrestricted text, |), ulocal(f.get-choices, %1))

&f.get-choices [v(d.cgf)]=strcat(squish(trim(iter(ulocal(f.get-player-bio-fields, %0), if(hasattr(%vD, strcat(d.value., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |), |, xget(%vD, d.choose-sections))

&f.get-choosable-stats [v(d.cgf)]=xget(%vD, d.choosable-stats)

&f.get-field-note [v(d.cgf)]=itemize(default(strcat(%vD, /, d.value., ulocal(f.get-stat-location, %0)), switch(%0, Name, Your full IC name, Alias, Your street alias, Look, Your short-desc, No limits)), |, or)

&f.get-layout-bio-stats [v(d.cgf)]=strcat(setq(L, ulocal(f.get-player-bio-fields, %0)), null(iter(xget(%vD, d.manual-bio-stats), setq(L, remove(%qL, itext(0), |)), |)), %qL)

&f.get-player-action [v(d.cgf)]=default(strcat(%0, /, ulocal(f.get-stat-location-on-player, %1)), 0)

&f.get-player-attribute [v(d.cgf)]=ladd(iter(xget(%vD, d.actions.%1), t(xget(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |))

&f.get-player-bio-fields [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(E, xget(%0, ulocal(f.get-stat-location-on-player, Expert Type))), if(t(%qE), xget(%vD, d.expert_bio), strcat(setq(F, xget(%vD, d.bio)), setq(F, strcat(%qF, |, xget(%vD, d.bio.%qP))), setq(F, setdiff(%qF, xget(%vD, d.bio.%qP.exclude), |, |)), squish(trim(%qF, b, |), |))))

&f.get-player-abilities [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(F, default(%vD/d.abilities.[edit(%qP, %b, _)], ulocal(f.get-abilities))), squish(trim(%qF, b, |), |))

&f.get-player-notes [v(d.cgf)]=iter(lattr(%0/_note.*), itext(0),, |)

&f.get-player-projects [v(d.cgf)]=iter(lattr(%0/_project.*), itext(0),, |)

&f.is_expert [v(d.cgf)]=t(ulocal(f.get-player-stat, expert type))

&f.get-playbook-default [v(d.cgf)]=if(cand(t(%0), switch(%1, XP Triggers, 1, Friends, 1, Gear, 1, 0)), xget(%vD, strcat(d., ulocal(f.get-stat-location, %1), ., %0)))

&f.get-player-stat [v(d.cgf)]=switch(%1, Crew, xget(ulocal(f.get-player-stat, %0, crew object), ulocal(f.get-stat-location-on-player, crew name)), strcat(setq(0, xget(%0, ulocal(f.get-stat-location-on-player, %1))), if(t(%q0), %q0, ulocal(f.get-playbook-default, xget(%0, ulocal(f.get-stat-location-on-player, Playbook)), %1))))

&f.get-player-stat-or-zero [v(d.cgf)]=ulocal(f.get-player-stat-or-default, %0, %1, 0)

@@ We do it this way because it should all come down to one place for getting the player stat, f.get-player-stat, and default() doesn't allow that.
&f.get-player-stat-or-default [v(d.cgf)]=if(t(setr(0, ulocal(f.get-player-stat, %0, %1))), %q0, %2)

&f.get-random-name-and-job [v(d.cgf)]=strcat(pickrand(xget(%vD, d.random.name), |), %,%b, art(setr(J, pickrand(xget(%vD, d.random.job), |))), %b, %qJ)

&f.get-section-playbooks [v(d.cgf)]=squish(trim(iter(ulocal(f.list-valid-values, Playbook, %1), if(hasattr(%vD, strcat(d., ulocal(f.get-stat-location, %0), ., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |)

&f.get-stat-location [v(d.cgf)]=edit(%0, %b, _)

&f.get-stat-location-on-player [v(d.cgf)]=switch(%0, Look, short-desc, Name, d.ic_full_name, Alias, d.street_alias, Special Ability, _stat.abilities, edit(%0, %b, _, ^, _stat.))

&f.get-stats [v(d.cgf)]=strcat(setq(S, xget(%vD, d.actions)|Load), squish(trim(strcat(%qS, |, setdiff(ulocal(f.get-player-bio-fields, %0), Crew, |, |), |, setdiff(xget(%vD, d.expert_bio), Crew, |, |), |, if(t(ulocal(f.get-player-stat, %0, crew object)), ulocal(f.get-crew-stats))), b, |), |))

&f.get-crew-stats [v(d.cgf)]=xget(%vD, d.crew_bio)

&f.has-crew-stats [v(d.cgf)]=strcat(setq(0, iter(ulocal(f.get-crew-stats)|crew*|cohort*|contacts|upgrades, ulocal(f.get-stat-location-on-player, itext(0)), |)), setq(0, iter(%q0, if(t(member(itext(0), *)), lattr(strcat(%0, /, itext(0))), itext(0)))), setq(0, setdiff(%q0, ulocal(f.get-stat-location-on-player, Crew Name))), t(ladd(iter(%q0, hasattr(%0, itext(0))))))

&f.get-crew-members [v(d.cgf)]=if(t(%0), search(EPLAYER=t(member(ulocal(f.get-player-stat, ##, crew object), %0))))

&f.get-total-player-abilities [v(d.cgf)]=words(ulocal(f.get-player-stat, %0, abilities), |)

&f.get-total-player-actions [v(d.cgf)]=ladd(iter(ulocal(f.list-actions), if(not(member(%1, itext(0))), ulocal(f.get-player-action, %0, itext(0))), |))

&f.get-valid-value [v(d.cgf)]=if(t(setr(S, ulocal(f.list-values, %0, %2))), finditem(%qS, %1, |), %1)

&f.is-action [v(d.cgf)]=finditem(ulocal(f.list-actions), %0, |)

&f.is-attribute [v(d.cgf)]=finditem(xget(%vD, d.attributes), %0, |)

&f.list-actions [v(d.cgf)]=xget(%vD, d.actions)

&f.list-restricted-values [v(d.cgf)]=xget(%vD, if(ulocal(f.is-action, %0), d.restricted.action, ulocal(f.get-stat-location, d.restricted.%0)))

&f.list-sheet-sections [v(d.cgf)]=xget(%vD, d.sheet-sections)

&f.list-valid-values [v(d.cgf)]=strcat(setq(R, ulocal(f.list-values, %0, %1)), null(iter(ulocal(f.list-restricted-values, %0), setq(R, remove(%qR, itext(0), |)), |)), if(member(%qR, *, |), strcat(setq(R, remove(%qR, *, |)), setq(R, strcat(%qR, |, any unrestricted text)))), %qR)

&f.list-values [v(d.cgf)]=case(1, t(ulocal(f.is-action, %0)), xget(%vD, d.value.action), t(member(Friends|XP Triggers|Gear, %0, |)), ulocal(f.get-section-playbooks, %0, %1), t(member(Ally, %0, |)), remove(ulocal(f.get-player-stat, %1, friends), ulocal(f.get-player-stat, %1, rival), |), t(member(Rival, %0, |)), remove(ulocal(f.get-player-stat, %1, friends), ulocal(f.get-player-stat, %1, ally), |), t(member(Special Ability|Special Abilities, %0, |)), ulocal(f.get-abilities), xget(%vD, ulocal(f.get-stat-location, d.value.%0)))
