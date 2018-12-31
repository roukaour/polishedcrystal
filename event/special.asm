SpecialGiveShinyDitto:

; Adding to the party.
	xor a
	ld [wMonType], a

; Level 5 Ditto.
	ld a, DITTO
	ld [wCurPartySpecies], a
	ld a, 5
	ld [wCurPartyLevel], a

	predef TryAddMonToParty
	jr nc, .NotGiven

; Caught data.
	lb bc, MALE, PREMIER_BALL
	farcall SetGiftPartyMonCaughtData

; Holding an Everstone for breeding natures.
	ld hl, wPartyMon1Item
	call _GetLastPartyMonAttribute
	ld [hl], EVERSTONE

; OT ID. Guaranteed to not be the same as the player's for Masuda method breeding.
	ld hl, wPartyMon1ID + 1
	call _GetLastPartyMonAttribute
	ld a, [wPlayerID + 1]
	add %01100101
	ld [hld], a
	ld a, [wPlayerID]
	adc %10100110
	ld [hl], a

; DVs and personality.
	ld hl, wPartyMon1DVs
	call _GetLastPartyMonAttribute
; Max IVs.
rept 3
	ld a, $ff
	ld [hli], a
endr
; Shiny with hidden ability.
	ld a, SHINY_MASK | HIDDEN_ABILITY | QUIRKY
	ld [hli], a
	ld a, MALE
	ld [hl], a

; BUG: stats are not recalculated after changing DVs and nature.

; Nickname.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld de, .Nickname
	call CopyName2

; OT.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonOT
	call SkipNames
	ld de, .OT
	call CopyName2

	ld a, TRUE
	ld [wScriptVar], a
	ret

.NotGiven:
	xor a ; ld a, FALSE
	ld [wScriptVar], a
	ret

.OT:
	db "Mr.<PK><MN>@"
.Nickname:
	db "Masuda@"

KIRK_BUFFY_ID EQU 00518

SpecialGiveWobbuffet: ; 7305

; Adding to the party.
	xor a
	ld [wMonType], a

; Level 20 Wobbuffet.
	ld a, WOBBUFFET
	ld [wCurPartySpecies], a
	ld a, 20
	ld [wCurPartyLevel], a

	predef TryAddMonToParty
	jr nc, .NotGiven

; Caught data.
	lb bc, MALE, DUSK_BALL
	farcall SetGiftPartyMonCaughtData

; Holding a Berry.
	ld hl, wPartyMon1Item
	call _GetLastPartyMonAttribute
	ld [hl], SITRUS_BERRY

; OT ID.
	ld hl, wPartyMon1ID
	call _GetLastPartyMonAttribute
	ld a, KIRK_BUFFY_ID / $100
	ld [hli], a
	ld [hl], KIRK_BUFFY_ID % $100

; Nickname.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	call SkipNames
	ld de, SpecialWobbuffetNick
	call CopyName2

; OT.
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonOT
	call SkipNames
	ld de, SpecialWobbuffetOT
	call CopyName2

; Engine flag for this event.
	ld hl, wDailyFlags
	set 5, [hl] ; ENGINE_WOBBUFFET_GIVEN
	ld a, TRUE
	ld [wScriptVar], a
	ret

.NotGiven:
	xor a ; ld a, FALSE
	ld [wScriptVar], a
	ret

_GetLastPartyMonAttribute:
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	jp AddNTimes

SpecialReturnWobbuffet: ; 737e
	farcall SelectMonFromParty
	jr c, .refused

	ld a, [wCurPartySpecies]
	cp WOBBUFFET
	jr nz, .DontReturn

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

; OT ID
	ld a, [hli]
	cp KIRK_BUFFY_ID / $100
	jr nz, .DontReturn
	ld a, [hl]
	cp KIRK_BUFFY_ID % $100
	jr nz, .DontReturn

; OT
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOT
	call SkipNames
	ld de, SpecialWobbuffetOT
.CheckOT:
	ld a, [de]
	cp [hl]
	jr nz, .DontReturn
	cp "@"
	jr z, .done
	inc de
	inc hl
	jr .CheckOT

.done
	farcall CheckCurPartyMonFainted
	jr c, .fainted
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	cp 150
	ld a, $3
	jr nc, .HappyToStayWithYou
	xor a ; take from pc
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ld a, $2
.HappyToStayWithYou:
	ld [wScriptVar], a
	ret

.refused
	ld a, $1
	ld [wScriptVar], a
	ret

.DontReturn:
	xor a
	ld [wScriptVar], a
	ret

.fainted
	ld a, $4
	ld [wScriptVar], a
	ret

SpecialWobbuffetOT:
	db "Kirk@"
SpecialWobbuffetNick:
	db "Buffy@"

Special_BillsGrandfather: ; 73f7
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	ld [wScriptVar], a
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ld [wScriptVar], a
	ret

Special_HiddenPowerGuru:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	call CopyPokemonName_Buffer1_Buffer3
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1DVs
	call GetPartyLocation
	call GetHiddenPowerType
	ld [wNamedObjectIndexBuffer], a
	farcall GetTypeName
	ld a, $2
.done
	ld [wScriptVar], a
	ret

.cancel
	ld a, $0
	jr .done

.egg
	ld a, $1
	jr .done

Special_YoungerHaircutBrother: ; 7413
	ld hl, Data_YoungerHaircutBrother
	jr MassageOrHaircut

Special_OlderHaircutBrother: ; 7418
	ld hl, Data_OlderHaircutBrother
	jr MassageOrHaircut

Special_DaisyMassage: ; 741d
	ld hl, Data_DaisyMassage
	jr MassageOrHaircut

Special_CianwoodPhotograph:
	ld hl, Data_CianwoodPhotograph
	jr MassageOrHaircut

Special_ReiBlessing:
	ld hl, Data_ReiBlessing

MassageOrHaircut: ; 7420
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call GetCurNick
	call CopyPokemonName_Buffer1_Buffer3
	pop hl
	call Random
.loop
	sub [hl]
	jr c, .ok
rept 3
	inc hl
endr
	jr .loop

.ok
	inc hl
	ld a, [hli]
	ld [wScriptVar], a
	ld c, [hl]
	jp ChangeHappiness

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

Data_YoungerHaircutBrother: ; 7459
	db $4c, 2, HAPPINESS_YOUNGCUT1 ; 30% chance
	db $80, 3, HAPPINESS_YOUNGCUT2 ; 20% chance
	db $ff, 4, HAPPINESS_YOUNGCUT3 ; 50% chance

Data_OlderHaircutBrother: ; 7462
	db $9a, 2, HAPPINESS_OLDERCUT1 ; 60% chance
	db $4c, 3, HAPPINESS_OLDERCUT2 ; 10% chance
	db $ff, 4, HAPPINESS_OLDERCUT3 ; 30% chance

Data_DaisyMassage: ; 746b
	db $80, 2, HAPPINESS_MASSAGE ; 50% chance
	db $ff, 2, HAPPINESS_MASSAGE ; 50% chance

Data_CianwoodPhotograph:
	db $80, 2, HAPPINESS_PHOTOGRAPH ; 50% chance
	db $ff, 2, HAPPINESS_PHOTOGRAPH ; 50% chance

Data_ReiBlessing:
	db $80, 2, HAPPINESS_BLESSING ; 50% chance
	db $ff, 2, HAPPINESS_BLESSING ; 50% chance

CopyPokemonName_Buffer1_Buffer3: ; 746e
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, PKMN_NAME_LENGTH
	jp CopyBytes