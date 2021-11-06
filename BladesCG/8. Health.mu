
&f.get-harm-field [v(d.cgf)]=case(%1, 3, if(hasattr(%0, _health-4), #-1 DEAD CHARACTER, if(hasattr(%0, _health-3), _health-4, _health-3)), case(strcat(hasattr(%0, _health-%1-1), hasattr(%0, _health-%1-2)), 00, _health-%1-1, 10, _health-%1-2, ulocal(f.get-harm-field, %0, add(%1, 1))))

&f.get-highest-health-level [v(d.cgf)]=trim(iter(4 3 2-2 2-1 1-2 1-1, if(hasattr(%0, _health-[itext(0)]), strcat(_health-, itext(0)))))

&layout.harm [v(d.cgf)]=cat(alert(Health), ulocal(f.get-name, %0), inflicted a, %chlevel %1%cn, harm on, obj(%0)self, called, %ch%2%cn., ulocal(layout.health-status, %0, %1, %2))

&layout.harm-text [v(d.cgf)]=if(hasattr(%0, _health-%1), cat(indent()-, xget(%0, _health-%1), strcat(%(, Level, %b, first(%1, -), %,, %b, switch(%1, 4, catastrophic%, permanent consequences, 3, needs help or to spend stress to act, 2*, -1 die to related rolls, less effect in related rolls), %))))

&layout.health-status [v(d.cgf)]=strcat(setq(H, squish(trim(iter(4 3 2-2 2-1 1-2 1-1, ulocal(layout.harm-text, %0, itext(0)),, |), b, |), |)), cat(capstr(subj(%0)), if(t(%qH), strcat(plural(%0, is, are), %b, suffering from the following ailments:, %r, edit(%qH, |, %r)), is perfectly healthy.)))

&layout.heal [v(d.cgf)]=squish(strcat(alert(Health), %b, ulocal(f.get-name, %0), %b, adds %ch%1%cn ticks to, %b, poss(%0), %b, healing clock, if(t(%2), cat(%,, removing, itemize(%ch%2%cn, |))), %b, and setting the clock to, %b, default(%#/_health-clock, 0)/4, ., %b, ulocal(layout.health-status, %0, %1, %2)))

&c.+health [v(d.cg)]=$+health:@pemit %#=ulocal(layout.subsection, health, %#, %#, 1)

&c.+harm [v(d.cg)]=$+harm *:@eval strcat(setq(L, edit(first(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, edit(last(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, 1), setq(D, %0)), setq(D, revwords(rest(revwords(%0)))))), setq(D, rest(%0)))); @assert t(match(1 2 3, %qL))={ @trigger me/tr.error=%#, You can only suffer a level 1%, 2%, or 3 harm.; }; @assert t(%qD)={ @trigger me/tr.error=%#, You must enter a description of the harm.; }; @assert t(setr(F, ulocal(f.get-harm-field, %#, %qL)))={ @trigger me/tr.error=%#, Your character has taken all available levels of harm and has suffered catastrophic%, permanent consequences.; }; @set %#=%qF:%qD; @set %#=_health-clock:[setq(C, xget(%#, _health-clock))]; @if t(%qC)={ @trigger me/tr.message=%#, Because you have taken harm%, your healing clock has been reset from %qC to 0.;  }; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.harm, %#, %qL, %qD), %#; @assert t(ulocal(f.get-harm-field, %#, %qL))={ @trigger  me/tr.remit-or-pemit=%L, cat(alert(Health), ulocal(f.get-name, %#) has taken all available levels of harm and has suffered catastrophic%, permanent consequences.), %#; };

&c.+hurt [v(d.cg)]=$+hurt *: @force %#=+harm %0;

&c.+heal [V(d.cg)]=$+heal*:@break match(%0, th); @eval setq(L, if(t(%0), trim(%0), 1)); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, You must enter either 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, revwords(ulocal(f.get-highest-health-level, %#))))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot heal.; }; @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), 4)]; @eval setq(H, iter(extract(%qF, 1, div(%qT, 4)), xget(%#, itext(0)),, |)); @eval iter(%qH, iter(%qF, set(%#, strcat(itext(0), :, xget(%#, extract(%qF, inc(inum(0)), 1))))), |); @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, %qH, t(ulocal(f.get-highest-health-level, %#))), %#;
