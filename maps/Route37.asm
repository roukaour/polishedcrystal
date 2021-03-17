Route37_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, SunnyCallback

	def_warp_events
	warp_event  11, 18, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event  5,  3, BGEVENT_JUMPTEXT, Route37SignText
	bg_event  4,  2, BGEVENT_ITEM + ETHER, EVENT_ROUTE_37_HIDDEN_ETHER
	bg_event 10, 17, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_37
	bg_event 11, 17, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_37

	def_object_events
	object_event 16,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SunnyScript, EVENT_ROUTE_37_SUNNY_OF_SUNDAY
	object_event  6, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsToriandtil1, -1
	object_event  7, 12, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerTwinsToriandtil2, -1
	object_event 14, 11, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicGreg, -1
	object_event  4,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyCallie, -1
	object_event  9,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyCassandra, -1
	fruittree_event 13,  5, FRUITTREE_ROUTE_37_1, RED_APRICORN, PAL_NPC_RED
	fruittree_event 16,  5, FRUITTREE_ROUTE_37_2, BLU_APRICORN, PAL_NPC_BLUE
	fruittree_event 15,  7, FRUITTREE_ROUTE_37_3, BLK_APRICORN, PAL_NPC_PURPLE

	object_const_def
	const ROUTE37_SUNNY

SunnyCallback:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .SunnyAppears
	disappear ROUTE37_SUNNY
	endcallback

.SunnyAppears:
	appear ROUTE37_SUNNY
	endcallback

GenericTrainerTwinsToriandtil1:
	generictrainer TWINS, ANNANDANNE1, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsToriandtil1SeenText, TwinsToriandtil1BeatenText

	text "Til: I can tell"
	line "what my sister and"

	para "my #mon are"
	line "thinking."
	done

GenericTrainerTwinsToriandtil2:
	generictrainer TWINS, ANNANDANNE2, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsToriandtil2SeenText, TwinsToriandtil2BeatenText

	text "Tori: We share the"
	line "same feelings as"
	cont "our #mon."
	done

GenericTrainerPsychicGreg:
	generictrainer PSYCHIC_T, GREG, EVENT_BEAT_PSYCHIC_GREG, PsychicGregSeenText, PsychicGregBeatenText

	text "Putting #mon to"
	line "sleep or paralyz-"
	cont "ing them are good"
	cont "battle techniques."
	done

SunnyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MAGNET_FROM_SUNNY
	iftrue SunnySundayScript
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, SunnyNotSundayScript
	checkevent EVENT_MET_SUNNY_OF_SUNDAY
	iftrue .MetSunny
	writetext MeetSunnyText
	promptbutton
	setevent EVENT_MET_SUNNY_OF_SUNDAY
.MetSunny:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Kris
	writetext SunnyGivesGiftText1
	promptbutton
	sjump .next
.Kris:
	writetext SunnyGivesGiftText2
	promptbutton
.next
	verbosegiveitem MAGNET
	iffalse SunnyDoneScript
	setevent EVENT_GOT_MAGNET_FROM_SUNNY
	jumpopenedtext SunnyGaveGiftText

SunnySundayScript:
	writetext SunnySundayText
	waitbutton
SunnyDoneScript:
	endtext

SunnyNotSundayScript:
	jumpopenedtext SunnyNotSundayText

GenericTrainerBeautyCallie:
	generictrainer BEAUTY, CALLIE, EVENT_BEAT_BEAUTY_CALLIE, BeautyCallieSeenText, BeautyCallieBeatenText

	text "Wow, you're cute"
	line "and skilled too!"
	done

GenericTrainerBeautyCassandra:
	generictrainer BEAUTY, CASSANDRA, EVENT_BEAT_BEAUTY_CASSANDRA, BeautyCassandraSeenText, BeautyCassandraBeatenText

	text "People like you"
	line "are skilled even"

	para "though they're"
	line "young…"
	done

TwinsToriandtil1SeenText:
	text "Til: Tori and I"
	line "are in this to-"
	cont "gether!"
	done

TwinsToriandtil1BeatenText:
TwinsToriandtil2BeatenText:
	text "Til & Tori: Nnn… A"
	line "little too strong."
	done

TwinsToriandtil2SeenText:
	text "Tori: Til and I"
	line "are in this to-"
	cont "gether!"
	done

PsychicGregSeenText:
	text "#mon can't do a"
	line "thing if they are"
	cont "asleep."

	para "I'll show you how"
	line "scary that is!"
	done

PsychicGregBeatenText:
	text "I lost. That's"
	line "pretty sad…"
	done

MeetSunnyText:
	text "Sunny: Hi!"

	para "I'm Sunny of Sun-"
	line "day, meaning it's"
	cont "Sunday today!"
	done

SunnyGivesGiftText1:
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
	done

SunnyGivesGiftText2:
	text "I was told to give"
	line "you this if I saw"
	cont "you!"
	done

SunnyGaveGiftText:
	text "Sunny: That thing…"

	para "Um…"

	para "…What was it now…"

	para "…"

	para "Oh! I remember"
	line "now!"

	para "A #mon that"
	line "knows Electric"

	para "moves should hold"
	line "it."

	para "My sis Monica said"
	line "it powers up"
	cont "Electric moves!"
	done

SunnySundayText:
	text "Sunny: My sisters"
	line "and brothers are"
	cont "Monica, Tuscany,"
	cont "Wesley, Arthur,"
	cont "Frieda and Santos."

	para "They're all older"
	line "than me!"
	done

SunnyNotSundayText:
	text "Sunny: Isn't today"
	line "Sunday?"
	cont "Um… I forgot!"
	done

BeautyCallieSeenText:
	text "Oh, you're a cute"
	line "little trainer!"

	para "Why don't you"
	line "battle me?"
	done

BeautyCallieBeatenText:
	text "You're good…"
	done

BeautyCassandraSeenText:
	text "Hey hey there,"
	line "you young trainer!"

	para "Won't you battle"
	line "with me?"
	done

BeautyCassandraBeatenText:
	text "Wow, you're strong…"
	done

Route37SignText:
	text "Route 37"
	done
