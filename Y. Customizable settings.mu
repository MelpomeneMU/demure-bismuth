@@ This is an overlay on the default file. Without default file, stuff will be missing.
@@ Here are where the settings go. Change this stuff if you want!

@@ Default alert message
&d.default-alert [v(d.bd)]=GAME

&d.indent-width [v(d.bd)]=5

&d.debug-target [v(d.bd)]=#1

@@ Where reports go - messages from the code that are important.
@@ Most games have a private staff-only channel called Monitor.
&d.report-target [v(d.bd)]=Monitor

@@ A few notes about color:
@@ 1. Not everyone likes it.
@@ 2. They can turn it off.
@@ 3. Use it to give the feel of your game.
@@ 4. Never use it for important text, it can obscure the meaning.
@@ 5. A little goes a long way.
@@ 6. Definitely change the defaults.

@@ Effect controls the color of the header, footer, and divider functions.
@@ -
@@ Available effects are:
@@   none - no colors
@@   alt - as in alternating - colors go A > B > C > A > B > C...
@@   altrev - as in alternating reverse - colors go A > B > C > B > A
@@   random - colors vary randomly, chosen from your list
@@   fade - colors go on the left and right of all functions.
@@ -
&d.effect [v(d.bd)]=fade

@@ These are the colors. Players won't see them unless they are set ANSI and
@@ COLOR256. You can set that up in your netmux.conf config with:
@@ -
@@   player_flags ansi color256 ascii keepalive
@@ -
@@ That means every player will be created with those flags already set.
@@ Remember that players can change these flags at any time if they want!
@@ Also, setting the flags doesn't magically make the player's client able to
@@ view colors or parse ascii characters. If they can they'll see it; if not,
@@ it won't change a thing.
@@ -
&d.colors [v(d.bd)]=x<#d4c0fa> x<#894ff7> x<#732bfc> x<#999999>

@@ What color is your text? 99% of people should just go with white for
@@ readability.
&d.text-color [v(d.bd)]=xw

&d.colors [v(d.bd)]=x<#e0c194> x<#e3aa56> x<#ffa31c> x<#ff9800>
&d.text-left [v(d.bd)]=^V^
&d.text-right [v(d.bd)]=^V^
&d.text-repeat [v(d.bd)]=^V^
&d.title-left [v(d.bd)]=\
&d.title-right [v(d.bd)]=/
&d.body-left [v(d.bd)]=[
&d.body-right [v(d.bd)]=]

&d.colors [v(d.bd)]=x<#e0c194> x<#e3aa56> x<#ffa31c> x<#ff9800>
&d.text-left [v(d.bd)]=.:
&d.text-right [v(d.bd)]=:.
&d.text-repeat [v(d.bd)]=.:.
&d.title-left [v(d.bd)]=;
&d.title-right [v(d.bd)]=;
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

&d.text-left [v(d.bd)]=.o:
&d.text-right [v(d.bd)]=:o.
&d.text-repeat [v(d.bd)]=,.
&d.title-left [v(d.bd)]={
&d.title-right [v(d.bd)]=}
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

@@ The emit prefix that comes out when people use "ooc <text>" to talk.
&d.ooc_text [v(d.bd)]=<OOC>

@@ Default poll (shows when you type DOING or +who). Max length is 45 characters. This is a MUX limit.
&d.default-poll [v(d.bd)]=Whatcha doing?

@@ Travel categories, separated by |. These will be specific to your game and could include categories like "Retail" or "Market" depending on your setting. Your players will group their businesses under these categories. The only default is "OOC Rooms", so that you can add OOC destinations like the OOC room, the RP Nexus, Chargen, etc.
&d.travel.categories [v(d.bd)]=OOC Rooms

@@ All communication in room # will go to this channel. You can add as many of these as you like. Users will be alerted that they need to join the channel to see the rest of the conversation if they're not already on the channel. To disable, just remove this attribute. This functionality can be used to direct convo from, say, the Chargen room to the Chargen channel, the OOC room to the Public channel, etc.
&d.redirect-poses.#0 [v(d.bd)]=Public

@@ Set this to the DBref of your quiet room and any other room you want silent.
@force me=&d.gag-emits [v(d.bd)]=[v(d.qr)]

@@ Default meeting timeout in seconds. Sometimes the default 10m is too short!
&d.meeting-timeout [v(d.bd)]=1200

&d.default-out-exit [v(d.bd)]=Out <O>;o;out;exit;

@@ If yours is the kind of place where you're fine with players who haven't been approved going through character generation, flip this flag to a 1 and they'll be able to wander around on the IC grid. Most places want at least a little staff involvement with that before letting them wander where they might interfere with roleplay, but some places don't have a definition of IC, or might be fine with allowing players on the grid but not allowing them to pose, etc. Note that this setting affects +travel, +summon, +join, +meet, etc - if disabled, unapproved characters will not be able to use code to get IC. (Staff can still summon them IC, of course.)
&d.allow-unapproved-players-IC [v(d.bd)]=0

+channel/create Public=The group hangout thing.
+channel/create Chargen=Character questions and help.
+channel/create Monitor=Monitor channel for errors and weird commands.
+channel/create Staff=For staff discussions.

+channel/public Public
+channel/public Chargen

+channel/staff Monitor
+channel/staff Staff

+channel/header Public=%x<#d4c0fa>-%x<#894ff7>\{ %xwPublic %x<#894ff7>\}%x<#d4c0fa>-

+channel/header Chargen=%x<#d4c0fa>-%x<#894ff7>\{ %xwChargen %x<#894ff7>\}%x<#d4c0fa>-

+channel/header Monitor=%x<#d4c0fa>\[%x<#CC0000>Monitor%x<#d4c0fa>\]

+channel/header Staff=%x<#894ff7><%xwStaff%x<#894ff7>>

@@ TODO: MAYBE: Code idea: +temproom Tavern > makes you a random tavern with desc, randomized name, etc.

@@ Changed the name of IC Handle to Street Alias and IC Occupation to Expert Type, added Crew. Changed Apparent Age to Age (since we have an Age stat) and removed Age from the settable fields since it's a stat with specific values (Young Adult, Adult, Mature, Elder).
&d.allowed-who-fields [v(d.bd)]=Alias|Age|Connection Info|Connected|DBref|Doing|Gender|IC Full Name|Street Alias|Expert Type|IC Pronouns|Idle|Last IP|Location|Mail Stats|Name|Note|OOC Pronouns|Played-by|Position|Private Alts|Public Alts|Quote|RP Prefs|Short-desc|Staff Notes|Status|Themesong|Timezone|Wiki|Crew

@force me=@edit [v(d.bd)]/d.who-field-widths=$, %%b20

&d.section.ic_info [v(d.bd)]=Age|Gender|IC Full Name|Street Alias|Crew|Crew Title|Expert Type|IC Pronouns|Played-by|Short-desc|Wiki|Themesong|Quote

&d.finger-settable-fields [v(d.bd)]=Gender|IC Full Name|Street Alias|Crew Title|IC Pronouns|OOC Pronouns|Played-by|Position|Public Alts|Quote|RP Prefs|Short-desc|Themesong|Timezone|Wiki

&f.get-expert_type [v(d.bf)]=xget(%0, _stat.expert_type)

&f.get-age [v(d.bf)]=xget(%0, _stat.age)

&f.get-crew [v(d.bf)]=if(t(setr(N, xget(setr(C, xget(%0, _stat.crew_object)), _stat.crew_name))), strcat(%qN, %b, %(, setq(T, default(%qC/_stat.tier, 0)), if(t(%qT), roman(%qT), %qT), %)))

&f.get-crew_title [v(d.bf)]=xget(%0, d.crew_title)

&f.get-street_alias [v(d.bf)]=xget(%0, d.street_alias)

&jobs [v(d.pp)]=BTCMO

@@ %0: an approved player
&f.is-active-player [v(d.bf)]=lte(sub(secs(), xget(%0, _last-conn)), mul(v(d.max-days-before-name-available), 60, 60, 24))

@@ Show retired as a separate thing
&layout.finger-footer [v(d.bf)]=cat(ulocal(f.get-status, %0, %1), case(1, isstaff(%0), staff, isapproved(%0), if(ulocal(f.is-active-player, %0), approved, approved but inactive), if(t(xget(%0, _stat.retired_date)), retired and unapproved, if(t(xget(%0, _stat.frozen_date)), frozen and unapproved, unapproved))), if(strmatch(setr(A, ulocal(f.get-idle, %0, %1)), -), if(ulocal(f.is-active-player, %0), disconnected, inactive), %qA idle))
