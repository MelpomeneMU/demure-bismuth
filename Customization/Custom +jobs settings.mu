@@ Jobs customization for Blades MUX

@set [search(ETHING=match(name(##), pitch))]=!safe
@set [search(ETHING=match(name(##), req))]=!safe

+bucket/delete apps
+bucket/delete feep
+bucket/delete forum
+bucket/delete rp
+bucket/delete tech
+bucket/delete tps
+bucket/delete pitch
+bucket/delete cgen
+bucket/delete admin
+bucket/delete pub
+bucket/delete req

+bucket/set BUILD/DESC=Special buildings, typos
+bucket/set CODE/DESC=Bugs & code requests
+bucket/set QUERY/DESC=Query bucket

+bucket/create PUBLIC=Everyone can see this.
+bucket/create FACTION=Faction changes & updates
+bucket/create CG=Character creation/statting
+bucket/create CREW=Crew creation/statting
+bucket/create PLOTS=Plot info & questions
+bucket/create REQUESTS=Player requests
+bucket/create SOCIAL=Game culture and PvP issues.
+bucket/create DOWNTIME=Non-LTP downtime jobs.
+bucket/create LTP=Long Term Projects.
+bucket/create CHARACTERS=Character updates.

/*
 .o:{ Bucket List },.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.:o.
  Name        Flags    Description                  # Pct  C  A  D  Due  ARTS
 .o:,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,.,:o.
  BUILD       V---M--  Special buildings, typos     1  8%  1  2  2    0     -
  CG          V---M--  Character creation/statting  0  0%  1  2  2    0     -
  CHARACTERS  V------  Character updates.           0  0%  1  2  2    0     -
  CODE        V---M--  Bugs & code requests         0  0%  1  2  2    0     -
  DOWNTIME    V---M--  Non-LTP downtime jobs.       5 42%  1  2  2    0     -
  FACTION     V---M--  Faction changes & updates    0  0%  1  2  2    0     -
  LTP         V---M--  Long Term Projects.          2 17%  1  2  2    0     -
  PLOTS       V---M--  Plot info & questions        0  0%  1  2  2    0     -
  PUBLIC      V---MP-  Everyone can see this.       1  8%  1  2  2    0    0d
  QUERY       V---M--  Query bucket                 0  0%  1  2  2  168     -
  REQUESTS    V---M--  Player requests              3 25%  1  2  2  168    0d
  SOCIAL      V---M--  Game culture and PvP issues  0  0%  1  2  2   72     -
 .o:,.,.,.,.,{ V=Viewing H=Hidden P=Published M=Myjobs L=Locked S=Summary }:o.
*/

@@ TODO: +bucket/set <name>/help=<stuff>
@@ +myjob/help <#>

@@ TODO: Set a logfile for each bucket. Remember to log in on the main game account and run the following, adjusted for each bucket:
@@ cd mux2.13/game
@@ mkdir logs
@@ touch M-joblog.log
@@ touch M-reqlog.log



@@ WARNING: Fire the commands below at least one second AFTER the commands above have been run.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Clear the transparent flag on all built-in buckets except PUBLIC
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Transparent means all players can see the job bucket and any jobs in it.

&transparent [search(ETHING=t(member(name(##), BUILD)))]=
&transparent [search(ETHING=t(member(name(##), CODE)))]=
&transparent [search(ETHING=t(member(name(##), QUERY)))]=
&transparent [search(ETHING=t(member(name(##), PUBLIC)))]=1

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PUBLIC bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Let everyone comment on every job in the bucket.
&access [search(ETHING=t(member(name(##), PUBLIC)))]=not(haspower(%#, GUEST))

@@ Accessible to +myjobs
&public [search(ETHING=t(member(name(##), PUBLIC)))]=1

@@ Let the players see the first comment.
&hook_cre [search(ETHING=t(member(name(##), PUBLIC)))]=@set %0/COMMENT_1=no_inherit

@@ If the job is published, let the players see EVERY comment. Otherwise they only see the first one and their own.
&HOOK_ADD [search(ETHING=t(member(name(##), PUBLIC)))]=@if hasattr(%0, transparent)={ @set %0/COMMENT_[dec(get(%0/NUM_COMMENT))]=no_inherit; }

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ FACTIONS bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), FACTION)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), FACTION)))]=1

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CG bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), CG)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), CG)))]=1
&turnaround [search(ETHING=t(member(name(##), CG)))]=168

&hook_oth [search(ETHING=t(member(name(##), CG)))]=@set [xget(%0, opened_by)]=_chargen-job:%0;

@force me=&vC [search(ETHING=t(member(name(##), CG)))]=[v(d.cg)]

&hook_apr [search(ETHING=t(member(name(##), CG)))]=@set [xget(%0, opened_by)]=_chargen-job:; @trigger %vC/tr.approve-player=xget(%0, opened_by), %1;

&MLETTER_OTH [search(ETHING=t(member(name(##), CG)))]=You have requested character approval from staff. The job is '[name(%0)]: [get(%0/TITLE)]':%r%r%3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r[divider(Turnaround, %2)]%r Our motto for chargen jobs is: "This is the fun part! Woohoo!" That means we'll rarely keep you waiting. We'll wait up to a week for responses, but hopefully you're more excited to play than that.%r%r The official turnaround time for CG jobs is [div(u(me/TURNAROUND), 24)] days. If you haven't heard from us by then, please reach out with a message on this +job or by paging us. Our actual turnaround time is typically much quicker, and depending on how responsive each player is, you can expect a decision within 1-3 days.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Crew bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), CREW)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), CREW)))]=1
&turnaround [search(ETHING=t(member(name(##), CREW)))]=240

&hook_oth [search(ETHING=t(member(name(##), CREW)))]=@dolist [xget(%0, opened_by)]={ @set ##=_crewgen-job:%0; };

@force me=&vC [search(ETHING=t(member(name(##), CREW)))]=[v(d.cg)]

&hook_apr [search(ETHING=t(member(name(##), CREW)))]=@dolist [xget(%0, opened_by)]={ @set ##=_crewgen-job:; }; @trigger %vC/tr.approve-crew=xget(%0, opened_by), %1;

&hook_cre [search(ETHING=t(member(name(##), CREW)))]=@set %0/COMMENT_1=no_inherit

&HOOK_ADD [search(ETHING=t(member(name(##), CREW)))]=@break isstaff(%1); @set %0/COMMENT_[dec(get(%0/NUM_COMMENT))]=no_inherit; 

&MLETTER_OTH [search(ETHING=t(member(name(##), CREW)))]=You have requested crew approval from staff. The job is '[name(%0)]: [get(%0/TITLE)]':%r%r%3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r[divider(Turnaround, %2)]%r The official turnaround time for CREW jobs is [div(u(me/TURNAROUND), 24)] days. If you haven't heard from us by then, please reach out with a message on this +job or by paging us. Our actual turnaround time is typically much quicker, and depending on how responsive the players are, you can expect a decision within 2-5 days.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ PLOTS bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), PLOTS)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), PLOTS)))]=1

&MLETTER_OTH [search(ETHING=t(member(name(##), PLOTS)))]=You have requested '[name(%0)]: [get(%0/TITLE)]' from staff: %r%r%3%r%r[divider(, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%r Please give staff at least [div(u(me/TURNAROUND), 24)] days from the date of this mail to process your request.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ REQUESTS
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), REQUESTS)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), REQUESTS)))]=1

&hook_cre [search(ETHING=t(member(name(##), REQUESTS)))]=@set %0/COMMENT_1=no_inherit

&turnaround [search(ETHING=t(member(name(##), REQUESTS)))]=168

&logfile [search(ETHING=t(member(name(##), REQUESTS)))]=reqlog

&MLETTER_OTH [search(ETHING=t(member(name(##), REQUESTS)))]=You have requested '[name(%0)]: [get(%0/TITLE)]' from staff: %r%r%3%r%r[divider(, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%r Please give staff at least [div(u(me/TURNAROUND), 24)] days from the date of this mail to process your request.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ SOCIAL
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), SOCIAL)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), SOCIAL)))]=1

&hook_cre [search(ETHING=t(member(name(##), SOCIAL)))]=@set %0/COMMENT_1=no_inherit

&turnaround [search(ETHING=t(member(name(##), SOCIAL)))]=48

&logfile [search(ETHING=t(member(name(##), SOCIAL)))]=sociallog

&priority [search(ETHING=t(member(name(##), SOCIAL)))]=2

&MLETTER_OTH [search(ETHING=t(member(name(##), SOCIAL)))]=You have alerted staff to a social issue regarding '[get(%0/TITLE)]': %r%r%3%r%r[divider(, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%r Please give staff at least [u(me/TURNAROUND)] hours from the date of this mail to process your request. If it's urgent, contact [xget(%vZ, d.staff-email-address)] or page a member of +staff right away.

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ LTP bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), LTP)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), LTP)))]=1

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ DOWNTIME bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), DOWNTIME)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), DOWNTIME)))]=1

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ CHARACTERS bucket
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

&access [search(ETHING=t(member(name(##), CHARACTERS)))]=[u(%va/FN_STAFFALL, %#)]

&public [search(ETHING=t(member(name(##), CHARACTERS)))]=1

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ More settings
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

@@ Set the default bucket to REQUESTS since REQ is gone.
&f.get.bucket [v(d.jrs)]=udefault(d.%0.bucket, REQUESTS)

@@ Set the default bucket to REQUESTS since REQ is gone.
&d.request.bucket [v(d.jrs)]=REQUESTS

@@ Getting rid of pitches.
&CMD_PITCH [v(JOB_GO)]=$+pitch*:@pemit %#=alert(+jobs) We are not currently accepting pitches. If it's an idea for a plot you want to run, +plot <title>=<info>! If you'd like a change to your sheet, +request Sheet change=<info>.
