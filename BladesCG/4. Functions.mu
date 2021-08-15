
@@ %0 - screen
@@ %1 - target
&f.get-choice-list [v(d.cgf)]=if(t(%0), remove(ulocal(f.list-valid-values, %0, %1), any unrestricted text, |), ulocal(f.get-choices, %1))

&f.get-choices [v(d.cgf)]=strcat(squish(trim(iter(ulocal(f.get-player-bio-fields, %0), if(hasattr(%vD, strcat(d.value., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |), |, xget(%vD, d.choose-sections))

&f.get-remaining-bio-fields [v(d.cgf)]=ladd(iter(ulocal(f.get-player-bio-fields, %0), not(hasattr(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |))

&f.get-player-bio-fields [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(F, xget(%vD, d.bio)), setq(F, strcat(%qF, |, xget(%vD, d.bio.%qP))), null(iter(xget(%vD, d.bio.%qP.exclude), setq(F, remove(%qF, itext(0), |, |)), |, |)), squish(trim(%qF, b, |), |))

&f.get-player-action [v(d.cgf)]=default(strcat(%0, /, ulocal(f.get-stat-location-on-player, %1)), 0)

&f.get-player-attribute [v(d.cgf)]=ladd(iter(xget(%vD, d.actions.%1), t(xget(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |))

&f.get-player-stat-or-zero [v(d.cgf)]=default(strcat(%0, /, ulocal(f.get-stat-location-on-player, %1)), 0)

&f.get-player-stat [v(d.cgf)]=xget(%0, ulocal(f.get-stat-location-on-player, %1))

&f.get-player-notes [v(d.cgf)]=iter(lattr(%0/_note.*), itext(0),, |)

&f.get-player-projects [v(d.cgf)]=iter(lattr(%0/_project.*), itext(0),, |)

&f.get-stats [v(d.cgf)]=strcat(setq(S, xget(%vD, d.actions)|Load), squish(trim(strcat(%qS, |, ulocal(f.get-player-bio-fields, %0)), b, |), |))

&f.get-choosable-stats [v(d.cgf)]=xget(%vD, d.choosable-stats)

&f.get-abilities [v(d.cgf)]=strcat(setq(S,), null(iter(xget(%vD, d.abilities), setq(S, setunion(%qS, xget(%vD, itext(0)), |)))), %qS)

&f.get-harm-field [v(d.cgf)]=case(%1, 3, if(hasattr(%0, _health-3), #-1 DEAD CHARACTER, _health-3), case(strcat(hasattr(%0, _health-%1-1), hasattr(%0, _health-%1-2)), 00, _health-%1-1, 10, _health-%1-2, ulocal(f.get-harm-field, %0, add(%1, 1))))

&f.get-highest-health-level [v(d.cgf)]=trim(iter(3 2-2 2-1 1-2 1-1, if(hasattr(%0, _health-[itext(0)]), strcat(_health-, itext(0)))))

&f.list-actions [v(d.cgf)]=xget(%vD, d.actions)

&f.is-action [v(d.cgf)]=finditem(ulocal(f.list-actions), %0, |)

&f.get-random-name-and-job [v(d.cgf)]=strcat(pickrand(xget(%vD, d.random.name), |), %,%b, art(setr(J, pickrand(xget(%vD, d.random.job), |))), %b, %qJ)

&f.get-section-playbooks [v(d.cgf)]=squish(trim(iter(ulocal(f.list-valid-values, Playbook, %1), if(hasattr(%vD, strcat(d., ulocal(f.get-stat-location, %0), ., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |)

&f.list-values [v(d.cgf)]=case(1, ulocal(f.is-action, %0), xget(%vD, d.value.action), t(member(Friends|XP Triggers, %0, |)), ulocal(f.get-section-playbooks, %0, %1), t(member(Rival|Ally, %0, |)), xget(%1, _stat.friends), xget(%vD, ulocal(f.get-stat-location, d.value.%0)))

&f.list-restricted-values [v(d.cgf)]=xget(%vD, if(ulocal(f.is-action, %0), d.restricted.action, ulocal(f.get-stat-location, d.restricted.%0)))

&f.list-valid-values [v(d.cgf)]=strcat(setq(R, ulocal(f.list-values, %0, %1)), null(iter(ulocal(f.list-restricted-values, %0), setq(R, remove(%qR, itext(0), |)), |)), if(member(%qR, *, |), strcat(setq(R, remove(%qR, *, |)), setq(R, strcat(%qR, |, any unrestricted text)))), %qR)

&f.get-valid-value [v(d.cgf)]=if(t(setr(S, ulocal(f.list-values, %0, %2))), finditem(%qS, %1, |), %1)

&f.get-stat-location-on-player [v(d.cgf)]=switch(%0, Look, short-desc, Name, d.ic_full_name, Alias, d.street_alias, edit(%0, %b, _, ^, _stat.))

&f.get-stat-location [v(d.cgf)]=edit(%0, %b, _)

&f.get-total-player-actions [v(d.cgf)]=ladd(iter(ulocal(f.list-actions), if(not(member(%1, itext(0))), ulocal(f.get-player-action, %0, itext(0))), |))

&f.get-total-player-abilities [v(d.cgf)]=words(ulocal(f.get-player-stat, %0, abilities), |)

&f.list-sheet-sections [v(d.cgf)]=xget(%vD, d.sheet-sections)
