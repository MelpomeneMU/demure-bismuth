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

&access [search(ETHING=t(member(name(##), FACTION)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), FACTION)))]=1

&access [search(ETHING=t(member(name(##), CG)))]=[u(%va/FN_STAFFALL, %#)]
&public [search(ETHING=t(member(name(##), CG)))]=1

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

@@ Set the default bucket to REQUESTS since REQ is gone.
&f.get.bucket [v(d.jrs)]=udefault(d.%0.bucket, REQUESTS)

@@ Set the default bucket to REQUESTS since REQ is gone.
&d.request.bucket [v(d.jrs)]=REQUESTS

@@ Getting rid of pitches.
&CMD_PITCH [v(JOB_GO)]=$+pitch*:@pemit %#=alert(+jobs) We are not currently accepting pitches. If it's an idea for a plot you want to run, +plot <title>=<info>! If you'd like a change to your sheet, +request Sheet change=<info>.
