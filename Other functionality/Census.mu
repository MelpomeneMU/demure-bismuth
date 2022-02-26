/*
Things to add to the census:
	Playbook
	Crew type
	Bio fields
	Gender: Ambiguous or Concealed|Female|Male
*/

@create Census Functions <CF>=10
@set CF=SAFE INHERIT
@force me=&d.cf me=[num(CF)]

@force me=@parent [v(d.cf)]=[v(d.bf)]

@create Census Commands <CC>=10
@set CC=SAFE INHERIT OPAQUE
@parent CC=CF
@force me=&d.cc me=[num(CC)]

@tel [v(d.cf)]=[v(d.cc)]
