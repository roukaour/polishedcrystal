VWFWidths:
	db 4 ; $7f " "
	db 5 ; $80 "A"
	db 5 ; $81 "B"
	db 6 ; $82 "C"
	db 5 ; $83 "D"
	db 5 ; $84 "E"
	db 5 ; $85 "F"
	db 6 ; $86 "G"
	db 6 ; $87 "H"
	db 4 ; $88 "I"
	db 6 ; $89 "J"
	db 5 ; $8a "K"
	db 5 ; $8b "L"
	db 6 ; $8c "M"
	db 5 ; $8d "N"
	db 6 ; $8e "O"
	db 5 ; $8f "P"
	db 6 ; $90 "Q"
	db 5 ; $91 "R"
	db 5 ; $92 "S"
	db 6 ; $93 "T"
	db 5 ; $94 "U"
	db 6 ; $95 "V"
	db 6 ; $96 "W"
	db 5 ; $97 "X"
	db 6 ; $98 "Y"
	db 5 ; $99 "Z"
	db 3 ; $9a "("
	db 3 ; $9b ")"
	db 2 ; $9c "."
	db 3 ; $9d ","
	db 6 ; $9e "?"
	db 4 ; $9f "!"
	db 5 ; $a0 "a"
	db 5 ; $a1 "b"
	db 4 ; $a2 "c"
	db 5 ; $a3 "d"
	db 5 ; $a4 "e"
	db 4 ; $a5 "f"
	db 5 ; $a6 "g"
	db 5 ; $a7 "h"
	db 3 ; $a8 "i"
	db 3 ; $a9 "j"
	db 5 ; $aa "k"
	db 3 ; $ab "l"
	db 6 ; $ac "m"
	db 5 ; $ad "n"
	db 5 ; $ae "o"
	db 5 ; $af "p"
	db 5 ; $b0 "q"
	db 4 ; $b1 "r"
	db 5 ; $b2 "s"
	db 4 ; $b3 "t"
	db 5 ; $b4 "u"
	db 5 ; $b5 "v"
	db 6 ; $b6 "w"
	db 6 ; $b7 "x"
	db 5 ; $b8 "y"
	db 5 ; $b9 "z"
	db 4 ; $ba "“"
	db 4 ; $bb "”"
	db 4 ; $bc "-"
	db 2 ; $bd ":"
	db 6 ; $be "♂"
	db 6 ; $bf "♀"
	db 2 ; $c0 "'"
	db 6 ; $c1 "'d"
	db 5 ; $c2 "'l"
	db 7 ; $c3 "'m"
	db 5 ; $c4 "'r"
	db 6 ; $c5 "'s"
	db 5 ; $c6 "'t"
	db 6 ; $c7 "'v"
	db 5 ; $c8 "é"
	db 5 ; $c9 "É"
	db 5 ; $ca "á"
	db 5 ; $cb "ê"
	db 3 ; $cc "í"
	db 5 ; $cd "ó"
	db 6 ; $ce "¿"
	db 4 ; $cf "¡"
	db 7 ; $d0 "<PO>"
	db 7 ; $d1 "<KE>"
	db 7 ; $d2 "<PK>"
	db 8 ; $d3 "<MN>"
	db 8 ; $d4 "<ID>"
	db 8 ; $d5 "№"
	db 7 ; $d6 "<LV>"
	db 5 ; $d7 "<BOLDP>"
	db 6 ; $d8 "&"
	db 5 ; $d9 "♪"
	db 6 ; $da "♥"
	db 4 ; $db "×"
	db 4 ; $dc "/"
	db 5 ; $dd "%"
	db 4 ; $de "+"
	db 6 ; $df "<SHARP>"
	db 5 ; $e0 "0"
	db 4 ; $e1 "1"
	db 5 ; $e2 "2"
	db 5 ; $e3 "3"
	db 5 ; $e4 "4"
	db 5 ; $e5 "5"
	db 5 ; $e6 "6"
	db 5 ; $e7 "7"
	db 5 ; $e8 "8"
	db 5 ; $e9 "9"
	db 6 ; $ea "¥"
	db 6 ; $eb "▲"
	db 6 ; $ec "▼"
	db 4 ; $ed "◀"
	db 4 ; $ee "▶"
	db 5 ; $ef "▷"
	db 6 ; $f0 "…"
	db 5 ; $f1 "<PHONE>"
	db 4 ; $f2 "<BLACK>"
	db 6 ; $f3 "<NONO>"
	db 3 ; $f4 "′"
	db 5 ; $f5 "″"
	db 6 ; $f6 "★"
	db 6 ; $f7 "↑"
	db 6 ; $f8 "↓"
	db 4 ; $f9 "<UPDN>"
	db 5 ; $fa "┌"
	db 5 ; $fb "─"
	db 5 ; $fc "┐"
	db 5 ; $fd "│"
	db 5 ; $fe "└"
	db 5 ; $ff "┘"

VWFCharacterGFX:
INCBIN "gfx/font/space.1bpp"
INCBIN "gfx/font/vwf.1bpp"
