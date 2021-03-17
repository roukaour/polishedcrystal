StormyBeach_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 30,  4, MURKY_SWAMP, 1
	warp_event 31,  4, MURKY_SWAMP, 2
	warp_event 19, 8, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 17,  6, BGEVENT_ITEM + STARDUST, EVENT_STORMY_BEACH_HIDDEN_STARDUST
	bg_event  19, 7, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_STORMY_BEACH
	bg_event  18, 7, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_STORMY_BEACH

	def_object_events
	object_event  5, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfBarbara, -1
	object_event 14,  8, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperJulian, -1
	object_event 28,  7, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerCamperFelix, -1
	object_event 24, 11, SPRITE_PICNICKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPicnickerLily, -1
	object_event 26, 17, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIM_AROUND, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, StormyBeachSwimmermText, -1
	object_event 32, 12, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, StormyBeachGrampsText, -1
	itemball_event 34,  7, ZINC, 1, EVENT_STORMY_BEACH_ZINC
	smashrock_event 16, 6
	smashrock_event 17, 7
	smashrock_event 12, 9
	smashrock_event 18, 10

GenericTrainerSwimmerfBarbara:
	generictrainer SWIMMERF, BARBARA, EVENT_BEAT_SWIMMERF_BARBARA, .SeenText, .BeatenText

	text "I'm being dragged"
	line "by the tides…"
	done

.SeenText:
	text "I was resting for"
	line "a while, but I am"

	para "always ready to"
	line "fight!"
	done

.BeatenText:
	text "It was a good"
	line "battle, even if"
	cont "I lost."
	done

GenericTrainerBird_keeperJulian:
	generictrainer BIRD_KEEPER, JULIAN, EVENT_BEAT_BIRD_KEEPER_JULIAN, .SeenText, .BeatenText

	text "It's harder to fly"
	line "in stormy places"
	cont "like this."
	done

.SeenText:
	text "I'm training my"
	line "Flying-type #-"
	cont "mon here."

	para "Want to help me?"
	done

.BeatenText:
	text "I lost…"
	line "What a pity!"
	done

GenericTrainerCamperFelix:
	generictrainer CAMPER, FELIX, EVENT_BEAT_CAMPER_FELIX, .SeenText, .BeatenText

	text "We're having a"
	line "barbecue later!"

	para "All I need is some"
	line "firewood for my"
	cont "#mon to light."
	done

.SeenText:
	text "I'm searching for"
	line "firewood."
	cont "Wanna help?"
	done

.BeatenText:
	text "I'll take that as"
	line "a no…"
	done

GenericTrainerPicnickerLily:
	generictrainer PICNICKER, LILY, EVENT_BEAT_PICNICKER_LILY, .SeenText, .BeatenText

	text "I came here for a"
	line "picnic, but forgot"
	cont "the food!"
	cont "How embarrassing!"
	done

.SeenText:
	text "I'm hungry!"
	done

.BeatenText:
	text "I was battling on"
	line "an empty stomach!"
	done

StormyBeachSwimmermText:
	text "We're here on a"
	line "camping trip,"

	para "but the weather"
	line "doesn't look great…"
	done

StormyBeachGrampsText:
	text "Can you feel it in"
	line "the air? A storm"
	cont "is brewing."

	para "A befitting omen"
	line "for those looking"
	cont "to explore the"
	cont "swamp."
	done
