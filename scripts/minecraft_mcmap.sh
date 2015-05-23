#! /bin/bash

X1="-11"
Y1="-15"
X2="8"
Y2="5"

DIRECTORY="/home/pfsmorigo/.minecraft/saves/SmoWorld/"

OUTPUT_DIR="$(date +%F)"
OUTPUT=${OUTPUT_DIR}/SmoWorld

mkdir -p "$OUTPUT_DIR"

layers() {
	OPT=

	for LAYER in all level-a0 level-b1 bedrock; do

		case "$LAYER" in
			all)
				OPT=;;
			level-a0)
				OPT="-max 64";;
			level-b1)
				OPT="-max 56";;
			bedrock)
				OPT="-max 7";;
			*)
		esac

		for POS in north east south west; do
			echo "$LAYER ($POS)..."
			mcmap -from $X1 $Y1 -to $X2 $Y2 -$POS $OPT -file ${OUTPUT}_${LAYER}_${POS}.png $DIRECTORY
		done
	done
}

xray() {
	for NUM in $(seq 0 150); do
		mcmap -from $X1 $Y1 -to $X2 $Y2 -height $NUM -file ${OUTPUT}_max$(printf "%03d" "$NUM").png $DIRECTORY
	done
}

slice() {
	for NUM in $(seq $X1 7); do
		mcmap -from $NUM $Y1 -to $X2 $Y2 -file ${OUTPUT}_slice$(printf "%02d" "$(expr $NUM + 11)").png $DIRECTORY
	done
}

big() {
	#mcmap -from -60 -80 -to 45 30 -south -file SmoWorld_big.png ~/.minecraft/saves/SmoWorld
	mcmap -from -80 -100 -to 65 50 -south -file ${OUTPUT}_big.png ~/.minecraft/saves/SmoWorld
}

nether() {
	#mcmap -from -60 -80 -to 45 30 -south -file SmoWorld_big.png ~/.minecraft/saves/SmoWorld
	for POS in north east south west; do
		mcmap -hell -$POS -file ${OUTPUT}_nether_$POS.png ~/.minecraft/saves/SmoWorld
	done
}

others() {
	#mcmap -from -55 -75 -to 40 25 -south -file SmoWorld_big.png ~/.minecraft/saves/SmoWorld
	#mcmap -south -file SmoWorld_all.png ~/.minecraft/saves/SmoWorld
	echo teste
}

case $1 in
	layers)
		layers
		;;

	xray)
		xray
		;;

	slice)
		slice
		;;

	big)
		big
		;;

	nether)
		nether
		;;

	all)
		layers
		xray
		slice
		big
		nether
		;;

	help)
		echo "layers"
		echo "xray"
		echo "slice"
		echo "big"
		;;

	*)
		echo "error"
		;;
esac

