&layout.harm [v(d.cgf)]=cat(alert(Health), ulocal(f.get-name, %0), inflicted a, %chlevel %1%cn, harm on, obj(%0)self, called, %ch%2%cn.)

&layout.heal [v(d.cgf)]=squish(cat(alert(Health), ulocal(f.get-name, %0), adds %ch%1%cn ticks to, poss(%0), healing clock%,, if(t(%2), cat(removing, itemize(%ch%2%cn, |)%,)), if(%3, but, and), subj(%0), switch(subj(%0), they, are, is), ansi(h, if(%3, still injured, fully healed).)))


&c.+health [v(d.cg)]=$+health:@pemit %#=ulocal(layout.subsection, health, %#, %#, 1)

&c.+harm [v(d.cg)]=$+harm *:@eval strcat(setq(L, edit(first(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, edit(last(%0), L,)), if(not(isnum(%qL)), strcat(setq(L, 1), setq(D, %0)), setq(D, revwords(rest(revwords(%0)))))), setq(D, rest(%0)))); @assert t(match(1 2 3, %qL))={ @trigger me/tr.error=%#, You can only suffer a level 1%, 2%, or 3 harm.; };  @assert t(%qD)={ @trigger me/tr.error=%#, You must enter a description of the harm.; }; @assert t(setr(F, ulocal(f.get-harm-field, %#, %qL)))={ @trigger me/tr.error=%#, Your character is out of the scene and cannot be further harmed.; }; @set %#=%qF:%qD; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.harm, %#, %qL, %qD), %#;

&c.+heal [v(d.cg)]=$+heal*:@break match(%0, th); @eval setq(L, if(t(%0), trim(%0), 1)); @assert t(member(1 2 3 5, %qL))={ @trigger me/tr.error=%#, You must enter either 1%, 2%, 3%, or 5 ticks to add to your healing clock.; }; @assert t(setr(F, ulocal(f.get-highest-health-level, %#)))={ @trigger me/tr.error=%#, You aren't currently wounded and cannot heal.; }; @set %#=_health-clock:[mod(setr(T, add(default(%#/_health-clock, 0), %qL)), 4)]; @eval setq(H, iter(extract(%qF, 1, div(%qT, 4)), xget(%#, itext(0)),, |)); @set %#=if(gte(div(%qT, 4), 1), first(%qF)):; @set %#=if(gte(div(%qT, 4), 2), first(rest(%qF))):; @trigger me/tr.remit-or-pemit=%L, ulocal(layout.heal, %#, %qL, %qH, t(ulocal(f.get-highest-health-level, %#))), %#;
