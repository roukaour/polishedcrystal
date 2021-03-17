Route44_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 56,  7, ICE_PATH_1F, 1
	warp_event 31, 8, HIDDEN_TREE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 53,  7, BGEVENT_JUMPTEXT, Route44Sign1Text
	bg_event  6, 10, BGEVENT_JUMPTEXT, Route44Sign2Text
	bg_event 32,  9, BGEVENT_ITEM + ELIXIR, EVENT_ROUTE_44_HIDDEN_ELIXIR
	bg_event  30, 7, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_44
	bg_event  31, 7, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_44

	def_object_events
	object_event 32,  8, SPRITE_VETERAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route44VeteranmScript, -1
	object_event 35,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerFisherWilton1, -1
	object_event 19, 13, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherEdgar, -1
	object_event 10,  9, SPRITE_PSYCHIC, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPsychicPhil, -1
	object_event 43,  2, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacZach, -1
	object_event 51,  5, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerBird_keeperVance1, -1
	object_event 41, 15, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerCooltrainermAllen, -1
	object_event 31, 14, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerCooltrainerfCybil, -1
	fruittree_event  9,  5, FRUITTREE_ROUTE_44, ASPEAR_BERRY, PAL_NPC_BROWN
	itemball_event 30,  8, MAX_REVIVE, 1, EVENT_ROUTE_44_MAX_REVIVE
	itemball_event 45,  4, ULTRA_BALL, 1, EVENT_ROUTE_44_ULTRA_BALL
	itemball_event 14,  9, MAX_REPEL, 1, EVENT_ROUTE_44_MAX_REPEL

	object_const_def
	const ROUTE44_VETERAN_M

Route44VeteranmScript:
	checkevent EVENT_GOT_ROCKY_HELMET_FROM_ROUTE_44_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_VETERANM_BARKHORN
	iftrue .Beaten
	checkevent EVENT_BEAT_BIRD_KEEPER_VANCE
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_PSYCHIC_PHIL
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_WILTON
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_FISHER_EDGAR
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_CYBIL
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_POKEMANIAC_ZACH
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERM_ALLEN
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE44_VETERAN_M
	loadtrainer VETERANM, BARKHORN
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_VETERANM_BARKHORN
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem ROCKY_HELMET
	iffalse_endtext
	setevent EVENT_GOT_ROCKY_HELMET_FROM_ROUTE_44_LEADER
	jumpthisopenedtext

.AfterText2:
	text "You're a very"
	line "quiet person."

	para "Has anybody told"
	line "you that before?"
	done

.IntroText:
	text "My #mon are"
	line "wearing Rocky"
	cont "Helmets."

	para "Want to challenge"
	line "them?"

	para "Okay, then you've"
	line "got to beat every"

	para "trainer on this"
	line "route first."
	done

.QuestionText:
	text "I saw your"
	line "battles."

	para "Your #mon are"
	line "really tough."

	para "Are you ready?"
	done

.RefusedText:
	text "You beat Team"
	line "Rocket and you're"
	cont "scared of me?"

	para "Do I look that"
	line "scary?"
	done

.SeenText:
	text "I'll show you the"
	line "power of my Rocky"
	cont "Helmets!"
	done

.BeatenText:
	text "Bah. These Helmets"
	line "weren't enough."
	done

.AfterText1:
	text "You're really"
	line "strong for someone"
	cont "so young."
	cont "Keep it up!"

	para "Take one of these"
	line "Rocky Helmets."

	para "You can use it as"
	line "well as me."
	done

TrainerBird_keeperVance1:
	trainer BIRD_KEEPER, VANCE1, EVENT_BEAT_BIRD_KEEPER_VANCE, Bird_keeperVance1SeenText, Bird_keeperVance1BeatenText, 0, Bird_keeperVance1Script

Bird_keeperVance1Script:
	loadvar VAR_CALLERID, PHONE_BIRDKEEPER_VANCE
	opentext
	checkflag ENGINE_VANCE_READY_FOR_REMATCH
	iftrue UnknownScript_0x19d86a
	checkcellnum PHONE_BIRDKEEPER_VANCE
	iftrue Route44NumberAcceptedM
	checkevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d853
	writetext BirdKeeperVanceLegendaryBirdsText
	promptbutton
	setevent EVENT_VANCE_ASKED_FOR_PHONE_NUMBER
	scall Route44AskNumber1M
	sjump UnknownScript_0x19d856

UnknownScript_0x19d853:
	scall Route44AskNumber2M
UnknownScript_0x19d856:
	askforphonenumber PHONE_BIRDKEEPER_VANCE
	ifequal $1, Route44PhoneFullM
	ifequal $2, Route44NumberDeclinedM
	gettrainername BIRD_KEEPER, VANCE1, $0
	scall Route44RegisteredNumberM
	sjump Route44NumberAcceptedM

UnknownScript_0x19d86a:
	scall Route44RematchM
	winlosstext Bird_keeperVance1BeatenText, 0
	readmem wVanceFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BIRD_KEEPER, VANCE1
	startbattle
	reloadmapafterbattle
	loadmem wVanceFightCount, 1
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BIRD_KEEPER, VANCE2
	startbattle
	reloadmapafterbattle
	loadmem wVanceFightCount, 2
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BIRD_KEEPER, VANCE3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_VANCE_READY_FOR_REMATCH
	checkevent EVENT_VANCE_CARBOS
	iftrue UnknownScript_0x19d8cb
	checkevent EVENT_GOT_CARBOS_FROM_VANCE
	iftrue UnknownScript_0x19d8ca
	scall Route44RematchGiftM
	verbosegiveitem CARBOS
	iffalse VancePackFull
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	sjump Route44NumberAcceptedM

UnknownScript_0x19d8ca:
	end

UnknownScript_0x19d8cb:
	opentext
	writetext BirdKeeperVance2BeatenText
	waitbutton
	verbosegiveitem CARBOS
	iffalse VancePackFull
	clearevent EVENT_VANCE_CARBOS
	setevent EVENT_GOT_CARBOS_FROM_VANCE
	sjump Route44NumberAcceptedM

Route44AskNumber1M:
	jumpstd asknumber1m

Route44AskNumber2M:
	jumpstd asknumber2m

Route44RegisteredNumberM:
	jumpstd registerednumberm

Route44NumberAcceptedM:
	jumpstd numberacceptedm

Route44NumberDeclinedM:
	jumpstd numberdeclinedm

Route44PhoneFullM:
	jumpstd phonefullm

Route44RematchM:
	jumpstd rematchm

Route44GiftM:
	jumpstd giftm

Route44PackFullM:
	jumpstd packfullm

VancePackFull:
	setevent EVENT_VANCE_CARBOS
	jumpstd packfullm
	end

Route44RematchGiftM:
	jumpstd rematchgiftm

GenericTrainerPsychicPhil:
	generictrainer PSYCHIC_T, PHIL, EVENT_BEAT_PSYCHIC_PHIL, PsychicPhilSeenText, PsychicPhilBeatenText

	text "It's important to"
	line "have conviction"
	cont "on your side."
	done

TrainerFisherWilton1:
	trainer FISHER, WILTON1, EVENT_BEAT_FISHER_WILTON, FisherWilton1SeenText, FisherWilton1BeatenText, 0, FisherWilton1Script

FisherWilton1Script:
	loadvar VAR_CALLERID, PHONE_FISHER_WILTON
	opentext
	checkflag ENGINE_WILTON_READY_FOR_REMATCH
	iftrue UnknownScript_0x19d96e
	checkflag ENGINE_WILTON_HAS_ITEM
	iftrue UnknownScript_0x19d9b4
	checkcellnum PHONE_FISHER_WILTON
	iftrue Route44NumberAcceptedM
	checkevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19d957
	checkunits
	iftrue .metric
	writetext UnknownText_0x19daa8_Imperial
	sjump .ok
.metric
	writetext UnknownText_0x19daa8_Metric
.ok
	promptbutton
	setevent EVENT_WILTON_ASKED_FOR_PHONE_NUMBER
	scall Route44AskNumber1M
	sjump UnknownScript_0x19d95a

UnknownScript_0x19d957:
	scall Route44AskNumber2M
UnknownScript_0x19d95a:
	askforphonenumber PHONE_FISHER_WILTON
	ifequal $1, Route44PhoneFullM
	ifequal $2, Route44NumberDeclinedM
	gettrainername FISHER, WILTON1, $0
	scall Route44RegisteredNumberM
	sjump Route44NumberAcceptedM

UnknownScript_0x19d96e:
	scall Route44RematchM
	winlosstext FisherWilton1BeatenText, 0
	readmem wWiltonFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer FISHER, WILTON1
	startbattle
	reloadmapafterbattle
	loadmem wWiltonFightCount, 1
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer FISHER, WILTON2
	startbattle
	reloadmapafterbattle
	loadmem wWiltonFightCount, 2
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer FISHER, WILTON3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_WILTON_READY_FOR_REMATCH
	end

UnknownScript_0x19d9b4:
	scall Route44GiftM
	checkevent EVENT_WILTON_HAS_ULTRA_BALL
	iftrue UnknownScript_0x19d9c9
	checkevent EVENT_WILTON_HAS_GREAT_BALL
	iftrue UnknownScript_0x19d9d2
	checkevent EVENT_WILTON_HAS_POKE_BALL
	iftrue UnknownScript_0x19d9db
UnknownScript_0x19d9c9:
	verbosegiveitem ULTRA_BALL
	iffalse UnknownScript_0x19d9e7
	sjump UnknownScript_0x19d9e1

UnknownScript_0x19d9d2:
	verbosegiveitem GREAT_BALL
	iffalse UnknownScript_0x19d9e7
	sjump UnknownScript_0x19d9e1

UnknownScript_0x19d9db:
	verbosegiveitem POKE_BALL
	iffalse UnknownScript_0x19d9e7
UnknownScript_0x19d9e1:
	clearflag ENGINE_WILTON_HAS_ITEM
	sjump Route44NumberAcceptedM

UnknownScript_0x19d9e7:
	sjump Route44PackFullM

GenericTrainerFisherEdgar:
	generictrainer FISHER, EDGAR, EVENT_BEAT_FISHER_EDGAR, FisherEdgarSeenText, FisherEdgarBeatenText

	text "That's 100 wins"
	line "to 101 losses."

	para "I won't battle"
	line "again for a while."
	done

GenericTrainerCooltrainerfCybil:
	generictrainer COOLTRAINERF, CYBIL, EVENT_BEAT_COOLTRAINERF_CYBIL, CooltrainerfCybilSeenText, CooltrainerfCybilBeatenText

	text "We all get better"
	line "by experiencing"
	cont "many battles."

	para "I battled a lot to"
	line "become what I am"
	cont "today--an elite."
	done

GenericTrainerPokemaniacZach:
	generictrainer POKEMANIAC, ZACH, EVENT_BEAT_POKEMANIAC_ZACH, PokemaniacZachSeenText, PokemaniacZachBeatenText

	text "If a #mon has"
	line "different colors"

	para "from usual, it's"
	line "more valuable."

	para "What? You mean"
	line "that's not true?"
	done

GenericTrainerCooltrainermAllen:
	generictrainer COOLTRAINERM, ALLEN, EVENT_BEAT_COOLTRAINERM_ALLEN, CooltrainermAllenSeenText, CooltrainermAllenBeatenText

	text "Wow. You have a"
	line "lot of Badges."

	para "No wonder you're"
	line "so tough."

	para "I wonder if"
	line "Ecruteak Gym's"

	para "Morty is still in"
	line "training?"

	para "He really hammered"
	line "me."
	done

FisherWilton1SeenText:
	text "Aack! You made me"
	line "lose a Poliwag!"

	para "What are you going"
	line "to do about it?"
	done

FisherWilton1BeatenText:
	text "Just forget about"
	line "it."
	done

UnknownText_0x19daa8_Imperial:
	text "That Poliwag that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been 16 feet long!"
	done

UnknownText_0x19daa8_Metric:
	text "That Poliwag that"
	line "got away…"
	cont "It was huge."

	para "I swear it must've"
	line "been five meters"
	cont "long!"
	done

FisherEdgarSeenText:
	text "I fish until I"
	line "can't anymore."

	para "I also battle"
	line "until I drop."

	para "That's my"
	line "relationship"
	cont "with my #mon."
	done

FisherEdgarBeatenText:
	text "Hmmmm…"
	line "This isn't right."
	done

Bird_keeperVance1SeenText:
	text "Do you know about"
	line "the legendary bird"
	cont "#mon?"
	done

Bird_keeperVance1BeatenText:
	text "Whew! You're hot"
	line "stuff."
	done

BirdKeeperVanceLegendaryBirdsText:
	text "Articuno, Zapdos"
	line "and Moltres are"

	para "the three legend-"
	line "ary bird #mon."

	para "I heard there are"
	line "other legendary"
	cont "birds, though."
	done

BirdKeeperVance2BeatenText:
	text "Why can't I ever"
	line "beat you?"

	para "Oh yeah, here you"
	line "go. It's that gift"

	para "I couldn't give"
	line "you last time."
	done

PsychicPhilSeenText:
	text "I'm gonna win,"
	line "for sure!"
	done

PsychicPhilBeatenText:
	text "Arrgh… That's a"
	line "shocking loss…"
	done

PokemaniacZachSeenText:
	text "I'll do anything"
	line "to get my hands on"
	cont "rare #mon!"
	done

PokemaniacZachBeatenText:
	text "Oooh, your #mon"
	line "are so appealing."
	done

CooltrainermAllenSeenText:
	text "I can tell you're"
	line "a good trainer by"
	cont "looking at you."

	para "I'm good at #-"
	line "mon, and I can see"
	cont "that you are too."
	done

CooltrainermAllenBeatenText:
	text "Tch! It's a total"
	line "loss on my part."
	done

CooltrainerfCybilSeenText:
	text "You look strong."

	para "Good trainers seek"
	line "tough opponents"
	cont "instinctively."
	done

CooltrainerfCybilBeatenText:
	text "Nope! This won't"
	line "do at all."
	done

Route44Sign1Text:
	text "Route 44"
	line "Ice Path Ahead"
	done

Route44Sign2Text:
	text "Route 44"

	para "Mahogany Town -"
	line "Blackthorn City"
	done
