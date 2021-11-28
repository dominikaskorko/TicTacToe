#!/bin/bash

PLANSZA=("0" "0" "0"
         "0" "0" "0"
	 "0" "0" "0" )

 KONIEC=0
 NUMBER=-1
 PLAYER=0
 PLAYER0SIGN="X"
 PLAYER1SIGN="@"
 CURRENTSIGN=$PLAYER0SIGN

 function wyswietl_plansze(){
	 echo "Plansza:"
	 first=${PLANSZA[*]:0:3};
	 second=${PLANSZA[*]:3:3};
	 third=${PLANSZA[*]:6:3};
	 echo "${first[*]}";
	 echo "${second[*]}";
	 echo "${third[*]}";
 }

function read_number(){
	echo "Wybierz numer od 0 do 8"
	flag=0
	while [ $flag -eq 0 ]
	do
		read NUMBER
		if [ ${PLANSZA[$NUMBER]} == "0" ]
			 then
			 PLANSZA[NUMBER]=$CURRENTSIGN
			 flag=1
		else
			 echo "Pole zajete, wybierz inny numer"
		fi
	done
	wyswietl_plansze
}
   
function random_shot(){
randomNumber=$(($RANDOM % 9))
while [ ${PLANSZA[$randomNumber]} != "0" ]
	do
	randomNumber=$(($RANDOM % 9))
	done
	PLANSZA[randomNumber]=$CURRENTSIGN
	echo "$randomNumber"
	wyswietl_plansze
 }

function change_player(){
if [ $PLAYER -eq 0 ]
then
PLAYER=1
CURRENTSIGN=$PLAYER1SIGN
else
PLAYER=0
CURRENTSIGN=$PLAYER0SIGN
fi
}

shotsNumber=0

function check_end(){
# rzedy
for i in $(seq 0 2)
do
startIndex=$(($i * 3))

if [[ ${PLANSZA[$startIndex]} != "0" &&  ${PLANSZA[$startIndex]} == ${PLANSZA[$startIndex+1]} && ${PLANSZA[$startIndex]} == ${PLANSZA[$startIndex+2]} ]]
then
	KONIEC=1
	echo "Koniec gry - wygrywa gracz "
	echo "$PLAYER"
fi

#kolumny
startColumnIndex=$((i))
if [[ ${PLANSZA[$startColumnIndex]} != "0" && ${PLANSZA[$startColumnIndex]} == ${PLANSZA[$startColmnIndex+3]} && ${PLANSZA[$startColumnIndex]} == ${PLANSZA[$startColumnIndex+6]} ]]
then
	KONIEC=1
	echo "Koniec gry - wygrywa gracz"
	echo "$PLAYER"
fi
done

#przekatne
if [[ ${PLANSZA[0]} != "0" && ${PLANSZA[0]} == ${PLANSZA[4]} && ${PLANSZA[0]} == ${PLANSZA[8]} ]]
then
	KONIEC=1
	echo "Koniec gry - wygrywa gracz"
	echo "$PLAYER"
fi

if [[ ${PLANSZA[2]} != "0" &&  ${PLANSZA[2]} == ${PLANSZA[4]} && ${PLANSZA[2]} == ${PLANSZA[6]}  ]]
then
	KONIEC=1
	echo "Koniec gry - wygrywa gracz"
	echo "$PLAYER"
fi

if [ $shotsNumber -ge 9 ]
then
	KONIEC=1
	echo "Koniec gry - remis"
fi

}

function normalGame(){
PLAYER=0
wyswietl_plansze
while [ $KONIEC -ne 1 ]
do
	read_number
	check_end
	change_player
done
}

function gameWithComputer(){
PLAYER=0
wyswietl_plansze
while [ $KONIEC -ne 1 ]
	do
		if [ $PLAYER -eq 0 ]
		then
		read_number
		check_end
		change_player
		else
		random_shot
		check_end
		change_player
		fi
shotsNumber=`expr $shotsNumber + 1`
done
}

function game(){
	echo "Wybierz mode"
	echo "1 - gra turowa"
	echo "2 - gra z komputerem"
	read mode
	if [[ $mode == 1 ]]
	then
		normalGame
	else
		gameWithComputer
	fi
}

game
