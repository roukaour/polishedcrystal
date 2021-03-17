OlivineCity_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, OlivineCityFlyPoint

	def_warp_events
	warp_event 13, 17, OLIVINE_POKECENTER_1F, 1
	warp_event 10,  7, OLIVINE_GYM, 1
	warp_event 25,  7, OLIVINE_TIMS_HOUSE, 1
	warp_event 29,  7, OLIVINE_PUNISHMENT_SPEECH_HOUSE, 1
	warp_event 13, 11, OLIVINE_GOOD_ROD_HOUSE, 1
	warp_event  7, 17, OLIVINE_CAFE, 1
	warp_event 19, 13, OLIVINE_MART, 2
	warp_event 33, 19, OLIVINE_LIGHTHOUSE_1F, 1
	warp_event 19, 31, OLIVINE_PORT_PASSAGE, 1
	warp_event 20, 31, OLIVINE_PORT_PASSAGE, 2
	warp_event 57, 30, ROUTE_35_NATIONAL_PARK_GATE, 5
	warp_event 57, 31, ROUTE_35_NATIONAL_PARK_GATE, 6
	warp_event 49, 16, HIDDEN_TREE_GROTTO, 1

	def_coord_events
	coord_event 10,  8, 0, OlivineCityRivalGymScript
	coord_event 33, 23, 0, OlivineCityRivalLighthouseScript

	def_bg_events
	bg_event 17,  7, BGEVENT_JUMPTEXT, OlivineCitySignText
	bg_event 20, 22, BGEVENT_JUMPTEXT, OlivineCityPortSignText
	bg_event  7,  7, BGEVENT_JUMPTEXT, OlivineGymSignText
	bg_event 34, 20, BGEVENT_JUMPTEXT, OlivineLighthouseSignText
	bg_event  1, 21, BGEVENT_JUMPTEXT, OlivineCityBattleTowerSignText
	bg_event 50, 27, BGEVENT_JUMPTEXT, OlivineCityPokeathlonDomeSignText
	bg_event 36, 14, BGEVENT_ITEM + RARE_CANDY, EVENT_OLIVINE_CITY_HIDDEN_RARE_CANDY
	bg_event 47, 17, BGEVENT_ITEM + BIG_PEARL, EVENT_OLIVINE_CITY_HIDDEN_BIG_PEARL
	bg_event 49, 29, BGEVENT_ITEM + SOFT_SAND, EVENT_OLIVINE_CITY_HIDDEN_SOFT_SAND
	bg_event  48, 15, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_OLIVINE_CITY
	bg_event  49, 15, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_OLIVINE_CITY

	def_object_events
	object_event 10,  7, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
	object_event 20,  8, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineCityYoungster1Script, -1
	object_event 26, 22, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor1Text, -1
	object_event 15, 21, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 1 << EVE, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor2Text, -1
	object_event 31, 17, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << MORN) | (1 << DAY), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCityFisherText, -1
	object_event 31, 17, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << EVE) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor3Text, -1
	object_event 18, 26, SPRITE_MATRON, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCityPokefanFText, -1
	object_event 21, 27, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << MORN) | (1 << NITE), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCityPokefanMText, -1
	object_event 23, 16, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor4Text, -1
	object_event 23, 17, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCitySailor5Text, -1
	object_event 26, 11, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, (1 << MORN) | (1 << EVE), PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCityLass1Text, -1
	object_event 28, 11, SPRITE_CAMPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << DAY) | (1 << NITE), 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCityYoungster2Text, -1
	object_event  8, 21, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, (1 << MORN) | (1 << DAY) | (1 << EVE), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlivineCityLass2Text, -1
	smashrock_event 52, 23
	smashrock_event 55, 26

	object_const_def
	const OLIVINECITY_OLIVINE_RIVAL

OlivineCityFlyPoint:
	setflag ENGINE_FLYPOINT_OLIVINE
	endcallback

OlivineCityRivalGymScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	playsound SFX_TACKLE
	applymovement PLAYER, OlivineCityMovementData_ShovePlayerDown
	applyonemovement OLIVINECITY_OLIVINE_RIVAL, step_down
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext OlivineCityRivalGymText
	turnobject PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalLeavesGym
	setscene $1
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	end

OlivineCityRivalLighthouseScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	moveobject OLIVINECITY_OLIVINE_RIVAL, 33, 19
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalExitsLighthouse
	playmusic MUSIC_RIVAL_ENCOUNTER
	showtext OlivineCityRivalLighthouseText
	playsound SFX_TACKLE
	applymovement PLAYER, OlivineCityMovementData_ShovePlayerDown2
	turnobject PLAYER, LEFT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityMovementData_RivalLeavesLighthouse
	setscene $1
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	end

OlivineCityYoungster1Script:
	random 2
	iffalse_jumptextfaceplayer OlivineCityStandingYoungsterPokedexText
	jumpthistextfaceplayer

	text "That thing you"
	line "have--it's a #-"
	cont "gear, right? Wow,"
	cont "that's cool."
	done

OlivineCityMovementData_ShovePlayerDown:
	turn_head_up
	fix_facing
	step_down
	remove_fixed_facing
	step_end

OlivineCityMovementData_RivalExitsLighthouse:
	step_down
	step_down
	step_down
	step_end

OlivineCityMovementData_RivalLeavesGym:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

OlivineCityMovementData_ShovePlayerDown2:
	turn_head_up
	fix_facing
	jump_step_down
	remove_fixed_facing
	step_end

OlivineCityMovementData_RivalLeavesLighthouse:
	step_down
	step_down
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

OlivineCityRivalGymText:
	text "…"

	para "You again?"

	para "There's no need to"
	line "panic. I don't"

	para "bother with wimps"
	line "like you."

	para "Speaking of weak-"
	line "lings, the city's"

	para "Gym Leader isn't"
	line "here."

	para "Supposedly taking"
	line "care of a sick"

	para "#mon at the"
	line "Lighthouse."

	para "Humph! Boo-hoo!"
	line "Just let sick"
	cont "#mon go!"

	para "A #mon that"
	line "can't battle is"
	cont "worthless!"

	para "Why don't you go"
	line "train at the"
	cont "Lighthouse?"

	para "Who knows. It may"
	line "make you a bit"
	cont "less weak!"
	done

OlivineCityRivalLighthouseText:
	text "…"

	para "You again?"

	para "There's no need to"
	line "panic. I don't"

	para "bother with wimps"
	line "like you."

	para "Speaking of weak-"
	line "lings, the city's"

	para "Gym Leader is"
	line "taking care of a"

	para "sick #mon in"
	line "the Lighthouse."

	para "Humph! Boo-hoo!"
	line "Just let sick"
	cont "#mon go!"

	para "A #mon that"
	line "can't battle is"
	cont "worthless!"

	para "Why don't you go"
	line "train inside?"

	para "Who knows. It may"
	line "make you a bit"
	cont "less weak!"
	done

OlivineCityStandingYoungsterPokedexText:
	text "Wow, you have a"
	line "#dex!"

	para "That is just so"
	line "awesome."
	done

OlivineCitySailor1Text:
	text "Dark roads are"
	line "dangerous at"
	cont "night."

	para "But in the pitch-"
	line "black of night,"

	para "the sea is even"
	line "more treacherous!"

	para "Without the beacon"
	line "of the Lighthouse"

	para "to guide it, no"
	line "ship can sail."
	done

OlivineCitySailor2Text:
	text "The sea is sweet!"

	para "Sunsets on the sea"
	line "are marvelous!"

	para "Sing with me!"
	line "♪ Yo-ho! Blow the"
	cont "man down!… ♪"
	done

OlivineCityFisherText:
	text "You remind me of"
	line "a kid who used to"
	cont "live here."

	para "The family moved"
	line "away when their"

	para "father became a"
	line "Gym Leader in"
	cont "another region."
	done

OlivineCitySailor3Text:
	text "To see the Light-"
	line "house illuminate"

	para "the sea at night--"
	line "it's beautiful!"
	done

OlivineCityPokefanFText:
	text "Have you been to"
	line "Olivine Café?"

	para "The food is"
	line "delicious."
	done

OlivineCityPokefanMText:
	text "Most trainers who"
	line "visit Olivine head"

	para "straight for the"
	line "Battle Tower."

	para "Only the best can"
	line "compete there."
	done

OlivineCitySailor4Text:
	text "♪ A home like"
	line "O-li-vine,"

	para "I'm so hap-py I"
	line "can call you mine,"

	para "Next to the deep"
	line "blue brine,"

	para "Ci-ty oh so"
	line "di-vine,"

	para "Shine bright my"
	line "O-li-vine!… ♪"
	done

OlivineCitySailor5Text:
	text "Us sailors love"
	line "a sing-song."
	cont "Join in!"

	para "♪ From off the"
	line "plank,"

	para "'twas then he"
	line "thank,"

	para "oh fiddle-dee"
	line "fiddle-dee dee… ♪"
	done

OlivineCityLass1Text:
	text "The sailors here"
	line "may seem like a"

	para "handful, but"
	line "they're harmless."
	done

OlivineCityYoungster2Text:
	text "Sailors and camp-"
	line "ers have something"
	cont "in common:"

	para "we both like to"
	line "sing!"

	para "But sailors' songs"
	line "are really…"
	cont "different."
	done

OlivineCityLass2Text:
	text "Jasmine, our Gym"
	line "Leader, is a shy"

	para "girl. She's no"
	line "pushover, mind!"
	done

OlivineCitySignText:
	text "Olivine City"

	para "The Port Closest"
	line "to Foreign Lands"
	done

OlivineCityPortSignText:
	text "Olivine Port"
	line "Fast Ship Pier"
	done

OlivineGymSignText:
	text "Olivine City"
	line "#mon Gym"
	cont "Leader: Jasmine"

	para "The Steel-Clad"
	line "Defense Girl"
	done

OlivineLighthouseSignText:
	text "Olivine Lighthouse"
	line "Also known as the"
	cont "Glitter Lighthouse"
	done

OlivineCityBattleTowerSignText:
	text "Battle Tower Ahead"
	line "Opening Now!"
	done

OlivineCityPokeathlonDomeSignText:
	text "The #athlon"
	line "Project Has"
	cont "Started!"
	done
