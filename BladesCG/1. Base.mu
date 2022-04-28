@create Chargen Database <CGDB>=10
@set CGDB=SAFE

@create Chargen Functions <CGF>=10
@set CGF=SAFE INHERIT
@force me=@parent CGF=[v(d.bf)]

@create Chargen Commands <CGC>=10
@set CGC=SAFE INHERIT
@parent CGC=CGF

@force me=&d.cg me=[search(ETHING=t(member(name(##), Chargen Commands <CGC>, |)))]
@force me=&d.cgf me=[search(ETHING=t(member(name(##), Chargen Functions <CGF>, |)))]
@force me=&d.cgdb me=[search(ETHING=t(member(name(##), Chargen Database <CGDB>, |)))]

@force me=&d.chargen-functions [v(d.bd)]=[v(d.cgf)]

@force me=&vG [v(d.cgf)]=[v(d.cgdb)]

@force me=&vA [v(d.cgf)]=[xget(search(ETHING=t(member(name(##), Job Global Object <JGO>, |))), va)]

@@ Characters bucket - expected to be named CHARACTERS
@force me=&d.characters-bucket [v(d.cgdb)]=[search(ETHING=t(member(name(##), CHARACTERS, |)))]

@@ CG bucket - expected to be named CG
@force me=&d.CG-bucket [v(d.cgdb)]=[search(ETHING=t(member(name(##), CG, |)))]

@@ CREW bucket - expected to be named CREW
@force me=&d.CREW-bucket [v(d.cgdb)]=[search(ETHING=t(member(name(##), CREW, |)))]

&tr.error [v(d.cg)]=@pemit %0=cat(alert(Error), %1);

&tr.message [v(d.cg)]=@pemit %0=cat(alert(Alert), %1);

&tr.success [v(d.cg)]=@pemit %0=cat(alert(Success), %1);

@tel [v(d.cgdb)]=[v(d.cgf)]
@tel [v(d.cgf)]=[v(d.cg)]
@tel [v(d.cg)]=[config(master_room)]
