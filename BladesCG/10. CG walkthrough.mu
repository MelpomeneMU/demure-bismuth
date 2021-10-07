@@ Make sure this is the room you want your CG to be in!
@tel #0

+dig Character Generation
@wait 1=cg
@wait 2=&short-desc here=A place for working on characters. All chat goes to the Chargen channel.
@wait 2=@desc here=%R%TWelcome to character creation! If you're an old hand at this, you don't have to be in here - the commands work from anywhere on the game. In case you need a refresher, though, the main command is %ch+stat/set <stat>=<value>%cn, and you can view your progress with %ch+sheet%cn. Use +sheet/all to see the whole sheet, but be warned, it's spammy!%R%R%TIf you need help at any point, type %chcg/on%cn and then %chcg <your question>%cn and people will give you a hand.%R%R%TIf you're brand new at this, we have two walkthroughs: Expert and Scoundrel. %chExperts%cn are very basic characters with few stats. They can go on Scores, help with rolls, and assist their friends. Experts can become Scoundrels later, but they can't gain XP or Coin until they do. %chScoundrels%cn are full-fledged characters with sheets, actions, details, and the ability to gain XP, Coin, and Gear.%R%R%TAny chat in this room goes to the Chargen channel. Please keep it on topic!%R
@wait 2=@force me=&d.cgr me=num(here);

+dig Expert
@wait 1=e
@wait 2=@name here=Chargen Walkthrough - Expert Type
@wait 2=@name O=Back <O>\;o\;out\;exi\;back\;b\;
@wait 2=@set here=INHERIT;
@wait 2=&vD here=[v(d.cgdb)]
@wait 2=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 2=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 2=@desc here=%R%TBecoming an Expert starts with choosing your Expert Type. Below is a list of available Expert Types, which are "jobs" your character performs in-game.%R%R%[multicol(xget(%%vD, d.value.expert_type), * * *, 0, |, getremainingwidth(%%#), 1)%]%R%R%T%ch+stat/set Expert Type=<your choice>%cn and hit Next!%R%R%TAll conversation in this room goes to the Chargen channel.%R


+dig Character Type
@wait 1=@name CT=Character Type <Next>\;ct\;char\;next\;n\;
@wait 2=n
@wait 3=@name here=Chargen Walkthrough - Character Type
@wait 3=@name O=Back <O>\;o\;out\;exit\;back\;b\;
@wait 3=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 3=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 3=@desc here=%R%TCharacter type should be a sentence or three at the most, explaining a little about the character. Details are not needed, just the broad strokes. Here's an example: A swashbuckling pirate from the Dagger Isles who leads a crew of misfits!%R%R%T%ch+stat/set Character Type=<short explanation of your character type>%cn and hit Next!%R%R%TAll conversation in this room goes to the Chargen channel.%R


+dig Details
@wait 1=@name D=Details <Next>\;d\;details\;next\;n\;
@wait 2=n
@wait 3=@name here=Chargen Walkthrough - Details
@wait 3=@name O=Back <O>\;o\;out\;exit\;back\;b\;
@wait 3=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 3=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 3=@desc here=%R%TNow it's time to set a few details about your character.%R%R%T%ch+stat/set Look=<your short description>%cn%R%R%T%ch@desc me=<your normal description>%cn - does not need to be long! Use %%%%R to create a line break and %%%%T to indent.%R%R%TOptional: %ch+stat/set Name=<your character's full name>%cn%R%R%TOnce those are set, type %ch+stats/lock%cn and you will be ready for approval!%R%R%TAll conversation in this room goes to the Chargen channel.%R
@wait 3=@open Limbo <OOC>\;ooc\;next\;n\;=#0


o

+dig Scoundrel <S>
@wait 1=s
@wait 2=@name here=Chargen Walkthrough - Playbook
@wait 2=@set here=INHERIT;
@wait 2=@name O=Back <O>\;o\;out\;exi\;back\;b\;
@wait 2=&vF here=[v(d.cgf)]
@wait 2=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 2=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 2=@desc here=%R%TYour playbook represents your character's reputation in the underworld, their special abilities, and how they advance. While we don't make strong use of playbooks in this game, a playbook can be an easy way to focus on what your character is good at and what you expect them to do during a score.%R%R%[multicol(ulocal(%%vF/f.get-choice-list, Playbook, %%#), * * *, 0, |, getremainingwidth(%%#), 1)%]%R%R%TTo select your playbook, type %ch+stat/set Playbook=<your choice>%cn.%[if(t(setr(R, ulocal(%%vF/f.list-restricted-values, Playbook, %%#))), cat(%R%R%TThe following are restricted and are not currently available:, itemize(%%qR, |).))%]%R%R%TYou do not have to choose one of the playbooks above - you can set your playbook to any non-restricted text. Try to keep it brief - it will have to fit on your sheet, after all.%R%R%TAll chat in this room goes to the Chargen channel.%R

+dig Biographical Information
@wait 1=@name bi=Biographical Information <Next>\;bio\;bi\;next\;n\;
@wait 2=bi
@wait 3=@name here=Chargen Walkthrough - Biographical Information
@wait 3=@set here=INHERIT;
@wait 3=&vF here=[v(d.cgf)]
@wait 3=@name O=Back <O>\;o\;out\;exit\;back\;b\;
@wait 3=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 3=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 3=@desc here=%R%TNext, you'll want to fill out your biographical information. This is the basic stat Those fields are:%R%R%[multicol(iter(remove(remove(ulocal(%%vF/f.get-player-bio-fields, %%#), Playbook, |), Crew, |), itext(0)|%[ulocal(%%vF/f.get-field-note, itext(0))%], |, |), 20 *, 0, |, getremainingwidth(%%#), 1)%]%R%R%TTo set each field, type %ch+stat/set <field>=<your choice>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R


+dig Actions
@wait 1=@name A=Actions <Next>\;a\;actions\;next\;n\;
@wait 2=n
@wait 3=@name here=Chargen Walkthrough - Actions
@wait 3=@set here=INHERIT;
@wait 3=&vF here=[v(d.cgf)]
@wait 3=@name O=Back <O>\;o\;out\;exit\;back\;b\;
@wait 3=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 3=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 3=@desc here=%R%TIt's time to fill in your Actions. You get 7 dots of Actions. None can be greater than 2 right now. Available actions are:%R%R%[multicol(fliplist(ulocal(%%vF/f.list-actions), 3, |), * * *, 0, |, getremainingwidth(%%#), 1)%]%R%R%TTo set each field, type %ch+stat/set <field>=<0, 1, or 2>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R


+dig Special Abilities
@wait 1=@name SA=Special Abilities <Next>\;sa\;special\;spec\;abilities\;next\;n\;
@wait 2=n
@wait 3=@name here=Chargen Walkthrough - Special Abilities
@wait 3=@set here=INHERIT;
@wait 3=&vF here=[v(d.cgf)]
@wait 3=@name O=Back <O>\;o\;out\;exit\;back\;b\;
@wait 3=&d.redirect-poses.[num(here)] [v(d.bd)]=Chargen
@wait 3=&short-desc here=All chat in this room goes to the Chargen channel.
@wait 3=@desc here=%R%TYou start play with one Special Ability. You can choose your special ability from any non-restricted playbook. To keep it simple%, here are :%R%R%[multicol(fliplist(ulocal(%%vF/f.get-abilities), 3, |), * * *, 0, |, getremainingwidth(%%#), 1)%]%R%R%TTo set each field, type %ch+stat/set <field>=<0, 1, or 2>%cn.%R%R%TAll chat in this room goes to the Chargen channel.%R

