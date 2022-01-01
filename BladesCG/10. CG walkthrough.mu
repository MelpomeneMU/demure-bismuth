@@ This must be entered via an /import or other call which puts a 1-second delay between each entry. The reason for this is that the digger takes a second to actually build the rooms when using +dig.

@@ Make sure this is the room you want your CG to be in!

&d.cg_parent_room me=#0
&d.parent_room_exit_name me=Limbo <OOC>;next;nex;ne;n;ooc

@force me=@tel [v(d.cg_parent_room)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Open +channels up so people working on crews can make channels
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@force me=&vF [v(d.chf)]=[v(d.cgf)]

&f.can-create-channels [v(d.chf)]=or(isstaff(%0), and(not(hasflag(%0, GUEST)), lt(words(xget(%0, _channels-created)), xget(%vD, d.max-player-channels)), cor(hasflag(%0, APPROVED), t(ulocal(%vF/f.get-player-stat, %0, crew object)))))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Main CG room
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Character Generation

cg

@name here=Character Generation

&short-desc here=A place for working on characters. All chat goes to the Chargen channel.

@desc here=%R%TWelcome to character creation! If you're an old hand at this, you don't have to be in here - the commands work from anywhere on the game. In case you need a refresher, though, the main command is %ch+stat/set <stat>=<value>%cn, and you can view your progress with %ch+sheet%cn. Use +sheet/all to see the whole sheet, but be warned, it's spammy!%R%R%TIf you need help at any point, type %chcg/on%cn and then %chcg <your question>%cn and people will give you a hand.%R%R%TIf you're brand new at this, we have two walkthroughs: Expert and Scoundrel.%R%R%T%chExperts%cn are a simpler type of character with a narrower focus and none of the more complicated mechanics of Scoundrels. They progress based on their Crew's Tier, rather than gaining experience. An Expert can have any specialty you could imagine someone in Doskvol having: bartender, medium, aristocrat, dockworker, or even thief or bravo. Experts can become Scoundrels later, but they can't gain XP or Coin until they do.%R%R%T%chScoundrels%cn are full-fledged characters with sheets, actions, details, and the ability to gain XP, Coin, and Gear.%R%R%TAny chat in this room goes to the Chargen channel. Please keep it on topic!%R

@force me=&d.cgr me=num(here);



@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Different CG walkthroughs
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Expert

+dig Scoundrel

+dig Crew Creation

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Expert walkthrough
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

e

@name here=Chargen - Expert Walkthrough - Expert Type

@name O=Back <O>;o;out;exi;back;b;

@set here=INHERIT

@force me=&vD here=[v(d.cgdb)]

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TBecoming an Expert starts with choosing your Expert Type. Below is a list of available Expert Types, which are "jobs" your character performs in-game.%R%R[multicol(xget(%vD, d.value.expert_type), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%T%ch+stat/set Expert Type=<your choice>%cn and hit Next!%R%R%TAll conversation in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Expert walkthrough - Character Type
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Character Type

@name CT=Character Type <Next>;ct;char;next;n;

n

@name here=Chargen - Expert Walkthrough - Character Type

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TCharacter type should be a sentence or three at the most, explaining a little about the character. Details are not needed, just the broad strokes. Here's an example: A swashbuckling pirate from the Dagger Isles who leads a crew of misfits!%R%R%T%ch+stat/set Character Type=<short explanation of your character type>%cn and hit Next!%R%R%TAll conversation in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Expert walkthrough - Details
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Details

@name D=Details <Next>;d;details;next;n;

n

@name here=Chargen - Expert Walkthrough - Details

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TNow it's time to set a few details about your character.%R%R%T%ch+stat/set Look=<your short description>%cn%R%R%T%ch@desc me=<your normal description>%cn - does not need to be long! Use %%R to create a line break and %%T to indent.%R%R%TOptional: %ch+stat/set Name=<your character's full name>%cn%R%R%TOnce those are set, type %ch+stats/lock%cn and you will be ready for approval!%R%R%TAll conversation in this room goes to the Chargen channel.%R

@force me=@open [escape(v(d.parent_room_exit_name))]=[v(d.cg_parent_room)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@force me=@tel [v(d.cgr)];

s

@name here=Chargen - Scoundrel Walkthrough - Playbook

@set here=INHERIT

@name O=Back <O>;o;out;exi;back;b;

@force me=&vF here=[v(d.cgf)]

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour playbook represents your character's reputation in the underworld, their special abilities, and how they advance. A playbook can be an easy way to focus on what your character is good at and what you expect them to do during a score.%R%R[multicol(ulocal(%vF/f.get-choice-list, Playbook, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo select your playbook, type %ch+stat/set Playbook=<your choice>%cn.[if(t(setr(R, ulocal(%vF/f.list-restricted-values, Playbook, %#))), cat(%R%R%TThe following are restricted and are not currently available:, itemize(%qR, |).))]%R%R%TNote: You don't have to stick with the defaults of your playbook at all - in fact, you can switch them up as you please. Instructions for how to do so will be further along in this walkthrough.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Biographical information
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Biographical Information

@name bi=Biographical Information <Next>;bio;bi;next;n;

n

@name here=Chargen - Scoundrel Walkthrough - Biographical Information

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TNext, you'll want to fill out your biographical information. This is the basic stat Those fields are:%R%R[multicol(iter(setdiff(ulocal(%vF/f.get-player-bio-fields, %#), Playbook|Crew|Expert Type|Character Type, |, |), itext(0)|[ulocal(%vF/f.get-field-note, itext(0))], |, |), 20 *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set each field, type %ch+stat/set <field>=<your choice>%cn.%R%R%TWhile you're at it, set your description with %ch@desc me=<your description>%cn - use %%R for line breaks and %%T to indent. It doesn't need to be long.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Actions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Actions

@name A=Actions <Next>;a;actions;next;n;

n

@name here=Chargen - Scoundrel Walkthrough - Actions

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TIt's time to fill in your Actions. You get 7 dots of Actions. None can be greater than 2 right now. Available actions are:%R%R[multicol(fliplist(ulocal(%vF/f.list-actions), 3, |), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set each field, type %ch+stat/set <field>=<0, 1, or 2>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Special Abilities
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Special Abilities

@name SA=Special Abilities <Next>;sa;special;spec;abilities;next;n;

n

@name here=Chargen - Scoundrel Walkthrough - Special Abilities

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYou start play with one Special Ability. You can choose your special ability from any non-restricted playbook. To keep it simple%, here are the abilities from your chosen playbook:%R%R[multicol(fliplist(ulocal(%vF/f.get-player-abilities, %#), 3, |), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo select a special ability, type %ch+stat/set Special Ability=<ability>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Friends
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Friends

@name f=Friends <Next>;f;fr;fri;friend;friends;next;n;

n

@name here=Chargen - Scoundrel Walkthrough - Friends

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TEvery character comes with some friends already built in. These are NPCs that are shared across the whole game - everyone has access to them. This is intentional - it gives you a pre-built connection with other players who run in similar circles to yours. You can see your Friends list with %ch+sheet/friends%cn.%R%R%TYou don't have to keep the list of Friends that comes with your Playbook, but if you want to, head on into the next room.%R%R%TTo change your Friends list, type %ch+stat/set Friends=<your choice>%cn, where your choice is from the following list:%R%R[multicol(ulocal(%vF/f.get-choice-list, Friends, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Ally
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Ally

@name a=Ally <Next>;a;al;all;ally;next;n;

n

@name here=Chargen - Scoundrel Walkthrough - Ally

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour Ally is someone within your group of friends who sees things the way you do and wants to see you succeed. They may offer you a discount for their services, do you favors, or slip you secrets on the sly. Choose someone from your list of friends to be your Ally:%R%R[multicol(ulocal(%vF/f.get-player-stat, %#, Friends), *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set your ally, type %ch+stat/set Ally=<your choice>%cn. Note: You cannot have the same person for your Ally and your Rival.%R%R%TYou can also skip this step, and your Ally will be set to the first person on this list.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Rival
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Rival

@name r=Rival <Next>;r;ri;riv;riva;rival;next;n;

n

@name here=Chargen - Scoundrel Walkthrough - Rival

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour Rival is someone who, for whatever reason, has it out for you. They probably won't go out of their way to do you harm, but they might spread rumors, charge you extra for their services, pass your secrets on to the wrong person, and so on. Choose someone from your list of friends to be your Rival:%R%R[multicol(ulocal(%vF/f.get-player-stat, %#, Friends), *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set your rival, type %ch+stat/set Rival=<your choice>%cn. Note: You cannot have the same person for your Ally and your Rival.%R%R%TYou can skip this step if you like. If you do, your Rival will be set to the last person on this list.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Gear
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Gear

@name g=Gear <Next>;g;ge;gea;gear;next;n;

N

@name here=Chargen - Scoundrel Walkthrough - Gear

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TGear is the equipment you have access to when you're on a job. By default, your playbook's gear will be available to you, but you can change this if it doesn't suit your character.%R%R%TTo select a different playbook's gear, type %ch+stat/set Gear=<your choice>%cn, where your choice comes from the following list:%R%R[multicol(ulocal(%vF/f.get-choice-list, Gear, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TYou can skip this step if you're happy with your playbook's default gear. You can see your gear list with %ch+sheet/gear%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - XP Triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig XP Triggers

@name xt=XP Triggers <Next>;xt;xp;xp triggers;triggers;next;n;

N

@name here=Chargen - Scoundrel Walkthrough - XP Triggers

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@force me=&vD here=[v(d.cgdb)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYou get XP when you roleplay your XP Triggers during a job. You can see your XP Triggers with %ch+sheet/xp%cn.%R%R%TYou can change your XP triggers with %ch+stat/set XP Triggers=<playbook name>%cn. Here's the full list:%R%R[multicol(iter(ulocal(%vF/f.get-choice-list, XP Triggers, %#), strcat(itext(0), |, xget(%vD, strcat(d.xp_triggers., ulocal(%vF/f.get-stat-location, itext(0))))), |, |), 10 *, 0, |, getremainingwidth(%#), 1)]%R%R%TYou can skip this step if you like, and your XP Triggers will be set to your Playbook's triggers.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Scoundrel walkthrough - Finishing Touches
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Finishing Touches

@name ft=Finishing Touches <Next>;ft;fin;finish;next;n;

N

@name here=Chargen - Scoundrel Walkthrough - Finishing Touches

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TLook over your +sheet one more time with %ch+sheet/all%cn and see if anything looks incomplete.%R%RStaff will be looking for:%R%T* Does your character fit into the theme OK?%R%T* Desc can't be underage.%R%T* Desc should be at least one (relevant) sentence long.%R%T* Anything missing? Any [ulocal(%vF/layout.fail)] marks on the CG check?%R%R%TWhen you're sure you're ready, type %ch+stat/lock%cn to lock your sheet and notify staff that you're ready for approval. There might still be changes, but staff will work those out with you.%R%R%TAll chat in this room goes to the Chargen channel.%R

+note/add here/Crew=%R%TCrews are not mandatory, but they do give you extra power. You can join a crew or make your own.%R%TIf you want to join an existing crew, ask around on the LFG channel (%chlfg/on%cn) or check out the Crews board (%ch+bbread Crews%cn).%R%TIf you're interested in creating your own crew - and no, you don't need other players to join you, and you can always join a different crew later! - head back into CG and visit the %chCrew Creation%cn walkthrough.%R

+note/approve here/Crew

@force me=@open [escape(v(d.parent_room_exit_name))]=[v(d.cg_parent_room)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@force me=@tel [v(d.cgr)];

CC

@name here=Chargen - Crew Creation Walkthrough

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TIf you're here, we assume you want to create a crew. If you just want to join one, log on to the LFG (Looking For Group) channel - %chlfg/on%cn - and ask around, or check out the Crews board - %ch+bbread Crews%cn, to see who's recruiting. Now, on to the crew creation process!%R%R%TCrew creation is a bit more involved than regular Scoundrel creation because it's designed to be done by multiple people.%R%R%TStep 1 is to come up with a name and %ch+crew/create <name>%cn. Don't worry, you can change it later.%R%R%TStep 2 is to invite your crew mates to help you out with this process - %ch+crew/invite <name>%cn. (If you're doing a solo crew, that's fine! See %ch+note here/Solo%cn.)%R%R%TStep 3 is optional: consider starting a channel for your crew with %ch+channel/create <crew name>=<description>%cn so you can all join that channel and talk this stuff over and make decisions as a group.%R%R%TWhen you're ready, proceed to the Next room to get started on mechanical stuff.%R%R%TAll chat in this room goes to the Chargen channel.%R

+note/add here/Solo Crews=%R%TSolo crews are a thing, and they are not limited in any way beyond their member count. You get to customize your crew to exactly your character's goals and preferences. All the scores you go on earn XP for your crew and other players who join later can keep it going well past the life of your character.%R%TSolo crews are not just you working alone - you'll have NPC crew members to work with, though they won't provide mechanical benefits unless you buy them as Cohorts with Upgrades.%R%TYou don't have to be the leader of your solo crew - you can just be another crew member, though you're assumed to be probably the most competent member of the crew thanks to your Scoundrel stats. (Unless you're an Expert, in which case the crew just doesn't have any Scoundrels - which is also fine!)%R%TYou can invite others to join your crew at any time. There's no difference between a solo crew and a normal crew aside from the resources the crew can bring to bear in Scoundrels and Experts, AKA members.%R

+note/public here/Solo

+note/approve here/Solo

+note/add here/NPC Crew Members=%R%TAll crews are assumed to have NPCs who are members of the crew but don't grant it any mechanical benefits, and you can spend Upgrades on Cohorts, which are named NPC Experts and Gangs who support your crew.%R%TSometimes NPC crew members become PC crew members - a player wants to turn a Cohort Expert or member of a Gang into a real character. In the case of a Gang, there is no change to the crew's sheet - the Gang Cohort is still there, and is just assumed to include this PC. If the Cohort was an Expert, they are removed from the crew's sheet and the crew gets those Upgrades back to spend on something else, since this Expert is now a full-fledged player who can make their own choices.%R%TExpert players can become Cohorts if the crew has the Advancements to pay for it. For this to happen, the Expert player must be retired and must give consent for their character to be used in this way.%R

+note/public here/NPC

+note/approve here/NPC

+note/add here/Crew Membership=%R%TYou can invite anyone to join your crew at any time. Before the crew is approved, any member can invite additional members and boot existing members.%R%TWhen the crew is approved, its existing members become the established membership of the crew, and any new members become Probationary members for the first 45 days.%R%TEstablished crew members can invite new members and boot Probationary members. You'll have to get staff involved if you want to boot an established member of the crew, though.%R

+note/public here/Crew

+note/approve here/Crew

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Crew Type
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Crew Type

@name ct=Crew Type <Next>;ct;crew;type;next;n;

n

@name here=Chargen - Crew Creation - Crew Type

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TDecide what kind of crew you want to be. Available crew types are:%R%R[multicol(ulocal(%vF/f.get-choice-list, crew type, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TWhen you're ready, type %ch+stat/set crew type=<your choice>%cn.%R%R%TCrew Type just sets the defaults for the kind of crew you are and the sorts of scores you do - if you're Smugglers, you're more likely to go on travelling scores than sneak around killing people. You still might take scores involving killing people, but that's probably not your main modus operandi. You might find as you go through this process that your crew wants to be something else, and that's fine - Crew Type can be changed at any point.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Reputation
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Crew Reputation

@name cr=Crew Reputation <Next>;cr;crew;rep;next;n;

n

@name here=Chargen - Crew Creation - Crew Reputation

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour crew's reputation is how you do business. It's also how your crew earns XP, so you should choose something that the whole crew is on board with. (If you choose Professional and one of your crew members wants to do Uncontrollable, you're going to have a hard time earning that XP!)%R%R%THere's a list of suggestions, or you can enter your own:%R%R[multicol(ulocal(%vF/f.get-choice-list, reputation, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo choose your crew rep, type %ch+stat/set reputation=<any short text>%cn.%R%R%TCrew Reputation can change over time. If you burn down a lot of buildings, your rep might become "Firebugs", for example. If you think your Rep should change once your crew is approved, put in a job with staff.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Lair
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Crew Lair

@name cl=Crew Lair <Next>;cl;cr;crew;lair;next;n;

n

@name here=Chargen - Crew Creation - Lair

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour crew's lair is where they sleep, where they hide out, and where they keep their stuff.%R%R%TFirst, choose a District for your Lair. (You can move later if you decide you want to - just open a job with staff.) %ch+stat/set Lair District=<yours>%cn. Available districts are [itemize(ulocal(%vF/f.list-values, Lair District), |)].%R%R%TNext, describe your lair in a short phrase, for example "An abandoned theater" or "The back room of a Sparkwright's shop". Feel free to get creative, but try to keep it short. %ch+stat/set Lair=<short description>%cn when you're ready.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Hunting Grounds
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Hunting Grounds

@name hg=Hunting Grounds <Next>;hg;hunt;hunting;hunting grounds;next;n;

n

@name here=Chargen - Crew Creation - Hunting Grounds

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour crew's Hunting Grounds are where they perform most of their Scores. Pick a district for your Hunting Grounds: %ch+stat/set Hunting Grounds=<district>%cn. Available districts are [itemize(ulocal(%vF/f.list-values, Lair District), |)].%R%R%TOnce you've chosen your district, you'll need to choose the faction whose territory you're in. If you look at %ch+factions%cn, you'll see several marked with a %ch%cy*%cn yellow star. Those are factions in your Hunting Grounds district. Choose one of them with %ch+faction/set Hunting=<faction>%cn.%R%R%TBecause you're operating in their territory, they start off a bit annoyed with you - Status [ulocal(%vF/f.get-faction-status-color, -1)]. You can choose to pay them Coin to make them happier - +1 per Coin. Your crew has 2 Coins to spend on keeping various factions happy with you during Character Creation. To pay them off and get on their good side, %ch+faction/pay Hunting=0, 1, or 2%cn.%R%R%TWhichever faction you chose will be expecting you to pay them a tithe as long as you do Scores in their territory.%R%R%TAll chat in this room goes to the Chargen channel.%R

+note/add here/Coin=%R%TCoin can be spent during Character Creation or saved for later, after the crew is approved. The average Score provides a return of 4-6 Coin, so you will earn more as long as you do Scores. Feel free to go through Character Creation without spending Coin, but if you do spend it all, you'll earn it back quickly.%R%TIn Character Creation, Coin is spent solely on making the various Factions you start out with like you more. You can appease or buy Status with 3 different Factions in total, and you only have 2 Coin, so someone's bound to be left disliking your crew. That's OK and expected.%R%TYou can find more info about Coin on page 42.%R

+note/public here/Coin

+note/approve here/Coin

+note/add here/Status=%R%THere's what the various Faction Status levels mean:%R%R%ch%cg+3%cn: Allies. This faction will help you even if it's not in their best interest to do so. They expect you to do the same for them.%R%cc+2%cn: Friendly. This faction will help you if it doesn't create serious problems for them. They expect you to do the same.%R%cc+1%cn: Helpful. This faction will help you if it causes no problems or significant cost for them. They expect the same from you.%R%ch+0%cn: Neutral%R%ch%cy-1%cn: Interfering. This faction will look for opportunities to cause trouble for you (or profit from your misfortune) as long as it causes no problems or significant cost for them. They expect the same from you.%R%ch%cy-2%cn: Hostile. This faction will look for opportunities to hurt you as long as it doesn't create serious problems for them. They expect you to do the same, and take precautions against you.%R%ch%cr-3%cn: War. This faction will go out of its way to hurt you even if it's not in their best interest to do so. They expect you to do the same, and take precautions against you.%R

+note/public here/Status

+note/approve here/Status

+note/add here/Tithe=%R%TYour crew's Hunting Grounds faction expects to be paid a Tithe with every Score you go on as long as it takes place in their territory. This continues until your crew reaches a Tier equal to the level of the Hunting Grounds faction.%R%TThe amount of the Tithe will be your crew's %chTier+1 in Coin%cn per Score.%R%TYour crew can choose not to pay the Tithe. This can have consequences in play, such as lowered status with this faction.%R

+note/public here/Tithe

+note/approve here/Tithe


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Crew Abilities
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Crew Abilities

@name ca=Crew Abilities <Next>;ca;cr;crew;abilities;next;n;

n

@name here=Chargen - Crew Creation - Crew Abilities

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour crew's special abilities are granted to every member of the crew. Some abilities add extra dice; some grant special powers. You can choose any Crew Ability you like, but to keep things simple, here are the iconic abilities available to yours:%R%R[multicol(ulocal(%vF/f.get-player-crew-abilities, %#), * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set your crew's ability, type %ch+stat/set Crew Ability=<your choice>%cn. If you're not sure what to pick, leave it alone - the default is the first item on the list, and it's usually a very good choice.%R%R%TAll chat in this room goes to the Chargen channel.%R


@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Crew Upgrades
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Crew Upgrades

@name cu=Crew Upgrades <Next>;cu;cr;crew;upgrades;up;upgrade;next;n;

n

@name here=Chargen - Crew Creation - Crew Upgrades

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TUpgrades make a crew unique. You have 4 Upgrade points to distribute on your sheet. Upgrade points are also used for creating Cohorts, 2 per Cohort, so if your crew wants Cohorts instead, save your points. Here are the default Upgrades:%R%R[ulocal(%vF/layout.crew-upgrades, %#, setr(W, getremainingwidth(%#)))]%r[footer(,%qW)]%R%R%T%ch+stat/add Upgrade=<upgrade>%cn to choose your upgrades.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Cohorts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Cohorts

@name c=Cohorts <Next>;c;co;cohort;cohorts;next;n;

n

@name here=Chargen - Crew Creation - Cohorts

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TA Cohort is an NPC which helps the crew out on Scores and can, with the right Crew Abilities, become quite powerful.%R%R%TIf you'd like to create a Cohort, get started with %ch+cohort/create <name>=<type>%cn. Available Cohort Types are [itemize(ulocal(%vF/f.list-cohort-stat-pretty-values, Cohort Type), |)]. (Vehicle is only available if you have the Crew Ability "Like Part of the Family".)%R%R%TOnce your Cohort is created, add 1-2 Edges and Flaws to it with %ch+cohort/add Edge=<edge>%cn and %ch+cohort/add Flaw=<flaw>%cn. Edges and Flaws must balance out, and you must have 1-2 of them for the Cohort to be considered valid.%R%R%TIf you're creating an Expert Cohort, %ch+cohort/set Specialty=<what they do>%cn. Try to keep this text to 1-2 words - they do one thing and they do it well.%R%R%TYou can check your cohorts at any time with %ch+cohorts%cn. Cohorts cost 2 Upgrade points apiece, and you can add additional Types to them for another 2 Upgrade points.%R%R%TIf you're not creating a Cohort right now, feel free to move on to the Next room.%R%R%TAll chat in this room goes to the Chargen channel.%R

l

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Upgrade Factions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Upgrade Factions

@name uf=Upgrade Factions <Next>;uf;up;upgrade;next;n;

n

@name here=Chargen - Crew Creation - Upgrade Factions

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TNow that you've chosen your Upgrades, think about where you got them from. Everything comes from somewhere - how did you get it? Did someone help you steal it? Did they throw it away, only to find out it was worth something after all? Regardless of how you got it, two of the city's many factions were involved.%R%R%TWho helped you get one of your Upgrades?%R%R%T%ch+faction/set Helped=<faction>%cn - they think highly of your crew, or they wouldn't have helped out - your crew starts out at %cc+1%cn Status with them. Did the crew repay their kindness? %ch+faction/pay Helped=0 or 1%cn to increase your crew's Status with them by +1 per Coin.%R%R%TWho was harmed when you acquired one of your Upgrades?%R%R%T%ch+faction/set Harmed=<faction>%cn - they're a bit angry at your crew, so the crew starts out at %ch%cy-2%cn Status with them. Did the crew spend Coin to pacify them? %ch+faction/pay Harmed=0 or 1%cn to bring that status closer to Neutral.%R%R%TAll chat in this room goes to the Chargen channel.%R

+note/add here/Status=%R%THere's what the various Faction Status levels mean:%R%R%ch%cg+3%cn: Allies. This faction will help you even if it's not in their best interest to do so. They expect you to do the same for them.%R%cc+2%cn: Friendly. This faction will help you if it doesn't create serious problems for them. They expect you to do the same.%R%cc+1%cn: Helpful. This faction will help you if it causes no problems or significant cost for them. They expect the same from you.%R%ch+0%cn: Neutral%R%ch%cy-1%cn: Interfering. This faction will look for opportunities to cause trouble for you (or profit from your misfortune) as long as it causes no problems or significant cost for them. They expect the same from you.%R%ch%cy-2%cn: Hostile. This faction will look for opportunities to hurt you as long as it doesn't create serious problems for them. They expect you to do the same, and take precautions against you.%R%ch%cr-3%cn: War. This faction will go out of its way to hurt you even if it's not in their best interest to do so. They expect you to do the same, and take precautions against you.%R

+note/public here/Status

+note/approve here/Status

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Contacts
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Contacts

@name c=Contacts <Next>;c;con;contact;contacts;next;n;

n

@name here=Chargen - Crew Creation - Contacts

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TEvery crew comes with built-in contacts. New ones can be gained in play, but these form the core of your starting group. You'll notice these are the same for every Crew Type, and there's a reason for that - people who run in the same circles know the same people, and it gives you a pre-built connection with other players.%R%R%TYour starting Contact list is determined by your Crew Type. If you want to change it, you can %ch+stat/set Contacts=<a different Crew Type>%cn. You can see your contacts list with %ch+crew/Contacts%cn.%R%R%TSelect one of those Contacts to be your crew's Favorite Contact with %ch+stat/set Favorite=<name>%cn, or you can leave it at the default.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Factions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Factions

@name f=Factions <Next>;f;fa;fac;fact;faction;factions;next;n;

n

@name here=Chargen - Crew Creation - Factions

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TIt's time to choose two more factions. These ones are Friendly or Unfriendly to your crew for whatever reason. Maybe they don't like your Favorite Contact. Maybe one of your Cohorts did a favor for them before they worked for you. Maybe they just don't like your crew and you don't know why. Regardless, pick two from the %ch+factions%cn list.%R%R%T%ch+faction/set Friendly=<faction>%cn - who likes your crew?%R%R%T%ch+faction/set Unfriendly=<faction>%cn - who doesn't like your crew?%R%R%TAt your option, you can intensify both relationships from a %ch%cy-1%cn and %cc+1%cn to a %ch%cy-2%cn and %cc+2%cn, just %ch+faction/boost%cn. If you change your mind, you can use %ch+faction/unboost%cn to bring them back down to the standard levels.%R%R%TThese factions can't be bought with +faction/pay - their animosity or adoration are for reasons that money can't help.%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Crew XP Triggers
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Crew XP Triggers

@name cxt=Crew XP Triggers <Next>;cxt;crew;xp;triggers;cx;ct;xt;xp;next;n;

n

@name here=Chargen - Crew Creation - Crew XP Triggers

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@force me=&vD here=[v(d.cgdb)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYour crew can choose an XP Trigger that fits its essential nature with %ch+stat/set Crew XP Triggers=<choice>%cn. By default, it's set to whatever your Crew Type's XP Triggers are. In case you want to make changes, here's the full list:%R%R[multicol(iter(ulocal(%vF/f.get-choice-list, Crew XP Triggers, %#), strcat(itext(0), |, xget(%vD, strcat(d.crew_xp_triggers., ulocal(%vF/f.get-stat-location, itext(0)))), |%b|), |, |), 10 *, 0, |, getremainingwidth(%#), 1)]%R%R%TAll chat in this room goes to the Chargen channel.%R

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew Creation Walkthrough - Wrapping Up
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Wrapping Up

@name wu=Wrapping Up <Next>;wu;wrap;wrapup;up;next;n;

n

@name here=Chargen - Crew Creation - Wrapping Up

@set here=INHERIT

@force me=&vF here=[v(d.cgf)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYou should have a pretty good crew setup by now. Check %ch+crew/all%cn to see your crew sheet and make any last minute changes you may need before you request crew approval.%R%R%TStaff will be looking for:%R%R%T* Any arbitrary text that doesn't fit the theme of the game.%R%T* Any [ulocal(%vF/layout.fail)] marks on your +crew sheet.%R%R%TWhen you're sure you're done, hit %ch+crew/lock%cn and staff will be notified that your crew is ready for approval.%R%R%TAll chat in this room goes to the Chargen channel.%R

@force me=@open [escape(v(d.parent_room_exit_name))]=[v(d.cg_parent_room)]
