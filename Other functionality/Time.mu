/*
For a calendar with holidays:

https://www.reddit.com/r/bladesinthedark/comments/k58fc9/about_holidays_in_doskvol/

https://i.imgur.com/lvkIT8e.png

And maybe weather. Events like "cold" and "fog" and "drizzle", etc.

*/

@create Time Clock <TC>=10
@set TC=SAFE INHERIT OPAQUE

@force me=@parent TC=[v(d.bf)]

@force me=&d.tc me=[num(TC)]

@tel [v(d.tc)]=[config(master_room)]

@@ How fast does time flow? Greater than 1 means fater than real life time. Less than 1 means slower.
&d.time-ratio [v(d.tc)]=1.33

@@ Set the starting time for the first year, beginning in winter. Change this date if you want a different starting time.
@force me=&d.start-date [v(d.tc)]=[convtime(Jan 01 00:00:00 2022)]

&f.get-ic-time [v(d.tc)]=round(add(mul(v(d.time-ratio), sub(secs(), v(d.start-date))), v(d.start-date)), 0)

&f.get-day-of-year [v(d.tc)]=div(mod(%0, 31104000), 86400)

&f.get-day-of-week [v(d.tc)]=switch(mod(%0, 6), 0, Market Day because public traders put out a new selection of wares for the coming week, 1, Home Day in Crow's Foot because prisoners are released from Ironhook Prison on this day, 2, Comission Day on the Docks because new ships launch on this day due to an ancient superstition, 3, Requiem in Charterhall because wills and testaments are traditionally prosecuted on this day, 4, Dust Day in Charhollow because the food begins to run out, Carillon in Brightstone for the operas and symphonies performed weekly on this day)

&f.get-month [v(d.tc)]=switch(%0, >300, Elisar, >240, Volnivet, >180, Ulsivet, >120, Suran, >60, Kalivet, Mendar)

&f.get-day-of-month [v(d.tc)]=mod(%0, 60)

&f.get-ordinal [v(d.tc)]=strcat(%0, if(cand(gt(%0, 10), lt(%0, 20)), th, case(mid(%0, sub(strlen(%0), 1), 1), 1, st, 2, nd, 3, rd, th)))

&f.get-hour [v(d.tc)]=div(mod(%0, 86400), 3600)

&f.get-season [v(d.tc)]=strcat(It is, %b, switch(%0, Mendar, cat(winter, switch(%1, >30, but the wind off the ocean holds the promise of spring, and the air is quiet and still save for the distant cracking of the ice on the ocean)), Kalivet, cat(spring, switch(%1, >30, and the few remaining plants have begun to grow%, not that anyone ever sees them, but the storms off the black sea still bring winter's chill)), Suran, cat(spring, switch(%1, >30, and the stormy air could almost qualify as muggy%, but never becomes warm enough to threaten summer, and the few remaining plants revel in their short time for growth%, while violent storms occasionally wash the Shattered Isles)), Ulsivet, cat(autumn, switch(%1, >30, but life clings tenaciously despite the oncoming chill, but the winds of spring still gust occasionally%, blasting the Shattered Isles with stormy ferocity)), Volnivet, cat(autumn, switch(%1, >30, and the few remaining plants are now lifeless husks%, failing to sprout even moss, and the winds have finally begun to die down as the distant parts of the ocean become icy and still)), cat(winter, switch(%2, >30, and even the ocean is still%, the ice reaching closer to the shore each year, and a few of the lesser canals are frozen%, creating temporary (and dangerous) skating parks. The world hunkers down and bundles up to avoid the cold))), .)

&f.get-hour-name [v(d.tc)]=switch(%0, 18, Hour of Honor (6pm to 7pm), 19, Hour of Song (7pm to 8pm), 20, Hour of Silver (8pm to 9pm), 21, Hour of Thread (9pm to 10pm), 22, Hour of Flame (10pm to 11pm), 23, Hour of Pearls (11pm to midnight), 0, Hour of Silk (midnight to 1am), 1, Hour of Wine (1am to 2am), 2, Hour of Ash (2am to 3am), 3, Hour of Coal (3am to 4am), 4, Hour of Chains (4am to 5am), 5, Hour of Smoke (5am to 6am), strcat(ulocal(f.get-ordinal, sub(%0, 5)) hour, %b, %(, switch(%0, >12, sub(%0, 12)pm, 12, noon, %0am) to, %b, switch(inc(%0), >12, sub(inc(%0), 12)pm, 12, noon, inc(%0)am)%)))

@@ The Hour of Silk (midnight to 1am)
&hour.desc.0 [v(d.tc)]=The pleasure-houses and vice dens are taking customers and coin as the world strives to forget.

@@ The Hour of Wine (1am to 2am)
&hour.desc.1 [v(d.tc)]=Let the wine flow freely and the hour grow late!

@@ The Hour of Ash (2am to 3am)
&hour.desc.2 [v(d.tc)]=The bars are closing, woe, woe! The night preys upon those who linger.

@@ The Hour of Coal (3am to 4am)
&hour.desc.3 [v(d.tc)]=One must rise in the night to add coal to the fire, lest the house freeze. Some are still feeding coal to empty fireplaces, though they froze to death long ago.

@@ The Hour of Chains (4am to 5am)
&hour.desc.4 [v(d.tc)]=It is widely whispered that when prisoners are taken from Ironhook Prison for whatever unknown purpose, they move in the wee hours of the morning.

@@ The Hour of Smoke (5am to 6am)
&hour.desc.5 [v(d.tc)]=The early morning fog has just begun to rise in the hour before dawn. Soon travel will become difficult as the sun rises and the fog burns red.

@@ The 1st hour (6am to 7am)
&hour.desc.6 [v(d.tc)]=It is the blind hour of dawn%, when the shattered sun rises and the fog thickens into a reddish soup - most wise souls are indoors resting.

@@ The 2nd hour (7am to 8am)
&hour.desc.7 [v(d.tc)]=Those in the day-shift rise to meet their duties. The city begins to bustle.

@@ The 3rd hour (8am to 9am)
&hour.desc.8 [v(d.tc)]=The noise of goats and street hawkers rouse all but the dead.

@@ The 4th hour (9am to 10am)
&hour.desc.9 [v(d.tc)]=Small shops do business while larger ones make business. The Bluecoats make themselves seen on the streetcorners of even the most criminal districts.

@@ The 5th hour (10am to 11am)
&hour.desc.10 [v(d.tc)]=The Gondoliers rattle spirit-chasers to call business and promise safety on the haunted waterways.

@@ The 6th hour (11am to noon)
&hour.desc.11 [v(d.tc)]=Shops begin closing for lunch as folk hurry to get their errands in. The clerks of City Hall take their lunches long and with those who pay well.

@@ The 7th hour (noon to 1pm)
&hour.desc.12 [v(d.tc)]=The mines let out for lunch in Coalridge. Filthy people crowd the bars and eateries around the mine to spend what little coin they've earned on ratburgers on mushroom bread.

@@ The 8th hour (1pm to 2pm)
&hour.desc.13 [v(d.tc)]=People return to work and shops reopen. The nobility take an early day because really, this morning was just too much.

@@ The 9th hour (2pm to 3pm)
&hour.desc.14 [v(d.tc)]=The warmest part of the day approaches. Those who have time off are taking advantage in the parks and outdoor eateries, though many still bundle up.

@@ The 10th hour (3pm to 4pm)
&hour.desc.15 [v(d.tc)]=As the afternoon waxes, the world quiets. Those who are out move with purpose. Bluecoats harass the 'honest citizenry' in passing out of boredom.

@@ The 11th hour (4pm to 5pm)
&hour.desc.16 [v(d.tc)]=The clerks' offices let out early and the street hawkers raise their voices again as evening approaches.

@@ The 12th hour (5pm to 6pm)
&hour.desc.17 [v(d.tc)]=The shops and offices of Brightstone begin wrapping up for the evening - their doors will close quickly. A flood of ordinary folk hit the sidewalks to make their way home in time for twilight.

@@ The Hour of Honor (6pm to 7pm)
&hour.desc.18 [v(d.tc)]=It is the blind hour of twilight, when fog rolls in from the black sea and one cannot see more than a few inches in front of one's face. The evening is perilous and the wise are indoors taking tea.

@@ The Hour of Song (7pm to 8pm)
&hour.desc.19 [v(d.tc)]=As the night begins, many dens of vice draw in patrons with the music playing within. The wealthy folk of the better districts begin their preparation for socialization - one must look one's best.

@@ The Hour of Silver (8pm to 9pm)
&hour.desc.20 [v(d.tc)]=Cabbies do brisk business transporting folk to various parties and houses of ill repute. They don't judge; they ask only for a scale or two to pay the bills.

@@ The Hour of Thread (9pm to 10pm)
&hour.desc.21 [v(d.tc)]=The day is over for many, and with its end comes the preparation for the next. One's clothing must be mended and one's soul stitched back together (such as it is). Many of the citizenry retire to bed.

@@ The Hour of Flame (10pm to 11pm)
&hour.desc.22 [v(d.tc)]=Those who don't retire to bed are either partying until the sun returns or up to no good. Hoodlums and hooligans abound, looking for easy prey.

@@ The Hour of Pearls (11pm to midnight)
&hour.desc.23 [v(d.tc)]=The wealthy folks' parties are in full swing. Galas of gorgeous people drip with jewels - because when one has everything, one must show it off.

&f.get-hour-description [v(d.tc)]=v(hour.desc.%0)

@@ %0: hour
@@ %1: day of the month
@@ %2: month
&f.get-weather [v(d.tc)]=ulocal(daily-weather)

&holiday.mendar.1-6 [v(d.tc)]=Gratitude

&holiday.mendar.60 [v(d.tc)]=Moontide

&holiday.kalivet.34 [v(d.tc)]=Unison

&holiday.kalivet.60 [v(d.tc)]=Moontide

&holiday.suran.39 [v(d.tc)]=Hunting Season starts

&holiday.suran.60 [v(d.tc)]=Moontide

&holiday.ulsivet.20 [v(d.tc)]=Arkenvorn

&holiday.ulsivet.60 [v(d.tc)]=Moontide

&holiday.volnivet.23 [v(d.tc)]=Hunting Season ends

&holiday.volnivet.60 [v(d.tc)]=Moontide

&holiday.elisar.25 [v(d.tc)]=Doskvorn

&holiday.elisar.60 [v(d.tc)]=Moontide

&holidaydesc.hunting_season_starts [v(d.tc)]=The beginning of Leviathan-hunting season. The leviathan hunter ships procure 80% of their hauls during this time of the year.

&holidaydesc.hunting_season_ends [v(d.tc)]=The end of Leviathan-hunting season. The leviathan hunter ships still go out, but don't have nearly as much luck.

&holidaydesc.Moontide [v(d.tc)]=The last day of each month is Moontide, an informal holiday based on a folk-practice honoring a forgotten sky deity; now merely an excuse to stop work and drink.

&holidaydesc.arkenvorn [v(d.tc)]=Honoring the institution of the Spirit Wardens.

&holidaydesc.Unison [v(d.tc)]=The official celebration (and for some, unofficial cursing) of the end of the Unity War with Skovlan.

&holidaydesc.doskvorn [v(d.tc)]=A birthday celebration for anyone born in Doskvol.

&holidaydesc.Gratitude [v(d.tc)]=Honoring the Immortal Emperor's ascension to the throne and the salvation of the Shattered Isles - as well as celebrating thankfulness for other things in life.

&layout.holidays [v(d.tc)]=strcat(%r, divider(Holidays in %1, %0), %r, multicol(strcat(Day|Holiday|Description|, iter(sort(lattr(me/holiday.%1.*)), strcat(last(itext(0), .), |, v(itext(0)), |, v(strcat(holidaydesc., edit(v(itext(0)), %b, _)))),, |)), 5 10 *, 1, |, %0))

&layout.time [v(d.tc)]=strcat(header(The time is now..., %0), %r, setq(T, %1), setq(A, ulocal(f.get-day-of-year, %qT)), setq(M, ulocal(f.get-month, %qA)), setq(D, ulocal(f.get-day-of-month, %qA)), setq(H, ulocal(f.get-hour, %qT)), formattext(strcat(It is the , %b, ulocal(f.get-ordinal, %qD) day of, %b, ansi(h, %qM)., %b, ulocal(f.get-season, %qM, %qD), %r%r%t, It's the, %b, ansi(h, ulocal(f.get-ordinal, inc(mod(%qD, 6)))), %b, day of the week%, called, %b, ulocal(f.get-day-of-week, %qD), ., %r%r%t, It is the, %b, ansi(h, ulocal(f.get-hour-name, %qH))., %b, ulocal(f.get-hour-description, %qH), %r%r%t, ulocal(f.get-weather, %qH, %qD, %qM)), 1, %0), ulocal(layout.holidays, %0, %qM), %r, footer(ansi(xh, cat(The time ratio is, v(d.time-ratio) x normal)), %0))

&c.+time [v(d.tc)]=$+time:@pemit %#=ulocal(layout.time, %#, ulocal(f.get-ic-time));

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Weather
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.tc)]=@set me=daily-weather:[ulocal(f.get-random-weather, setr(A, ulocal(f.get-day-of-year, ulocal(f.get-ic-time))), ulocal(f.get-month, %qA))];

@@ The month this weather is in.
&f.get-random-weather [v(d.tc)]=strcat(setq(0, ulocal(pickrand(lattr(me/weather.descs.%1-*)))), setq(1,), null(iter(lcstr(lattr(me/words.*)), strcat(setq(0, edit(%q0, %{[rest(itext(0), .)]%}, setr(2, pickrand(setdiff(v(itext(0)), %q1, |), |)))), setq(1, setunion(%q1, %q2, |))))), cat(ulocal(f.get-moon, %0), %q0))

&words.roars [v(d.tc)]=roars|howls|whistles

&words.cloudy [v(d.tc)]=cloudy|overcast|gloomy

&words.angrily [v(d.tc)]=angrily|maliciously|fiercely|wildly

&words.rooftops [v(d.tc)]=rooftops|docks|black sea

&weather.descs.mendar-1 [v(d.tc)]=The wind {roars} {angrily} off the {rooftops}, threatening snow but never actually delivering.

&weather.descs.mendar-2 [v(d.tc)]=The {cloudy} sky hangs low over the world, as if the stars themselves have abandoned it.

&weather.descs.mendar-3 [v(d.tc)]=The sky opens up on a day of sunless cold and a night full of uncaring stars.

&weather.descs.mendar-4 [v(d.tc)]=The sky releases sleet in sporradic bursts, turning the roads to slush.

&weather.descs.mendar-5 [v(d.tc)]=The fractured sun beams down on the damaged world, glittering {angrily}.

@@ TODO: 5 more descs per season.


&f.get-moon [v(d.tc)]=if(neq(mod(%0, 17), 0), The moon looms huge and bright%, swelling with each passing year%, as if drawn ever closer by some terrible power., The moon appears to multiply across the sky%, in pairs and trios of sibling lights%, as if reflected on the facets of a vast crystalline dome.)

@@ +weather/set random
@@ +weather/set <text>
&c.+weather/set [v(d.tc)]=$+weather/set *:@assert isstaff(%#)={ @trigger me/tr.error=#, Only staff can set the weather.; }; @assert t={ @trigger me/tr.error=%#, You must set something to change the weather to.; }; @eval setq(V, switch(%0, rand*, ulocal(f.get-random-weather, setr(A, ulocal(f.get-day-of-year, ulocal(f.get-ic-time))), ulocal(f.get-month, %qA)), %0)); @set me=daily-weather:%qV; @trigger me/tr.success=%#, You set the global weather to '%qV'. It will show up on +time and +weather until it is changed by someone else or the daily weather change occurs. You may want to make an announcement with %ch+wall/emit <text>%cn so that all players are aware of the change.;

&c.+weather/rand [v(d.tc)]=$+weather/r*:@force %#=+weather/set random

&c.+weather [v(d.tc)]=$+weather:@force %#=+time;

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Tests for the time system.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.test-hour [v(d.tc)]=strcat(header(The rhythms of Doskvol in the wee hours, %0), %r, multicol(iter(lnum(6), strcat(ansi(h, ulocal(f.get-hour-name, itext(0))), :%b, ulocal(f.get-hour-description, itext(0))),, |), *, 0, |, %0), %r, footer(, %0))

&layout.test-hour2 [v(d.tc)]=strcat(header(The rhythms of Doskvol in the morning, %0), %r, multicol(iter(lnum(6, 11), strcat(ansi(h, ulocal(f.get-hour-name, itext(0))), :%b, ulocal(f.get-hour-description, itext(0))),, |), *, 0, |, %0), %r, footer(, %0))

&layout.test-hour3 [v(d.tc)]=strcat(header(The rhythms of Doskvol in the afternoon, %0), %r, multicol(iter(lnum(12, 17), strcat(ansi(h, ulocal(f.get-hour-name, itext(0))), :%b, ulocal(f.get-hour-description, itext(0))),, |), *, 0, |, %0), %r, footer(, %0))

&layout.test-hour4 [v(d.tc)]=strcat(header(The rhythms of Doskvol in the evening, %0), %r, multicol(iter(lnum(18, 23), strcat(ansi(h, ulocal(f.get-hour-name, itext(0))), :%b, ulocal(f.get-hour-description, itext(0))),, |), *, 0, |, %0), %r, footer(, %0))

&layout.test-season [v(d.tc)]=strcat(header(The cycle of the Shattered Isles, %0), %r, multicol(iter(lnum(6), strcat(ansi(h, setr(M, ulocal(f.get-month, mul(inum(0), 60)))), %b, 1-30:, %b, ulocal(f.get-season, %qM, 1), ||, ansi(h, %qM) 31-60:, %b, ulocal(f.get-season, %qM, 60)),, ||), *, 0, |, %0), %r, footer(, %0))

&layout.test-days [v(d.tc)]=strcat(header(The days of the week, %0), %r, multicol(iter(lnum(6), strcat(ulocal(f.get-day-of-week, itext(0))),, |), * * *, 0, |, %0), %r, footer(, %0))

&layout.test-holidays [v(d.tc)]=strcat(ulocal(layout.holidays, %0, %1), footer(, %0))

&c.+time/test [v(d.tc)]=$+time/test *:@assert setr(T, finditem(setr(L, hour|days|season|holidays), first(%0, =), |))={ @trigger me/tr.error=%#, Couldn't find '[first(%0, =)]' on the list. The list is: [ulocal(layout.list, %qL)].; }; @assert cor(not(strmatch(%qT, holidays)), t(setr(M, finditem(setr(L, Mendar|Kalivet|Suran|Ulsivet|Volnivet|Elisar), rest(%0, =), |))))={ @trigger me/tr.error=%#, To view the tests for holidays%, you must enter the month name like so: %ch+time/test Holidays=<month>%cn. Valid months are [ulocal(layout.list, %qL)].; }; @pemit %#=ulocal(layout.test-%qT, %#, %qM); @assert strmatch(%qT, hour); @pemit %#=ulocal(layout.test-%qT2, %#); @pemit %#=ulocal(layout.test-%qT3, %#); @pemit %#=ulocal(layout.test-%qT4, %#);

