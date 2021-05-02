	db  75,  55,  70, 110,  55,  95 ; 460 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, FLYING ; type
	db 45 ; catch rate
	db 176 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/jumpluff/front.dimensions"
	abilities_for JUMPLUFF, CHLOROPHYLL, LEAF_GUARD, INFILTRATOR
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FAIRY, EGG_GRASS ; egg groups

	ev_yield   0,   0,   0,   3,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY BALL, FALSE_SWIPE, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, SWORDS_DANCE, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end