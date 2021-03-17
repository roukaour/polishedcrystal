Route45_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  5, DARK_CAVE_BLACKTHORN_ENTRANCE, 1
	warp_event  9, 31, HIDDEN_CAVE_GROTTO, 1

	def_coord_events

	def_bg_events
	bg_event 17,  5, BGEVENT_JUMPTEXT, Route45SignText
	bg_event 17, 78, BGEVENT_ITEM + PP_UP, EVENT_ROUTE_45_HIDDEN_PP_UP
	bg_event 18, 63, BGEVENT_JUMPSTD, cavegrotto, HIDDENGROTTO_ROUTE_45

	def_object_events
	object_event 19, 75, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route45Dragon_tamerScript, -1
	object_event  5, 59, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBattleGirlNozomi, -1
	object_event 12, 18, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerHikerErik, -1
	object_event 19, 65, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerHikerMichael, -1
	object_event  7, 28, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerHikerParry, -1
	object_event 13, 65, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerHikerTimothy, -1
	object_event 16, 50, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerBlackbeltKenji, -1
	object_event 21, 18, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCooltrainermRyan, -1
	object_event  6, 33, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCooltrainerfKelly, -1
	fruittree_event 20, 80, FRUITTREE_ROUTE_45, LEPPA_BERRY, PAL_NPC_RED
	itemball_event  8, 51, NUGGET, 1, EVENT_ROUTE_45_NUGGET
	itemball_event  5, 66, REVIVE, 1, EVENT_ROUTE_45_REVIVE
	itemball_event  7, 20, ELIXIR, 1, EVENT_ROUTE_45_ELIXIR
	itemball_event 15, 32, MAX_POTION, 1, EVENT_ROUTE_45_MAX_POTION
	object_event  4, 70, SPRITE_CAMPER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCamperQuentin, -1

	object_const_def
	const ROUTE45_DRAGON_TAMER

Route45Dragon_tamerScript:
	checkevent EVENT_GOT_FOCUS_SASH_FROM_ROUTE_45_LEADER
	iftrue_jumptextfaceplayer .AfterText2
	faceplayer
	checkevent EVENT_BEAT_DRAGON_TAMER_AEGON
	iftrue .Beaten
	checkevent EVENT_BEAT_BATTLE_GIRL_NOZOMI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_BLACKBELT_KENJI
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_HIKER_ERIK
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_HIKER_MICHAEL
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_HIKER_PARRY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_HIKER_TIMOTHY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERM_RYAN
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_COOLTRAINERF_KELLY
	iffalse_jumptext .IntroText
	checkevent EVENT_BEAT_CAMPER_QUENTIN
	iffalse_jumptext .IntroText
	opentext
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	setlasttalked ROUTE45_DRAGON_TAMER
	loadtrainer DRAGON_TAMER, AEGON
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_DRAGON_TAMER_AEGON
.Beaten:
	opentext
	writetext .AfterText1
	promptbutton
	verbosegiveitem FOCUS_SASH
	iffalse_endtext
	setevent EVENT_GOT_FOCUS_SASH_FROM_ROUTE_45_LEADER
	jumpthisopenedtext

.AfterText2:
	text "The art of train-"
	line "ing Dragon-type"
	cont "#mon is just"
	cont "amazing."

	para "You should become"
	line "a Dragon Tamer"
	cont "too."
	done

.IntroText:
	text "I'm training my"
	line "dragons here."

	para "Huh? A battle?"
	line "I want a good one,"

	para "so prove to me"
	line "that you're strong."

	para "Win against every"
	line "trainer on this"

	para "route and I'll"
	line "battle you."
	done

.QuestionText:
	text "Oh, you're ready."
	line "It's time for a"
	cont "duel: your #mon"
	cont "versus my dragons."

	para "Should we start"
	line "now?"
	done

.RefusedText:
	text "No problem."
	line "I'll keep on"
	cont "training."
	done

.SeenText:
	text "Let's see if you"
	line "can handle my"

	para "dragons' unyield-"
	line "ing focus."
	cont "Go, Dragonite!"
	done

.BeatenText:
	text "How powerful!"
	line "My #mon were"
	cont "no match for you."
	done

.AfterText1:
	text "Your strength"
	line "rivals my own!"

	para "Take this. You"
	line "deserve it."
	done

GenericTrainerBattleGirlNozomi:
	generictrainer BATTLE_GIRL, NOZOMI, EVENT_BEAT_BATTLE_GIRL_NOZOMI, BattleGirlNozomiSeenText, BattleGirlNozomiBeatenText

	text "Thanks for the"
	line "workout, <PLAYER>!"
	done

TrainerBlackbeltKenji:
	trainer BLACKBELT_T, KENJI1, EVENT_BEAT_BLACKBELT_KENJI, BlackbeltKenji1SeenText, BlackbeltKenji1BeatenText, 0, BlackbeltKenji1Script

BlackbeltKenji1Script:
	loadvar VAR_CALLERID, PHONE_BLACKBELT_KENJI
	opentext
	checkcellnum PHONE_BLACKBELT_KENJI
	iftrue UnknownScript_0x19e0e4
	checkevent EVENT_KENJI_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19e0cd
	special Special_SampleKenjiBreakCountdown
	writetext BlackbeltKenjiAfterBattleText
	waitbutton
	setevent EVENT_KENJI_ASKED_FOR_PHONE_NUMBER
	scall Route45AskNumber1M
	sjump UnknownScript_0x19e0d0

UnknownScript_0x19e0cd:
	scall Route45AskNumber2M
UnknownScript_0x19e0d0:
	askforphonenumber PHONE_BLACKBELT_KENJI
	ifequal $1, Route45PhoneFullM
	ifequal $2, Route45NumberDeclinedM
	gettrainername BLACKBELT_T, KENJI1, $0
	scall Route45RegisteredNumberM
	sjump Route45NumberAcceptedM

UnknownScript_0x19e0e4:
	readvar VAR_KENJI_BREAK
	ifnotequal $1, Route45NumberAcceptedM
	checktime 1 << MORN
	iftrue UnknownScript_0x19e10c
	checktime (1 << EVE) | (1 << NITE)
	iftrue UnknownScript_0x19e112
	checkevent EVENT_KENJI_ON_BREAK
	iffalse Route45NumberAcceptedM
	scall Route45GiftM
	verbosegiveitem PP_UP
	iffalse UnknownScript_0x19e118
	clearevent EVENT_KENJI_ON_BREAK
	special Special_SampleKenjiBreakCountdown
	sjump Route45NumberAcceptedM

UnknownScript_0x19e10c:
	jumpopenedtext BlackbeltKenjiMorningText

UnknownScript_0x19e112:
	jumpopenedtext BlackbeltKenjiNightText

UnknownScript_0x19e118:
	sjump Route45PackFullM

Route45AskNumber1M:
	jumpstd asknumber1m

Route45AskNumber2M:
	jumpstd asknumber2m

Route45RegisteredNumberM:
	jumpstd registerednumberm

Route45NumberAcceptedM:
	jumpstd numberacceptedm

Route45NumberDeclinedM:
	jumpstd numberdeclinedm

Route45PhoneFullM:
	jumpstd phonefullm

Route45RematchM:
	jumpstd rematchm

Route45GiftM:
	jumpstd giftm

Route45PackFullM:
	jumpstd packfullm

HikerParryHasIron:
	setevent EVENT_PARRY_IRON
	jumpstd packfullm
	end

Route45RematchGiftM:
	jumpstd rematchgiftm

GenericTrainerHikerErik:
	generictrainer HIKER, ERIK, EVENT_BEAT_HIKER_ERIK, HikerErikSeenText, HikerErikBeatenText

	text "I'll head back to"
	line "Blackthorn's Ice"

	para "Path and train"
	line "some more."
	done

GenericTrainerHikerMichael:
	generictrainer HIKER, MICHAEL, EVENT_BEAT_HIKER_MICHAEL, HikerMichaelSeenText, HikerMichaelBeatenText

	text "Boy, do I love"
	line "HP Up! Mmmm, yum!"

	para "I keep drinking my"
	line "#mon's!"

	para "I can't help it!"
	done

TrainerHikerParry:
	trainer HIKER, PARRY1, EVENT_BEAT_HIKER_PARRY, HikerParry1SeenText, HikerParry1BeatenText, 0, HikerParry1Script

HikerParry1Script:
	loadvar VAR_CALLERID, PHONE_HIKER_PARRY
	opentext
	checkflag ENGINE_PARRY_READY_FOR_REMATCH
	iftrue UnknownScript_0x19e1b8
	checkcellnum PHONE_HIKER_PARRY
	iftrue Route45NumberAcceptedM
	checkevent EVENT_PARRY_ASKED_FOR_PHONE_NUMBER
	iftrue UnknownScript_0x19e1a1
	writetext HikerParryAfterBattleText
	promptbutton
	setevent EVENT_PARRY_ASKED_FOR_PHONE_NUMBER
	scall Route45AskNumber1M
	sjump UnknownScript_0x19e1a4

UnknownScript_0x19e1a1:
	scall Route45AskNumber2M
UnknownScript_0x19e1a4:
	askforphonenumber PHONE_HIKER_PARRY
	ifequal $1, Route45PhoneFullM
	ifequal $2, Route45NumberDeclinedM
	gettrainername HIKER, PARRY1, $0
	scall Route45RegisteredNumberM
	sjump Route45NumberAcceptedM

UnknownScript_0x19e1b8:
	scall Route45RematchM
	winlosstext HikerParry1BeatenText, 0
	readmem wParryFightCount
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
	loadtrainer HIKER, PARRY1
	startbattle
	reloadmapafterbattle
	loadmem wParryFightCount, 1
	clearflag ENGINE_PARRY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer HIKER, PARRY2
	startbattle
	reloadmapafterbattle
	loadmem wParryFightCount, 2
	clearflag ENGINE_PARRY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer HIKER, PARRY3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_PARRY_READY_FOR_REMATCH
	checkevent EVENT_PARRY_IRON
	iftrue UnknownScript_0x19e219
	checkevent EVENT_GOT_IRON_FROM_PARRY
	iftrue UnknownScript_0x19e218
	scall Route45RematchGiftM
	verbosegiveitem IRON
	iffalse HikerParryHasIron
	setevent EVENT_GOT_IRON_FROM_PARRY
	sjump Route45NumberAcceptedM

UnknownScript_0x19e218:
	end

UnknownScript_0x19e219:
	opentext
	writetext HikerParryGivesIronText
	waitbutton
	verbosegiveitem IRON
	iffalse HikerParryHasIron
	clearevent EVENT_PARRY_IRON
	setevent EVENT_GOT_IRON_FROM_PARRY
	sjump Route45NumberAcceptedM

GenericTrainerHikerTimothy:
	generictrainer HIKER, TIMOTHY, EVENT_BEAT_HIKER_TIMOTHY, HikerTimothySeenText, HikerTimothyBeatenText

	text "The best thing to"
	line "ever happen to me"

	para "was discovering"
	line "#mon."
	done

GenericTrainerCooltrainermRyan:
	generictrainer COOLTRAINERM, RYAN, EVENT_BEAT_COOLTRAINERM_RYAN, CooltrainermRyanSeenText, CooltrainermRyanBeatenText

	text "I see you're rais-"
	line "ing your #mon"
	cont "with care."

	para "The bond you build"
	line "will save you in"
	cont "tough situations."
	done

GenericTrainerCooltrainerfKelly:
	generictrainer COOLTRAINERF, KELLY, EVENT_BEAT_COOLTRAINERF_KELLY, CooltrainerfKellySeenText, CooltrainerfKellyBeatenText

	text "I'm not in favor"
	line "of overly power-"
	cont "ful moves."

	para "I want to win, but"
	line "I also don't want"
	cont "to harm #mon."
	done

GenericTrainerCamperQuentin:
	generictrainer CAMPER, QUENTIN, EVENT_BEAT_CAMPER_QUENTIN, CamperQuentinSeenText, CamperQuentinBeatenText

	text "Have you been to"
	line "the Battle Tower?"

	para "I never, ever lose"
	line "there, but…"
	done

BattleGirlNozomiSeenText:
	text "This is no place"
	line "for weak #mon!"
	done

BattleGirlNozomiBeatenText:
	text "What a fight!"
	done

HikerErikSeenText:
	text "Be prepared for"
	line "anything!"

	para "Let me see if your"
	line "#mon have been"
	cont "raised properly!"
	done

HikerErikBeatenText:
	text "Oh, I lost that!"
	done

HikerMichaelSeenText:
	text "Yo! You're spunky!"
	line "But you know what?"

	para "When it comes to"
	line "sheer spunkiness,"
	cont "I'm the man!"
	done

HikerMichaelBeatenText:
	text "My #mon weren't"
	line "spunky enough!"
	done

HikerParry1SeenText:
	text "My #mon are"
	line "power packed!"
	done

HikerParry1BeatenText:
	text "Wahahah! I'm the"
	line "big loser!"
	done

HikerParryAfterBattleText:
	text "I'm not much good"
	line "at thinking, see?"

	para "So, I just plow"
	line "ahead with power!"
	done

HikerTimothySeenText:
	text "Why do I climb"
	line "mountains?"

	para "Because they're"
	line "there."

	para "Why do I train"
	line "#mon?"

	para "Because they're"
	line "there!"
	done

HikerTimothyBeatenText:
	text "Losses…"
	line "They're there too!"
	done

HikerParryGivesIronText:
	text "I just can't find"
	line "a way to win!"

	para "Keep it up!"

	para "Oh, and take this"
	line "--it's the gift"

	para "you couldn't take"
	line "when we last met."
	done

BlackbeltKenji1SeenText:
	text "I was training"
	line "here alone."

	para "Behold the fruits"
	line "of my labor!"
	done

BlackbeltKenji1BeatenText:
	text "Waaaargh!"
	done

BlackbeltKenjiAfterBattleText:
	text "This calls for"
	line "extreme measures."

	para "I must take to the"
	line "hills and train in"
	cont "solitude."
	done

BlackbeltKenjiMorningText:
	text "I'm going to train"
	line "a bit more before"
	cont "I break for lunch."
	done

BlackbeltKenjiNightText:
	text "We had plenty of"
	line "rest at lunch, so"

	para "now we're all"
	line "ready to go again!"

	para "We're going to"
	line "train again!"
	done

CooltrainermRyanSeenText:
	text "What are your"
	line "thoughts on rais-"
	cont "ing #mon?"
	done

CooltrainermRyanBeatenText:
	text "You've won my"
	line "respect."
	done

CooltrainerfKellySeenText:
	text "What is your"
	line "battle strategy?"

	para "It is foolish to"
	line "use strong moves"
	cont "indiscriminately."
	done

CooltrainerfKellyBeatenText:
	text "Fine. I lost."
	done

CamperQuentinSeenText:
	text "I'm really, really"
	line "tough!"

	para "Is there anywhere"
	line "I can prove how"
	cont "tough I really am?"
	done

CamperQuentinBeatenText:
	text "I was tough at the"
	line "Battle Tower…"
	done

Route45SignText:
	text "Route 45"
	line "Mountain Rd. Ahead"
	done
