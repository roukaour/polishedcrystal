SilverCaveOutside_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, SilverCaveOutsideFlyPoint

	def_warp_events
	warp_event 23, 13, SILVER_CAVE_POKECENTER_1F, 1
	warp_event 18,  5, SILVER_CAVE_ROOM_1, 1
	warp_event  5, 20, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 17,  7, BGEVENT_JUMPTEXT, MtSilverSignText
	bg_event  9, 19, BGEVENT_ITEM + FULL_RESTORE, EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE
	bg_event  4, 19, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_SILVER_CAVE_OUTSIDE
	bg_event  5, 19, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_SILVER_CAVE_OUTSIDE

	def_object_events
	cuttree_event 31, 18, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_1
	cuttree_event 34, 17, EVENT_SILVER_CAVE_OUTSIDE_CUT_TREE_2

SilverCaveOutsideFlyPoint:
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	endcallback

MtSilverSignText:
	text "Mt.Silver"
	done
