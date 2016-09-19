StatsScreenInit: ; 4dc8a
	ld hl, StatsScreenMain
	ld a, [hMapAnims]
	push af
	xor a
	ld [hMapAnims], a ; disable overworld tile animations
	ld a, [wBoxAlignment] ; whether sprite is to be mirrorred
	push af
	ld a, [wJumptableIndex]
	ld b, a
	ld a, [wcf64]
	ld c, a

	push bc
	push hl
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	callba Functionfb53e
	pop hl
	call _hl_
	call ClearBGPalettes
	call ClearTileMap
	pop bc

	; restore old values
	ld a, b
	ld [wJumptableIndex], a
	ld a, c
	ld [wcf64], a
	pop af
	ld [wBoxAlignment], a
	pop af
	ld [hMapAnims], a
	ret
; 0x4dcd2

StatsScreenMain: ; 0x4dcd2
	xor a
	ld [wJumptableIndex], a
	; stupid interns
	ld [wcf64], a
	ld a, [wcf64]
	and $fc
	ld [wcf64], a
.loop ; 4dce3
	ld a, [wJumptableIndex]
	and $7f
	ld hl, StatsScreenPointerTable
	rst JumpTable
	call StatsScreen_WaitAnim ; check for keys?
	ld a, [wJumptableIndex]
	bit 7, a
	jr z, .loop
	ret
; 0x4dcf7

StatsScreenPointerTable: ; 4dd2a
	dw MonStatsInit       ; regular pokémon
	dw EggStatsInit       ; egg
	dw StatsScreenWaitCry
	dw EggStatsJoypad
	dw StatsScreen_LoadPage
	dw StatsScreenWaitCry
	dw MonStatsJoypad
	dw StatsScreen_Exit
; 4dd3a

StatsScreen_WaitAnim: ; 4dd3a (13:5d3a)
	ld hl, wcf64
	bit 6, [hl]
	jr nz, .try_anim
	bit 5, [hl]
	jr nz, .finish
	call DelayFrame
	ret

.try_anim
	callba SetUpPokeAnim
	jr nc, .finish
	ld hl, wcf64
	res 6, [hl]
.finish
	ld hl, wcf64
	res 5, [hl]
	callba Function10402d
	ret

StatsScreen_SetJumptableIndex: ; 4dd62 (13:5d62)
	ld a, [wJumptableIndex]
	and $80
	or h
	ld [wJumptableIndex], a
	ret

StatsScreen_Exit: ; 4dd6c (13:5d6c)
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

MonStatsInit: ; 4dd72 (13:5d72)
	ld hl, wcf64
	res 6, [hl]
	call ClearBGPalettes
	call ClearTileMap
	callba Function10402d
	call StatsScreen_CopyToTempMon
	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg
	call StatsScreen_InitUpperHalf
	ld hl, wcf64
	set 4, [hl]
	ld h, 4
	call StatsScreen_SetJumptableIndex
	ret

.egg
	ld h, 1
	call StatsScreen_SetJumptableIndex
	ret

EggStatsInit: ; 4dda1
	call EggStatsScreen
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret
; 0x4ddac


EggStatsJoypad: ; 4ddac (13:5dac)
	call StatsScreen_GetJoypad
	jr nc, .check
	ld h, 0
	call StatsScreen_SetJumptableIndex
	ret

.check
	bit A_BUTTON_F, a
	jr nz, .quit
	and D_DOWN | D_UP | A_BUTTON | B_BUTTON
	jp StatsScreen_JoypadAction

.quit
	ld h, 7
	call StatsScreen_SetJumptableIndex
	ret

StatsScreen_LoadPage: ; 4ddc6 (13:5dc6)
	call StatsScreen_LoadGFX
	ld hl, wcf64
	res 4, [hl]
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

MonStatsJoypad: ; 4ddd6 (13:5dd6)
	call StatsScreen_GetJoypad
	jr nc, .next
	ld h, 0
	call StatsScreen_SetJumptableIndex
	ret

.next
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON
	jp StatsScreen_JoypadAction

StatsScreenWaitCry: ; 4dde6 (13:5de6)
	call IsSFXPlaying
	ret nc
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

StatsScreen_CopyToTempMon: ; 4ddf2 (13:5df2)
	ld a, [MonType]
	cp BREEDMON
	jr nz, .breedmon
	ld a, [wBufferMon]
	ld [CurSpecies], a
	call GetBaseData
	ld hl, wBufferMon
	ld de, TempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	jr .done

.breedmon
	callba CopyPkmnToTempMon
	ld a, [CurPartySpecies]
	cp EGG
	jr z, .done
	ld a, [MonType]
	cp BOXMON
	jr c, .done
	callba CalcTempmonStats
.done
	and a
	ret

StatsScreen_GetJoypad: ; 4de2c (13:5e2c)
	call GetJoypad
	ld a, [MonType]
	cp BREEDMON
	jr nz, .notbreedmon
	push hl
	push de
	push bc
	callba StatsScreenDPad
	pop bc
	pop de
	pop hl
	ld a, [wMenuJoypad]
	and D_DOWN | D_UP
	jr nz, .set_carry
	ld a, [wMenuJoypad]
	jr .clear_flags

.notbreedmon
	ld a, [hJoyPressed]
.clear_flags
	and a
	ret

.set_carry
	scf
	ret

StatsScreen_JoypadAction: ; 4de54 (13:5e54)
	push af
	ld a, [wcf64]
	and $3
	ld c, a
	pop af
	bit B_BUTTON_F, a
	jp nz, .b_button
	bit D_LEFT_F, a
	jr nz, .d_left
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit D_UP_F, a
	jr nz, .d_up
	bit D_DOWN_F, a
	jr nz, .d_down
	jr .done

.d_down
	ld a, [MonType]
	cp BOXMON
	jr nc, .done
	and a
	ld a, [PartyCount]
	jr z, .next_mon
	ld a, [OTPartyCount]
.next_mon
	ld b, a
	ld a, [CurPartyMon]
	inc a
	cp b
	jr z, .done
	ld [CurPartyMon], a
	ld b, a
	ld a, [MonType]
	and a
	jr nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jr .load_mon

.d_up
	ld a, [CurPartyMon]
	and a
	jr z, .done
	dec a
	ld [CurPartyMon], a
	ld b, a
	ld a, [MonType]
	and a
	jr nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jr .load_mon

.a_button
	ld a, c
	cp $3
	jr z, .b_button
.d_right
	inc c
	ld a, $3
	cp c
	jr nc, .set_page
	ld c, 0
	jr .set_page

.d_left
	ld a, c
	dec c
	and a
	jr nz, .set_page
	ld c, $3
	jr .set_page

.done
	ret

.set_page
	ld a, [wcf64]
	and %11111100
	or c
	ld [wcf64], a
	ld h, 4
	call StatsScreen_SetJumptableIndex
	ret

.load_mon
	ld h, 0
	call StatsScreen_SetJumptableIndex
	ret

.b_button ; 4dee4 (13:5ee4)
	ld h, 7
	call StatsScreen_SetJumptableIndex
	ret

StatsScreen_InitUpperHalf: ; 4deea (13:5eea)
	call .PlaceHPBar
	xor a
	ld [hBGMapMode], a
	ld a, [CurBaseData] ; wd236 (aliases: BaseDexNo)
	ld [wd265], a
	ld [CurSpecies], a
	hlcoord 8, 0
	ld [hl], "№"
	inc hl
	ld [hl], "."
	inc hl
	hlcoord 10, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	ld de, wd265
	call PrintNum
	hlcoord 14, 0
	call PrintLevel
	ld hl, .NicknamePointers
	call GetNicknamePointer
	call CopyNickname
	hlcoord 8, 2
	call PlaceString
	hlcoord 18, 0
	call .PlaceGenderChar
	hlcoord 9, 4
	ld a, "/"
	ld [hli], a
	ld a, [CurBaseData] ; wd236 (aliases: BaseDexNo)
	ld [wd265], a
	call GetPokemonName
	call PlaceString
	call StatsScreen_PlaceHorizontalDivider
	call StatsScreen_PlacePageSwitchArrows
	call StatsScreen_PlaceShinyIcon
	ret

.PlaceHPBar: ; 4df45 (13:5f45)
	ld hl, TempMonHP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, TempMonMaxHP
	ld a, [hli]
	ld d, a
	ld e, [hl]
	callba ComputeHPBarPixels
	ld hl, wcda1
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call DelayFrame
	ret

.PlaceGenderChar: ; 4df66 (13:5f66)
	push hl
	callba GetGender
	pop hl
	ret c
	ld a, "♂"
	jr nz, .got_gender
	ld a, "♀"
.got_gender
	ld [hl], a
	ret
; 4df77 (13:5f77)

.NicknamePointers: ; 4df77
	dw PartyMonNicknames
	dw OTPartyMonNicknames
	dw sBoxMonNicknames
	dw wBufferMonNick
; 4df7f

StatsScreen_PlaceHorizontalDivider: ; 4df8f (13:5f8f)
	hlcoord 0, 7
	ld b, SCREEN_WIDTH
	ld a, "_"
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

StatsScreen_PlacePageSwitchArrows: ; 4df9b (13:5f9b)
	hlcoord 10, 6
	ld [hl], "◀"
	hlcoord 19, 6
	ld [hl], "▶"
	ret

StatsScreen_PlaceShinyIcon: ; 4dfa6 (13:5fa6)
	ld bc, TempMonDVs
	callba CheckShininess
	ret nc
	hlcoord 19, 0
	ld [hl], "<SHINY>"
	ret

StatsScreen_LoadGFX: ; 4dfb6 (13:5fb6)
	ld a, [BaseDexNo] ; wd236 (aliases: BaseDexNo)
	ld [wd265], a
	ld [CurSpecies], a
	xor a
	ld [hBGMapMode], a
	call .ClearBox
	call .PageTilemap
	call .LoadPals
	ld hl, wcf64
	bit 4, [hl]
	jr nz, .place_frontpic
	call SetPalettes
	ret

.place_frontpic
	call StatsScreen_PlaceFrontpic
	ret

.ClearBox: ; 4dfda (13:5fda)
	ld a, [wcf64]
	and $3
	ld c, a
	call StatsScreen_LoadPageIndicators
	hlcoord 0, 8
	lb bc, 10, 20
	call ClearBox
	ret

.LoadPals: ; 4dfed (13:5fed)
	ld a, [wcf64]
	and $3
	ld c, a
	callba LoadStatsScreenPals
	call DelayFrame
	ld hl, wcf64
	set 5, [hl]
	ret

.PageTilemap: ; 4e002 (13:6002)
	ld a, [wcf64]
	and $3
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable: ; 4e00d (13:600d)
	dw .PinkPage
	dw .GreenPage
	dw .BluePage
	dw .OrangePage

.PinkPage: ; 4e013 (13:6013)
	hlcoord 0, 9
	ld b, $0
	predef DrawPlayerHP
	hlcoord 8, 9
	ld [hl], $41
	ld de, .Status_Type
	hlcoord 0, 12
	call PlaceString
	ld a, [TempMonPokerusStatus]
	ld b, a
	and $f
	jr nz, .HasPokerus
	ld a, b
	and $f0
	jr z, .NotImmuneToPkrs
	hlcoord 8, 8
	ld [hl], "."
.NotImmuneToPkrs:
	ld a, [MonType]
	cp BOXMON
	jr z, .StatusOK
	hlcoord 6, 13
	push hl
	ld de, TempMonStatus
	predef PlaceStatusString
	pop hl
	jr nz, .done_status
	jr .StatusOK
.HasPokerus:
	ld de, .PkrsStr
	hlcoord 1, 13
	call PlaceString
	jr .done_status
.StatusOK:
	ld de, .OK_str
	call PlaceString
.done_status
	hlcoord 1, 15
	predef PrintMonTypes
	hlcoord 9, 8
	ld de, SCREEN_WIDTH
	ld b, 10
	ld a, $31
.vertical_divider
	ld [hl], a
	add hl, de
	dec b
	jr nz, .vertical_divider
	ld de, .ExpPointStr
	hlcoord 10, 9
	call PlaceString
	hlcoord 17, 14
	call .PrintNextLevel
	hlcoord 13, 10
	lb bc, 3, 7
	ld de, TempMonExp
	call PrintNum
	call .CalcExpToNextLevel
	hlcoord 13, 13
	lb bc, 3, 7
	ld de, Buffer1 ; wd1ea (aliases: MagikarpLength)
	call PrintNum
	ld de, .LevelUpStr
	hlcoord 10, 12
	call PlaceString
	ld de, .ToStr
	hlcoord 14, 14
	call PlaceString
	hlcoord 11, 16
	ld a, [TempMonLevel]
	ld b, a
	ld de, TempMonExp + 2
	predef FillInExpBar
	hlcoord 10, 16
	ld [hl], $40
	hlcoord 19, 16
	ld [hl], $41
	ret

.PrintNextLevel: ; 4e0d3 (13:60d3)
	ld a, [TempMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .AtMaxLevel
	inc a
	ld [TempMonLevel], a
.AtMaxLevel:
	call PrintLevel
	pop af
	ld [TempMonLevel], a
	ret

.CalcExpToNextLevel: ; 4e0e7 (13:60e7)
	ld a, [TempMonLevel]
	cp MAX_LEVEL
	jr z, .AlreadyAtMaxLevel
	inc a
	ld d, a
	callba CalcExpAtLevel
rept 2
	ld hl, TempMonExp + 2
endr
	ld a, [hQuotient + 2]
	sub [hl]
	dec hl
	ld [Buffer3], a
	ld a, [hQuotient + 1]
	sbc [hl]
	dec hl
	ld [Buffer2], a ; wd1eb (aliases: MovementType)
	ld a, [hQuotient]
	sbc [hl]
	ld [Buffer1], a ; wd1ea (aliases: MagikarpLength)
	ret

.AlreadyAtMaxLevel:
	ld hl, Buffer1 ; wd1ea (aliases: MagikarpLength)
	xor a
rept 2
	ld [hli], a
endr
	ld [hl], a
	ret
; 4e119 (13:6119)

.Status_Type: ; 4e119
	db   "Status/"
	next "Type/@"
; 4e127

.OK_str: ; 4e127
	db "OK @"
; 4e12b

.ExpPointStr: ; 4e12b
	db "Exp.Points@"
; 4e136

.LevelUpStr: ; 4e136
	db "Level Up@"
; 4e13f

.ToStr: ; 4e13f
	db "to@"
; 4e142

.PkrsStr: ; 4e142
	db "#rus@"
; 4e147

.GreenPage: ; 4e147 (13:6147)
	ld de, .Item
	hlcoord 0, 8
	call PlaceString
	call .GetItemName
	hlcoord 8, 8
	call PlaceString
	ld de, .Move
	hlcoord 0, 10
	call PlaceString
	ld hl, TempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	hlcoord 8, 10
	ld a, SCREEN_WIDTH * 2
	ld [Buffer1], a
	predef ListMoves
	hlcoord 12, 11
	ld a, SCREEN_WIDTH * 2
	ld [Buffer1], a
	predef ListMovePP
	ret

.GetItemName: ; 4e189 (13:6189)
	ld de, .ThreeDashes
	ld a, [TempMonItem]
	and a
	ret z
	ld [wd265], a
	call GetItemName
	ret
; 4e1a0 (13:61a0)

.Item: ; 4e1a0
	db "Item@"
; 4e1a5

.ThreeDashes: ; 4e1a5
	db "---@"
; 4e1a9

.Move: ; 4e1a9
	db "Moves@"
; 4e1ae

.BluePage: ; 4e1ae (13:61ae)
	call .PlaceOTInfo
	call .PlaceNatureInfo
	hlcoord 10, 8
	ld de, SCREEN_WIDTH
	ld b, 10
	ld a, $31
.BluePageVerticalDivider:
	ld [hl], a
	add hl, de
	dec b
	jr nz, .BluePageVerticalDivider
	hlcoord 11, 8
	ld bc, 6
	predef PrintTempMonStats
	ret

.PlaceOTInfo: ; 4e1cc (13:61cc)
	ld de, IDNoString
	hlcoord 0, 9
	call PlaceString
	ld de, OTString
	hlcoord 0, 12
	call PlaceString
	hlcoord 2, 10
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	ld de, TempMonID
	call PrintNum
	ld hl, .OTNamePointers
	call GetNicknamePointer
	call CopyNickname
	callba CheckNickErrors
	hlcoord 2, 13
	call PlaceString
	ld a, [TempMonCaughtGender]
	and a
	jr z, .done
	cp $7f
	jr z, .done
	and $80
	ld a, "♂"
	jr z, .got_gender
	ld a, "♀"
.got_gender
	hlcoord 9, 13
	ld [hl], a
.done
	ret
; 4e216 (13:6216)

.OTNamePointers: ; 4e216
	dw PartyMonOT
	dw OTPartyMonOT
	dw sBoxMonOT
	dw wBufferMonOT
; 4e21e

.PlaceNatureInfo:
	ld de, NatureString
	hlcoord 0, 15
	call PlaceString
	ld a, [TempMonDVs]
	ld b, a
	callba CheckNature
	hlcoord 2, 16
	predef PrintNature
	ret

.OrangePage:
	callba OrangePage_
	ret

IDNoString: ; 4e21e
	db "<ID>№.@"

OTString: ; 4e222
	db "OT/@"
; 4e226

NatureString:
	db "Nature/@"


; Fourth stats page code by TPP Anniversary Crystal 251
; Ported by FredrIQ
OrangePage_:
	call TN_PrintToD
	call TN_PrintLocation
	call TN_PrintLV
	jp TN_PrintCharacteristics

TN_PrintToD
	ld de, .caughtat
	hlcoord 1, 9
	call PlaceString
	ld a, [TempMonCaughtTime]
	and $c0
	ld de, .unknown
	jr z, .print
	rlca
	rlca
	cp 2
	ld de, .morn
	jr c, .print
	ld de, .day
	jr z, .print
	ld de, .nite
.print
	hlcoord 5, 9
	jp PlaceString

.caughtat
	db "Met@"

.morn
	db "in the morning@"

.day
	db "during the day@"

.nite
	db "at night@"

.unknown
	db "at some time@"

TN_PrintLocation:
	ld de, .unknown
	ld a, [TempMonCaughtLocation]
	and $7f
	jr z, .print
	cp $7e
	jr z, .print
	ld de, .event
	cp $7f
	jr z, .print
	ld e, a
	callba GetLandmarkName
	ld de, StringBuffer1
.print
	hlcoord 1, 11
	jp PlaceString

.unknown
	db "Unknown location@"

.event
	db "Event #mon@"

TN_PrintLV:
	ld a, [TempMonCaughtLevel]
	and $3f
	hlcoord 1, 13
	jr z, .unknown
	cp 1
	jr z, .hatched
	cp 63
	jr z, .max
	ld [Buffer2], a
	ld de, .metat
	call PlaceString
	ld de, Buffer2
	lb bc, PRINTNUM_RIGHTALIGN | 1, 2
	hlcoord 9, 13
	jp PrintNum
.hatched
	ld de, .egg
	jp PlaceString
.unknown
	ld de, .str_unknown
	jp PlaceString
.max
	ld de, .str_max
	call PlaceString
	ret

.metat
	db "Met at <LV>@"

.egg
	db "Hatched from Egg@"

.str_unknown
	db "Given in a trade@"

.str_max
	db "Met at <LV>63 or more@"

TN_PrintCharacteristics:
	ld hl, TempMonDVs
	ld d, 0 ; hp
	ld a, [hl]
	and $f
	ld c, a ; def
	ld a, [hli]
	swap a
	and $f ; atk
	cp c
	ld e, 2
	ld b, c
	jr c, .atk
	ld e, 1
	ld b, a
.atk
	srl a
	rl d
	srl c
	rl d
	ld a, [hl]
	and $f
	ld c, a ; spd
	ld a, [hl]
	swap a
	and $f ; spc
	cp c
	ld l, 5
	ld h, c
	jr c, .spx
	ld l, 3
	ld h, a
.spx
	srl a
	rl d
	srl c
	rl d
	ld a, b
	cp h
	jr nc, .skip
	ld e, l
	ld b, h
.skip
	ld a, b
	cp d
	jr nc, .skiphp
	ld e, 0
	ld b, d
.skiphp
	ld a, 3
	cp e
	jr nz, .skipspx
	; since DVs don't have SpA/SpD split so we have to
	; determine it by OT ID
	ld a, [TempMonID + 1]
	bit 0, a
	jr z, .skipspx
	inc e
.skipspx
	ld a, b
	ld c, 5
	call SimpleDivide
	ld b, a
	ld a, e
	call SimpleMultiply
	add b
	ld l, a
	ld h, 0
	ld bc, Characteristics
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	decoord 1, 15
	push de
.loop
	ld a, [hli]
	cp "@"
	jr z, .done
	cp $4e
	jr z, .line
	ld [de], a
	inc de
	jr .loop

.line
	pop de
	push hl
	ld hl, $0014
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push de
	jr .loop

.done
	pop de
	ret


Characteristics:
	dw Chara_HP0, Chara_HP1, Chara_HP2, Chara_HP3, Chara_HP4
	dw Chara_ATK0, Chara_ATK1, Chara_ATK2, Chara_ATK3, Chara_ATK4
	dw Chara_DEF0, Chara_DEF1, Chara_DEF2, Chara_DEF3, Chara_DEF4
	dw Chara_SPA0, Chara_SPA1, Chara_SPA2, Chara_SPA3, Chara_SPA4
	dw Chara_SPD0, Chara_SPD1, Chara_SPD2, Chara_SPD3, Chara_SPD4
	dw Chara_SPE0, Chara_SPE1, Chara_SPE2, Chara_SPE3, Chara_SPE4

Chara_HP0:
	db   "Loves to eat@"
Chara_HP1:
	db   "Takes plenty of"
	next "siestas@"
Chara_HP2:
	db   "Nods off a lot@"
Chara_HP3:
	db   "Scatters things"
	next "often@"
Chara_HP4:
	db   "Likes to relax@"

Chara_ATK0:
	db   "Proud of its"
	next "power@"
Chara_ATK1:
	db   "Likes to thrash"
	next "about@"
Chara_ATK2:
	db   "A little quick"
	next "tempered@"
Chara_ATK3:
	db   "Likes to fight@"
Chara_ATK4:
	db   "Quick tempered@"

Chara_DEF0:
	db   "Sturdy body@"
Chara_DEF1:
	db   "Capable of taking"
	next "hits@"
Chara_DEF2:
	db   "Highly persistent@"
Chara_DEF3:
	db   "Good endurance@"
Chara_DEF4:
	db   "Good perseverance@"

Chara_SPA0:
	db   "Highly curious@"
Chara_SPA1:
	db   "Mischievous@"
Chara_SPA2:
	db   "Thoroughly"
	next "cunning@"
Chara_SPA3:
	db   "Often lost in"
	next "thought@"
Chara_SPA4:
	db   "Very finicky@"

Chara_SPD0:
	db   "Strong willed@"
Chara_SPD1:
	db   "Somewhat vain@"
Chara_SPD2:
	db   "Strongly defiant@"
Chara_SPD3:
	db   "Hates to lose@"
Chara_SPD4:
	db   "Somewhat stubborn@"

Chara_SPE0:
	db   "Likes to run@"
Chara_SPE1:
	db   "Alert to sounds@"
Chara_SPE2:
	db   "Impetuous and"
	next "silly@"
Chara_SPE3:
	db   "Somewhat of a"
	next "clown@"
Chara_SPE4:
	db   "Quick to flee@"


StatsScreen_PlaceFrontpic: ; 4e226 (13:6226)
	ld hl, TempMonDVs
	predef GetVariant
	call StatsScreen_GetAnimationParam
	jr c, .egg
	and a
	jr z, .no_cry
	jr .cry

.egg
	call .AnimateEgg
	call SetPalettes
	ret

.no_cry
	call .AnimateMon
	call SetPalettes
	ret

.cry
	call SetPalettes
	call .AnimateMon
	ld a, [CurPartySpecies]
	call PlayCry2
	ret

.AnimateMon: ; 4e253 (13:6253)
	ld hl, wcf64
	set 5, [hl]
	ld a, [CurPartySpecies]
	cp UNOWN
	jr z, .unown
	hlcoord 0, 0
	call PrepMonFrontpic
	ret

.unown
	xor a
	ld [wBoxAlignment], a
	hlcoord 0, 0
	call _PrepMonFrontpic
	ret

.AnimateEgg: ; 4e271 (13:6271)
	ld a, [CurPartySpecies]
	cp UNOWN
	jr z, .unownegg
	ld a, TRUE
	ld [wBoxAlignment], a
	call .get_animation
	ret

.unownegg
	xor a
	ld [wBoxAlignment], a
	call .get_animation
	ret

.get_animation ; 4e289 (13:6289)
	ld a, [CurPartySpecies]
	call IsAPokemon
	ret c
	call StatsScreen_LoadTextBoxSpaceGFX
	ld de, VTiles2 tile $00
	predef FrontpicPredef
	hlcoord 0, 0
	ld d, $0
	ld e, $2
	predef LoadMonAnimation
	ld hl, wcf64
	set 6, [hl]
	ret

StatsScreen_GetAnimationParam: ; 4e2ad (13:62ad)
	ld a, [MonType]
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable: ; 4e2b5 (13:62b5)
	dw .PartyMon
	dw .OTPartyMon
	dw .BoxMon
	dw .Tempmon
	dw .Wildmon


.PartyMon: ; 4e2bf (13:62bf)
	ld a, [CurPartyMon]
	ld hl, PartyMons ; wdcdf (aliases: PartyMon1, PartyMon1Species)
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld b, h
	ld c, l
	jr .CheckEggFaintedFrzSlp

.OTPartyMon: ; 4e2cf (13:62cf)
	xor a
	ret

.BoxMon: ; 4e2d1 (13:62d1)
	ld hl, sBoxMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [CurPartyMon]
	call AddNTimes
	ld b, h
	ld c, l
	ld a, BANK(sBoxMons)
	call GetSRAMBank
	call .CheckEggFaintedFrzSlp
	push af
	call CloseSRAM
	pop af
	ret

.Tempmon: ; 4e2ed (13:62ed)
	ld bc, TempMonSpecies ; wd10e (aliases: TempMon)
.CheckEggFaintedFrzSlp: ; 4e2f2 (13:62f2)
	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg
	call CheckFaintedFrzSlp
	jr c, .FaintedFrzSlp
.egg
	xor a
	scf
	ret

.Wildmon: ; 4e301 (13:6301)
	ld a, $1
	and a
	ret

.FaintedFrzSlp: ; 4e305 (13:6305)
	xor a
	ret

StatsScreen_LoadTextBoxSpaceGFX: ; 4e307 (13:6307)
	nop
	push hl
	push de
	push bc
	push af
	call DelayFrame
	ld a, [rVBK]
	push af
	ld a, $1
	ld [rVBK], a
	ld de, TextBoxSpaceGFX
	lb bc, BANK(TextBoxSpaceGFX), 1
	ld hl, VTiles2 tile $7f
	call Get2bpp
	pop af
	ld [rVBK], a
	pop af
	pop bc
	pop de
	pop hl
	ret
; 4e32a (13:632a)

EggStatsScreen: ; 4e33a
	xor a
	ld [hBGMapMode], a
	ld hl, wcda1
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call StatsScreen_PlaceHorizontalDivider
	ld de, EggString
	hlcoord 8, 1
	call PlaceString
	ld de, IDNoString
	hlcoord 8, 3
	call PlaceString
	ld de, OTString
	hlcoord 8, 5
	call PlaceString
	ld de, FiveQMarkString
	hlcoord 11, 3
	call PlaceString
	ld de, FiveQMarkString
	hlcoord 11, 5
	call PlaceString
	ld a, [TempMonHappiness] ; egg status
	ld de, EggSoonString
	cp $6
	jr c, .picked
	ld de, EggCloseString
	cp $b
	jr c, .picked
	ld de, EggMoreTimeString
	cp $29
	jr c, .picked
	ld de, EggALotMoreTimeString
.picked
	hlcoord 1, 9
	call PlaceString
	ld hl, wcf64
	set 5, [hl]
	call SetPalettes ; pals
	call DelayFrame
	hlcoord 0, 0
	call PrepMonFrontpic
	callba Function10402d
	call StatsScreen_AnimateEgg

	ld a, [TempMonHappiness]
	cp 6
	ret nc
	ld de, SFX_2_BOOPS
	call PlaySFX
	ret
; 0x4e3c0

EggString: ; 4e3c0
	db "Egg@"

FiveQMarkString: ; 4e3c4
	db "?????@"

EggSoonString: ; 0x4e3ca
	db   "It's making sounds"
	next "inside. It's going"
	next "to hatch soon!@"

EggCloseString: ; 0x4e3fd
	db   "It moves around"
	next "inside sometimes."
	next "It must be close"
	next "to hatching.@"

EggMoreTimeString: ; 0x4e43d
	db   "Wonder what's"
	next "inside? It needs"
	next "more time, though.@"

EggALotMoreTimeString: ; 0x4e46e
	db   "This Egg needs a"
	next "lot more time to"
	next "hatch.@"
; 0x4e497


StatsScreen_AnimateEgg: ; 4e497 (13:6497)
	call StatsScreen_GetAnimationParam
	ret nc
	ld a, [TempMonHappiness]
	ld e, $7
	cp 6
	jr c, .animate
	ld e, $8
	cp 11
	jr c, .animate
	ret

.animate
	push de
	ld a, $1
	ld [wBoxAlignment], a
	call StatsScreen_LoadTextBoxSpaceGFX
	ld de, VTiles2 tile $00
	predef FrontpicPredef
	pop de
	hlcoord 0, 0
	ld d, $0
	predef LoadMonAnimation
	ld hl, wcf64
	set 6, [hl]
	ret

StatsScreen_LoadPageIndicators: ; 4e4cd (13:64cd)
	hlcoord 11, 5
	ld a, $36
	call .load_square
	hlcoord 13, 5
	ld a, $36
	call .load_square
	hlcoord 15, 5
	ld a, $36
	call .load_square
	hlcoord 17, 5
	ld a, $36
	call .load_square
	ld a, c
	and a
	jr z, .zero
	cp $2
	ld a, $3a
	hlcoord 13, 5
	jr c, .load_square
	hlcoord 15, 5
	jr z, .load_square
	hlcoord 17, 5
	jr .load_square
.zero
	ld a, $3a
	hlcoord 11, 5
.load_square ; 4e4f7 (13:64f7)
	push bc
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	pop bc
	ret

CopyNickname: ; 4e505 (13:6505)
	ld de, StringBuffer1
	ld bc, PKMN_NAME_LENGTH
	ld a, [MonType]
	cp BOXMON
	jr nz, .partymon
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank
	push de
	call CopyBytes
	pop de
	call CloseSRAM
	ret

.partymon
	push de
	call CopyBytes
	pop de
	ret

GetNicknamePointer: ; 4e528 (13:6528)
	ld a, [MonType]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [MonType]
	cp BREEDMON
	ret z
	ld a, [CurPartyMon]
	jp SkipNames


CheckFaintedFrzSlp: ; 4e53f
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .fainted_frz_slp
	ld hl, MON_STATUS
	add hl, bc
	ld a, [hl]
	and (1 << FRZ) | SLP
	jr nz, .fainted_frz_slp
	and a
	ret

.fainted_frz_slp
	scf
	ret
; 4e554
