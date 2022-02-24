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

@@ Transparent means all players can see the job bucket and any jobs in it. They can add to the job as if they owned it.

@@ TODO: Make sure that's actually true. Right now it looks like "transparent" makes it so they can only SEE it. Not add to it. WTF, +jobs.

&transparent [search(ETHING=t(member(name(##), FACTION)))]=
&transparent [search(ETHING=t(member(name(##), CG)))]=
&transparent [search(ETHING=t(member(name(##), PLOTS)))]=
&transparent [search(ETHING=t(member(name(##), REQUESTS)))]=
&transparent [search(ETHING=t(member(name(##), SOCIAL)))]=
&transparent [search(ETHING=t(member(name(##), BUILD)))]=
&transparent [search(ETHING=t(member(name(##), CODE)))]=
&transparent [search(ETHING=t(member(name(##), QUERY)))]=
&transparent [search(ETHING=t(member(name(##), PUBLIC)))]=1

&access [search(ETHING=t(member(name(##), PUBLIC)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), PUBLIC)))]=1
&publish [search(ETHING=t(member(name(##), PUBLIC)))]=1
&hook_cre [search(ETHING=t(member(name(##), PUBLIC)))]=@set %0/COMMENT_1=no_inherit
&HOOK_ADD [search(ETHING=t(member(name(##), PUBLIC)))]=@set %0/[dec(get(%0/NUM_COMMENT))]=no_inherit

&access [search(ETHING=t(member(name(##), FACTION)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), FACTION)))]=1

&access [search(ETHING=t(member(name(##), CG)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), CG)))]=1
&turnaround [search(ETHING=t(member(name(##), CG)))]=168

&hook_oth [search(ETHING=t(member(name(##), CG)))]=@set [xget(%0, opened_by)]=_chargen-job:%0;

@force me=&vC [search(ETHING=t(member(name(##), CG)))]=[v(d.cg)]

&hook_apr [search(ETHING=t(member(name(##), CG)))]=@set [xget(%0, opened_by)]=_chargen-job:; @trigger %vC/tr.approve-player=xget(%0, opened_by), %1;

&MLETTER_OTH [search(ETHING=t(member(name(##), CG)))]=You have requested character approval from staff. The job is '[name(%0)]: [get(%0/TITLE)]':%r%r%3%r%r[divider(Help, %2)]%r See '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r[divider(Turnaround, %2)]%r Our motto for chargen jobs is: "This is the fun part! Woohoo!" That means we'll rarely keep you waiting. We'll wait up to a week for responses, but hopefully you're more excited to play than that.%r%r The official turnaround time for CG jobs is [div(u(me/TURNAROUND), 24)] days. If you haven't heard from us by then, please reach out with a message on this +job or by paging us. Our actual turnaround time is typically much quicker, and depending on how responsive each player is, you can expect a decision within 1-3 days.

&access [search(ETHING=t(member(name(##), PLOTS)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), PLOTS)))]=1

&access [search(ETHING=t(member(name(##), REQUESTS)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), REQUESTS)))]=1
&hook_cre [search(ETHING=t(member(name(##), REQUESTS)))]=@set %0/COMMENT_1=no_inherit
&turnaround [search(ETHING=t(member(name(##), REQUESTS)))]=168
&logfile [search(ETHING=t(member(name(##), REQUESTS)))]=reqlog
&MLETTER_OTH [search(ETHING=t(member(name(##), REQUESTS)))]=You have requested '[name(%0)]: [get(%0/TITLE)]' from staff: %r%r%3%r%r[repeat(-, 75)]%rSee '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%rPlease give staff at least [div(u(me/TURNAROUND), 24)] days from the date of this mail to process your request.

&access [search(ETHING=t(member(name(##), SOCIAL)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), SOCIAL)))]=1
&hook_cre [search(ETHING=t(member(name(##), SOCIAL)))]=@set %0/COMMENT_1=no_inherit
&turnaround [search(ETHING=t(member(name(##), SOCIAL)))]=72
&logfile [search(ETHING=t(member(name(##), SOCIAL)))]=sociallog
&priority [search(ETHING=t(member(name(##), SOCIAL)))]=1
&MLETTER_OTH [search(ETHING=t(member(name(##), SOCIAL)))]=You have alerted staff to a social issue regarding '[get(%0/TITLE)]': %r%r%3%r%r[repeat(-, 75)]%rSee '[ansi(h, +help myjobs)]' for help on how to display and add to your jobs.%r%rPlease give staff at least [u(me/TURNAROUND)] hours from the date of this mail to process your request. If it's urgent, contact [xget(%vZ, d.staff-email-address)] or page a member of +staff right away.

&access [search(ETHING=t(member(name(##), LTP)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), LTP)))]=1

&access [search(ETHING=t(member(name(##), DOWNTIME)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), DOWNTIME)))]=1

&access [search(ETHING=t(member(name(##), CHARACTERS)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), CHARACTERS)))]=1

@@ Set the default bucket to REQUESTS since REQ is gone.
&f.get.bucket [v(d.jrs)]=udefault(d.%0.bucket, REQUESTS)

@@ Set the default bucket to REQUESTS since REQ is gone.
&d.request.bucket [v(d.jrs)]=REQUESTS

@@ Getting rid of pitches.
&CMD_PITCH [v(JOB_GO)]=$+pitch*:@pemit %#=alert(+jobs) We are not currently accepting pitches. If it's an idea for a plot you want to run, +plot <title>=<info>! If you'd like a change to your sheet, +request Sheet change=<info>.
