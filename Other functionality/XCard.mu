/*
The X card was designed by John Stavropoulos and you can read more about it here: https://tinyurl.com/x-card-rpg
*/

@create XCard Commands <XC>=10

@force me=&d.xc me=[search(ETHING=t(member(name(##), XCard Commands <XC>, |)))]

@force me=@parent [v(d.xc)]=[v(d.bf)]

@set [v(d.xc)]=SAFE INHERIT

@tel [v(d.xc)]=[config(master_room)]

&layout.xcard [v(d.xc)]=strcat(alert(XCard), %b, The X Card has been played. A player is uncomfortable with what's going on right now. Please adjust play or conversation to avoid the topic., if(t(trim(%0)), strcat(%b, The player provided the following %chcomment%cn:, %b, trim(%0))))

&c.+xcard [v(d.xc)]=$+xcard*:@trigger me/tr.remit=%l, ulocal(layout.xcard, %0), %#;

@@ TODO: /flags - /com? /page? /job, /msg?

