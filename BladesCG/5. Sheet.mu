/*

TODO: Add sheet-sharing, not just showing. So that people can +sheets and +sheet <name> if they have permission.

Questions: What about crew sheet sharing?

+sheet/share <player>
+sheet/unshare <player>
+sheets - see all the sheets shared with you and all the people you've shared your sheet with
+sheet <name>

TODO: +sheet/prove
*/

&c.+sheet [v(d.cg)]=$+sheet:@pemit %#=ulocal(layout.page1, %#, %#); @assert hasattr(%#, _stat.locked)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %#, %#)); };

&c.sheet [v(d.cg)]=$sheet*:@force %#=+sheet%0;

&c.+sheet_player [v(d.cg)]=$+sheet *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view someone else's sheet.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.page1, %qP, %#); @assert isapproved(%qP)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %qP, %#)); };

&c.+sheet_all [v(d.cg)]=$+sheet/all:@pemit %#=ulocal(layout.page1, %#, %#); @pemit %#=ulocal(layout.page2, %#, %#); @assert hasattr(%#, _stat.locked)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %#, %#)); };

&c.+sheet_all_player [v(d.cg)]=$+sheet/all *:@assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view someone else's sheet.; }; @assert t(setr(P, ulocal(f.find-player, %0, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%0'.; }; @pemit %#=ulocal(layout.page1, %qP, %#); @pemit %#=ulocal(layout.page2, %qP, %#); @assert isapproved(%qP)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %qP, %#)); };

&c.+sheet_page [v(d.cg)]=$+sheet/*:@break cand(isstaff(%#), strmatch(%0, * *)); @break t(finditem(all|lock, %0, |)); @assert cor(not(strmatch(%0, crew*)), t(ulocal(f.get-player-stat, %#, crew object)))={ @trigger me/tr.error=%#, You're not on a crew yet. +crew/join or +crew/create one!; }; @eval setq(V, if(member(1 2, %0), page%0, %0)); @assert t(setr(S, finditem(setr(L, ulocal(f.list-sheet-sections)), %qV, |)))={ @trigger me/tr.error=%#, Could not find the section of the sheet starting with '%0'. Valid sections are 'all' or: [itemize(%qL, |)].; }; @pemit %#=ulocal(layout.subsection, %qS, %#, %#); @assert cor(not(strmatch(%0, crew*)), hasattr(ulocal(f.get-player-stat, %#, crew object), _stat.crew_locked))={ @pemit %#=strcat(%r, ulocal(layout.crew-cg-errors, %#, %#)); };

&c.+sheet_page_player [v(d.cg)]=$+sheet/* *:@break strmatch(%0, all); @assert isstaff(%#)={ @trigger me/tr.error=%#, You must be staff to view someone else's sheet.; }; @assert t(setr(P, ulocal(f.find-player, %1, %#)))={ @trigger me/tr.error=%#, Could not find a player named '%1'.; }; @assert cor(not(strmatch(%0, crew*)), t(ulocal(f.get-player-stat, %qP, crew object)))={ @trigger me/tr.error=%#, ulocal(f.get-name, %qP) is not on a crew yet.; }; @eval setq(V, if(member(1 2, %0), page%0, %0)); @assert t(setr(S, finditem(setr(L, ulocal(f.list-sheet-sections)), %qV, |)))={ @trigger me/tr.error=%#, Could not find the section of the sheet starting with '%0'. Valid sections are 'all' or: [itemize(%qL, |)].; }; @pemit %#=ulocal(layout.subsection, %qS, %qP, %#); @assert cor(not(strmatch(%0, crew*)), hasattr(ulocal(f.get-player-stat, %qP, crew object), _stat.crew_locked))={ @pemit %#=strcat(%r, ulocal(layout.crew-cg-errors, %qP, %#)); };

