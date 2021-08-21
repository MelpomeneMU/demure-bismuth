@create Crew Database <CrewDB>=10
@set CrewDB=SAFE

@create Crew Functions <CF>=10
@set CF=SAFE INHERIT

@create Crew Commands <CC>=10
@set CC=SAFE INHERIT
@parent CC=CF

@force me=&d.cc me=[search(ETHING=t(member(name(##), Crew Commands <CC>, |)))]
@force me=&d.cf me=[search(ETHING=t(member(name(##), Crew Functions <CF>, |)))]
@force me=&d.cd me=[search(ETHING=t(member(name(##), Crew Database <CrewDB>, |)))]

@force me=@parent [v(d.cd)]=[v(d.cgdb)]

@force me=@parent [v(d.cf)]=[v(d.cgf)]

@force me=&vD [v(d.cf)]=[v(d.cd)]

&tr.error [v(d.cc)]=@pemit %0=cat(alert(Error), %1);

&tr.message [v(d.cc)]=@pemit %0=cat(alert(Alert), %1);

&tr.success [v(d.cc)]=@pemit %0=cat(alert(Success), %1);

@tel [v(d.cd)]=[v(d.cf)]
@tel [v(d.cf)]=[v(d.cc)]
@tel [v(d.cc)]=#2

&c.+crew/found [v(d.cc)]=$+crew/found *:@assert isapproved(%#)={ @trigger me/tr.error=%#, You must be approved to found a crew.; }; @assert not(t(ulocal(f.get-player-stat, %0, crew object)))={ @trigger me/tr.error=%#, You are currently part of a crew. You must leave it before you can found your own. Please +crew/leave your current crew.; }; @assert t(%0)={ @trigger me/tr.error=%#, Please enter a crew name for the crew you wish to found.; }; @assert t(setr(O, create(%0, 10)))={ @trigger me/tr.error=%#, Could not create a crew object with the name '%0'. Perhaps that's a bad name for an object?; }; @set %qO=[ulocal(f.get-stat-location-on-player, founded)]:[prettytime()] by [ulocal(f.get-name, %#)] %(%#%); @set %#=[ulocal(f.get-stat-location-on-player, crew object)]:%qO; @set %#=[ulocal(f.get-stat-location-on-player, crew)]:%0; @set %qO=[ulocal(f.get-stat-location-on-player, crew name)]:%0; @set %vD=crew.%qO:%0; @tel %qO=%vD; @trigger me/tr.success=%#, You founded a new crew called '%0'. Hit +crew to take a look!;

