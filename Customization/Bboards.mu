@@ First, a tiny hack (Myrddin forgive me):

&fn_bbs_staff [v(dbref_bbpocket)]=isstaff(%0)

@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@
@@ Board creation stuff
@@ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @@

+bbnewgroup Announcements

+bbnewgroup Events

+bbnewgroup Theme

+bbnewgroup Doskvol News

+bbnewgroup Doskvol Rumors

@wait 1=+bbconfig Theme/timeout=0

@wait 1=+bbconfig Doskvol News/timeout=365
