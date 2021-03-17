CherrygroveBay_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  22, 22, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event  22, 21, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_CHERRYGROVEBAY
	bg_event  23, 21, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_CHERRYGROVEBAY

	def_object_events
	object_event  9, 32, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveBayHikerScript, -1
	object_event 21, 22, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerHikerTony, -1
	object_event 15, 43, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CherrygroveBayFisherText, -1
	object_event  7, 39, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmermThomas, -1
	object_event  7, 22, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfSally, -1
	object_event 22, 39, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfTara, -1
	itemball_event 22, 24, SHINY_STONE, 1, EVENT_CHERRYGROVE_BAY_SHINY_STONE
	cuttree_event  3,  8, EVENT_CHERRYGROVE_BAY_CUT_TREE

CherrygroveBayHikerScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_EARTH_POWER_INTRO
	iftrue CherrygroveBayTutorEarthPowerScript
	writetext CherrygroveBayHikerText
	waitbutton
	setevent EVENT_LISTENED_TO_EARTH_POWER_INTRO
CherrygroveBayTutorEarthPowerScript:
	writetext Text_CherrygroveBayTutorEarthPower
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_CherrygroveBayTutorQuestion
	yesorno
	iffalse .TutorRefused
	setval EARTH_POWER
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpopenedtext Text_CherrygroveBayTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_CherrygroveBayTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_CherrygroveBayTutorTaught

GenericTrainerSwimmermThomas:
	generictrainer SWIMMERM, THOMAS, EVENT_BEAT_SWIMMERM_THOMAS, .SeenText, .BeatenText

	text "My #mon knows"
	line "how to Surf, but"
	cont "I prefer swimming."
	done

.SeenText:
	text "Do you know how to"
	line "swim? I can teach"
	cont "you, if you want."
	done

.BeatenText:
	text "Glub, glub, glub…"
	done

GenericTrainerSwimmerfSally:
	generictrainer SWIMMERF, SALLY, EVENT_BEAT_SWIMMERF_SALLY, .SeenText, .BeatenText

	text "I like drifting on"
	line "the waves along-"
	cont "side my #mon!"
	done

.SeenText:
	text "I like this bay."
	line "Its waters are so"

	para "much calmer than"
	line "the open ocean."
	done

.BeatenText:
	text "I don't like"
	line "losing, however…"
	done

GenericTrainerSwimmerfTara:
	generictrainer SWIMMERF, TARA, EVENT_BEAT_SWIMMERF_TARA, .SeenText, .BeatenText

	text "There's a grove of"
	line "golden trees north"
	cont "of Ecruteak City."

	para "I'd love to visit"
	line "someday."
	done

.SeenText:
	text "Ah, swimming amid"
	line "cherry blossoms is"
	cont "so relaxing!"
	done

.BeatenText:
	text "I don't even mind"
	line "losing…"
	done

GenericTrainerHikerTony:
	generictrainer HIKER, TONY, EVENT_BEAT_HIKER_TONY, .SeenText, .BeatenText

	text "After a long hike,"
	line "resting under the"

	para "cherry trees hits"
	line "the spot."
	done

.SeenText:
	text "I hiked through"
	line "miles of woods"
	cont "to get here!"
	done

.BeatenText:
	text "I'm exhausted…"
	done

CherrygroveBayFisherText:
	text "I can watch"
	line "Cherrygrove City"

	para "from afar while"
	line "I fish."
	done

CherrygroveBayHikerText:
	text "I don't believe in"
	line "legendary #mon"
	cont "creation myths."

	para "Johto was formed"
	line "over millions of"

	para "years by the power"
	line "of the earth!"
	done

Text_CherrygroveBayTutorEarthPower:
	text "I can teach your"
	line "#mon how to"

	para "use Earth Power"
	line "for a Silver Leaf."
	done

Text_CherrygroveBayTutorNoSilverLeaf:
	text "You don't have any"
	line "Silver Leaves…"
	done

Text_CherrygroveBayTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Earth Power?"
	done

Text_CherrygroveBayTutorRefused:
	text "Oh well."
	done

Text_CherrygroveBayTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Earth Power."
	done
