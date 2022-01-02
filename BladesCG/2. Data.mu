@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Settings
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ If this is set, +stat/set will emit to this channel when used by staff.
&d.log-staff-statting-to-channel [v(d.cgdb)]=Monitor

@@ This is how long crew invitations last - default is 3 days.
&d.crew-invitation-time [v(d.cgdb)]=259200

@@ If this is 'msg', the code will use the msg command to send notes to players. If it's anything else, the code will first try to @pemit, then will send @mail.
&d.message-method [v(d.cgdb)]=msg

@@ This is how the crew invitation will look.
&d.crew_invitation_flair [v(d.cgdb)]=alert(Crew Invitation)

@@ TODO: Add advanced abilities from pg 234. These aren't "special abilities", they're Advances (costs the same?) and they may go in a different section. Might also come with some hidden bio fields like "which Iruvian path are you on" but I don't think we vitally *need* that.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Data for chargen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.sheet-sections [v(d.cgdb)]=Page1|Page2|Bio|Actions|Abilities|Health|Pools|XP Triggers|Friends|Gear|Projects|Notes|Crew1|Crew2

&d.crew-sheet-sections [v(d.cgdb)]=Crew1|Crew2|Bio|Abilities|Upgrades|Contacts|Factions|XP Triggers|Members|Map|Cohorts

&d.stats_editable_after_chargen [v(d.cgdb)]=Name|Alias|Look

@@ Consider expanding editable stats - Playbook, Crew Type, etc should maybe be changeable after CG. Maybe there are others - stats that change the feel of the character or crew but not the stats. (Consider who can change those stats in a crew, if we allow crews to be editable after CG.)

&d.stats-where-player-gets-entire-list [v(d.cgdb)]=Gear|XP Triggers|Friends|Contacts|Crew XP Triggers

&d.choose-sections [v(d.cgdb)]=Abilities|XP Triggers|Gear|Friends|Ally|Rival|Crew Abilities|Favorite|Upgrades|Crew XP Triggers

&d.choosable-stats [v(d.cgdb)]=Abilities|Friends|Ally|Rival|Gear|XP Triggers|Favorite|Crew Abilities|Upgrades|Contacts|Crew XP Triggers

&d.addable-stats [v(d.cgdb)]=Abilities|Friends|Crew Abilities|Upgrades

@@ TODO: Add Friends and Contacts to the list of CG-addable stats once we figure out how that'll work.

&d.cg-addable-stats [v(d.cgdb)]=Upgrades|Abilities

&d.faction.questions [v(d.cgdb)]=Hunting|Helped|Harmed|Friendly|Unfriendly

@@ Stats you can "+stat/set <stat>=<a playbook>":
&d.playbook-stats [v(d.cgdb)]=XP Triggers|Playbook|Friends|Gear

@@ Stats you can "+stat/set <stat>=<a crew type>":
&d.crew-type-stats [v(d.cgdb)]=Crew XP Triggers|Contacts

&d.xp_tracks [v(d.cgdb)]=Insight|Prowess|Resolve|Playbook|Crew|Untracked

&d.stats-that-default [v(d.cgdb)]=Friends|Abilities|Gear|XP_Triggers

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Stat aliases
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Aliases should only be added for the following cases:
@@ -
@@  1. The stat has a short but confusing version of itself ("Crew" for "Crew Name") - if a player types the short version, you want it going directly to the long version, even if there are multiple stats that begin with that word.
@@ -
@@  2. The stat's singular version is spelled slightly differently from its plural version ("Special Ability" vs "Special Abilities") - if a player types the whole thing out, we want it to work.
@@ -
@@ You can add multiple aliases for the same stat.
@@ -
@@ Make sure the last entry on the alias is the actual destination of the stat.
@@ -
@@ Make sure that the actual destination of the stat matches an existing stat on d.choosable-stats, the actions list, the bio lists, or the crew stats list. Otherwise you will get errors.

&d.alias.crew_name [v(d.cgdb)]=Crew|Crew Name

&d.alias.abilities [v(d.cgdb)]=Special Ability|Special Abilities|Ability|Abilities

&d.alias.crew_abilities [v(d.cgdb)]=Crew Ability|Crew Abilities

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Expert stats
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.manual-bio-stats [v(d.cgdb)]=Expert Type|Character Type|Look

&d.expert_bio [v(d.cgdb)]=Name|Alias|Crew|Expert Type|Character Type|Age|Look

&d.value.expert_type [v(d.cgdb)]=Academic|Anarchist|Antiquarian|Apothecary|Arms Dealer|Assassin|Astronomer|Beggar|Blacksmith|Blood Dealer|Bluecoat|Bounty Hunter|Chemist|City Clerk|Cold Killer|Collector|Corpse Thief|Deal Broker|Dilettante|Dock Worker|Drug Dealer|Explorer|Extortionist|Gang Boss|Gang Leader|Information Broker|Jail-Bird|Locksmith|Magistrate|Master Architect|Merchant Lord|Noble|Occultist|Physicker|Pit Fighter|Priestess|Prostitute|Psychonaut|Pugilist|Sentinel|Servant|Smuggler|Spirit Trafficker|Spirit Warden|Spy|Tavern Owner|Vicious Noble|Vicious Thug|Ward Boss|Witch

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Restricted values at character generation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.restricted.playbook [v(d.cgdb)]=Ghost|Hull|Vampire

&d.restricted.action [v(d.cgdb)]=3|4|5

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel stats
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.bio [v(d.cgdb)]=Name|Alias|Playbook|Crew|Heritage|Background|Vice|Age|Look

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

&d.standard_gear [v(d.cgdb)]=1L A blade or two|1L Throwing knives|1L A pistol|1L A second pistol|2L A large weapon|1L An unusual weapon|2L Armor|3L Heavy Armor (requires Armor)|1L Burglary Gear|2L Climbing gear|1L Arcane implements|1L Documents|1L Subterfuge supplies|2L Demolition tools|1L Tinkering tools|1L Lantern|0L Spiritbane charm

&d.gear.hound [v(d.cgdb)]=1L Fine pair of pistols|2L Fine long rifle|1L Electroplasmic ammunition|0L A trained hunting pet|1L Spyglass|0L Spiritbane charm

&d.abilities.leech [v(d.cgdb)]=Alchemist|Analyst|Artificer|Fortitude|Ghost Ward|Phsysicker|Saboteur|Venomous

&d.friends.leech [v(d.cgdb)]=Stazia, an apothecary|Veldren, a psychonaut|Eckard, a corpse thief|Jul, a blood dealer|Malista, a priestess

&d.xp_triggers.leech [v(d.cgdb)]=address a challenge with Technical Skill or Mayhem

&d.gear.leech [v(d.cgdb)]=1L Fine tinkering tools|2L Fine wrecking tools|0L Blowgun & darts, syringes|1L Bandolier (3 uses)|1L Bandolier (3 uses)|1L Gadgets|1L Gadgets|1L Gadgets|0L Alcahest |0L Binding Oil|0L Drift Oil|0L Drown Powder|0L Eyeblind Poison|0L Fire Oil|0L Grenade|0L Quicksilver|0L Skullfire Poison|0L Smoke Bomb|0L Spark (drug)|0L Standstill Poison|0L Trance Powder

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

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Valid values for various stats - * means write your own
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.value.playbook [v(d.cgdb)]=Cutter|Hound|Leech|Lurk|Slide|Spider|Whisper|Ghost|Hull|Vampire

&d.value.age [v(d.cgdb)]=Young Adult|Adult|Mature|Elderly

&d.value.load [v(d.cgdb)]=Light|Normal|Heavy|Encumbered

&d.value.heritage [v(d.cgdb)]=Akoros|The Dagger Isles|Iruvia|Severos|Skovland|Tycheros

&d.value.background [v(d.cgdb)]=Academic|Labor|Law|Trade|Military|Noble|Underworld

&d.value.vice [v(d.cgdb)]=Faith|Gambling|Luxury|Obligation|Pleasure|Stupor|Weird

&d.value.action [v(d.cgdb)]=0|1|2|3|4|5

&d.value.frame_size [v(d.cgdb)]=Small|Medium|Heavy

&d.value.primary_drive [v(d.cgdb)]=Guard|Destroy|Discover|Acquire|Labor

&d.value.secondary_drive [v(d.cgdb)]=Guard|Destroy|Discover|Acquire|Labor

&d.value.tertiary_drive [v(d.cgdb)]=Guard|Destroy|Discover|Acquire|Labor

&d.value.trauma [v(d.cgdb)]=Cold|Haunted|Obsessed|Paranoid|Reckless|Soft|Unstable|Vicious

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew stats
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.crew_bio [v(d.cgdb)]=Crew Name|Crew Type|Reputation|Hunting Grounds|Lair|Lair District

@@ TODO: Add Preferred Operation Type?

&d.crew-stats [v(d.cgdb)]=Tier|Crew XP Triggers|Crew Abilities|Contacts|Favorite|Factions

&d.value.crew_type [v(d.cgdb)]=Assassins|Bravos|Cult|Hawkers|Shadows|Smugglers

&d.value.reputation [v(d.cgdb)]=Ambitious|Brutal|Daring|Honorable|Professional|Savvy|Subtle|Strange|*

&d.value.hunting_grounds [v(d.cgdb)]=Barrowcleft|Brightstone|Charhollow|Charterhall|Coalridge|Crow's Foot|The Docks|Dunslough|Nightmarket|Silkshore|Six Towers|Whitecrown

&d.value.lair_district [v(d.cgdb)]=Barrowcleft|Brightstone|Charhollow|Charterhall|Coalridge|Crow's Foot|The Docks|Dunslough|Nightmarket|Silkshore|Six Towers|Whitecrown

&d.crew_abilities [v(d.cgdb)]=d.crew_abilities.assassins d.crew_abilities.bravos d.crew_abilities.cult d.crew_abilities.hawkers d.crew_abilities.shadows d.crew_abilities.smugglers

&d.crew_abilities.assassins [v(d.cgdb)]=Deadly|Crow's Veil|Emberdeath|No Traces|Patron|Predators|Vipers

&d.crew_abilities.bravos [v(d.cgdb)]=Dangerous|Blood Brothers|Door Kickers|Fiends|Forged in the Fire|Patron|War Dogs

&d.crew_abilities.cult [v(d.cgdb)]=Chosen|Anointed|Bound in Darkness|Conviction|Glory Incarnate|Sealed in Blood|Zealotry

&d.crew_abilities.hawkers [v(d.cgdb)]=Silver Tongues|Accord|The Good Stuff|Ghost Market|High Society|Hooked|Patron

&d.crew_abilities.shadows [v(d.cgdb)]=Everyone Steals|Ghost Echoes|Pack Rats|Patron|Second Story|Slippery|Synchronized

&d.crew_abilities.smugglers [v(d.cgdb)]=Like Part of the Family|All Hands|Ghost Passage|Just Passing Through|Leverage|Reavers|Renegades

&d.crew_xp_triggers.assassins [v(d.cgdb)]=Execute a successful accident, disappearance, murder, or ransom operation.

&d.crew_xp_triggers.bravos [v(d.cgdb)]=Execute a successful battle, extortion, sabotage, or smash & grab operation.

&d.crew_xp_triggers.cult [v(d.cgdb)]=Advance the agenda of your deity or embody its precepts in Actions.

&d.crew_xp_triggers.hawkers [v(d.cgdb)]=Acquire product supply, execute clandestine/covert sales, or secure new territory.

&d.crew_xp_triggers.shadows [v(d.cgdb)]=Execute a successful espionage, sabotage, or theft operation.

&d.crew_xp_triggers.smugglers [v(d.cgdb)]=Execute a successful smuggling or acquire new clients or contraband sources.

&d.contacts.assassins [v(d.cgdb)]=Trev, a gang boss|Lydra, a deal broker|Irimina, a vicious noble|Karlos, a bounty hunter|Exeter, a spirit warden|Sevoy, a merchant lord

&d.contacts.bravos [v(d.cgdb)]=Meg, a pit-fighter|Conway, a bluecoat|Keller, a blacksmith|Tomas, a physicker|Walker, a ward boss|Lutes, a tavern owner

&d.contacts.cult [v(d.cgdb)]=Gagan, an academic|Adikin, an occultist|Hutchins, an antiquarian|Moriya, a spirit trafficker|Mateas Kline, a noble|Bennett, an astronomer

&d.contacts.hawkers [v(d.cgdb)]=Rolan Wott, a magistrate|Laroze, a bluecoat|Lydra, a deal broker|Hoxley, a smuggler|Anya, a dillettante|Marlo, a gang boss

&d.contacts.shadows [v(d.cgdb)]=Dowler, an explorer|Laroze, a bluecoat|Amancio, a deal broker|Fitz, a collector|Adelaide Phroaig, a noble|Rigney, a tavern owner

&d.contacts.smugglers [v(d.cgdb)]=Elynn, a dock worker|Rolan, a drug dealer|Sera, an arms dealer|Nyelle, a spirit trafficker|Decker, an anarchist|Esme, a tavern owner

&d.upgrades [v(d.cgdb)]=d.upgrades.lair d.upgrades.quality d.upgrades.training d.upgrades.assassins d.upgrades.bravos d.upgrades.cult d.upgrades.hawkers d.upgrades.shadows d.upgrades.smugglers

&d.upgrades.lair [v(d.cgdb)]=[ ] [ ] Carriage|[ ] [ ] Boat|[ ] [ ] Vehicle|[ ] Hidden|[ ] Quarters|[ ] [ ] Secure|[ ] [ ] Vault|[ ] Workshop

&d.upgrades.quality [v(d.cgdb)]=[ ] Documents|[ ] Gear|[ ] Implements|[ ] Supplies|[ ] Tools|[ ] Weapons

&d.upgrades.training [v(d.cgdb)]=[ ] Insight|[ ] Prowess|[ ] Resolve|[ ] Playbook|[ ]-[ ]-[ ]-[ ] Mastery

&d.upgrades.assassins [v(d.cgdb)]=[ ] Assassin rigging|[ ] Ironhook Contacts|[ ] Elite Skulks|[ ] Elite Thugs|[ ]-[ ]-[ ] Hardened

&d.upgrades.bravos [v(d.cgdb)]=[ ] Bravos rigging|[ ] Ironhook Contacts|[ ] Elite Rovers|[ ] Elite Thugs|[ ]-[ ]-[ ] Hardened

&d.upgrades.cult [v(d.cgdb)]=[ ] Cult rigging|[ ] Ritual sanctum in lair|[ ] Elite Adepts|[ ] Elite Thugs|[ ]-[ ]-[ ] Ordained

&d.upgrades.hawkers [v(d.cgdb)]=[ ] Hawker's rigging|[ ] Ironhook Contacts|[ ] Elite Rooks|[ ] Elite Thugs|[ ]-[ ]-[ ] Composed

&d.upgrades.shadows [v(d.cgdb)]=[ ] Thief rigging|[ ] Underground maps & passkeys|[ ] Elite Rooks|[ ] Elite Skulks|[ ]-[ ]-[ ] Steady

&d.upgrades.smugglers [v(d.cgdb)]=[ ] Smuggler's rigging|[ ] Camouflage|[ ] Elite Rovers|[ ] Barge|[ ]-[ ]-[ ] Steady

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Factions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.factions [v(d.cgdb)]=d.factions.criminal_underworld d.factions.city_institutions d.factions.labor_and_trade d.factions.citizenry d.factions.the_fringe

&d.factions.criminal_underworld [v(d.cgdb)]=The Unseen (IV)|The Hive (IV)|The Circle of Flame (III)|The Silver Nails (III)|Lord Scurlock (III)|The Crows (II)|The Lampblacks (II)|The Red Sashes (II)|The Dimmer Sisters (II)|The Grinders (II)|The Billhooks (II)|The Wraiths (II)|The Gray Cloaks (II)|Ulf Ironborn (I)|The Fog Hounds (I)|The Lost (I)

&d.factions.city_institutions [v(d.cgdb)]=Imperial Military (VI)|City Council (V)|Ministry of Preservation (V)|Leviathan Hunters (V)|Ironhook Prison (IV)|Sparkwrights (IV)|Spirit Wardens (IV)|Bluecoats (III)|Inspectors (III)|Iruvian Consulate (III)|Skovlan Consulate (III)|The Brigade (II)|Severosi Consulate (I)|Dagger Isles Consulate (I)

&d.factions.labor_and_trade [v(d.cgdb)]=The Foundation (IV)|Dockers (III)|Gondoliers (III)|Sailors (III)|Laborers (III)|Cabbies (II)|Cyphers (II)|Ink Rakes (II)|Rail Jacks (II)|Servants (II)|The Red Lamps (II)

&d.factions.citizenry [v(d.cgdb)]=Whitecrown (V)|Brightstone (IV)|Charterhall (IV)|Six Towers (III)|Barrowcleft (II)|Coalridge (II)|Crow's Foot (II)|The Docks (II)|Nightmarket (II)|Silkshore (II)|Charhollow (I)|Dunslough (I)

&d.factions.the_fringe [v(d.cgdb)]=The Church of Ecstasy (IV)|The Horde (III)|The Path of Echoes (III)|The Forgotten Gods (III)|The Reconciled (III)|Skovlander Refugees (III)|The Weeping Lady (II)|Deathlands Scavengers (II)

@@ The below are for use in determining which crime boss you pay for your hunting grounds. Do not add factions to these list unless they are crime bosses.

&d.Barrowcleft.factions [v(d.cgdb)]=The Brigade (II)|The Grinders (II)|Ministry of Preservation (V)

&d.Brightstone.factions [v(d.cgdb)]=The Church of Ecstasy (IV)|The Reconciled (III)|Sparkwrights (IV)

&d.Charhollow.factions [v(d.cgdb)]=Cabbies (II)|The Lost (I)|Skovlander Refugees (III)

&d.Charterhall.factions [v(d.cgdb)]=The Foundation (IV)|Leviathan Hunters (V)

&d.Coalridge.factions [v(d.cgdb)]=The Billhooks (II)|Rail Jacks (II)|Ulf Ironborn (I)

&d.Crow's_Foot.factions [v(d.cgdb)]=Bluecoats (III)|The Crows (II)|The Lampblacks (II)|The Red Sashes (II)

&d.The_Docks.factions [v(d.cgdb)]=Dockers (III)|The Gray Cloaks (II)|The Fog Hounds (I)|Ink Rakes (II)|Sailors (III)

&d.Dunslough.factions [v(d.cgdb)]=Deathlands Scavengers (II)|Ironhook Prison (IV)

&d.Nightmarket.factions [v(d.cgdb)]=Cyphers (II)|The Dimmer Sisters (II)|The Forgotten Gods (III)|The Path of Echoes (III)

&d.Silkshore.factions [v(d.cgdb)]=Gondoliers (III)|The Hive (IV)|The Silver Nails (III)|The Wraiths (II)|The Red Lamps (II)

&d.Six_Towers.factions [v(d.cgdb)]=The Circle of Flame (III)|Lord Scurlock (III)|The Unseen (IV)|The Weeping Lady (II)

&d.Whitecrown.factions [v(d.cgdb)]=City Council (V)|Imperial Military (VI)|Spirit Wardens (IV)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Cohort stats
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.cohort.stats [v(d.cgdb)]=Cohort Type|Edges|Flaws|Name|Specialty|Types

&d.cohort.addable_stats [v(d.cgdb)]=Edges|Flaws|Types

&d.value.cohort_type [v(d.cgdb)]=Expert|Gang|Vehicle

&d.value.types [v(d.cgdb)]=Adepts|Rooks|Rovers|Skulks|Thugs|Vehicle

&d.value.edges [v(d.cgdb)]=Fearsome|Independent|Loyal|Tenacious

&d.value.flaws [v(d.cgdb)]=Principled|Savage|Unreliable|Wild

&d.value.vehicle_types [v(d.cgdb)]=Vehicle

&d.value.vehicle_edges [v(d.cgdb)]=Nimble|Simple|Sturdy

&d.value.vehicle_flaws [v(d.cgdb)]=Costly|Distinct|Finicky
