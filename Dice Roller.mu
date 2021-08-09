/*
Requirements: byzantine-opal

Commands:
	+roll 4 - roll 4 dice
	+roll 0 - roll two and take the lowest
	+roll <action> - roll your <action> score
	+roll <attribute> - tells you how many stress you'll take for this resistance (since attributes are only used for resistance)

Aliases:
	+dice

Switches:
	/quiet - secretly roll something
	/page - roll it to another player
	/job - do we even want jobs? Hmm.
	/com - roll to a channel?

*/


@create Dice Roller <DR>=10
@set DR=SAFE INHERIT OPAQUE

@force me=@parent DR=[v(d.bf)]

@force me=&d.dr me=[search(ETHING=t(member(name(##), Dice Roller <DR>, |)))]

&tr.error [v(d.dr)]=@pemit %0=cat(alert(Error), %1);

&tr.message [v(d.dr)]=@pemit %0=cat(alert(Alert), %1);

&tr.success [v(d.dr)]=@pemit %0=cat(alert(Success), %1);

&layout.die-roll [v(d.dr)]=ansi(case(%0, 6, ch, 5, hg, 4, hg, xh), %0)

&layout.crit [v(d.dr)]=ansi(ch, critical success)

&layout.success [v(d.dr)]=ansi(ch, success)

&layout.mixed [v(d.dr)]=ansi(g, mixed)

&layout.failure [v(d.dr)]=ansi(r, failure)

&layout.dice_results [v(d.dr)]=strcat(alert(Dice), ulocal(f.get-name, %0) rolls %1 dice and gets, setq(S, setr(M, 0)), %b, iter(lnum(%1), strcat(ulocal(layout.die-roll, setr(R, die(1, 6))), case(%qR, 6, setq(S, add(%qS, 1)), 5, setq(M, add(%qM, 1)), 4, setq(M, add(%qM, 1))))), %,, %b, a result of, %b, case(1, gt(%qS, 1), ulocal(layout.crit), gt(%qS, 0), ulocal(layout.success), gt(%qM, 0), ulocal(layout.mixed), ulocal(layout.failure)), !)

&layout.dice_results-zero [v(d.dr)]=strcat(alert(Dice), ulocal(f.get-name, %0) rolls %1 dice and gets, setq(S, setr(M, setr(F, 0))), %b, iter(1 2, strcat(ulocal(layout.die-roll, setr(R, die(1, 6))), case(%qR, 6, setq(S, add(%qS, 1)), 5, setq(M, add(%qM, 1)), 4, setq(M, add(%qM, 1)), setq(F, add(%qF, 1))))), %,, %b, a result of, %b, case(1, gt(%qF, 0), ulocal(layout.failure), gt(%qM, 0), ulocal(layout.mixed), gt(%qS, 0), ulocal(layout.success)), !)

&c.+roll_number [v(d.dr)]=$+roll *:@assert isnum(%0); @assert gte(%0, 0)={ @trigger me/tr.error=%#, You must enter a number greater than or equal to zero.; }; @assert lte(%0, 10)={ @trigger me/tr.error=%#, You must enter a number less than or equal to ten.; }; @trigger me/tr.remit=%l, ulocal(layout.dice_results[case(%0, 0, -zero)], %#, %0), %#;

&c.+roll_text [v(d.dr)]=$+roll *:@assert not(isnum(%0)); @trigger me/tr.error=%#, Rolling stats doesn't work yet.; 

@tel [v(d.dr)]=#2
