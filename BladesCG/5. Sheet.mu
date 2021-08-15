
&c.+sheet [v(d.cg)]=$+sheet:@pemit %#=ulocal(layout.page1, %#, %#); @assert isapproved(%#)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %#, %#)); };

&c.+sheet_all [v(d.cg)]=$+sheet/all:@pemit %#=ulocal(layout.page1, %#, %#); @pemit %#=ulocal(layout.page2, %#, %#); @assert isapproved(%#)={ @pemit %#=strcat(%r, ulocal(layout.cg-errors, %#, %#)); };

&c.+sheet_page [v(d.cg)]=$+sheet/*:@assert not(strmatch(%0, * *)); @assert not(strmatch(%0, all)); @eval setq(V, if(member(1 2, %0), page%0, %0)); @assert t(setr(S, finditem(setr(L, ulocal(f.list-sheet-sections)), %qV, |)))={ @trigger me/tr.error=%#, Could not find the section of the sheet starting with '%0'. Valid sections are 'all' or: [itemize(%qL, |)].; }; @pemit %#=ulocal(strcat(layout., switch(%qS, page*, %qS, subsection)), switch(%qS, page*, %#, %qS), %#, %#);

&c.+stat [v(d.cg)]=$+stats:@pemit %#=ulocal(layout.sheet, %#, %#)
