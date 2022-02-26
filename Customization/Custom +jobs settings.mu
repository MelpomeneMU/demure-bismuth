/*
WARNING: This is not an import-and-forget file. There are 3 parts to it, each called out as PART 1, PART 2, and PART 3. Enter them separately and customize each to your game's needs.

Current list of all buckets because I find it useful:

 .o:{ Bucket List },.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.:o.
  Name        Flags    Description                  # Pct  C  A  D  Due  ARTS
 .o:,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,:o.
  BUILD       V---M--  New buildings, typos         8 17%  1  2  2    0     -
  CG          V---M--  New character creation      12 26%  1  2  2  168    0d
  CHARACTERS  V---M--  Character updates            3  7%  1  2  2    0     -
  CODE        V---M--  Bugs and code tweaks        11 24%  1  2  2    0     -
  CREW        V---M--  New crew creation            1  2%  1  2  2  240     -
  DOWNTIME    V---M--  Acquire an Asset, LTPs, etc  0  0%  1  2  2    0     -
  PLOTS       V---M--  Plot info & questions        0  0%  1  2  2    0     -
  PUBLIC      V---M--  Everyone can see this.       4  9%  1  2  2    0    0d
  QUERY       V---M--  Query bucket                 0  0%  1  2  2  168     -
  REQUESTS    V---M--  General player requests      3  7%  1  2  2  168    0d
  SOCIAL      V---M--  Game culture and PvP issues  4  9%  1  2  2   48     -
  THEME       V---M--  Theme issues, factions, etc  0  0%  1  2  2    0     -
  WIKI        V------  New accounts and lost passw  0  0%  1  2  2    0     -
 .o:,.,.,.,.,{ V=Viewing H=Hidden P=Published M=Myjobs L=Locked S=Summary }:o.

Request aliases:

request - generic request. Use this if none of the others fit!
  req/downtime - start a miscellaneous downtime job
    req/acquire - acquire an asset
  	req/ltp - start a Long Term Project
	req/build - build something new
    req/typo - report a typo (automatically includes your location)
	req/char - character jobs, sheet changes, "help I'm dead" jobs
    req/adv - spend advancements
	req/code - request code tweaks
    req/bug - report a bug
	req/plot - propose a plot you want to run
	req/social - report an issue with another player
	req/theme - questions about theme, factions, etc
  req/wiki - request a wiki login

Buckets that don't have aliases:

  CG - only accessible via +stats/lock
  CREW - only accessible via +crew/lock
  PUBLIC - only staff can make jobs in public, but everyone can see them.
  QUERY - bucket for sending questions to players.

*/

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PART 1
@@   - Get rid of buckets we don't want
@@   - Create buckets we do want
@@   - Create BBS groups to receive the postings of these buckets
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Get rid of unwanted buckets
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@set [search(ETHING=match(name(##), pitch))]=!safe
@set [search(ETHING=match(name(##), req))]=!safe

+bucket/delete admin
+bucket/delete apps
+bucket/delete cgen
+bucket/delete feep
+bucket/delete forum
+bucket/delete pitch
+bucket/delete pub
+bucket/delete req
+bucket/delete rp
+bucket/delete tech
+bucket/delete tps

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Set up desired buckets
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+bucket/set BUILD/DESC=New buildings, typos
+bucket/set CODE/DESC=Bugs and code tweaks
+bucket/set QUERY/DESC=Query bucket

+bucket/create CG=New character creation
+bucket/create CHARACTERS=Character updates
+bucket/create CREW=New crew creation
+bucket/create DOWNTIME=Acquire an Asset, LTPs, etc
+bucket/create PLOTS=Plot info & questions
+bucket/create PUBLIC=Everyone can see this.
+bucket/create REQUESTS=General player requests
+bucket/create SOCIAL=Game culture and PvP issues
+bucket/create THEME=Theme issues, factions, etc
+bucket/create WIKI=New accounts and lost passwords

@@ Fix the descs because +jobs doesn't like commas:
+bucket/set DOWNTIME/DESC=Acquire an Asset, LTPs, etc
+bucket/set THEME/DESC=Theme issues, factions, etc

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Set up some BBoards for these buckets
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+bbnewgroup Jobs: BUILD
+bbnewgroup Jobs: CG
+bbnewgroup Jobs: CHARACTERS
+bbnewgroup Jobs: CODE
+bbnewgroup Jobs: CREW
+bbnewgroup Jobs: DOWNTIME
+bbnewgroup Jobs: PLOTS
+bbnewgroup Jobs: PUBLIC
+bbnewgroup Jobs: QUERY
+bbnewgroup Jobs: REQUESTS
+bbnewgroup Jobs: SOCIAL
+bbnewgroup Jobs: THEME
+bbnewgroup Jobs: WIKI

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PART 2
@@  - Run this on the SERVER.
@@  - This makes it so that all jobs log to the server's hard disk.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Modify this to fit with your game's install directory and settings.

@@ NOTE: You cannot use spaces, dashes, underscores, or special characters for the actual log name. MUX will error unless it's plain text and one word. To test whether MUX will error, try @log filename=Test. If you get back "Syntax: @log file=message", it's an error.

cd mux2.13/game
mkdir logs
touch M-build.log
touch M-cg.log
touch M-characters.log
touch M-code.log
touch M-crew.log
touch M-downtime.log
touch M-plots.log
touch M-public.log
touch M-query.log
touch M-requests.log
touch M-social.log
touch M-theme.log
touch M-wiki.log

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PART 3
@@  - Customize each bucket according to our needs.
@@  - See https://github.com/lashtear/Anomaly-Jobs/blob/master/full/jhelp.txt
@@  - Lock the new job boards down!
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Clear the transparent flag on all built-in buckets except PUBLIC
@@ Transparent means all players can see the job bucket and any jobs in it.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&transparent [search(ETHING=t(strmatch(name(##), BUILD)))]=
&transparent [search(ETHING=t(strmatch(name(##), CODE)))]=
&transparent [search(ETHING=t(strmatch(name(##), QUERY)))]=
&transparent [search(ETHING=t(strmatch(name(##), PUBLIC)))]=1

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ BUILD bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&help [search(ETHING=t(strmatch(name(##), BUILD)))]=formattext(This bucket is for new buildings%, getting rid of buildings%, correcting typos%, etc. If it has to do with the grid%, your job belongs here.%R%R%TSee 'news build' for building information., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), BUILD)))]=build

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), BUILD)))]=[search(ETHING=t(strmatch(name(##), Jobs: BUILD)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CG bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), CG)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), CG)))]=1
&turnaround [search(ETHING=t(strmatch(name(##), CG)))]=168

&hook_oth [search(ETHING=t(strmatch(name(##), CG)))]=@set [xget(%0, opened_by)]=_chargen-job:%0;

@force me=&vC [search(ETHING=t(strmatch(name(##), CG)))]=[v(d.cg)]

&hook_apr [search(ETHING=t(strmatch(name(##), CG)))]=@set [xget(%0, opened_by)]=_chargen-job:; @trigger %vC/tr.approve-player=xget(%0, opened_by), %1; @trigger [v(VA)]/TRIG_LOG=%0,[v(VA)]; @trigger me/TRIG_POINTS=%1;

&MLETTER_OTH [search(ETHING=t(strmatch(name(##), CG)))]=You have requested character approval from staff. The job is '[name(%0)]: [get(%0/TITLE)]':%r%r %3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r[divider(Turnaround, %2)]%r Our motto for chargen jobs is: "This is the fun part! Woohoo!" That means we'll rarely keep you waiting. We'll wait up to a week for responses, but hopefully you're more excited to play than that.%r%r The official turnaround time for CG jobs is [div(u(me/TURNAROUND), 24)] days. If you haven't heard from us by then, please reach out with a message on this +job or by paging us. Our actual turnaround time is typically much quicker, and depending on how responsive each player is, you can expect a decision within 1-3 days.

&help [search(ETHING=t(strmatch(name(##), CG)))]=formattext(For brand new character builds only. If you have a question%, type %chcg/on%cn to join the Chargen channel., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), CG)))]=cg

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), CG)))]=[search(ETHING=t(strmatch(name(##), Jobs: CG)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CHARACTERS bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), CHARACTERS)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), CHARACTERS)))]=1

&help [search(ETHING=t(strmatch(name(##), CHARACTERS)))]=formattext(This bucket is for all kinds of character jobs like:%R%T- Messed up stats%R%T- Overindulgence of one's vice (you would never!)%R%T- Harmed so bad you're ready for the afterlife (spooooooky)%R%T- Tired of getting shot at and would like to retire%R%T- Spending some of those sweet sweet advancements%R%R%TYou get the idea. This is the place.%R%R%TIf your question is rules related%, %chrul/on%cn to join the Rules channel and ask it. If it needs an official ruling%, though%, you might want to put it on in %chreq/theme%cn instead of here.%R%R%TPlot rewards should be handled in %chreq/plots%cn%, not here., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), CHARACTERS)))]=characters

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), CHARACTERS)))]=[search(ETHING=t(strmatch(name(##), Jobs: CHARACTERS)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CODE bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&help [search(ETHING=t(strmatch(name(##), CODE)))]=formattext(Code%, bugs%, and feature suggestions can go here. Please be aware that we may say no to features that don't make sense for the game or are too hard to implement. Still%, worth a try to put it in - it might be really easy and helpful for everyone. The worst we can do is say no!, 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), CODE)))]=code

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), CODE)))]=[search(ETHING=t(strmatch(name(##), Jobs: CODE)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CREW bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), CREW)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), CREW)))]=1
&turnaround [search(ETHING=t(strmatch(name(##), CREW)))]=240

&hook_oth [search(ETHING=t(strmatch(name(##), CREW)))]=@dolist [xget(%0, opened_by)]={ @set ##=_crewgen-job:%0; };

@force me=&vC [search(ETHING=t(strmatch(name(##), CREW)))]=[v(d.cg)]

&hook_apr [search(ETHING=t(strmatch(name(##), CREW)))]=@dolist [xget(%0, opened_by)]={ @set ##=_crewgen-job:; }; @trigger %vC/tr.approve-crew=xget(%0, opened_by), %1; @trigger [v(VA)]/TRIG_LOG=%0,[v(VA)]; @trigger me/TRIG_POINTS=%1;

&hook_cre [search(ETHING=t(strmatch(name(##), CREW)))]=@set %0/COMMENT_1=no_inherit

&HOOK_ADD [search(ETHING=t(strmatch(name(##), CREW)))]=@break isstaff(%1); @set %0/COMMENT_[dec(get(%0/NUM_COMMENT))]=no_inherit;

@@ Send a letter anytime a PLAYER adds a comment to the job.
&MLETTER_ADD [search(ETHING=t(strmatch(name(##), CREW)))]=if(not(isstaff(%2)), %bComments have been added to '[name(%0)]' by [name(%2)]:%R%R %3%R%R[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.)

&MLETTER_OTH [search(ETHING=t(strmatch(name(##), CREW)))]=You have requested crew approval from staff. The job is '[name(%0)]: [get(%0/TITLE)]':%r%r %3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r[divider(Turnaround, %2)]%r The official turnaround time for CREW jobs is [div(u(me/TURNAROUND), 24)] days. If you haven't heard from us by then, please reach out with a message on this +job or by paging us. Our actual turnaround time is typically much quicker, and depending on how responsive the players are, you can expect a decision within 2-5 days.

&help [search(ETHING=t(strmatch(name(##), CREW)))]=formattext(For crews requesting approval only. Other types of crew-related jobs probably belong in the %chreq/char%cn%, %chreq/theme%cn%, or %chreq/social%cn., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), CREW)))]=crew

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), CREW)))]=[search(ETHING=t(strmatch(name(##), Jobs: CREW)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ DOWNTIME bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), DOWNTIME)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), DOWNTIME)))]=1

&MLETTER_OTH [search(ETHING=t(strmatch(name(##), DOWNTIME)))]=You have requested '[name(%0)]: [get(%0/TITLE)]' from staff: %r%r %3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r You may be asked to roll to this job. If so, use %ch+roll/job <job number>=<roll>%cn.%r[divider(Turnaround, %2)]%r Some of the jobs in this bucket are meant to be kept open for weeks, so we don't list a turnaround time. For smaller jobs, you should hear from us within 3 days.

&help [search(ETHING=t(strmatch(name(##), DOWNTIME)))]=formattext(All jobs relating to downtime%, like Long Term Projects or Acquire an Asset. If you want to spend a bunch of downtime at once%, feel free to put it in a single job even if it's related to multiple things%, but that will necessarily make the job more complex and thus it'll take longer., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), DOWNTIME)))]=downtime

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), DOWNTIME)))]=[search(ETHING=t(strmatch(name(##), Jobs: DOWNTIME)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PLOTS bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), PLOTS)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), PLOTS)))]=1

&MLETTER_OTH [search(ETHING=t(strmatch(name(##), PLOTS)))]=You have requested '[name(%0)]: [get(%0/TITLE)]' from staff: %r%r %3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%r Please give staff at least [div(u(me/TURNAROUND), 24)] days from the date of this mail to process your request.

&help [search(ETHING=t(strmatch(name(##), PLOTS)))]=formattext(All plot-related jobs go here. For the most part%, these will be back-and-forth jobs between players and staff about new plots the players wish to run%, but there may be other types of plot-related jobs that belong here.%R%R%TPlot jobs are expected to stay open until the plot is completed so that all the information will be in one place. Rewards related to plots belong in the plot job.%R%R%TNote that staff on this game does not run plots - we exist to facilitate player-run plots. See %chnews plots%cn for information., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), PLOTS)))]=plots

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), PLOTS)))]=[search(ETHING=t(strmatch(name(##), Jobs: PLOTS)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PUBLIC bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Let everyone comment on every job in the bucket.
&access [search(ETHING=t(strmatch(name(##), PUBLIC)))]=not(haspower(%#, GUEST))

@@ Accessible to +myjobs
&public [search(ETHING=t(strmatch(name(##), PUBLIC)))]=1

@@ Let the players see the first comment.
&hook_cre [search(ETHING=t(strmatch(name(##), PUBLIC)))]=@set %0/COMMENT_1=no_inherit

@@ If the job is published, let the players see EVERY comment. Otherwise they only see the first one and their own.
&HOOK_ADD [search(ETHING=t(strmatch(name(##), PUBLIC)))]=@if hasattr(%0, transparent)={ @set %0/COMMENT_[dec(get(%0/NUM_COMMENT))]=no_inherit; }

&help [search(ETHING=t(strmatch(name(##), PUBLIC)))]=formattext(This bucket is for PUBLIC jobs. Every player can see - and add to! - every job in this bucket. Comments on those jobs will be hidden unless staff runs +job/publish <job> or +job/publish <job>=<comment>.%R%R%TWe wanted a way to run polls without spamming the BBSes., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), PUBLIC)))]=public

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), PUBLIC)))]=[search(ETHING=t(strmatch(name(##), Jobs: PUBLIC)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ QUERY bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&help [search(ETHING=t(strmatch(name(##), QUERY)))]=formattext(When staff reaches out to a player or group of players%, the job ends up here. It can be moved from this bucket to something more relevant with +job/move <job>=<bucket>., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), QUERY)))]=query

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), QUERY)))]=[search(ETHING=t(strmatch(name(##), Jobs: QUERY)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ REQUESTS
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), REQUESTS)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), REQUESTS)))]=1

&hook_cre [search(ETHING=t(strmatch(name(##), REQUESTS)))]=@set %0/COMMENT_1=no_inherit

&turnaround [search(ETHING=t(strmatch(name(##), REQUESTS)))]=168

&logfile [search(ETHING=t(strmatch(name(##), REQUESTS)))]=requests

&MLETTER_OTH [search(ETHING=t(strmatch(name(##), REQUESTS)))]=You have requested '[name(%0)]: [get(%0/TITLE)]' from staff: %r%r %3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%r Please give staff at least [div(u(me/TURNAROUND), 24)] days from the date of this mail to process your request.

&help [search(ETHING=t(strmatch(name(##), REQUESTS)))]=formattext(When no other bucket seems to fit%, put your job in this one. It can be moved with +job/move <job>=<bucket> if staff chooses., 1, %#)

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), REQUESTS)))]=[search(ETHING=t(strmatch(name(##), Jobs: REQUESTS)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ SOCIAL
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), SOCIAL)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), SOCIAL)))]=1

&turnaround [search(ETHING=t(strmatch(name(##), SOCIAL)))]=48

&logfile [search(ETHING=t(strmatch(name(##), SOCIAL)))]=sociallog

&priority [search(ETHING=t(strmatch(name(##), SOCIAL)))]=2

&MLETTER_OTH [search(ETHING=t(strmatch(name(##), SOCIAL)))]=You have alerted staff to a social issue regarding '[get(%0/TITLE)]': %r%r %3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r[divider(Turnaround, %2)]%r Staff will be handling this ASAP. We welcome emails at [xget(%vZ, d.staff-email-address)] if you need to disconnect from the game.

&help [search(ETHING=t(strmatch(name(##), SOCIAL)))]=formattext(Social issues belong here. These include reports of harassment%, requests for staff to help negotiate between players%, do-not-contact requests%, issues of crew strmatchship%, etc.%R%R%T\See %chnews harassment%cn for our harassment policy.%R%R%TWe welcome emails at [xget(%vZ, d.staff-email-address)]., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), SOCIAL)))]=social

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), SOCIAL)))]=[search(ETHING=t(strmatch(name(##), Jobs: SOCIAL)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ THEME bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), THEME)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), THEME)))]=1

&help [search(ETHING=t(strmatch(name(##), THEME)))]=formattext(Questions about theme? Questions about rules %(which%, given that this is a story-first game%, are also theme%)? Ask them here.%R%R%TYou may also want to try on the Rules channel with %chrul/on%cn first%, so you can get the answer faster.%R%R%TYou should also see %chnews setting%cn in case your question has already been answered., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), THEME)))]=theme

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), THEME)))]=[search(ETHING=t(strmatch(name(##), Jobs: THEME)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ WIKI bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(strmatch(name(##), WIKI)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(strmatch(name(##), WIKI)))]=1

&turnaround [search(ETHING=t(strmatch(name(##), WIKI)))]=24

&help [search(ETHING=t(strmatch(name(##), WIKI)))]=formattext(If you want a wiki login%, send us your email and your preferred login name.%R%R%TIf you want new features on the wiki%, that's a harder ask and less likely to succeed. We wrench on the wiki maybe once a year and always with trepidation.%R%R%TIf you find a bug or problem with the wiki%, report it here! We can't promise we'll be able to fix it%, but we'll at least look at it disapprovingly and maybe try a few basic troubleshooting steps., 1, %#)

&logfile [search(ETHING=t(strmatch(name(##), WIKI)))]=wiki

@force me=&bboard_dbref [search(ETHING=t(strmatch(name(##), WIKI)))]=[search(ETHING=t(strmatch(name(##), Jobs: WIKI)))]

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ More settings
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Set the default bucket to REQUESTS since REQ is gone.
&f.get.bucket [v(d.jrs)]=udefault(d.%0.bucket, REQUESTS)

@@ Getting rid of pitches.
&CMD_PITCH [v(JOB_GO)]=$+pitch*:@pemit %#=alert(+jobs) We are not currently accepting pitches for plots - staff does not run plots. If you would like to run a plot, req/plot <title>=<info> or see %chnews plots%cn.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Fix up the JRS system to fit more with our new bucket list.
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Set the default bucket to REQUESTS since REQ is gone.
&d.request.bucket [v(d.jrs)]=REQUESTS

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Bugs should undergo some triage rather than start at max priority.
&d.bug.level [v(d.jrs)]=

&d.bug.msg [v(d.jrs)]=strcat(Bug report ', u(display.msg.job_title, %0), ' received with the following details: %r%r%b, secure(u(%va/FN_STRTRUNC, trim(%1), get(%va/BUFFER))), %r%r%b, If the bug doesn't already include this information%, please add:, %R%T- What you were doing at the time, %R%T- Any steps necessary to get the bug to happen again, %R%T- If it's not obvious%, what you expected to happen and what actually happened, %r%r%T, Thank you for helping us hunt down bugs!, %r)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.acquire.bucket [v(d.jrs)]=DOWNTIME

&d.acquire.prefix [v(d.jrs)]=ACQUIRE

&d.acquire.jgroup [v(d.jrs)]=+allstaff

&d.acquire.msg [v(d.jrs)]=u(display.generic_msg, %0, acquire)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.adv.bucket [v(d.jrs)]=CHARACTERS

&d.adv.prefix [v(d.jrs)]=ADV

&d.adv.jgroup [v(d.jrs)]=+allstaff

&d.adv.msg [v(d.jrs)]=u(display.generic_msg, %0, advancement)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.advance.bucket [v(d.jrs)]=CHARACTERS

&d.advance.prefix [v(d.jrs)]=ADV

&d.advance.jgroup [v(d.jrs)]=+allstaff

&d.advance.msg [v(d.jrs)]=u(display.generic_msg, %0, advancement)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.char.bucket [v(d.jrs)]=CHARACTERS

&d.char.jgroup [v(d.jrs)]=+allstaff

&d.char.msg [v(d.jrs)]=u(display.generic_msg, %0, character)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.dt.bucket [v(d.jrs)]=DOWNTIME

&d.dt.jgroup [v(d.jrs)]=+allstaff

&d.dt.msg [v(d.jrs)]=u(display.generic_msg, %0, downtime)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.downtime.bucket [v(d.jrs)]=DOWNTIME

&d.downtime.jgroup [v(d.jrs)]=+allstaff

&d.downtime.msg [v(d.jrs)]=u(display.generic_msg, %0, downtime)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.ltp.bucket [v(d.jrs)]=DOWNTIME

&d.ltp.prefix [v(d.jrs)]=LTP

&d.ltp.jgroup [v(d.jrs)]=+allstaff

&d.ltp.msg [v(d.jrs)]=u(display.generic_msg, %0, Long Term Project)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.plot.bucket [v(d.jrs)]=PLOTS

&d.plot.jgroup [v(d.jrs)]=+allstaff

&d.plot.msg [v(d.jrs)]=u(display.generic_msg, %0, plot)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.social.bucket [v(d.jrs)]=SOCIAL

&d.social.level [v(d.jrs)]=2

&d.social.jgroup [v(d.jrs)]=+allstaff

&d.social.msg [v(d.jrs)]=You have reported a social issue. Social issues are our highest priority because games aren't fun if they cause players real life stress and trauma. Code and typos can be fixed but it's a lot harder to fix people, so we try to stop the damage right away. If you need to step off the game or just want to get our attention faster, we welcome email at [xget(%vZ, d.staff-email-address)]. We will respond as quickly as possible.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.theme.bucket [v(d.jrs)]=THEME

&d.theme.jgroup [v(d.jrs)]=+allstaff

&d.theme.msg [v(d.jrs)]=u(display.generic_msg, %0, theme)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&d.wiki.bucket [v(d.jrs)]=WIKI

&d.wiki.jgroup [v(d.jrs)]=+allstaff

&d.wiki.msg [v(d.jrs)]=u(display.generic_msg, %0, wiki)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Lock the job boards down!
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: BUILD)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: CG)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: CHARACTERS)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: CODE)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: CREW)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: DOWNTIME)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: PLOTS)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: PUBLIC)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: QUERY)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: REQUESTS)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: SOCIAL)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: THEME)))]=isstaff(%0)
&CANREAD [search(ETHING=t(strmatch(name(##), Jobs: WIKI)))]=isstaff(%0)

@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: BUILD)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: CG)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: CHARACTERS)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: CODE)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: CREW)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: DOWNTIME)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: PLOTS)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: PUBLIC)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: QUERY)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: REQUESTS)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: SOCIAL)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: THEME)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
@force me=&CANWRITE [search(ETHING=t(strmatch(name(##), Jobs: WIKI)))]=lit(or(strmatch(%%0, [v(JOB_VB)]), isstaff(%%0)))
