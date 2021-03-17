; object constants
PLAYER      EQU  0
LAST_TALKED EQU -2

; string buffer constants
	const_def
	const STRING_BUFFER_3 ; use wStringBuffer3
	const STRING_BUFFER_4 ; use wStringBuffer4
	const STRING_BUFFER_5 ; use wStringBuffer5
NUM_STRING_BUFFERS EQU const_value

STRING_BUFFER_LENGTH EQU 19

; readvar/writevar/loadvar arguments
; _GetVarAction.VarActionTable indexes (see engine/overworld/variables.asm)
	const_def
	const VAR_STRINGBUFFER2    ; 00
	const VAR_PARTYCOUNT       ; 01
	const VAR_BATTLERESULT     ; 02
	const VAR_BATTLETYPE       ; 03
	const VAR_TIMEOFDAY        ; 04
	const VAR_DEXCAUGHT        ; 05
	const VAR_DEXSEEN          ; 06
	const VAR_BADGES           ; 07
	const VAR_MOVEMENT         ; 08
	const VAR_FACING           ; 09
	const VAR_HOUR             ; 0a
	const VAR_WEEKDAY          ; 0b
	const VAR_MAPGROUP         ; 0c
	const VAR_MAPNUMBER        ; 0d
	const VAR_UNOWNCOUNT       ; 0e
	const VAR_ROOFPALETTE      ; 0f
	const VAR_BOXSPACE         ; 10
	const VAR_CONTESTMINUTES   ; 11
	const VAR_XCOORD           ; 12
	const VAR_YCOORD           ; 13
	const VAR_SPECIALPHONECALL ; 14
	const VAR_KURT_APRICORNS   ; 15
	const VAR_CALLERID         ; 16
	const VAR_BLUECARDBALANCE  ; 17
	const VAR_BUENASPASSWORD   ; 18
	const VAR_KENJI_BREAK      ; 19
	const VAR_PKMN_JOURNALS    ; 1a
	const VAR_TRAINER_STARS    ; 1b
NUM_VARS EQU const_value   ; 1c

; variable action types
RETVAR_STRBUF2 EQU (0 << 6)
RETVAR_ADDR_DE EQU (1 << 6)
RETVAR_EXECUTE EQU (2 << 6)

; PlayerEventScriptPointers indexes (see engine/overworld/events.asm)
	const_def -1
	const PLAYEREVENT_MAPSCRIPT
	const PLAYEREVENT_NONE
	const PLAYEREVENT_SEENBYTRAINER
	const PLAYEREVENT_TALKTOTRAINER
	const PLAYEREVENT_ITEMBALL
	const PLAYEREVENT_CONNECTION
	const PLAYEREVENT_WARP
	const PLAYEREVENT_FALL
	const PLAYEREVENT_WHITEOUT
	const PLAYEREVENT_HATCH
	const PLAYEREVENT_JOYCHANGEFACING
	const PLAYEREVENT_TMHMBALL
	const PLAYEREVENT_KEYITEMBALL
NUM_PLAYER_EVENTS EQU const_value

; PlayerMovement.pointers indexes (see engine/overworld/events.asm)
	const_def
	const PLAYERMOVEMENT_NORMAL
	const PLAYERMOVEMENT_WARP
	const PLAYERMOVEMENT_TURN
	const PLAYERMOVEMENT_FORCE_TURN
	const PLAYERMOVEMENT_FINISH
	const PLAYERMOVEMENT_CONTINUE
	const PLAYERMOVEMENT_EXIT_WATER
	const PLAYERMOVEMENT_JUMP

; script data sizes (see macros/scripts/maps.asm)
SCENE_SCRIPT_SIZE EQU 2  ; scene_script
CALLBACK_SIZE     EQU 3  ; callback
WARP_EVENT_SIZE   EQU 5  ; warp_event
COORD_EVENT_SIZE  EQU 5  ; coord_event
BG_EVENT_SIZE     EQU 5  ; bg_event
OBJECT_EVENT_SIZE EQU 13 ; object_event

; bg_event types
; TryBGEvent arguments (see engine/overworld/events.asm)
	const_def
	const BGEVENT_READ
	const BGEVENT_UP
	const BGEVENT_DOWN
	const BGEVENT_RIGHT
	const BGEVENT_LEFT
	const BGEVENT_IFSET
	const BGEVENT_IFNOTSET
	const BGEVENT_JUMPTEXT
	const BGEVENT_JUMPSTD
	const BGEVENT_GROTTOITEM
; BGEVENT_ITEM has to be the last BG event type, since hidden item BG events
; use type BGEVENT_ITEM + (item id) to save space.
; Note that this requires BGEVENT_ITEM + (item id) <= $ff, so currently most
; of the mail items cannot be hidden.
BGEVENT_ITEM EQU const_value

; see engine/events.asm:TryObjectEvent.pointers
	const_def
	const OBJECTTYPE_SCRIPT         ; 0
	const OBJECTTYPE_ITEMBALL       ; 1
	const OBJECTTYPE_TRAINER        ; 2
	const OBJECTTYPE_GENERICTRAINER ; 3
	const OBJECTTYPE_POKEMON        ; 4
	const OBJECTTYPE_COMMAND        ; 5
NUM_OBJECTTYPES EQU const_value

; elevfloor macro values
; ElevatorFloorNames indexes (see data/events/elevator_floors.asm)
	const_def
	const _B4F
	const _B3F
	const _B2F
	const _B1F
	const _1F
	const _2F
	const _3F
	const _4F
	const _5F
	const _6F
	const _7F
	const _8F
	const _9F
	const _10F
	const _11F
	const _ROOF

; showemote arguments
; Emotes indexes (see data/sprites/emotes.asm)
	const_def
	const EMOTE_SHOCK ; 0
	const EMOTE_QUESTION ; 1
	const EMOTE_HAPPY ; 2
	const EMOTE_SAD ; 3
	const EMOTE_HEART ; 4
	const EMOTE_BOLT ; 5
	const EMOTE_SLEEP ; 6
	const EMOTE_FISH ; 7
EMOTE_FROM_MEM EQU -1

; fruittree arguments
; FruitTreeItems indexes (see data/items/fruit_trees.asm)
	const_def 1
; Apricorn trees come first, then Berry trees
	const FRUITTREE_AZALEA_TOWN     ; 01
	const FRUITTREE_ROUTE_37_1      ; 02
	const FRUITTREE_ROUTE_37_2      ; 03
	const FRUITTREE_ROUTE_37_3      ; 04
	const FRUITTREE_ROUTE_42_1      ; 05
	const FRUITTREE_ROUTE_42_2      ; 06
	const FRUITTREE_ROUTE_42_3      ; 07
FIRST_BERRY_TREE EQU const_value
	const FRUITTREE_ROUTE_29        ; 08
	const FRUITTREE_ROUTE_30_1      ; 09
	const FRUITTREE_ROUTE_30_2      ; 0a
	const FRUITTREE_ROUTE_31        ; 0b
	const FRUITTREE_VIOLET_CITY     ; 0c
	const FRUITTREE_ROUTE_32_COAST  ; 0d
	const FRUITTREE_ROUTE_33        ; 0e
	const FRUITTREE_ROUTE_35        ; 0f
	const FRUITTREE_ROUTE_36        ; 10
	const FRUITTREE_ROUTE_38        ; 11
	const FRUITTREE_ROUTE_39        ; 12
	const FRUITTREE_ROUTE_43        ; 13
	const FRUITTREE_ROUTE_44        ; 14
	const FRUITTREE_ROUTE_45        ; 15
	const FRUITTREE_ROUTE_46_1      ; 16
	const FRUITTREE_ROUTE_46_2      ; 17
	const FRUITTREE_ROUTE_27        ; 18
	const FRUITTREE_ROUTE_26        ; 19
	const FRUITTREE_ROUTE_8         ; 1a
	const FRUITTREE_ROUTE_11        ; 1b
	const FRUITTREE_FUCHSIA_CITY    ; 1c
	const FRUITTREE_PEWTER_CITY_1   ; 1d
	const FRUITTREE_PEWTER_CITY_2   ; 1e
	const FRUITTREE_ROUTE_2         ; 1f
	const FRUITTREE_ROUTE_1         ; 20
	const FRUITTREE_LUCKY_ISLAND    ; 21
	const FRUITTREE_SHAMOUTI_ISLAND ; 22
	const FRUITTREE_ROUTE_49        ; 23
NUM_FRUIT_TREES EQU const_value - 1

; hidden grottoes
; see engine/hidden_grottoes.asm:HiddenGrottoData
	const_def 1
	const HIDDENGROTTO_ROUTE_32           ; 01
	const HIDDENGROTTO_ILEX_FOREST        ; 02
	const HIDDENGROTTO_ROUTE_35           ; 03
	const HIDDENGROTTO_LAKE_OF_RAGE       ; 04
	const HIDDENGROTTO_CHERRYGROVEBAY     ; 05
	const HIDDENGROTTO_RUINSOFALPH        ; 06
	const HIDDENGROTTO_ROUTE_33           ; 07
	const HIDDENGROTTO_ROUTE_32_COAST     ; 08
	const HIDDENGROTTO_OLIVINE_CITY       ; 09
	const HIDDENGROTTO_ROUTE_39           ; 0a
	const HIDDENGROTTO_STORMY_BEACH       ; 0b
	const HIDDENGROTTO_ROUTE_37           ; 0c
	const HIDDENGROTTO_ROUTE_47           ; 0d
	const HIDDENGROTTO_ROUTE_48           ; 0e
	const HIDDENGROTTO_BELLCHIME_TRAIL    ; 0f
	const HIDDENGROTTO_ROUTE_44           ; 10
	const HIDDENGROTTO_ROUTE_45           ; 11
	const HIDDENGROTTO_SILVER_CAVE_OUTSIDE; 12
	const HIDDENGROTTO_13                 ; 13
	const HIDDENGROTTO_14                 ; 14
	const HIDDENGROTTO_15                 ; 15
	const HIDDENGROTTO_16                 ; 16
	const HIDDENGROTTO_17                 ; 17
NUM_HIDDEN_GROTTOES EQU const_value - 1

; describedecoration arguments
; DescribeDecoration.JumpTable indexes (see engine/overworld/decorations.asm)
	const_def
	const DECODESC_POSTER     ; 0
	const DECODESC_LEFT_DOLL  ; 1
	const DECODESC_RIGHT_DOLL ; 2
	const DECODESC_BIG_DOLL   ; 3
	const DECODESC_CONSOLE    ; 4

; swarm arguments
; StoreSwarmMapIndices arguments
	const_def
	const SWARM_DUNSPARCE ; 0
	const SWARM_YANMA     ; 1

; ActivateFishingSwarm setval arguments
	const_def
	const FISHSWARM_NONE     ; 0
	const FISHSWARM_QWILFISH ; 1
	const FISHSWARM_REMORAID ; 2

; paintings
	const_def
	const HO_OH_PAINTING
	const LUGIA_PAINTING
	const BELL_TOWER_PAINTING
	const KABUTO_PUZZLE
	const OMANYTE_PUZZLE
	const AERODACTYL_PUZZLE
	const HO_OH_PUZZLE
NUM_PAINTINGS EQU const_value
