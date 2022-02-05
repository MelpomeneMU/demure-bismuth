
&f.get-harm-field [v(d.cgf)]=case(%1, 3, if(hasattr(%0, _health-4), #-1 DEAD CHARACTER, if(hasattr(%0, _health-3), _health-4, _health-3)), case(strcat(hasattr(%0, _health-%1-1), hasattr(%0, _health-%1-2)), 00, _health-%1-1, 10, _health-%1-2, ulocal(f.get-harm-field, %0, add(%1, 1))))

&f.get-highest-health-level [v(d.cgf)]=trim(iter(4 3 2-2 2-1 1-2 1-1, if(hasattr(%0, _health-[itext(0)]), strcat(_health-, itext(0)))))

&layout.harm [v(d.cgf)]=cat(alert(Health), ulocal(f.get-name, %0), inflicted a, %chlevel %1%cn, harm on, obj(%0)self, called, %ch%2%cn., ulocal(layout.health-status, %0, %1, %2))

&layout.harm-text [v(d.cgf)]=if(hasattr(%0, _health-%1), cat(indent()-, xget(%0, _health-%1), strcat(%(, Level, %b, first(%1, -), %,, %b, switch(%1, 4, catastrophic%, permanent consequences, 3, needs help or to spend stress to act, 2*, -1 die to related rolls, less effect in related rolls), %))))

&layout.health-status [v(d.cgf)]=strcat(setq(H, squish(trim(iter(4 3 2-2 2-1 1-2 1-1, ulocal(layout.harm-text, %0, itext(0)),, |), b, |), |)), cat(capstr(subj(%0)), if(t(%qH), strcat(plural(%0, is, are), %b, suffering from the following ailments:, %r, edit(%qH, |, %r)), plural(%0, is, are) perfectly healthy.)))

&c.+health [v(d.cg)]=$+health:@pemit %#=ulocal(layout.subsection, health, %#, %#, 1)

&c.+harm [v(d.cg)]=$+harm *:@eval setq(L, if(isnum(first(edit(%0, L,))), strcat(first(edit(%0, L,)), setq(D, rest(%0))), if(isnum(last(edit(%0, L,))), strcat(last(edit(%0, L,)), setq(D, revwords(rest(revwords(%0))))), strcat(1, setq(D, %0))))); @assert t(match(1 2 3, %qL))={ @trigger me/tr.error=%#, You can only suffer a level 1%, 2%, or 3 harm.; }; @assert t(%qD)={ @trigger me/tr.error=%#, You must enter a description of the harm.; }; @assert t(setr(F, ulocal(f.get-harm-field, %#, %qL)))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences.; }; @assert cor(not(strmatch(%qF, _health-4)), gettimer(%#, health-doom, %qD))={ @eval settimer(%#, health-doom, 600, %qD); @trigger me/tr.message=%#, Taking this level of harm will have catastrophic%, permanent consequences for your character. Are you sure? If yes%, send %ch+harm %0%cn again within 10 minutes. The time is now [prettytime()].; }; @set %#=%qF:%qD; @set %#=_health-clock:[setq(C, xget(%#, _health-clock))]; @if t(%qC)={ @trigger me/tr.message=%#, Because you have taken harm%, your healing clock has been reset from %qC to 0.; }; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.harm, %#, %qL, %qD), %#; @assert t(ulocal(f.get-harm-field, %#, %qL))={ @trigger  me/tr.remit-or-pemit=%L, cat(alert(Health), ulocal(f.get-name, %#) has taken all available levels of harm and has suffered catastrophic%, permanent consequences.), %#; @trigger %vA/trig_create=%#, xget(%vD, d.characters-bucket), 1, cat(Max Harm:, ulocal(f.get-name, %#)), cat(ulocal(f.get-name, %#), has taken the maximum possible level of harm and this will have catastrophic consequences%, such as limb loss or sudden death.); };

&c.+hurt [v(d.cg)]=$+hurt *: @force %#=+harm %0;

&c.+heal [V(d.cg)]=$+heal*:@break strmatch(%0, th); @trigger me/tr.error=%#, Healing costs downtime. +dt/recover <#> to spend downtime and roll to heal.;

