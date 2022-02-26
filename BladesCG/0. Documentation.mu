/*
Requirements: byzantine-opal

Commands:
	+sheet and +stats - same thing
	+sheet/all - show all the pages of your sheet
	+sheet/1, 2, etc - show just that page

Chargen:
	+stat/set <stat>=<value>
	+stat/add <stat>=<value>
	+stats/clear - clear your stats. Will ask if you're sure first.
	+stats/lock - lock your stats and request approval.
	+stats/unlock - unlock your stats. Will ask if you're sure before proceeding if you're already approved.

Staff commands:
	+stat/set <player>/<stat>=<value>
	+stat/add <player>/<section>=<value>
	+stat/remove <player>/<section>=<value>
	+approve <player>=<comment>
	+uunapprove <player>=<comment>

Gear:
	+gear
	
	+gear/load <light|normal|heavy|encumbered> - set your load, reset your marks and tags, will ask if you're sure

	+gear/mark <gear> - mark it as present for a score
	+gear/unmark <gear> or all
	+gear/tag <gear>=<tag> - tag small changes like "Stolen" or "Possessed"
	+gear/untag <gear> or all

	+gear/drop <gear> - will ask if you're sure

Staff gear commands:
	+gear/give <player>=<gear> - 0L Example; 1L Fancy Sword; etc.
	+gear/take <player>=<gear> - will only take from their "other gear" list, manual editing will be required to remove gear from other lists.

XP:
	+xp
	+xp/buy <stat>
	+xp/unwind <player>/<action>
	+xp/award <player>/<attribute or playbook>=<amount>
	+xp/unaward <player>/<attribute or playbook>=<amount>

Healing and harming:
	+health
	+harm Shanked 2
	+harm Gravely insulted
	+harm L2 Defenestrated
	+heal 1, 2, 3, or 5 - tick your healing clock based on your healer's rolls. When the clock reaches 4, you heal a level of harm.

*/