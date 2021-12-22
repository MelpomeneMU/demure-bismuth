@@ This must be entered via an /import or other call which puts a 1-second delay between each entry. The reason for this is that the digger takes a second to actually build the rooms when using +dig.

@@ Make sure this is the room you want your CG to be in!

&d.cg_parent_room me=#0
&d.parent_room_exit_name me=Limbo <OOC>;next;nex;ne;n;ooc

@force me=@tel [v(d.cg_parent_room)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Main CG room
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+dig Character Generation

cg

@name here=Character Generation

&short-desc here=A place for working on characters. All chat goes to the Chargen channel.

@desc here=%R%TWelcome to character creation! If you're an old hand at this, you don't have to be in here - the commands work from anywhere on the game. In case you need a refresher, though, the main command is %ch+stat/set <stat>=<value>%cn, and you can view your progress with %ch+sheet%cn. Use +sheet/all to see the whole sheet, but be warned, it's spammy!%R%R%TIf you need help at any point, type %chcg/on%cn and then %chcg <your question>%cn and people will give you a hand.%R%R%TIf you're brand new at this, we have two walkthroughs: Expert and Scoundrel. %chExperts%cn are very basic characters with few stats. They can go on Scores, help with rolls, and assist their friends. Experts can become Scoundrels later, but they can't gain XP or Coin until they do. %chScoundrels%cn are full-fledged characters with sheets, actions, details, and the ability to gain XP, Coin, and Gear.%R%R%TAny chat in this room goes to the Chargen channel. Please keep it on topic!%R

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

&vD here=[v(d.cgdb)]

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

@force me=@open [v(d.parent_room_exit_name)]=[v(d.cg_parent_room)]

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

@desc here=%R%TYou start play with one Special Ability. You can choose your special ability from any non-restricted playbook. 

[if(t(finditem(xget())))] To keep it simple%, here are the abilities from your chosen playbook:%R%R[multicol(fliplist(ulocal(%vF/f.get-player-abilities, %#), 3, |), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo select a special ability, type %ch+stat/set Special Ability=<ability>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

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

&vD here=[v(d.cgdb)]

@name O=Back <O>;o;out;exit;back;b;

&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen

&short-desc here=All chat in this room goes to the Chargen channel.

@desc here=%R%TYou get XP when you roleplay your XP Triggers during a job. You can see your XP Triggers with %ch+sheet/xp%cn.%R%R%TYou can change your XP triggers with %ch+stat/set XP Triggers=<playbook name>%cn. Here's the full list:%R%R[multicol(iter(ulocal(%vF/f.get-choice-list, XP Triggers, %#), strcat(itext(0), |, xget(%vD, strcat(d.xp_triggers., edit(itext(0), %b, _)))), |, |), 10 *, 0, |, getremainingwidth(%#), 1)]%R%R%TYou can skip this step if you like, and your XP Triggers will be set to your Playbook's triggers.%R%R%TAll chat in this room goes to the Chargen channel.%R

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

@desc here=%R%TLook over your +sheet one more time with %ch+sheet/all%cn and see if anything looks incomplete.%R%RStaff will be looking for:%R%T* Does your character fit into the theme OK?%R%T* Desc can't be underage.%R%T* Desc should be at least one (relevant) sentence long.%R%T* Anything missing? Any red on the sheet check?%R%R%TWhen you're sure you're ready, type %ch+stat/lock%cn to lock your sheet and notify staff that you're ready for approval. There might still be changes, but staff will work those out with you.%R%R%TAll chat in this room goes to the Chargen channel.%R

+note/add here/Crew=%R%TCrews are not mandatory, but they do give you extra power. You can join a crew or make your own.%R%TIf you want to join an existing crew, ask around on the LFG channel (%chlfg/on%cn) or check out the Crews board (%ch+bbread Crews%cn).%R%TIf you're interested in creating your own crew - and no, you don't need other players to join you, and you can always join a different crew later! - head back into CG and visit the %chCrew Creation%cn walkthrough.%R

+note/approve here/Crew

@force me=@open [v(d.parent_room_exit_name)]=[v(d.cg_parent_room)]

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

@desc here=%R%TYou don't HAVE to join a crew, but if you do, you'll be more powerful and you'll have a group to back you up. (Plus, you get cool stats!)%R%TTo join an existing crew, you need an invitation. You can get one by going to the LFG (Looking For Group) channel - %chlfg/on%cn - and asking around, or checking out the Crews board - %ch+bbread Crews%cn, and following the instructions on the posts there.%R%TIf you don't see a crew that fits your character, you can make one. Solo crews are a thing, and they can indeed be fun. The crew is assumed to have NPCs who are members of the crew but don't grant it any mechanical benefits, and you can spend XP on more useful members and groups of members. Once you have a crew, you can invite others to join it.%R%TTo get started making your own crew, %ch+stat/set Crew=<Crew name>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

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

@desc here=%R%TFirst, you'll need to pick a crew type:%R%R[multicol(ulocal(%vF/f.get-choice-list, crew type, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo choose your crew type, type %ch+stat/set crew type=<your choice>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

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

@desc here=%R%TYour crew's reputation is how you do business. Select from the following list:%R%R[multicol(ulocal(%vF/f.get-choice-list, reputation, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo choose your crew rep, type %ch+stat/set reputation=<your choice>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

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

@desc here=%R%TYour crew's lair is where they sleep, where they hide out, and where they keep their stuff. It should be a short description with a little flavor, such as "An abandoned theater in Nightmarket" or "A dilapidated manor near the good side of town". No need to get too specific.%R%R%TTo set your crew's lair, type %ch+stat/set lair=<short description>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

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

@desc here=%R%TYour crew's special abilities are granted to every member of the crew. Some abilities add extra dice; some grant special powers. You can choose abilities from any crew type, not just your own crew type, but to keep things simple, here are the special abilities available to your Crew Type:%R%R[multicol(ulocal(%vF/f.get-player-crew-abilities, %#), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set your crew's ability, type %ch+stat/set Crew Ability=<your choice>%cn. If you skip this step, the first item on the list will be selected by default.%R%R%TAll chat in this room goes to the Chargen channel.%R


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

@desc here=%R%TUpgrades are features of your crew:%R%R[multicol(ulocal(%vF/f.get-choice-list, upgrades), * * *, 0, |, getremainingwidth(%#), 1)]%R%R%TTo set your crew's ability, type %ch+stat/set Crew Ability=<your choice>%cn. If you skip this step, the first item on the list will be selected by default.%R%R%TAll chat in this room goes to the Chargen channel.%R

