Route48_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route48JessieJamesCallback

	def_warp_events
	warp_event 11,  5, YELLOW_FOREST_GATE, 3
	warp_event  9, 16, HIDDEN_TREE_GROTTO, 1

	def_coord_events
	coord_event 20, 12, 0, Route48JessieJamesScript1
	coord_event 20, 13, 0, Route48JessieJamesScript2

	def_bg_events
	bg_event 27, 11, BGEVENT_JUMPTEXT, Route48YellowForestSignText
	bg_event  8, 15, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_48
	bg_event  9, 15, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_48

	def_object_events
	object_event 11,  6, SPRITE_ARCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerArcher2, EVENT_CLEARED_YELLOW_FOREST
	object_event 15, 12, SPRITE_JESSIE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_JESSIE
	object_event 26, 12, SPRITE_JAMES, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_JAMES
	object_event 11,  5, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ROUTE_48_NURSE
	itemball_event  4, 13, NUGGET, 1, EVENT_ROUTE_48_NUGGET

	object_const_def
	const ROUTE48_ARCHER
	const ROUTE48_JESSIE
	const ROUTE48_JAMES
	const ROUTE48_NURSE

Route48JessieJamesCallback:
	setflag ENGINE_FLYPOINT_YELLOW_FOREST
	disappear ROUTE48_JESSIE
	disappear ROUTE48_JAMES
	endcallback

Route48JessieJamesScript2:
	moveobject ROUTE48_JESSIE, 15, 13
	moveobject ROUTE48_JAMES, 26, 13
Route48JessieJamesScript1:
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	appear ROUTE48_JESSIE
	appear ROUTE48_JAMES
	playmusic MUSIC_JESSIE_JAMES_ENCOUNTER
	applymovement ROUTE48_JESSIE, JessieEnterMovementData
	applymovement ROUTE48_JAMES, JamesEnterMovementData
	showtext Route48JessieJamesSeenText
	setscene $1
	setevent EVENT_BEAT_JESSIE_AND_JAMES
	setevent EVENT_ROUTE_48_JESSIE
	setevent EVENT_ROUTE_48_JAMES
	winlosstext Route48JessieJamesBeatenText, 0
	setlasttalked ROUTE48_JESSIE
	loadtrainer JESSIE_JAMES, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special DeleteSavedMusic
	playmusic MUSIC_JESSIE_JAMES_ENCOUNTER
	showtext Route48JessieJamesAfterText
	applymovement ROUTE48_JESSIE, JessieLeaveMovementData
	applymovement ROUTE48_JAMES, JamesLeaveMovementData
	disappear ROUTE48_JESSIE
	disappear ROUTE48_JAMES
	playmapmusic
Route48JessieJamesScript_End:
	end

JessieEnterMovementData:
	step_right
	step_right
	step_right
	step_right
	step_end

JamesEnterMovementData:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end

JessieLeaveMovementData:
	run_step_left
	run_step_left
	run_step_left
	run_step_left
	step_end

JamesLeaveMovementData:
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	run_step_right
	step_end

TrainerArcher2:
	trainer ARCHER, ARCHER2, EVENT_BEAT_ARCHER_2, Archer2SeenText, Archer2BeatenText, 0, Archer2Script

Archer2Script:
	showtext Archer2AfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear ROUTE48_ARCHER
	pause 15
	special Special_FadeInQuickly
	setevent EVENT_CLEARED_YELLOW_FOREST
	clearevent EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	playsound SFX_ENTER_DOOR
	appear ROUTE48_NURSE
	waitsfx
	applyonemovement ROUTE48_NURSE, step_down
	setlasttalked ROUTE48_NURSE
	faceplayer
	showtext Route48NurseText1
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	showtext Route48NurseText2
	applyonemovement ROUTE48_NURSE, step_up
	playsound SFX_EXIT_BUILDING
	disappear ROUTE48_NURSE
	end

Route48JessieJamesSeenText:
	text "Stop right there,"
	line "twerp!"

	para "You know what"
	line "#mon lives in"
	cont "that forest?"
	cont "Pikachu!"

	para "The boss will be"
	line "pleased if we"

	para "capture a power-"
	line "ful one!"

	para "Surrender now, or"
	line "prepare to fight!"
	done

Route48JessieJamesBeatenText:
	text "A brat beat us?"
	done

Route48JessieJamesAfterText:
	text "Looks like Team"
	line "Rocket's blasting"
	cont "off again!"
	done

Archer2SeenText:
	text "So you want to"
	line "interfere with"

	para "Team Rocket's"
	line "plans again."

	para "Always sticking"
	line "your nose where it"
	cont "doesn't belong."

	para "We're selling"
	line "those #mon,"

	para "and there's nothing"
	line "you can do about"
	cont "it!"
	done

Archer2BeatenText:
	text "This is so"
	line "frustrating…"
	done

Archer2AfterText:
	text "…Have it your"
	line "way."

	para "Team Rocket will"
	line "withdraw for now."

	para "Our other plan is"
	line "going smoothly"
	cont "anyway…"
	done

Route48NurseText1:
	text "I saw your battle"
	line "from the window!"

	para "You drove away"
	line "Team Rocket"
	cont "and saved the"
	cont "Pikachu!"

	para "Thank you so"
	line "much!"

	para "Your #mon de-"
	line "serve a rest"
	cont "after all that."
	done

Route48NurseText2:
	text "I like to relax"
	line "here by the forest"
	cont "and watch the"
	cont "#mon play."

	para "I'll heal your"
	line "#mon any time!"

	para "Thanks again!"
	done

Route48YellowForestSignText:
	text "Route 48"

	para "North to"
	line "Yellow Forest"
	done
