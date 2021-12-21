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

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Data for chargen
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.manual-bio-stats [v(d.cgdb)]=Expert Type|Character Type|Look

&d.sheet-sections [v(d.cgdb)]=Page1|Page2|Bio|Actions|Abilities|Health|Pools|XP Triggers|Friends|Gear|Projects|Notes|Crew

&d.bio [v(d.cgdb)]=Name|Alias|Playbook|Crew|Heritage|Background|Vice|Age|Look

&d.expert_bio [v(d.cgdb)]=Name|Alias|Crew|Expert Type|Character Type|Age|Look

&d.bio.hull [v(d.cgdb)]=Frame Size|Primary Drive|Secondary Drive|Tertiary Drive

&d.bio.hull.exclude [v(d.cgdb)]=Vice

&d.bio.vampire [v(d.cgdb)]=Telltale

&d.bio.vampire.exclude [v(d.cgdb)]=Vice

&d.crew_bio [v(d.cgdb)]=Crew Name|Crew Type|Reputation|Lair

&d.attributes [v(d.cgdb)]=Insight|Prowess|Resolve

&d.actions.insight [v(d.cgdb)]=Hunt|Study|Survey|Tinker

&d.actions.prowess [v(d.cgdb)]=Finesse|Prowl|Skirmish|Wreck

&d.actions.resolve [v(d.cgdb)]=Attune|Command|Consort|Sway

&d.actions [v(d.cgdb)]=Hunt|Study|Survey|Tinker|Finesse|Prowl|Skirmish|Wreck|Attune|Command|Consort|Sway

&d.abilities [v(d.cgdb)]=d.abilities.cutter d.abilities.hound d.abilities.leech d.abilities.lurk d.abilities.slide d.abilities.spider d.abilities.whisper

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

&d.stats_editable_after_chargen [v(d.cgdb)]=Name|Alias|Look

&d.standard_gear [v(d.cgdb)]=1L A blade or two|1L Throwing knives|1L A pistol|1L A second pistol|2L A large weapon|1L An unusual weapon|2L Armor|3L Heavy Armor (requires Armor)|1L Burglary Gear|2L Climbing gear|1L Arcane implements|1L Documents|1L Subterfuge supplies|2L Demolition tools|1L Tinkering tools|1L Lantern|0L Spiritbane charm

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Valid values for various stats - * means write your own
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.value.expert_type [v(d.cgdb)]=Apothecary|Assassin|Beggar|Blood Dealer|Bounty Hunter|Chemist|City Clerk|Cold Killer|Corpse Thief|Drug Dealer|Extortionist|Gang Leader|Information Broker|Jail-Bird|Locksmith|Master Architect|Noble|Phsysicker|Priestess|Prostitute|Psychonaut|Pugilist|Sentinel|Servant|Spirit Trafficker|Spy|Tavern Owner|Vicious Thug|Witch

&d.value.playbook [v(d.cgdb)]=Cutter|Hound|Leech|Lurk|Slide|Spider|Whisper|Ghost|Hull|Vampire

&d.value.age [v(d.cgdb)]=Young Adult|Adult|Mature|Elderly

&d.value.load [v(d.cgdb)]=Light|Normal|Heavy|Encumbered

&d.value.crew_type [v(d.cgdb)]=Assassins|Bravos|Cult|Hawkers|Shadows|Smugglers

&d.value.reputation [v(d.cgdb)]=Ambitious|Brutal|Daring|Honorable|Professional|Savvy|Subtle|Strange

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
@@ Restricted values at character generation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.restricted.playbook [v(d.cgdb)]=Ghost|Hull|Vampire

&d.restricted.action [v(d.cgdb)]=3|4|5

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Text for the chooser
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.choose-sections [v(d.cgdb)]=Special Abilities|XP Triggers|Gear|Friends|Ally|Rival|Crew Ability|Favorite

&d.choosable-stats [v(d.cgdb)]=Special Ability|Friends|Ally|Rival|Gear|XP Triggers|Favorite|Crew Ability

&d.addable-stats [v(d.cgdb)]=Special Ability|Friend|Ally|Rival|Crew Ability

&d.crew-choose-sections [v(d.cgdb)]=

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Data about the game.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.districts [v(d.cgdb)]=Barrowcleft: Residences and markets for the farmers who work the fields and eeleries.|Brightstone: The grand mansions and luxury shops of the wealthy elite.|Charhollow: A crowded district of tenements and stacked houses.|Charterhall: The city's civic offices and the hub for shops, artisans, and commerce.|Coalridge: The remnants of Doskvol's original hilltop mining settlement, now home to laborers and industrial factories.|Crow's Foot: A cramped neighborhood of multi-level streets, ruled by gangs.|The Docks: Rough taverns, tattoo parlors, fighting pits, and warehouses.|Dunslough: A labor camp served by convicts and a ghetto for the destitute poor.|Nightmarket: The trade center for exotic goods imported by rail. Many vendors also trade in illicit goods.|Silkshore: The "red lamp district" and artist community.|Six Towers: A formerly rich district, now worn down and dilapidated.|Whitecrown: The sprawling estates of the Lord Governor, Hunter Commander, Master Warden, and Doskvol Academy.

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
