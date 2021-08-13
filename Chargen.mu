/*
Requirements: byzantine-opal

Commands:
	+sheet

Chargen:
	+stat/choose - get a list of choices.
	+stat/choose <# or text> - pick a choice from the list

	+stat/set <stat>=<value>
	+stat/add <special ability>
	+stat/remove <special ability>

	+stat/random <stat> - will choose a random value for <stat> for you.

	+stat/clear - clear your stats. Will ask if you're sure first.

Staff commands:
	+stat/set <player>/<stat>=<value>
	+stat/add <player>/<special ability>
	+stat/remove <player>/<special ability>
	+stat/choose <player>/<section>
	+stat/choose <#>
	+stat/choose random

XP:
	+xp
	+xp/buy <stat>
	+xp/unwind <player>/<action>
	+xp/award <player>/<attribute or playbook>=<amount>
	+xp/unaward <player>/<attribute or playbook>=<amount>

Healing and harming:
	+harm Shanked 2
	+harm Gravely insulted
	+harm L2 Defenestrated
	+heal 1, 2, 3, or 5 - tick your healing clock based on your healer's rolls. When the clock reaches 4, you heal a level of harm.

Pools:
	+take 1 stress
	+take stress|drain|gloom
	+take trauma=<which>
	+vice???

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

Page 2:

 ==============================[ Friends ]====================================
 Jimbob the candlestick maker                (rival) Jasper the bravo
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
@force me=&d.cgdb me=[search(ETHING=t(member(name(##), Chargen Database <CGDB>, |)))]

@force me=&d.chargen-functions [v(d.bd)]=[v(d.cgf)]

@force me=&vD [v(d.cgf)]=[v(d.cgdb)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Settings
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.log-staff-statting-to-channel [v(d.cgdb)]=Monitor

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Data for chargen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.sheet-sections [v(d.cgdb)]=Page1|Page2|Bio|Actions|Abilities|Health|Pools|XP Triggers|Friends|Gear|Projects|Notes

&d.bio [v(d.cgdb)]=Name|Alias|Playbook|Crew|Heritage|Background|Vice|Look

&d.bio.hull [v(d.cgdb)]=Frame Size|Primary Drive|Secondary Drive|Tertiary Drive

&d.bio.hull.exclude [v(d.cgdb)]=Vice

&d.bio.vampire [v(d.cgdb)]=Telltale

&d.bio.vampire.exclude [v(d.cgdb)]=Vice

&d.attributes [v(d.cgdb)]=Insight|Prowess|Resolve

&d.actions.insight [v(d.cgdb)]=Hunt|Study|Survey|Tinker

&d.actions.prowess [v(d.cgdb)]=Finesse|Prowl|Skirmish|Wreck

&d.actions.resolve [v(d.cgdb)]=Attune|Command|Consort|Sway

&d.actions [v(d.cgdb)]=Hunt|Study|Survey|Tinker|Finesse|Prowl|Skirmish|Wreck|Attune|Command|Consort|Sway

&d.abilities [v(d.cgdb)]=d.abilities.cutter d.abilities.hound d.abilities.leech d.abilities.lurk d.abilities.slide d.abilities.spider d.abilities.whisper

&d.abilities.cutter [v(d.cgdb)]=Battleborn|Bodyguard|Ghost Fighter|Leader|Mule|Not to be Trifled With|Savage|Vigorous

&d.friends.cutter [v(d.cgdb)]=Marlene, a pugilist|Chael, a vicious thug|Mercy, a cold killer|Grace, an extortionist|Sawtooth, a phsysicker

&d.xp_triggers.cutter [v(d.cgdb)]=address a challenge with Violence or Coercion

&d.gear.cutter [v(d.cgdb)]=1L Fine hand weapon|2L Fine heavy weapon|1L Scary weapon or tool|0L Manacles & chain|0L Rage essence vial|0L Spiritbane charm

&d.abilities.hound [v(d.cgdb)]=Sharpshooter|Focused|Ghost Hunter (ghost-form)|Ghost Hunter (mind-link)|Ghost Hunter (arrow-swift)|Scout|Survivor|Tough as Nails|Vengeful

&d.friends.hound [v(d.cgdb)]=Steiner, an assassin|Celene, a sentinel|Melvir, a phsysicker|Veleris, a spy|Casta, a bounty hunter

&d.xp_triggers.hound [v(d.cgdb)]=address a challenge with Tracking or Violence

&d.gear.hound [v(d.cgdb)]=1L Fine pair of pistols|2L Fine long rifle|1L Electroplasmic ammunition|0L A trained hunting pet|1L Spyglass|0L Spiritbane charm

&d.abilities.leech [v(d.cgdb)]=Alchemist|Analyst|Artificer|Fortitude|Ghost Ward|Phsysicker|Saboteur|Venomous

&d.friends.leech [v(d.cgdb)]=Stazia, an apothecary|Veldren, a psychonaut|Eckard, a corpse thief|Jul, a blood dealer|Malista, a priestess

&d.xp_triggers.leech [v(d.cgdb)]=address a challenge with Technical Skill or Mayhem

&d.gear.leech [v(d.cgdb)]=1L Fine tinkering tools|2L Fine wrecking tools|0L Blowgun & darts, syringes|1L Bandolier (3 uses)|1L Bandolier (3 uses)|1-3L Gadgets|0L Alcahest |0L Binding Oil|0L Drift Oil|0L Drown Powder|0L Eyeblind Poison|0L Fire Oil|0L Grenade|0L Quicksilver|0L Skullfire Poison|0L Smoke Bomb|0L Spark (drug)|0L Standstill Poison|0L Trance Powder

&d.abilities.lurk [v(d.cgdb)]=Infiltrator|Ambush|Daredevil|The Devil's Footsteps|Expertise|Ghost Veil|Reflexes|Shadow

&d.friends.lurk [v(d.cgdb)]=Telda, a beggar|Darmot, a bluecoat|Frake, a locksmith|Roslyn Kellis, a noble|Petra, a city clerk

&d.xp_triggers.lurk [v(d.cgdb)]=address a challenge with Stealth or Evasion

&d.gear.lurk [v(d.cgdb)]=0L Fine lockpicks|1L Fine shadow cloak|1L Light climbing gear|0L Silence potion vial|1L Dark sight goggles|0L Spiritbane charm

&d.abilities.slide [v(d.cgdb)]=Rook's Gambit|Cloak & Dagger|Ghost Voice|Like Looking into a Mirror|A Little Something on the Side|Mesmerism|Subterfuge|Trust in Me

&d.friends.slide [v(d.cgdb)]=Bryl, a drug dealer|Bazso Baz, a  gang leader|Klyra, a tavern owner|Nyryx, a prostitute|Harker, a jail-bird

&d.xp_triggers.slide [v(d.cgdb)]=address a challenge with Deception or Influence

&d.gear.slide [v(d.cgdb)]=0L Fine clothes and jewelry|1L Fine disguise kit|0L Fine loaded dice, trick cards|0L Trance powder|1L A cane sword|0L Spiritbane charm

&d.abilities.spider [v(d.cgdb)]=Foresight|Calculating|Connected|Functioning Vice|Ghost Contract|Jail Bird|Mastermind|Weaving the Web

&d.friends.spider [v(d.cgdb)]=Salia, an information broker|Augus, a master architect|Jennah, a servant|Riven, a chemist|Jeren, a bluecoat archivist

&d.xp_triggers.spider [v(d.cgdb)]=address a challenge with Calculation or Conspiracy

&d.gear.spider [v(d.cgdb)]=0L Fine cover identity|1L Fine bottle of whiskey|1L Blueprints|0L Vial of slumber essence|0L Concealed palm pistol|0L Spiritbane charm

&d.abilities.whisper [v(d.cgdb)]=Compel|Ghost Mind|Iron Will|Occultist|Ritual|Strange Methods|Tempest|Warded

&d.friends.whisper [v(d.cgdb)]=Nyryx, a possessor ghost|Scurlock, a vampire|Setarra, a demon|Quellyn, a witch|Flint, a spirit trafficker

&d.xp_triggers.whisper [v(d.cgdb)]=address a challenge with Knowledge or Arcane Power

&d.gear.whisper [v(d.cgdb)]=2L Fine lightning hook|1L Fine spirit mask|0L Electroplasm vials|1L Spirit Bottles (2)|0L Ghost key|0L Demonbane charm

&d.abilities.ghost [v(d.cgdb)]=Ghost Form|Dissipate|Manifest|Poltergeist|Possess

&d.xp_triggers.ghost [v(d.cgdb)]=Exact Vengeance, Express Outrage or Anger, or Settle Scores from Your Heritage or Background

&d.abilities.hull [v(d.cgdb)]=Compartments|Electroplasmic Projectors|Interface|Overcharge|Secondary Hull|Frame Upgrade

&d.xp_triggers.hull [v(d.cgdb)]=fulfill your Drives despite Difficulty or Danger or Suppress or Ignore your former Human Qualities

&d.abilities.vampire [v(d.cgdb)]=Arcane Sight|Dark Talent|Sinister Guile|Terrible Power|A Void in the Echo

&d.xp_triggers.vampire [v(d.cgdb)]=Display Dominance or Slay without Mercy

&d.frame_upgrades.hull [v(d.cgdb)]=Interior Chamber|Life-like Appearance|Levitation|Phonograph|Plating|Reflexes|Sensors|Smoke Projectors|Spider Climb|Spring-leap Pistons

&d.strictures.vampire [v(d.cgdb)]=Slumber|Forbidden|Repelled|Bestial|Bound

&d.stats_editable_after_chargen [v(d.cgdb)]=Name|Alias|Look

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Valid values for various stats - * means write your own
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.value.playbook [v(d.cgdb)]=Cutter|Hound|Leech|Lurk|Slide|Spider|Whisper|Ghost|Hull|Vampire|*

&d.value.load [v(d.cgdb)]=Light|Normal|Heavy|Encumbered

&d.choose.note.playbook [v(d.cgdb)]=Your playbook represents your character's reputation in the underworld, their special abilities, and how they advance. While we don't make strong use of playbooks in this game, a playbook can be an easy way to focus on what your character is good at and what you expect them to do during a job.

&d.value.heritage [v(d.cgdb)]=Akoros|The Dagger Isles|Iruvia|Severos|Skovland|Tycheros

&d.value.background [v(d.cgdb)]=Academic|Labor|Law|Trade|Military|Noble|Underworld

&d.value.vice [v(d.cgdb)]=Faith|Gambling|Luxury|Obligation|Pleasure|Stupor|Weird

&d.value.action [v(d.cgdb)]=0|1|2|3|4|5

&d.value.frame_size [v(d.cgdb)]=Small|Medium|Heavy

&d.value.primary_function [v(d.cgdb)]=Guard|Destroy|Discover|Acquire|Labor

&d.value.secondary_function [v(d.cgdb)]=Guard|Destroy|Discover|Acquire|Labor

&d.value.tertiary_function [v(d.cgdb)]=Guard|Destroy|Discover|Acquire|Labor

&d.choose.note.friends [v(d.cgdb)]=Every playbook has a list of 5 friends that come with it. You can choose your list from any playbook. Which would you like?

&d.choose.note.xp_triggers [v(d.cgdb)]=Every playbook has a list of XP triggers that, when encountered, grant you XP. You can choose your triggers from any playbook. Which would you like?

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Restricted values at character generation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.restricted.playbook [v(d.cgdb)]=Ghost|Hull|Vampire

&d.restricted.action [v(d.cgdb)]=3|4|5

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Text for the chooser
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.choose-sections [v(d.cgdb)]=Special Abilities|XP Triggers|Gear|Friends|Ally|Rival

&d.choosable-stats [v(d.cgdb)]=Friends|Ally|Rival|Gear|XP Triggers

&d.crew-choose-sections [v(d.cgdb)]=

&d.choose.note. [v(d.cgdb)]=Welcome to the Chargen Chooser! Each of the sections below contains unique choices to help you flesh out your character. To visit one, type +stat/choose <section>.

&d.choose.afterword. [v(d.cgdb)]=These are not the only options to set. Take a look at your %ch+sheet%cn and you'll find you can fill out more of it with %ch+stat/set <stat>=<value>%cn. As always%, if you have questions%, use %chcg/on%cn to turn on the Chargen channel and %chcg <question>%cn to ask questions.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Random values for chargen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.random.job [v(d.cgdb)]=phsysicker|pugilist|vicious thug|cold killer|extortionist|assassin|sentinel|spy|bounty hunter|apothecary|psychonaut|corpse thief|blood dealer|priestess|beggar|bluecoat|locksmith|noble|city clerk|drug dealer|gang leader|tavern owner|prostitute|jail-bird|information broker|master architect|servant|chemist|bluecoat archivist|possessor ghost|vampire|demon|witch|spirit trafficker

&d.random.name [v(d.cgdb)]=Adric|Aldo|Amosen|Andrel|Arden|Arlyn|Arquo|Arvus|Ashlyn|Branon|Brace|Brance|Brena|Bricks|Candra|Carissa|Carro|Casslyn|Cavelle| Clave|Corille|Cross|Crowl|Cyrene|Daphnia|Drav|Edlun|Emeline|Grine|Helles|Hix|Holtz|Kamelin|Kelyr|Kobb|Kristov|Laudius|Lauria|Lenia|Lizete|Lorette|Lucella|Lynthia|Mara|Milos|Morlan|Myre|Narcus|Naria|Noggs|Odrienne|Orlan|Phin|Polonia|Quess|Remira|Ring|Roethe|Sesereth|Sethla|Skannon|Stavrul|Stev|Syra|Talitha|Tesslyn|Thena|Timoth|Tocker|Una|Vaurin|Veleris|Veretta|Vestine|Vey|Volette|Vond|Weaver|Wester|Zamira

&d.random.surname [v(d.cgdb)]=Ankhayat|Arran|Athanoch|Basran|Boden|Booker|Bowman|Breakiron|Brogan|Clelland|Clermont|Coleburn|Comber|Daava|Dalmore|Danfield|Dunvil|Farros|Grine|Haig|Helker|Helles|Hellyers|Jayan|Jeduin|Kardera|Karstas|Keel|Kessarin|Kinclaith|Lomond|Maroden|Michter|Morriston|Penderyn|Prichard|Rowan|Sevoy|Skelkallan|Skora|Slane|Strangford|Strathmill|Templeton|Tyrconnell|Vale|Walund|Welker

&d.random.gender_presentation [v(d.cgdb)]=Man|Woman|Ambiguous|Concealed

&d.random.appearance_adjective [v(d.cgdb)]=Affable|Athletic|Bony|Bright|Brooding|Calm|Chiseled|Cold|Dark|Delicate|Fair|Fierce|Grimy|Handsome|Huge|Hunched|Languid|Lovely|Open|Plump|Rough|Sad|Scarred|Slim|Soft|Squat|Stern|Stout|Striking|Twitchy|Weathered|Wiry|Worn

&d.random.clothing [v(d.cgdb)]=Collared Shirt|Eel-skin Bodysuit|Fitted Dress|Fitted Leggings|Half-Cape|Heavy Cloak|Heavy Jacket|Hide & Furs|Hood & Veil|Hooded Cape|Hooded Coat|Knit Cap|Knit Sweater|Leathers|Long Coat|Long Scarf|Loose Silks|Mask & Robes|Rags & Tatters|Rough Tunic|Scavenged Uniform|Sharp Trousers|Short Cloak|Skirt & Blouse|Slim Jacket|Soft Boots|Suit & Tie|Suspenders|Tall Boots|Thick Greatcoat|Tricorn Hat|Vest or Waistcoat|Waxed Coat|Wide Belt|Work Boots|Work Trousers

&d.random.alias [v(d.cgdb)]=Bell|Birch|Bricks|Bug|Chime|Coil|Cricket|Cross|Crow|Echo|Flint|Frog|Frost|Grip|Gunner|Hammer|Hook|Junker|Mist|Moon|Nail|Needle|Ogre|Pool|Ring|Ruby|Silver|Skinner|Song|Spur|Tackle|Thistle|Thorn|Tick-Tock|Twelves|Vixen|Whip|Wicker

&d.random. [v(d.cgdb)]=
&d.random. [v(d.cgdb)]=
&d.random. [v(d.cgdb)]=
&d.random. [v(d.cgdb)]=

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - target
@@ %1 - viewer
&layout.page1 [v(d.cgf)]=strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.actions, %0, %1), %r, ulocal(layout.abilities, %0, %1), %r, ulocal(layout.health, %0, %1), %r, ulocal(layout.pools, %0, %1), %r, ulocal(layout.xp_triggers, %0, %1), %r, footer(ulocal(layout.footer, %0, %1), %1))

&layout.page2 [v(d.cgf)]=strcat(header(ulocal(layout.name, %0, %1), %1), %r, ulocal(layout.bio, %0, %1), %r, ulocal(layout.friends, %0, %1), %r, ulocal(layout.gear, %0, %1), %r, ulocal(layout.projects, %0, %1), %r, ulocal(layout.notes, %0, %1))

&layout.pass [v(d.cgf)]=%ch%cg%[Pass%]

&layout.fail [v(d.cgf)]=%cr%[Needs work%]

&layout.test [v(d.cgf)]=strcat(%b, if(t(%0), ulocal(layout.pass), ulocal(layout.fail)))

&layout.cg-errors [v(d.cgf)]=strcat(header(Character generation instructions), %r, formattext(strcat(- You get 7 action dots. You have, %b, setr(A, ulocal(f.get-total-player-actions, %0))., ulocal(layout.test, eq(%qA, 7)), %r, - You get one special ability. You have%b, setr(A, ulocal(f.get-total-player-abilities, %0))., ulocal(layout.test, eq(%qA, 1)), %r, - Fill out all the bio fields. You have%b, setr(A, ulocal(f.get-remaining-bio-fields, %0)) remaining., ulocal(layout.test, eq(%qA, 0)), %r, setq(A, words(ulocal(f.get-player-stat, %0, friends), |)), if(eq(%qA, 0), - You have no friends. Select 5 with +stat/choose Friends., - Choose 5 friends.), ulocal(layout.test, gt(%qA, 0)), %r, setq(A, words(ulocal(f.get-player-stat, %0, gear), |)), if(neq(%qA, 5), - You need gear. Select it with +stat/choose Gear., - Choose your gear.), ulocal(layout.test, gt(%qA, 0))), 0, %1), %r, divider(Commands), %r, multicol(+stat/set <stat>=<value>|+stat/add <stat>|+stat/remove <stat>|+stat/choose|+stat/random <stat>|+stat/list, * * *, 0, |, %1), %r, footer(cg/on to join the Chargen channel and ask questions!))

&layout.name [v(d.cgf)]=strcat(ulocal(f.get-name, %0, %1), if(isstaff(%1), strcat(%b, %(, %0, %))))

&layout.bio [v(d.cgf)]=strcat(multicol(ulocal(layout.player-bio, %0, %1), * * *, 0, |, %1), %r, formattext(cat(Look:, shortdesc(%0, %1))))

&layout.player-bio [v(d.cgf)]=iter(remove(ulocal(f.get-player-bio-fields, %0), Look, |), strcat(itext(0), :, %b, default(strcat(%0, /, ulocal(f.get-stat-location-on-player, itext(0))), Not set)), |, |)
+sheet

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

&layout.friends [v(d.cgf)]=strcat(divider(Friends, %1), setq(E, ulocal(f.get-player-stat, %0, rival)), setq(A, ulocal(f.get-player-stat, %0, ally)), %r, multicol(iter(ulocal(f.get-player-stat, %0, friends), strcat(switch(itext(0), %qA, %ch%cg%(Ally%)%cn%b, %qE, %cr%(Rival%)%cn%b,), itext(0)), |, |), * *, 0, |, %1))

&layout.gear [v(d.cgf)]=strcat(divider(cat(Load:, ulocal(f.get-player-stat, %0, load)), %1), %r, multicol(edit(iter(setr(T, fliplist(ulocal(f.get-player-stat, %0, gear), 2, |)), ulocal(layout.gear-item, itext(0)), |, |), 0L, %ch%cx--%cn), * *, 0, |, %1), %r, ulocal(layout.load-chart, %0, %1))

&layout.load-chart [v(d.cgf)]=strcat(formattext(%b, 0, %1), multicol(ulocal(f.get-player-load, %0), 10 5 * 5 * 5 12 3, 0, |, %1))

&layout.gear-item [v(d.cgf)]=switch(%0, %[*%]*, %0, cat(%[, %], %0))

&layout.projects [v(d.cgf)]=strcat(divider(Long-term projects, %1), %r, multicol(ulocal(f.get-player-projects, %0), *, 0, |, %1))

&layout.notes [v(d.cgf)]=strcat(divider(Notes, %1), %r, multicol(ulocal(f.get-player-notes, %0), *, 0, |, %1))

&layout.footer [v(d.cgf)]=strcat(Approved status and date, %,, %b, X advancements, %,, %b, Y XP)

&layout.subsection [v(d.cgf)]=strcat(ulocal(ulocal(f.get-stat-location, layout.%0), %1, %2, %3), %r, footer(ulocal(layout.footer, %1, %2), %2))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Non-sheet layouts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.harm [v(d.cgf)]=cat(alert(Health), ulocal(f.get-name, %0), inflicted a, %chlevel %1%cn, harm on, obj(%0)self, called, %ch%2%cn.)

&layout.heal [v(d.cgf)]=squish(cat(alert(Health), ulocal(f.get-name, %0), adds %ch%1%cn ticks to, poss(%0), healing clock%,, if(t(%2), cat(removing, itemize(%ch%2%cn, |)%,)), if(%3, but, and), subj(%0), switch(subj(%0), they, are, is), ansi(h, if(%3, still injured, fully healed).)))

&layout.room-emit [v(d.cgf)]=cat(alert(Game), ulocal(f.get-name, %0), %1)

@@ %0 - screen
@@ %1 - target
@@ %2 - viewer
&layout.choose [v(d.cgf)]=strcat(header(cat(Choose your, if(t(%0), %0, CG section)), %2), %r, setq(M, ulocal(layout.choose_list, ulocal(f.get-choice-list, %0, %1))), setq(N, words(%qM, |)), setq(N, add(div(%qN, 10), t(mod(%qN, 10)))), setq(R, ulocal(f.list-restricted-values, %0, %1)), setq(T, xget(%vD, ulocal(f.get-stat-location, d.choose.note.%0))), setq(A, xget(%vD, ulocal(f.get-stat-location, d.choose.afterword.%0))), formattext(%qT%b, t(%qT), %2), edit(multicol(if(gt(%qN, 1), fliplist(%qM, %qN, |), %qM), repeat(*%b, %qN), 0, |, %2), _, %b), %r, formattext(If you're stuck for choices%, choose "Random" to have the chooser pick one for you., 1, %2), , if(t(%qR), formattext(strcat(indent(), The following are restricted and are not currently available:%b, itemize(%qR, |), ., %r), 0, %1)), if(t(%qA), formattext(%qA%b, 1, %2)), %r, footer(+stat/choose <#> to choose, %2))

&layout.choose_list [v(d.cgf)]=strcat(setq(N, 0), iter(%0, strcat(___, setr(N, inum(0)).%b, itext(0)), |, |), |, ___, inc(%qN). Random)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Functions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ %0 - screen
@@ %1 - target
&f.get-choice-list [v(d.cgf)]=if(t(%0), remove(ulocal(f.list-valid-values, %0, %1), any unrestricted text, |), ulocal(f.get-choices, %1))

&f.get-choices [v(d.cgf)]=strcat(squish(trim(iter(ulocal(f.get-player-bio-fields, %0), if(hasattr(%vD, strcat(d.value., ulocal(f.get-stat-location, itext(0)))), itext(0)), |, |), b, |), |), |, xget(%vD, d.choose-sections))

&f.get-remaining-bio-fields [v(d.cgf)]=ladd(iter(ulocal(f.get-player-bio-fields, %0), not(hasattr(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |))

&f.get-player-bio-fields [v(d.cgf)]=strcat(setq(P, xget(%0, ulocal(f.get-stat-location-on-player, Playbook))), setq(F, xget(%vD, d.bio)), setq(F, strcat(%qF, |, xget(%vD, d.bio.%qP))), null(iter(xget(%vD, d.bio.%qP.exclude), setq(F, remove(%qF, itext(0), |, |)), |, |)), squish(trim(%qF, b, |), |))

&f.get-player-action [v(d.cgf)]=default(strcat(%0, /, ulocal(f.get-stat-location-on-player, %1)), 0)

&f.get-player-attribute [v(d.cgf)]=ladd(iter(xget(%vD, d.actions.%1), t(xget(%0, ulocal(f.get-stat-location-on-player, itext(0)))), |))

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

&f.get-player-load [v(d.cgf)]=if(t(finditem(ulocal(f.get-player-stat, %0, abilities), Mule, |)), Light:|1-5|Normal:|6-7|Heavy:|8|Encumbered:|9, Light:|1-3|Normal:|4-5|Heavy:|6|Encumbered:|7-9)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&tr.error [v(d.cg)]=@pemit %0=cat(alert(Error), %1);

&tr.message [v(d.cg)]=@pemit %0=cat(alert(Alert), %1);

&tr.success [v(d.cg)]=@pemit %0=cat(alert(Success), %1);

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Commands
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+sheet [v(d.cg)]=$+sheet:@pemit %#=ulocal(layout.page1, %#, %#); @assert isapproved(%#)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %#, %#)); };

&c.+sheet_page [v(d.cg)]=$+sheet/*:@eval setq(V, if(member(1 2, %0), page%0, %0)); @assert t(setr(S, finditem(setr(L, ulocal(f.list-sheet-sections)), %qV, |)))={ @trigger me/tr.error=%#, Could not find the section of the sheet starting with '%0'. Valid sections are: [itemize(%qL, |)].; }; @pemit %#=ulocal(layout.subsection, %qS, %#, %#);

&c.+stat [v(d.cg)]=$+stats:@pemit %#=ulocal(layout.sheet, %#, %#)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Health
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+health [v(d.cg)]=$+health:@pemit %#=ulocal(layout.subsection, health, %#, %#, 1)

&c.+harm [v(d.cg)]=$+harm *:@eval strcat(setq(L, edit(first(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, edit(last(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, 1), setq(D, %0)), setq(D, revwords(rest(revwords(%0)))))), setq(D, rest(%0)))); @assert t(match(1 2 3, %qL))={ @trigger me/tr.error=%#, You can only suffer a level 1%, 2%, or 3 harm.; };  @assert t(%qD)={ @trigger me/tr.error=%#, You must enter a description of the harm.; }; @assert t(setr(F, ulocal(f.get-harm-field, %#, %qL)))={ @trigger me/tr.error=%#, Your character is out of the scene and cannot be further harmed.; }; @set %#=%qF:%qD; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.harm, %#, %qL, %qD), %#;

&c.+heal [v(d.cg)]=$+heal*:@break match(%0, th); @eval setq(L, if(t(%0), trim(%0), 1)); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, You must enter either 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, ulocal(f.get-highest-health-level, %#)))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot heal.; }; @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), 4)]; @eval setq(H, iter(extract(%qF, 1, div(%qT, 4)), xget(%#, itext(0)),, |)); @set %#=if(gte(div(%qT, 4), 1), first(%qF)):; @set %#=if(gte(div(%qT, 4), 2), first(rest(%qF))):; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, %qH, t(ulocal(f.get-highest-health-level, %#))), %#;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Gear
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+gear [v(d.cg)]=$+gear:@pemit %#=ulocal(layout.subsection, gear, %#, %#)

&c.+mark [v(d.cg)]=$+mark *:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to mark yet.; }; @assert t(setr(G, finditem(edit(iter(%qL, switch(itext(0), %[X%]*,, %[ %]*, extract(itext(0), 4, words(itext(0))), rest(itext(0))), |, |), %b%[Used%],), %0, |)))={ @trigger me/tr.error=%#, Could not find an unmarked piece of your gear starting with '%0'.; }; @set %#=ulocal(f.get-stat-location-on-player, gear):[iter(%qL, switch(itext(0), %[X%]*, itext(0), %[ %]*, if(cand(not(t(%qX)), match(extract(itext(0), 4, words(itext(0))), %qG, |)), edit(itext(0), %[ %], %[X%])[setq(X, 1)], itext(0)), if(cand(not(t(%qX)), match(rest(itext(0)), %qG, |)), edit(itext(0), ^, %[X%]%b)[setq(X, 1)], itext(0))), |, |)]; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, marks [poss(%#)] %qG gear as present for this score.);

&c.+unmark [v(d.cg)]=$+unmark*:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to unmark yet.; }; @assert t(match(%qL, %[X%]*, |))={ @trigger me/tr.error=%#, None of your gear is marked%, so it can't be unmarked.; }; @assert cor(match(%0, /all), t(setr(G, finditem(edit(iter(%qL, switch(itext(0), %[ %]*,, %[X%]*, extract(itext(0), 3, words(itext(0)))), |, |), %b%[Used%],), trim(%0), |))))={ @trigger me/tr.error=%#, Could not find an unmarked piece of your gear starting with '[trim(%0)]'.; }; @set %#=ulocal(f.get-stat-location-on-player, gear):[switch(%0, /all, edit(%qL, %[X%], %[ %]), iter(%qL, switch(itext(0), %[ %]*, itext(0), %[X%]*, if(cand(not(t(%qX)), match(extract(itext(0), 3, words(itext(0))), %qG, |)), edit(itext(0), %[X%], %[ %])[setq(X, 1)], itext(0)), if(cand(not(t(%qX)), match(rest(itext(0)), %qG, |)), edit(itext(0), ^, %[ %]%b)[setq(X, 1)], itext(0))), |, |))]; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, unmarks [switch(%0, /all, all [poss(%#)], [poss(%#)] %qG)] gear - it is no longer present for this score.);

&c.+use [v(d.cg)]=$+use *:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to mark used yet.; }; @assert t(setr(G, finditem(edit(iter(%qL, extract(itext(0), switch(itext(0), %[X%]*, 3, %[ %]*, 4, 2), words(itext(0))), |, |), %b%[Used%],), %0, |)))={ @trigger me/tr.error=%#, Could not find a piece of your gear starting with '%0'.; }; @set %#=ulocal(f.get-stat-location-on-player, gear):[iter(%qL, if(cand(not(t(%qX)), match(extract(edit(itext(0), %b%[Used%],), switch(itext(0), %[X%]*, 3, %[ %]*, 4, 2), words(itext(0))), %qG, |)), setr(X, edit(itext(0), $, %b%[Used%])), itext(0)), |, |)]; @pemit %#=%qG!; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, marks off [strcat(setq(X, words(graball(%qX, %[Used%]))), a, %b, case(%qX, 1, first, 2, second, 3, third, 4, fourth, 5, fifth, %qXth))] use of [poss(%#)] %qG gear.);

&c.+unuse [v(d.cg)]=$+unuse *:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to mark unused yet.; }; @assert t(setr(G, finditem(iter(%qL, if(match(itext(0), *%b%[Used%]), extract(itext(0), switch(itext(0), %[X%]*, 3, %[ %]*, 4, 2), words(itext(0)))), |, |), %0, |)))={ @trigger me/tr.error=%#, Could not find a used piece of your gear starting with '%0'.; }; @set %#=ulocal(f.get-stat-location-on-player, gear):[iter(%qL, if(cand(not(t(%qX)), match(extract(edit(itext(0), %b%[Used%],), switch(itext(0), %[X%]*, 3, %[ %]*, 4, 2), words(itext(0))), %qG, |)), setr(X, remove(itext(0), %[Used%])), itext(0)), |, |)]; @pemit %#=%qG!; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, marks off [strcat(setq(X, words(graball(%qX, %[Used%]))), a, %b, case(%qX, 1, first, 2, second, 3, third, 4, fourth, 5, fifth, %qXth))] use of [poss(%#)] %qG gear.);

&c.+unuse_all [v(d.cg)]=$+unuse:@assert t(setr(L, ulocal(f.get-player-stat, %#, gear)))={ @trigger me/tr.error=%#, You don't have any gear to mark used yet.; }; @set %#=ulocal(f.get-stat-location-on-player, gear):[edit(%qL, %b%[Used%],)]; @trigger me/tr.remit-or-pemit=%#, ulocal(layout.room-emit, %#, marks all of [poss(%#)] gear unused.);


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Chargen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&c.+stat/set [v(d.cg)]=$+stat/set *=*: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @assert t(setr(S, finditem(ulocal(f.get-stats, %#), %0, |)))={ @trigger me/tr.error=%#, Could not find a settable stat that starts with '%0'.; }; @assert cand(t(strlen(setr(V, ulocal(f.get-valid-value, %qS, %1, %#)))), not(member(ulocal(f.list-restricted-values, %qS), %qV, |)))={ @trigger me/tr.error=%#, '%1' is not a value for %qS. Valid values are: [itemize(ulocal(f.list-valid-values, %qS, %#), |)].[if(t(setr(R, itemize(ulocal(f.list-restricted-values, %qS), |))), %bRestricted values are: %qR.)]; }; @assert cor(not(isapproved(%#)), member(xget(%vD, d.stats_editable_after_chargen), %qS, |))={ @assert not(isnum(%qV))={ @force %#={ +xp/buy %qS; }; }; @trigger me/tr.error=%#, %qS cannot be changed after you are approved. You will need to either %ch+xp/buy%cn or open a job with staff.; }; @assert if(ulocal(f.is-action, %qS), strcat(setq(T, ulocal(f.get-total-player-actions, %#, %qS)), lte(add(%qT, %qV), 7)), 1)={ @trigger me/tr.error=%#, Setting your %qS to %qV would take you over 7 points of actions. Reduce your action total to move the dots around.; }; @set %#=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @trigger me/tr.success=%#, You set your %ch%qS%cn to %ch%qV%cn.;

&c.+stat/add [v(d.cg)]=$+stat/add *: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to add.; }; @assert t(setr(S, finditem(ulocal(f.get-abilities), %0, |)))={ @trigger me/tr.error=%#, Could not find a special ability that starts with '%0'.; }; @assert not(t(finditem(setr(L, ulocal(f.get-player-stat, %#, abilities)), %qS, |)))={ @trigger me/tr.error=%#, You already have a special ability called '%qS'.; }; @assert not(isapproved(%#))={ @force %#={ +xp/buy %qS; }; }; @assert strcat(setq(T, ulocal(f.get-total-player-abilities, %#)), lte(add(%qT, 1), 1))={ @trigger me/tr.error=%#, Adding %qS would take you over 1 points of special abilities. +stat/remove something else to move the dots around.; }; @set %#=_stat.abilities:[trim(strcat(%qL, |, %qS), b, |)]; @trigger me/tr.success=%#, You added the special ability %ch%qS%cn.;

&c.+stat/choose_thing [v(d.cg)]=$+stat/choose *=*:@break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to choose.; }; @assert t(setr(S, finditem(ulocal(f.get-choosable-stats, %#), %0, |)))={ @trigger me/tr.error=%#, Could not find a choosable stat that starts with '%0'.; }; @assert cand(t(strlen(setr(C, ulocal(f.get-valid-value, %qS, %1, %#)))), not(member(ulocal(f.list-restricted-values, %qS), %qC, |)))={ @trigger me/tr.error=%#, '%1' is not a value for %qS. Valid values are: [itemize(ulocal(f.list-valid-values, %qS, %#), |)].[if(t(setr(R, itemize(ulocal(f.list-restricted-values, %qS), |))), %bRestricted values are: %qR.)]; }; @assert cor(not(isapproved(%#)), member(xget(%vD, d.stats_editable_after_chargen), %qS, |))={ @trigger me/tr.error=%#, %qS cannot be changed after you are approved. You will need to open a job with staff.; }; @assert t(setr(V, switch(%qS, Rival, %qC, Ally, %qC, xget(%vD, strcat(d., ulocal(f.get-stat-location, %qS.%qC))))))={ @trigger me/tr.error=%#, %qS is not set up for %qC.; }; @set %#=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @assert not(t(member(Rival|Ally, %qS, |)))={ @trigger me/tr.success=%#, You set your %ch%qS%cn to %ch%qV%cn.; };  @trigger me/tr.success=%#, You set your %ch%qS%cn to the %ch%qC%cn list: %ch[itemize(%qV, |, and, ;)]%cn.;

&c.+stat/remove [v(d.cg)]=$+stat/remove *: @break match(%0, */*); @assert t(%0)={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @assert t(setr(S, finditem(setr(L, ulocal(f.get-player-stat, %#, abilities)), %0, |)))={ @trigger me/tr.error=%#, You don't have a special ability that starts with '%0'.; }; @assert not(isapproved(%#))={ @trigger me/tr.error=%#, You cannot remove abilities after you are approved. You will need to open a job with staff.; }; @set %#=_stat.abilities:[trim(remove(%qL, %qS, |, |), b, |)]; @trigger me/tr.success=%#, You removed the special ability %ch%qS%cn.;

&c.+stat/clear [v(d.cg)]=$+stat/clear*: @assert not(isapproved(%#))={ @trigger me/tr.error=%#, You can't clear your stats once you're approved.; };  @assert cand(lte(sub(secs(), xget(%0, _stat.clear-request)), 600), match(trim(%0), YES))={ @wipe %#/_stat.*; @trigger me/tr.success=%#, Your stats have been cleared.; }; @set %#=_stat.clear-request:[secs()]; @trigger me/tr.success=%#, This will clear all of your stats. If you would like to continue%, type %ch+stat/clear YES%cn within the next 10 minutes. It is now [prettytime()].;

&c.+stat/set_staff [v(d.cg)]=$+stat/set */*=*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set other players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; };  @assert t(%1)={ @trigger me/tr.error=%#, You need to enter something to set or unset.; }; @assert t(setr(S, finditem(ulocal(f.get-stats, %#), %1, |)))={ @trigger me/tr.error=%#, Could not find a settable stat that starts with '%1'.; }; @assert t(strlen(setr(V, ulocal(f.get-valid-value, %qS, %2, %qP))))={ @trigger me/tr.error=%#, '%2' is not a value for %qS. Valid values are: [itemize(ulocal(f.list-valid-values, %qS, %qP), |)].; }; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %#) set [ulocal(f.get-name, %qP)]'s %ch%qS%cn to %ch%qV%cn.; @set %qP=[ulocal(f.get-stat-location-on-player, %qS)]:%qV; @trigger me/tr.success=%#, You set [ulocal(f.get-name, %qP, %#)]'s %ch%qS%cn to %ch%qV%cn.;

&c.+stat/add_staff [v(d.cg)]=$+stat/add */*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set other players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(%1)={ @trigger me/tr.error=%#, You need to enter something to add.; }; @assert t(setr(S, finditem(ulocal(f.get-abilities), %1, |)))={ @trigger me/tr.error=%#, Could not find a special ability that starts with '%1'.; }; @assert not(t(finditem(setr(L, ulocal(f.get-player-stat, %qP, abilities)), %qS, |)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) already has a special ability called '%qS'.; }; @set %qP=_stat.abilities:[trim(strcat(%qL, |, %qS), b, |)]; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %#) added the special ability %ch%qS%cn to [ulocal(f.get-name, %qP)]'s character sheet.; @trigger me/tr.success=%#, You added the special ability %ch%qS%cn to [ulocal(f.get-name, %qP, %#)]'s character sheet.;

&c.+stat/remove_staff [v(d.cg)]=$+stat/remove */*: @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to set other players' stats.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @assert t(%1)={ @trigger me/tr.error=%#, You need to enter something to remove.; }; @assert t(setr(S, finditem(setr(L, ulocal(f.get-player-stat, %qP, abilities)), %1, |)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP, %#) doesn't have a special ability that starts with '%1'.; }; @cemit [xget(%vD, d.log-staff-statting-to-channel)]=ulocal(f.get-name, %#) removed the special ability %ch%qS%cn from [ulocal(f.get-name, %qP)]'s character sheet.; @set %qP=_stat.abilities:[trim(remove(%qL, %qS, |, |), b, |)]; @trigger me/tr.success=%#, You removed the special ability %ch%qS%cn from [ulocal(f.get-name, %qP, %#)]'s character sheet.;

&c.+stat/choose [v(d.cg)]=$+stat/choose:@pemit %#=ulocal(layout.choose,, %#, %#); @set %#=_last-cg-choice:;

&c.+stat/choose_text [v(d.cg)]=$+stat/choose *:@break match(%0, *=*); @assert t(setr(L, ulocal(f.get-choice-list, setr(S, xget(%#, _last-cg-choice)), %#)|Random))={ @trigger me/tr.error=%#, No choices were found to choose from! Something is very wrong.; }; @assert t(setr(C, if(isnum(%0), extract(%qL, %0, 1, |), finditem(%qL, %0, |))))={ @trigger me/tr.error=%#, Could not find an item in your list of choices [if(isnum(%0), at position %0, called '%0')].; }; @eval setq(X, strcat(t(member(Random, %qC, |)), cand(t(member(ulocal(f.get-choosable-stats), %qS, |)), hasattr(%#, _last-cg-choice)), t(member(ulocal(f.get-stats, %#), %qS, |)), t(member(ulocal(f.get-choices), %qC, |)))); @switch/first %qX=1*, { @trigger me/tr.random_choice=%#, %qL;  }, 01*, { @force %#={ +stat/choose %qS=%qC; }; }, 001*, { @force %#={ +stat/set %qS=%qC; }; }, { @set %#=_last-cg-choice:%qC; @pemit %#=ulocal(layout.choose, %qC, %#, %#); };

&tr.random_choice [v(d.cg)]=@force %0={ +stat/choose [inc(rand(words(%1, |)))]; }; @break t(setr(S, xget(%0, _last-cg-choice)))={ @trigger me/tr.message=%0, Randomly selected your %qS.; };


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Wrap-up
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@


@tel [v(d.cgdb)]=[v(d.cgf)]
@tel [v(d.cgf)]=[v(d.cg)]
@tel [v(d.cg)]=#2
