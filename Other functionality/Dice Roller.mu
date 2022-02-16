/*
Requirements: byzantine-opal with channels auxillary functionality if you want rolling to channels to work. Has not been tested without channels code.

Commands:
	+roll 4 - roll 4 dice
	+roll 0 - roll two and take the lowest
	+roll Tier - roll your character's tier
	+roll Lifestyle - roll your character's lifestyle as a fortune roll
	+roll <action> - roll your <action> score
	+roll <attribute> - tells you how many stress you'll take for this resistance (since attributes are only used for resistance)

Aliases:
	+dice

Switches:
	/quiet <dice> - secretly roll something
	/page <name>=<dice> - roll it to another player
	/com <channel>=<dice> - roll to a channel
	/<channel> <dice> - roll to the channel
	/job <job>=<dice>

*/


@create Dice Roller <DR>=10
@set DR=SAFE INHERIT OPAQUE

@force me=@parent DR=[v(d.bf)]

@force me=&d.dr me=[search(ETHING=t(member(name(##), Dice Roller <DR>, |)))]

@force me=&d.jobs [v(d.dr)]=[search(ETHING=t(member(name(##), Job Global Object <JGO>, |)))]

@force me=&va [v(d.dr)]=[xget(search(ETHING=t(member(name(##), Job Global Object <JGO>, |))), va)]

@tel [v(d.dr)]=#2

&d.monitor-channel [v(d.dr)]=Monitor

@@ %0: player
@@ %1: message
&tr.alert-to-monitor [v(d.dr)]=@cemit [v(d.monitor-channel)]=[cat(ansi(xh, extract(prettytime(), 1, 2, /)), ansi(<#777777>, rest(prettytime())), ulocal(f.get-name, %0):, %1)];

@@ %0 - number of dice
@@ Output: Roll results|Successes|Mixed|Failures|Highest|Lowest
&f.roll-dice [v(d.dr)]=strcat(setq(S, setr(M, setr(F, setr(H, 0)))), setq(L, 6), iter(switch(%0, 0, 1 2, lnum(%0)), strcat(setr(R, die(1, 6)), case(1, gte(%qR, 6), setq(S, inc(%qS)), gte(%qR, 4), setq(M, inc(%qM)), setq(F, inc(%qF))), if(gt(%qR, %qH), setq(H, %qR)), if(lt(%qR, %qL), setq(L, %qR)))), |%qS|%qM|%qF|%qH|%qL)

&f.colorize-die-roll [v(d.dr)]=if(t(%1), iter(%0, ansi(case(itext(0), 6, ch, 5, hg, 4, hg, xh), itext(0))), edit(%0, lmin(%0), ansi(hg, lmin(%0))))

@@ %0 - player
@@ %1 - dice to roll
@@ %2 - stat to Roll
@@ %3 - is resistance roll
@@ %4 - destination
&layout.sentence [v(d.dr)]=squish(strcat(alert(Dice), %b, setq(R, ulocal(f.roll-dice, %1)), ulocal(layout.destination, %4, %0), %b, ulocal(f.get-name, %0) rolled, %b, if(t(%2), cat(poss(%0), %2%,, %1), %1), %b, plural(%1, die, dice)%, and got, %b, ulocal(f.colorize-die-roll, first(%qR, |), %1)., %b, ulocal(layout.[if(%3, resistance, result)], %1, %qR, %0)))

@@ %0 - number of dice
@@ %1 - roll results
&layout.result [v(d.dr)]=cat(This was a, ulocal(strcat(layout., if(gt(%0, 0), case(1, gt(extract(%1, 2, 1, |), 1), crit, gt(extract(%1, 2, 1, |), 0), success, gt(extract(%1, 3, 1, |), 0), mixed, failure), case(1, gte(last(%1, |), 6), success, gt(last(%1, |), 3), mixed, failure)))))

&layout.resistance [v(d.dr)]=ulocal(strcat(layout., if(gt(%0, 0), case(1, gt(extract(%1, 2, 1, |), 1), crit, normal), normal), _resistance), if(gt(%0, 0), extract(%1, 5, 1, |), last(%1, |)), %2)

@@ %0 - destination
@@ %1 - player
&layout.destination [v(d.dr)]=switch(%0, %1, To yourself:, loc(%1),, ulocal(f.find-player, %0, %1), cat(To, ulocal(f.get-name, %0):), if(cand(isdbref(%0), hastype(%0, THING)), cat(To, name(%0):), switch(%0, * *, cat(To, itemize(iter(%0, ulocal(f.get-name, itext(0)),, |), |):))))

&layout.crit [v(d.dr)]=ansi(ch, critical success)!

&layout.success [v(d.dr)]=ansi(ch, success)!

&layout.mixed [v(d.dr)]=ansi(g, mixed result).

&layout.failure [v(d.dr)]=ansi(r, failure).

&layout.crit_resistance [v(d.dr)]=cat(This was a, ansi(ch, critical success)%,, which allows, obj(%1), to clear a stress!)

&layout.normal_resistance [v(d.dr)]=case(sub(6, %0), 0, cat(capstr(subj(%1)), plural(%1, does, do), not need to spend stress.), cat(capstr(subj(%1)) must spend, ansi(ch, #$), stress.))

&f.can-roll-to-job [v(d.dr)]=cand(cor(isapproved(%0), isstaff(%0)), isdbref(%1), cor(cand(ulocal(%vA/is_public, %1), t(match(xget(%1, opened_by), %0))), ulocal(%vA/fn_myaccesscheck, parent(%1), %0, %1)), not(hasattr(%1, locked)))

&f.get-stat-value [v(d.dr)]=case(1, strmatch(%1, Tier), setq(A, ulocal(%2/f.get-player-stat-or-zero, %0, setr(W, Tier))), strmatch(%1, Lifestyle), setq(A, ulocal(%2/f.get-lifestyle, %0, setr(W, Lifestyle))), t(setr(W, ulocal(%2/f.is-action, %1))), setq(A, ulocal(%2/f.get-player-stat-or-zero, %0, %qW)), t(setr(W, ulocal(%2/f.is-attribute, %1))), setr(A, ulocal(%2/f.get-player-attribute, %0, %qW, setq(S, 1))))

&c.+roll [v(d.dr)]=$+roll* *: @eval strcat(setq(F, trim(edit(%0, /,))), setq(D, switch(%1, *=*, first(%1, =))), setq(R, switch(%1, *=*, rest(%1, =), %1)), switch(%qF, c*, setq(D, ulocal(v(d.channel-functions)/f.get-channel-name, %qD)), j*, setq(D, ulocal(%vA/fn_find-job, %qD))), if(not(t(%qD)), setq(D, switch(%qF, q*, %#, if(t(%qF), ulocal(v(d.channel-functions)/f.get-channel-name, %qF, setq(F, com)), loc(%#)))))); @assert t(%qD)={ @trigger me/tr.error=%#, Could not figure out where to send the roll.; }; @eval if(cand(not(isdbref(%qD)), not(strmatch(%qF, c*))), setq(D, iter(%qD, if(t(setr(P, ulocal(f.find-player, itext(0), %#))), %qP, setq(E, %qE|[itext(0)]))))); @assert not(t(%qE))={ @trigger me/tr.error=%#, Could not find player(s) [itemize(trim(%qE, b, |), |)].; }; @eval setq(E, switch(%qF, j*, if(not(ulocal(f.can-roll-to-job, %#, %qD)), Could not find the job you wish to roll to. You might not have entered it correctly%, or you may not have access.))); @assert not(t(%qE))={ @trigger me/tr.error=%#, %qE; }; @assert t(setr(C, v(d.chargen-functions)))={ @trigger me/tr.error=%#, Rolling stats is not set up yet.; }; @eval if(not(isint(%qR)), u(f.get-stat-value, %#, %qR, %qC)); @assert not(t(setr(E, if(isint(%qR), if(cor(lt(%qR, 0), gt(%qR, 10)), You cannot roll a number greater than 10 or less than 0., setq(A, %qR)), if(not(cand(t(%qW), t(strlen(%qA)))), Could not find a stat you can roll starting with '%qR'.)))))={ @trigger me/tr.error=%#, %qE; }; @assert t(setr(X, ulocal(layout.sentence, %#, %qA, %qW, %qS, %qD)))={ @trigger me/tr.error=%#, Could not roll dice for some reason. Got %qX.; }; @trigger me/tr.alert-to-monitor=%#, edit(%qX, cat(alert(Dice), ulocal(f.get-name, %#), r), R); @assert switch(%qF, q*, 0, p*, 0, 1)={ @trigger me/tr.pemit=%qD %#, %qX, %#; }; @assert switch(%qF, j*, 0, 1)={ @trigger %vA/trig_add=%qD, %qX, %#, ADD; @trigger me/tr.pemit=%#, %qX, %#; }; @assert not(t(%qF))={ @force %#={ +com/emit %qD=%qX; }; }; @trigger me/tr.remit-or-pemit=%qD, %qX, %#;

&c.+dice [v(d.dr)]=$+dice*: @force %#={ +roll%0 };
