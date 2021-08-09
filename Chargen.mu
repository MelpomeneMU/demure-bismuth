/*
Requirements: byzantine-opal

Commands:
	+sheet & +stats
	+set <blah>=<bleh>
	+list <stuff>
	+xp
	+xp/cost
	+xp/spend <stat>
	+xp/award
	+xp/unaward

Healing and harming:
	+harm Shanked 2
	+harm Gravely insulted
	+harm L2 Defenestrated
	+heal 1, 2, 3, or 5.

 =[ Name ] ===================================================================
 Playbook: Hound           Crew: The Rooks            Heritage: Akorosi
 Background: Military      Vice: Obligation
 =============================================================================
 Insight  (2/6 XP)     4   Prowess  (0/6 XP)     1   Resolve  (0/6 XP)     2
 Hunt                  1   Finesse               0   Attune                2
 Study                 1   Prowl                 0   Command               2
 Survey                1   Skirmish              1   Consort               0
 Tinker                1   Wreck                 0   Sway                  0
 =====================[ Special abilities (4/8 XP) ]=========================
 Leader                    Not to be trifled with    Arcane Fighter
 Battleborn                Sharpshooter
 =================================[ Health ]=================================
   3 [                                                         ] Need help
   2 [                            ][                           ] -1d
   1 [          Shanked           ][       Spiked drink        ] Less effect
 ===============================[ Pools ]=====================================
 Stress              8/9   Trauma              2/4   Healing             1/4
 Traumas: Reckless, Cold
 ============================[ XP Triggers ]==================================
 * You addressed a challenge with Guile or Hyper-positivity
 * You roll a desparate action
 * You express your beliefs, drives, heritage, or background
 * You struggled with issues from your vice or traumas during a session
 ===============================[ Approved 08/01/2021, 5 advancements, 6 XP ]=

 Insight (2/6 XP)    4
   Hunt 1, Study 1, Survey 1, Tinker 1
 Prowess (0/6 XP)    1
   Finesse 0, Prowl 0, Skirmish 1, Wreck 0
 Resolve (0/6 XP)    2
   Attune 2, Command 2, Consort 0, Sway 0


Page 2:

 ==============================[ Friends ]====================================
 Jimbob the candlestick maker                (enemy) Jasper the bravo
 Shinji the mech pilot                       Beatrice the bellmaker
 ===============================[ Armor ]=====================================
 Armor                 1   Heavy Armor           0   Special Armor         0
 ============================[ Load: Heavy ]==================================
 Fine pistols 1L                             A blade or two
 Fine long rifle 2L                          Armor
 Electroplasmic ammunition                   Disguise (Wardens)
 Ghost-hunting horse
 Spyglass 1L
 ===========================[ Long-term projects ]============================
 3/6 Get a key to the prison
 =================================[ Notes ]===================================
 Name is a blah bleh bloo
 On 08/01/2021, Name finished a 12-count long term project to: Steal 3 cannons
 ===============================[ Approved 08/01/2021, 5 advancements, 2 XP ]=

*/


@create Chargen Database <CGDB>=10
@set CGDB=SAFE

@create Chargen Functions <CGF>=10
@set CGF=SAFE INHERIT
@force me=@parent CGF=[v(d.bf)]

@create Chargen Commands <CGC>=10
@set CGC=SAFE INHERIT
@parent CGC=CGF

@force me=&d.cg me=[search(ETHING=t(member(name(##), Chargen Commands <CGC>, |)))]
@force me=&d.cgf me=[search(ETHING=t(member(name(##), Chargen Functions <CGF>, |)))]
@force me=&d.cdb me=[search(ETHING=t(member(name(##), Chargen Database <CGDB>, |)))]

@force me=&d.chargen-functions [v(d.bd)]=[v(d.cgf)]

@force me=&vD [v(d.cgf)]=[v(d.cdb)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Settings
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.bio [v(d.cdb)]=Playbook|Crew|Heritage|Background|Vice

&d.bio.playbook [v(d.cdb)]=Hound|etc

&d.attributes [v(d.cdb)]=Insight|Prowess|Resolve

&d.actions.insight [v(d.cdb)]=Hunt|Study|Survey|Tinker

&d.actions.prowess [v(d.cdb)]=Finesse|Prowl|Skirmish|Wreck

&d.actions.resolve [v(d.cdb)]=Attune|Command|Consort|Sway

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - target
@@ %1 - viewer
&layout.sheet [v(d.cgf)]=strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.actions, %0, %1), %r, ulocal(layout.abilities, %0, %1), %r, ulocal(layout.health, %0, %1), %r, ulocal(layout.pools, %0, %1), %r, ulocal(layout.xp_triggers, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&layout.name [v(d.cgf)]=strcat(ulocal(f.get-name, %0, %1), if(isstaff(%1), strcat(%b, %(, %0, %))))

&layout.bio [v(d.cgf)]=multicol(ulocal(layout.player-bio, %0, %1), 33p 34p 33p, 0, |, %1)

&layout.player-bio [v(d.cgf)]=iter(xget(%vD, d.bio), strcat(itext(0), :, %b, default(strcat(%0, /, _bio., itext(0)), Not set)), |, |)

&layout.actions [v(d.cgf)]=strcat(divider(Actions, %0), %r, multicol(ulocal(layout.player-actions, %0), * 1 * 1 * 1, 1, |, %1))

&layout.player-actions [v(d.cgf)]=iter(strcat(xget(%vD, d.attributes), |, fliplist(strcat(xget(%vD, d.actions.insight), |, xget(%vD, d.actions.prowess), |, xget(%vD, d.actions.resolve)), 3, |)), strcat(itext(0), if(lte(inum(0), 3), strcat(space(3), %(, 0, /, 6, %b, XP, %))), |, default(%0/_action.[itext(0)], 0)), |, |)

&layout.abilities-title [v(d.cgf)]=strcat(Special Abilities %(, default(%0/_abilities-xp, 0), /8, %b, XP, %))

&layout.abilities [v(d.cgf)]=strcat(divider(ulocal(layout.abilities-title, %0, %1), %1), %r, multicol(, 33p 34p 33p, 0, |, %1))

&layout.health [v(d.cgf)]=strcat(divider(Health, %1), setq(3, ulocal(layout.3health, %0, %1, %2)), setq(2, ulocal(layout.2health, %0, %1, 2, %2)), setq(1, ulocal(layout.2health, %0, %1, 1, %2)), if(t(%q3), strcat(%r, %q3)), if(t(%q2), strcat(%r, %q2)), if(t(%q1), strcat(%r, %q1)), if(not(cor(t(%q3), t(%q2), t(%q1))), strcat(%r, formattext(Unwounded, 0, %1))))

&layout.3health [v(d.cgf)]=if(or(t(%2), t(setr(H, xget(%0, _health-3)))), edit(multicol(strcat(setq(W, sub(getremainingwidth(%1), 13)), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, ||, 3, |, ulocal(layout.player-health, %0, %1, %qH, %qW), |, Need help, ||, #, repeat(@, %qW), #), 1 * 13, 0, |, %1), _, %b, @, _, #, |))

&layout.player-health [v(d.cgf)]=strcat(#, center(mid(%2, 0, %3), %3, _), #)

&layout.2health [v(d.cgf)]=if(or(t(%3), t(setr(1, xget(%0, _health-%2-1))), t(setr(2, xget(%0, _health-%2-2)))), edit(multicol(strcat(setq(W, sub(div(sub(getremainingwidth(%1), 10), 2), 3)), |, _, repeat(@, %qW), |, _, repeat(@, %qW), |||, #, center(__, %qW, _), #, |, #, center(__, %qW, _), #, ||, %2, |, ulocal(layout.player-health, %0, %1, %q1, %qW), |, ulocal(layout.player-health, %0, %1, %q2, %qW), |, case(%2, 2, -1d, Less effect), ||, #, repeat(@, %qW), #, |, #, repeat(@, %qW), #), 1 * * 13, 0, |, %1), _, %b, @, _, #, |))


&layout.pools [v(d.cgf)]=strcat(divider(Pools, %0), %r, multicol(strcat(Stress, |, 0/9, |, Trauma, |, 0/4, |, Healing, |, default(%0/_health-clock, 0), /4), * 5 * 5 * 5, 0, |, %1), %r, formattext(Traumas: None yet., 0, %1))

&layout.xp_triggers [v(d.cgf)]=strcat(divider(XP Triggers, %1), %r, formattext(strcat(* You addressed a challenge with ______ or ______., %r, * You roll a desperate action., %r, * You express your beliefs%, drives%, heritage%, or background., %r, * You struggled with issues from your vice or traumas during the session.), 0, %1))

&layout.footer [v(d.cgf)]=strcat(Approved status and date, %,, %b, X advancements, %,, %b, Y XP)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Non-sheet layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.harm [v(d.cgf)]=cat(alert(Health), ulocal(f.get-name, %0), inflicted a level, %1, harm on, obj(%0)self, called, %2.)

&layout.heal [v(d.cgf)]=squish(cat(alert(Health), ulocal(f.get-name, %0), adds %1 ticks to, poss(%0), healing clock%,, if(t(%2), cat(removing, itemize(%2, |)%,)), if(%3, but, and), subj(%0), switch(subj(%0), they, are, is), if(%3, still injured, fully healed).))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Functions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&f.get-harm-field [v(d.cgf)]=case(%1, 3, if(hasattr(%0, _health-3), #-1 DEAD CHARACTER, _health-3), case(strcat(hasattr(%0, _health-%1-1), hasattr(%0, _health-%1-2)), 00, _health-%1-1, 10, _health-%1-2, ulocal(f.get-harm-field, %0, add(%1, 1))))

&f.get-highest-health-level [v(d.cgf)]=trim(iter(3 2-2 2-1 1-2 1-1, if(hasattr(%0, _health-[itext(0)]), strcat(_health-, itext(0)))))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&tr.error [v(d.cg)]=@pemit %0=cat(alert(Error), %1);

&tr.message [v(d.cg)]=@pemit %0=cat(alert(Alert), %1);

&tr.success [v(d.cg)]=@pemit %0=cat(alert(Success), %1);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+sheet [v(d.cg)]=$+sheet:@pemit %#=ulocal(layout.sheet, %#, %#)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Health
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+health [v(d.cg)]=$+health:@pemit %#=strcat(ulocal(layout.health, %#, %#, 1), %r, footer(, %#))

&c.+harm [v(d.cg)]=$+harm *:@eval strcat(setq(L, edit(first(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, edit(last(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, 1), setq(D, %0)), setq(D, revwords(rest(revwords(%0)))))), setq(D, rest(%0)))); @assert t(match(1 2 3, %qL))={ @trigger me/tr.error=%#, You can only suffer a level 1%, 2%, or 3 harm.; };  @assert t(%qD)={ @trigger me/tr.error=%#, You must enter a description of the harm.; }; @assert t(setr(F, ulocal(f.get-harm-field, %#, %qL)))={ @trigger me/tr.error=%#, Your character is out of the scene and cannot be further harmed.; }; @set %#=%qF:%qD; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.harm, %#, %qL, %qD), %#;

&c.+heal [v(d.cg)]=$+heal*:@break match(%0, th); @eval setq(L, if(t(%0), trim(%0), 1)); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, You must enter either 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, ulocal(f.get-highest-health-level, %#)))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot heal.; }; @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), 4)]; @eval setq(H, iter(extract(%qF, 1, div(%qT, 4)), xget(%#, itext(0)),, |)); @set %#=if(gte(div(%qT, 4), 1), first(%qF)):; @set %#=if(gte(div(%qT, 4), 2), first(rest(%qF))):; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, %qH, t(ulocal(f.get-highest-health-level, %#))), %#;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Chargen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+set [v(d.cg)]=$+set: ; @trigger me/tr.success=%#, ;



@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Wrap-up
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@


@tel [v(d.cdb)]=[v(d.cgf)]
@tel [v(d.cgf)]=[v(d.cg)]
@tel [v(d.cg)]=#2
