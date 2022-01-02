@@ Tests:

@@ Create a Crew
@@ Set a crew up partially
@@ Create a new crew (wipes old crew)

@@ Invite someone to join your crew
@@ Invitation when you are not approved and they are (should fail)
@@ Invitation when you are approved and they are not (should succeed)
@@ Invitation when both are unapproved (should succeed)

@wait 1=+stat/set crew type=assassins
@wait 2=+crew2
@wait 3=+stat/set crew type=bravos
@wait 4=+crew2
@wait 5=+stat/set crew type=cult
@wait 6=+crew2
@wait 7=+stat/set crew type=hawkers
@wait 8=+crew2
@wait 9=+stat/set crew type=shadows
@wait 10=+crew2
@wait 11=+stat/set crew type=smugglers
@wait 12=+crew2
