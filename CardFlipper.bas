' 50 dashes: --------------------------------------------------

' Program Notes                                                                                                                                                                             Program Notes
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_1_ProgramNotes:

' Bugs:
' --------------------------------------------------
' "continue" button often either ends the game or ends the program on first run, but not always, and rarely does the same on a random run of the game

' Implement:
' --------------------------------------------------
' save/load game (to/from file)
' colored cards instead of numbered cards (-c option)?

' To Do:
' --------------------------------------------------
' statistics page (endGame()) - continue
' highscores - continue

' make all selections dependent on optionSelectionType var
' make colors of elements in the game dependent on colorPalette var
' configSettings() - continue
	' add:
		' "selection type"
		' "auto write stats" to file on exit of statistics

' Rules:
' --------------------------------------------------
	' 10x8 card grid
	' each card has 2 numbers (or colors, -c option) on (double click to flip a card)
	' you can swap 2 cards with same number (or color) showing (right click)
	' click and drag a set of 3 or more cards with the same number (or color) on to clear them. If in 'Endless' mode add new cards in their position and add the respective number of points
	' click on a card to highlight cards with the same number as the clicked on cards upward-facing number
	
	' definitions:
		' adjacent = 1 card slot away
		' L# = difficulty level #, where '#' is a number from 1 to 5

' Dificulty Levels:
' --------------------------------------------------
	' 1:
		' 6 possible values (or colors)
		' 60/80 cards flipped to win
	
	' 2:
		' 7 possible values (or colors)
		' 65/80 cards flipped to win
	
	' 3:
		' 8 possible values (or colors)
		' 70/80 cards flipped to win

	' 4:
		' 9 possible values (or colors)
		' 75/80 cards flipped to win

	' 5:
		' 10 possible values (or colors)
		' 80/80 cards flipped to win

' Command-Line Options (CLO = Command-Line Option)
' --------------------------------------------------
	' -c = color mode - makes cards colored instead of having numbers on

dim shared CLOs as string
CLOs=command
dim shared CLOcolor as byte = 0

if instr(CLOs, "-") > 0 then
	if mid(CLOs, instr(CLOs, "-"), 2) = "-c" then
		CLOcolor=1
		CLOs=right(CLOs, len(CLOs)-3)
	end if
end if

if CLOcolor=1 then
	print "Color Mode:  On"
else
	print "Color Mode:  Off"
end if

' Files                                                                                                                                                                                             Files
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
dim shared ff as integer
shell("./files/checkfiles.sh")

' Vars / Routines                                                                                                                                                                         Vars / Routines
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_2_Declerations:

#include "include/Variables.bi" ' Include Variables
#include "include/IndependentFunctions.bi" ' Include Independent Functions
#include "include/Functions.bi" ' Include Interdependent Functions
#include "include/Defaults.bi" ' Include Default Values for Variables

'sigint() = interupt signal (^C in a terminal), this checks if a key combination of Ctrl+C has been entered and if so end the program immediately with a "^C" just before the command prompt

' Initialisation                                                                                                                                                                           Initialisation
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

screenres graphwidth,graphheight,32,2
screenset 0,1

' Pre-Loop                                                                                                                                                                                       Pre-Loop
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_3_PreLoop:

mainMenu()

' Main Loop                                                                                                                                                                                    Main Loop
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_4_MainLoop:

' Background
line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF

' Top bar
topBar("inGame", "mouseControl")

createCardSetValues(difficultyLevel)
createCardSetGraphics()

timeval=0
winGame(1)=55+(difficultyLevel*5)

do
	sigint()
	
	timeval+=1
	if not timeLimit=0 and (timeval/100)>timeLimit then
		timeLimitReached()
		goto _3_PreLoop
	end if
	
	getmouse(mousex,mousey, ,mouseb)
	
	' Or middle click to Pause
	if mouseb=4 then
		while mouseb=4
			sigint()
			getmouse(mousex,mousey, ,mouseb)
			sleep 10,1
		wend
		
		pauseGame("inGame")
	end if
	
	' Pause button if statement
	if mousex>10 and mousex<70 and mousey>28 and mousey<48 and mouseb=1 then
		while mouseb=1
			sigint()
			getmouse(mousex,mousey, ,mouseb)
			sleep 10,1
		wend
		
		pauseGame("inGame")
		if returnToPreLoop=1 then
			goto _3_PreLoop
		end if
	end if
	
	' Background
	line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF
	
	' Top bar
	topBar("inGame", "mouseControl")
	
	' Win button interaction (enabled after you have won the game on the current dificulty)
	if winGame(3)=0 then
		' clicking on button
		if mousex>270 and mousex<330 and mousey>18 and mousey<38 then
			' roll over goes here <<<
			
			if mouseb=1 then
				while mouseb=1
					sigint()
					getmouse(mousex,mousey, ,mouseb)
				wend
				
				endGame("inGame")
				goto _3_PreLoop
			end if
		end if
	end if
	
	' Continue being selected after LMB is released (green box)
	' arrows pointing towards button maths
	if int(timeval/20)-(highlightTimer(1))=1 then
		highlightTimer(1)=int(timeval/20)
		
		highlightTimer(0)+=1
		if highlightTimer(0)=5 then highlightTimer(0)=1
	end if
	
	' draw the boxes
	if LMB=1 then
		for y = 0 to 7
			for x = 0 to 9
				' if either side of each card is the same number as the card clicked on then point out that card
				if optionSelectionType=0 then
					if cardValue1((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B
					if cardValue2((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B
				elseif optionSelectionType=1 then
					if highlightTimer(0)=1 then
						if cardValue1((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b1100110011001100
						if cardValue2((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b1100110011001100
					elseif highlightTimer(0)=2 then
						if cardValue1((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b0110011001100110
						if cardValue2((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b0110011001100110
					elseif highlightTimer(0)=3 then
						if cardValue1((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b0011001100110011
						if cardValue2((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b0011001100110011
					elseif highlightTimer(0)=4 then
						if cardValue1((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b1001100110011001
						if cardValue2((y*xs)+x)=highlightCardNumber then line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(3),B,&b1001100110011001
					end if
				end if
			next x
		next y
	end if
	
	' if a card is hovered over, or clicked in various ways (mouse control), do something
	for y = 0 to 7
		for x = 0 to 9
			sigint()
			
			if mousex>cardx(x)-15 and mousex<cardx(x)+15 and mousey>cardy(y)-25 and mousey<cardy(y)+25 then
				line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(2),BF ' red box around card
				
				do ' to be exited
					if mouseb=1 then
						' drag the mouse over 3 or more cards of the same number to clear them
						while mouseb=1
							sigint()
							getmouse(mousex,mousey, ,mouseb)
							
							if mousex<cardx(x)-15 or mousex>cardx(x)+15 or mousey<cardy(y)-25 or mousey>cardy(y)+25 then
								CADStartCard=(y*xs)+x
								clearCardSet()
								exit do
							end if
							
							sleep 10,1
						wend
						
						do ' to be exited
							' or flip the card over if double clicked
							for i as integer = 1 to 20 ' <<< change this to change double click speed
								sigint()
								getmouse(mousex,mousey, ,mouseb)
								
								if mouseb=1 then
									flipCard()
									exit do
								end if
								
								sleep 10,1
							next i
							
							' or highlight all cards with the same number if single clicked
							if LMB=0 then
								while mouseb=1
									sigint()
									getmouse(mousex,mousey, ,mouseb)
								wend
								
								if cardSide((y*xs)+x)=1 then
									highlightCardNumber=cardValue1((y*xs)+x)
								else
									highlightCardNumber=cardValue2((y*xs)+x)
								end if
								
								LMB=1
							else
								while mouseb=1
									sigint()
									getmouse(mousex,mousey, ,mouseb)
								wend
								
								LMB=0
							end if
							
							exit do
						loop
					end if
					
					exit do
				loop
				
				' swap 2 cards if each is right clicked on
				if mouseb=2 then
					if RMB=1 then
						' 2nd card clicked on
						RMB=0
						if x=RMBCardX and y=RMBCardY then
							mouseb=0
						else
							line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),rgba(220,0,220,255),BF ' purple box around card if right clicked
							SwapCard()
						end if
					else
						' 1st card clicked on
						mouseb=0
						
						RMB=1
						RMBCardX=x
						RMBCardY=y
						line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),rgba(220,0,220,255),BF ' purple box around card if right clicked
						sleep 200
					end if
				end if
				
			end if
		next x
	next y
	
	' Continue being selected after RMB is released (purple box)
	if RMB=1 then line (cardx(RMBCardX)-16,cardy(RMBCardY)-26)-(cardx(RMBCardX)+16,cardy(RMBCardY)+26),rgba(220,0,220,255),B
	
	' Add in cards and numbers on cards (or cards colors)
	if CLOcolor=0 then
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				sigint()
				
				' Cards backgrounds
				if not ARC((y*xs)+x)=1 then line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),colorPalette(0),BF
				
				' Numbers on cards
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
			next x
		next y
	'else
	' 
	end if
	
	' Have you won the game yet?
	winGame(2)=0
	for i as integer = 0 to 79
		if ARC(i)=1 then winGame(2)+=1
	next i
	
	if winGame(2)>(winGame(1)-1) then
		winGame(0)=1
		if winGame(3)=1 then
			winGameQuestion()
			if returnToPreLoop=1 then
				returnToPreLoop=0
				goto _3_PreLoop
			end if
		end if
	end if
	
	sleep 10,1
	screencopy
loop

_5_End:
