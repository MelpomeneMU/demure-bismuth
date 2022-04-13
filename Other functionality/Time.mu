/*
+time and +weather - same thing, view the time and weather

+time/<hours|holidays|seasons> - view all the text for the hours, seasons, and holidays. If looking for holidays, you must also provide the month, as in "+time/hol M" to get the holidays in Mendar.

+weather/set <random or value> - set the weather to a specific weather across the whole grid. Staff-only.

The weather changes daily, not hourly, since Doskvol's weather is relatively stable from hour to hour and place to place within the city.

*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Object creation - don't change this.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@create Time Clock <TC>=10
@set TC=SAFE INHERIT OPAQUE

@force me=@parent TC=[v(d.bf)]

@force me=&d.tc me=[num(TC)]

@tel [v(d.tc)]=[config(master_room)]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Settings - OK to change these.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ How fast does time flow? Greater than 1 means faster than real life time. Less than 1 means slower.
&d.time-ratio [v(d.tc)]=1.33

@@ Set the starting time for the first year, beginning in winter. Change this date if you want a different starting time.
@force me=&d.start-date [v(d.tc)]=[convtime(Jan 01 00:00:00 2022)]

@@ How many days between Dimmer Sisters Moons?
&d.dimmer_sisters_moon [v(d.tc)]=17

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Day descriptions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&day.desc.0 [v(d.tc)]=It is the %ch1st%cn day of the week, called Market Day because public traders put out a new selection of wares for the coming week.

&day.desc.1 [v(d.tc)]=It is the %ch2nd%cn day of the week, called Home Day in Crow's Foot because prisoners are released from Ironhook Prison on this day.

&day.desc.2 [v(d.tc)]=It is the %ch3rd%cn day of the week, called Commission Day on the Docks because new ships launch on this day due to an ancient superstition.

&day.desc.3 [v(d.tc)]=It is the %ch4th%cn day of the week, called Requiem in Charterhall because wills and testaments are traditionally prosecuted on this day.

&day.desc.4 [v(d.tc)]=It is the %ch5th%cn day of the week, called Dust Day in Charhollow because the food begins to run out.

&day.desc.5 [v(d.tc)]=It is the %ch6th%cn and last day of the week, called Carillon in Brightstone for the operas and symphonies performed weekly on this day.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Season descriptions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Spring ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&season.desc.kalivet-0 [v(d.tc)]=It is the beginning of spring but the wind off the black sea still brings winter's chill.

&season.desc.kalivet-1 [v(d.tc)]=It is spring and the few remaining plants have begun to grow, not that anyone ever sees them. The wind roars wildly.

&season.desc.suran-0 [v(d.tc)]=It is spring and the air could almost qualify as muggy, but the wind dissipates it wherever the heat manages to linger.

&season.desc.suran-1 [v(d.tc)]=It is nearing the end of spring and the windy air has an electrical quality to it, presaging the storms of autumn.

@@ Autumn ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&season.desc.ulsivet-0 [v(d.tc)]=It is the beginning of autumn and the winds of spring still gust frequently. Every storm is an opportunity for disaster, the wind particularly murderous, but the storms are just getting started.

&season.desc.ulsivet-1 [v(d.tc)]=It is autumn and life clings tenaciously despite the oncoming chill. The storms rage regularly, like a spoiled child throwing a tantrum.

&season.desc.volnivet-0 [v(d.tc)]=It is autumn and the winds have finally begun to die down as the distant parts of the ocean become icy and still. The storms are getting rarer, but they are vicious when they come.

&season.desc.volnivet-1 [v(d.tc)]=It is nearing the end of autumn and the few remaining plants are now lifeless husks, failing to sprout even moss. The last storms of the season fight to destroy what they can before their time is up.

@@ Winter ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&season.desc.elisar-0 [v(d.tc)]=It is the beginning of winter, a blessed relief after the storms of autumn. Occasional flurries spill slush into the city streets and provide the illusion that all is bright and clean.

&season.desc.elisar-1 [v(d.tc)]=It is winter and even the ocean is still, the ice reaching closer to the shore each year. A few of the lesser canals are frozen, creating temporary (and dangerous) skating parks.

&season.desc.mendar-0 [v(d.tc)]=It is winter and the air is quiet and still save for the distant cracking of the ice on the ocean. The world hunkers down and bundles up to avoid the cold.

&season.desc.mendar-1 [v(d.tc)]=It is nearing the end of winter and the wind off the ocean holds the promise of spring. Snow still clings to the rooftops, melting into another year's layer of grime.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Hour descriptions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&hour.name.0 [v(d.tc)]=Hour of Silk (midnight to 1am)
&hour.desc.0 [v(d.tc)]=The pleasure-houses and vice dens are taking customers and coin as the world strives to forget.

&hour.name.1 [v(d.tc)]=Hour of Wine (1am to 2am)
&hour.desc.1 [v(d.tc)]=Let the wine flow freely and the hour grow late!

&hour.name.2 [v(d.tc)]=Hour of Ash (2am to 3am)
&hour.desc.2 [v(d.tc)]=The bars are closing, woe, woe! The night preys upon those who linger.

&hour.name.3 [v(d.tc)]=Hour of Coal (3am to 4am)
&hour.desc.3 [v(d.tc)]=One must rise in the night to add coal to the fire, lest the house freeze. Some are still feeding coal to empty fireplaces, though they froze to death long ago.

&hour.name.4 [v(d.tc)]=Hour of Chains (4am to 5am)
&hour.desc.4 [v(d.tc)]=It is widely whispered that when prisoners are taken from Ironhook Prison for whatever unknown purpose, they move in the wee hours of the morning.

&hour.name.5 [v(d.tc)]=Hour of Smoke (5am to 6am)
&hour.desc.5 [v(d.tc)]=The early morning fog has just begun to rise in the hour before dawn. Soon travel will become difficult as the sun rises and the fog burns red.

&hour.name.6 [v(d.tc)]=1st hour (6am to 7am)
&hour.desc.6 [v(d.tc)]=It is the blind hour of dawn, when the shattered sun rises and the fog thickens into a reddish soup - most wise souls are indoors resting.

&hour.name.7 [v(d.tc)]=2nd hour (7am to 8am)
&hour.desc.7 [v(d.tc)]=Those in the day-shift rise to meet their duties. The city begins to bustle.

&hour.name.8 [v(d.tc)]=3rd hour (8am to 9am)
&hour.desc.8 [v(d.tc)]=The noise of goats and street hawkers rouse all but the dead.

&hour.name.9 [v(d.tc)]=4th hour (9am to 10am)
&hour.desc.9 [v(d.tc)]=Small shops do business while larger ones make business. The Bluecoats make themselves seen on the street corners of even the most criminal districts.

&hour.name.10 [v(d.tc)]=5th hour (10am to 11am)
&hour.desc.10 [v(d.tc)]=The Gondoliers rattle spirit-chasers to call business and promise safety on the haunted waterways.

&hour.name.11 [v(d.tc)]=6th hour (11am to noon)
&hour.desc.11 [v(d.tc)]=Shops begin closing for lunch as folk hurry to get their errands in. The clerks of City Hall take their lunches long and with those who pay well.

&hour.name.12 [v(d.tc)]=7th hour (noon to 1pm)
&hour.desc.12 [v(d.tc)]=The mines let out for lunch in Coalridge. Filthy people crowd the bars and eateries around the mine to spend what little coin they've earned on rat-burgers on mushroom bread.

&hour.name.13 [v(d.tc)]=8th hour (1pm to 2pm)
&hour.desc.13 [v(d.tc)]=People return to work and shops reopen. The nobility take an early day because really, this morning was just too much.

&hour.name.14 [v(d.tc)]=9th hour (2pm to 3pm)
&hour.desc.14 [v(d.tc)]=The warmest part of the day approaches. Those who have time off are taking advantage in the parks and outdoor eateries, though many still bundle up.

&hour.name.15 [v(d.tc)]=10th hour (3pm to 4pm)
&hour.desc.15 [v(d.tc)]=As the afternoon waxes, the world quiets. Those who are out move with purpose. Bluecoats harass the 'honest citizenry' in passing out of boredom.

&hour.name.16 [v(d.tc)]=11th hour (4pm to 5pm)
&hour.desc.16 [v(d.tc)]=The clerks' offices let out early and the street hawkers raise their voices again as evening approaches.

&hour.name.17 [v(d.tc)]=12th hour (5pm to 6pm)
&hour.desc.17 [v(d.tc)]=The shops and offices of Brightstone begin wrapping up for the evening - their doors will close quickly. A flood of ordinary folk hit the sidewalks to make their way home in time for twilight.

&hour.name.18 [v(d.tc)]=Hour of Honor (6pm to 7pm)
&hour.desc.18 [v(d.tc)]=It is the blind hour of twilight, when fog rolls in from the black sea and one cannot see more than a few inches in front of one's face. The evening is perilous and the wise are indoors taking tea.

&hour.name.19 [v(d.tc)]=Hour of Song (7pm to 8pm)
&hour.desc.19 [v(d.tc)]=As the night begins, many dens of vice draw in patrons with the music playing within. The wealthy folk of the better districts begin their preparation for socialization - one must look one's best.

&hour.name.20 [v(d.tc)]=Hour of Silver (8pm to 9pm)
&hour.desc.20 [v(d.tc)]=Cabbies do brisk business transporting folk to various parties and houses of ill repute. They don't judge; they ask only for a scale or two to pay the bills.

&hour.name.21 [v(d.tc)]=Hour of Thread (9pm to 10pm)
&hour.desc.21 [v(d.tc)]=The day is over for many, and with its end comes the preparation for the next. One's clothing must be mended and one's soul stitched back together (such as it is). Many of the citizenry retire to bed.

&hour.name.22 [v(d.tc)]=Hour of Flame (10pm to 11pm)
&hour.desc.22 [v(d.tc)]=Those who don't retire to bed are either partying until the sun returns or up to no good. Hoodlums and hooligans abound, looking for easy prey.

&hour.name.23 [v(d.tc)]=Hour of Pearls (11pm to midnight)
&hour.desc.23 [v(d.tc)]=The wealthy folks' parties are in full swing. Galas of gorgeous people drip with jewels - because when one has everything, one must show it off.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Holidays
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

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

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Holiday descriptions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&holiday-desc.hunting_season_starts [v(d.tc)]=The beginning of Leviathan-hunting season. The leviathan hunter ships procure 80% of their hauls during this time of the year.

&holiday-desc.hunting_season_ends [v(d.tc)]=The end of Leviathan-hunting season. The leviathan hunter ships still go out, but don't have nearly as much luck.

&holiday-desc.Moontide [v(d.tc)]=The last day of each month is Moontide, an informal holiday based on a folk-practice honoring a forgotten sky deity; now merely an excuse to stop work and drink.

&holiday-desc.arkenvorn [v(d.tc)]=Honoring the institution of the Spirit Wardens.

&holiday-desc.Unison [v(d.tc)]=The official celebration (and for some, unofficial cursing) of the end of the Unity War with Skovlan.

&holiday-desc.doskvorn [v(d.tc)]=A birthday celebration for anyone born in Doskvol.

&holiday-desc.Gratitude [v(d.tc)]=Honoring the Immortal Emperor's ascension to the throne and the salvation of the Shattered Isles - as well as celebrating thankfulness for other things in life.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Weather descriptions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Word replacements ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&words.roars [v(d.tc)]=roars|howls|whistles

&words.cloudy [v(d.tc)]=cloudy|overcast|gloomy

&words.angrily [v(d.tc)]=angrily|maliciously|fiercely|wildly|furiously

&words.gleefully [v(d.tc)]=gleefully|merrily|excitedly

&words.rooftops [v(d.tc)]=rooftops|docks|black sea

&words.violent [v(d.tc)]=violent|vicious|savage|murderous|aggressive

&words.torrents [v(d.tc)]=torrents|floods|curtains

@@ Spring ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&weather.descs.kalivet-1 [v(d.tc)]=The wind whistles {gleefully} off the {rooftops}, singing to itself on this {cloudy} day.

&weather.descs.kalivet-2 [v(d.tc)]=The wind comes in fits and starts, {gleefully} tossing bits of dust and trash here and there.

&weather.descs.suran-1 [v(d.tc)]=The clouds have been swept back by the {violent} wind, the threat of storms swept out to sea.

&weather.descs.suran-2 [v(d.tc)]=Lightning dances on the ocean, but the storm fails to make landfall. The wind sweeps away papers and bits of rubbish.

&weather.descs.suran-3 [v(d.tc)]=A light rainfall drizzles and spits over the city, blasted by the occasional burst of wind at the most inconvenient angle.

@@ Autumn ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&weather.descs.ulsivet-1 [v(d.tc)]=The storms have come home to roost, {angrily} lashing the {rooftops} with {torrents} of rain.

&weather.descs.volnivet-1 [v(d.tc)]=Lightning crackles in the distance, an ominous storm forboding.

&weather.descs.volnivet-2 [v(d.tc)]=The weather takes a turn for the worse, the storm finally breaking. Wind {roars} {angrily}, spilling {torrents} of water on the unwary head.

&weather.descs.volnivet-3 [v(d.tc)]=Thunder rumbles, but the rain holds off for now.

@@ Winter ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&weather.descs.mendar-1 [v(d.tc)]=The wind {roars} {angrily} off the {rooftops}, threatening snow but never actually delivering.

&weather.descs.mendar-2 [v(d.tc)]=The {cloudy} sky hangs low over the world, as if the stars themselves have abandoned it.

&weather.descs.mendar-3 [v(d.tc)]=The clear sky opens up on a day of sunless cold and a night full of uncaring stars.

&weather.descs.mendar-4 [v(d.tc)]=The sky releases sleet in sporadic bursts, turning the roads to slush.

&weather.descs.mendar-5 [v(d.tc)]=The fractured sun beams down on the damaged world, glittering {angrily} off the melting snow.

&weather.descs.elisar-1 [v(d.tc)]=Ice settles upon the world like a shroud on a corpse. Snow glitters dangerously, promising beauty and hiding a treacherous path.

@@ TODO: More seasonal descs.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Moon descriptions
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&moon.normal [v(d.tc)]=The moon looms huge and bright, swelling with each passing year, as if drawn ever closer by some terrible power.

&moon.dimmer_sisters [v(d.tc)]=The moon appears to multiply across the sky, in pairs and trios of sibling lights, as if reflected on the facets of a vast crystalline dome.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Clock functions - don't change anything below this point.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&f.get-ic-time [v(d.tc)]=round(add(mul(v(d.time-ratio), sub(secs(), v(d.start-date))), v(d.start-date)), 0)

&f.get-day-of-year [v(d.tc)]=div(mod(%0, 31104000), 86400)

&f.get-month [v(d.tc)]=switch(%0, >300, Elisar, >240, Volnivet, >180, Ulsivet, >120, Suran, >60, Kalivet, Mendar)

&f.get-day-of-month [v(d.tc)]=mod(%0, 60)

&f.get-ordinal [v(d.tc)]=strcat(%0, if(cand(gt(%0, 10), lt(%0, 20)), th, case(mid(%0, sub(strlen(%0), 1), 1), 1, st, 2, nd, 3, rd, th)))

&f.get-hour [v(d.tc)]=div(mod(%0, 86400), 3600)

&f.get-day-of-week [v(d.tc)]=ulocal(strcat(day.desc., mod(%0, 6)))

&f.get-season [v(d.tc)]=ulocal(strcat(season.desc., %0, -, gt(%1, 30)))

&f.get-hour-name [v(d.tc)]=ulocal(hour.name.%0)

&f.get-hour-description [v(d.tc)]=ulocal(hour.desc.%0)

&f.get-weather [v(d.tc)]=ulocal(daily-weather)

&f.get-moon [v(d.tc)]=ulocal(if(neq(mod(%0, v(d.dimmer_sisters_moon)), 0), moon.normal, moon.dimmer_sisters))

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Layouts for +time
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&layout.holidays [v(d.tc)]=strcat(divider(Holidays in %1, %0), %r, multicol(strcat(Day|Holiday|Description|, iter(sort(lattr(me/holiday.%1.*)), strcat(last(itext(0), .), |, v(itext(0)), |, v(strcat(holiday-desc., edit(v(itext(0)), %b, _)))),, |)), 5 10 *, 1, |, %0))

&layout.time [v(d.tc)]=strcat(header(The time is now..., %0), %r, setq(T, %1), setq(A, ulocal(f.get-day-of-year, %qT)), setq(M, ulocal(f.get-month, %qA)), setq(D, ulocal(f.get-day-of-month, %qA)), setq(H, ulocal(f.get-hour, %qT)), formattext(strcat(It is the , %b, ansi(h, ulocal(f.get-ordinal, %qD)) day of, %b, ansi(h, %qM)., %b, ulocal(f.get-season, %qM, %qD), %r%r%t, ulocal(f.get-day-of-week, %qD), %r%r%t, It is the, %b, ansi(h, ulocal(f.get-hour-name, %qH))., %b, ulocal(f.get-hour-description, %qH), %r%r%t, ulocal(f.get-weather)), 1, %0), %r, ulocal(layout.holidays, %0, %qM), %r, footer(ansi(xh, cat(The time ratio is, v(d.time-ratio) x normal)), %0))

&c.+time [v(d.tc)]=$+time:@pemit %#=ulocal(layout.time, %#, ulocal(f.get-ic-time));

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Weather
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@daily [v(d.tc)]=@set me=daily-weather:[ulocal(f.get-random-weather, setr(A, ulocal(f.get-day-of-year, ulocal(f.get-ic-time))), ulocal(f.get-month, %qA))];

@@ The month this weather is in.
&f.get-random-weather [v(d.tc)]=strcat(setq(0, ulocal(pickrand(lattr(me/weather.descs.%1-*)))), setq(1,), null(iter(lcstr(lattr(me/words.*)), strcat(setq(0, edit(%q0, %{[rest(itext(0), .)]%}, setr(2, pickrand(setdiff(v(itext(0)), %q1, |), |)))), setq(1, setunion(%q1, %q2, |))))), cat(ulocal(f.get-moon, %0), %q0))

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

&layout.test-days [v(d.tc)]=strcat(header(The days of the week, %0), %r, multicol(iter(lnum(6), strcat(ulocal(f.get-day-of-week, itext(0))),, ||), *, 0, |, %0), %r, footer(, %0))

&layout.test-holidays [v(d.tc)]=strcat(ulocal(layout.holidays, %0, %1), footer(, %0))

&c.+time/test [v(d.tc)]=$+time/*:@assert setr(T, finditem(setr(L, hours|days|season|holidays), first(%0), |))={ @trigger me/tr.error=%#, Couldn't find '[first(%0)]' on the list. The list is: [ulocal(layout.list, %qL)].; }; @eval setq(T, switch(%qT, hou*, hour, %qT)); @assert cor(not(strmatch(%qT, holidays)), t(setr(M, finditem(setr(L, Mendar|Kalivet|Suran|Ulsivet|Volnivet|Elisar), rest(%0), |))))={ @trigger me/tr.error=%#, To view the tests for holidays%, you must enter the month name like so: %ch+time/holidays <month>%cn. Valid months are [ulocal(layout.list, %qL)].; }; @pemit %#=ulocal(layout.test-%qT, %#, %qM); @assert strmatch(%qT, hou*); @pemit %#=ulocal(layout.test-%qT2, %#); @pemit %#=ulocal(layout.test-%qT3, %#); @pemit %#=ulocal(layout.test-%qT4, %#);

