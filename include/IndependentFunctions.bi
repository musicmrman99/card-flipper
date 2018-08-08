' Functions for "CardFlipper.bas"
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sub endp
	end
end sub

sub scoreUpdate()
	' Old:
	' score = ([cards_flipped] * 3) - ([time_taken] / 10)
	'score=(winGame(2)*3)-(int(timeval/100)/10)
	
	' New:
	' if [time_limit]=0 then
	' 		score = ([cards_flipped] * 3) - ([time_taken] / 10)
	' else
	' 		score = ([cards_flipped] * 3) + ((3000 - ([time_limit] * 2)) - ([time_taken] / 10))
	' end if
	if timeLimit=0 then
		score = (winGame(2)*3) - ((timeval/100)/10)
	else
		score = (winGame(2)*3) + ((3000-(timeLimit*2)) - ((timeval/100)/10))
	end if
end sub

sub sigint() '                                                                                                                                                                           Signal Interupt
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' ^C Interupt
	if multikey(29) and multikey(46) and optionSigint=1 then
		screen 0
		shell("echo -n '^C'")
		endp()
	end if
end sub

sub createCardSetValues(difficultyLevel as integer) '                                                                                                                             Create Card Set Values
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	randomize
	
	for i as integer = 0 to 79
		ARC(i)=0
	next i
	
	for i as integer = 0 to 79
		if difficultyLevel=1 then
			cardValue1(i)=int(rnd*5)
		elseif difficultyLevel=2 then
			cardValue1(i)=int(rnd*6)
		elseif difficultyLevel=3 then
			cardValue1(i)=int(rnd*7)
		elseif difficultyLevel=4 then
			cardValue1(i)=int(rnd*8)
		elseif difficultyLevel=5 then
			cardValue1(i)=int(rnd*9)
		end if
		
		' for testing:
		'cardValue1(i)=5
	next i
	
	for i as integer = 0 to 79
		if difficultyLevel=1 then
			cardValue2(i)=int(rnd*6)
		elseif difficultyLevel=2 then
			cardValue2(i)=int(rnd*7)
		elseif difficultyLevel=3 then
			cardValue2(i)=int(rnd*8)
		elseif difficultyLevel=4 then
			cardValue2(i)=int(rnd*9)
		elseif difficultyLevel=5 then
			cardValue2(i)=int(rnd*10)
		end if
		
		' for testing:
		'cardValue2(i)=5
	next i
end sub

sub createCardSetGraphics() '                                                                                                                                                   Create Card Set Graphics
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	for a as integer = 1 to 15
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				line (cardx(x),cardy(y)-25)-step(a,50),colorPalette(0),BF
				line (cardx(x),cardy(y)-25)-step(-a,50),colorPalette(0),BF
			next x
		next y
		
		sleep 10,1
		screencopy
	next a
end sub

sub displayCrosses() '                                                                                                                                                                   Display Crosses
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' red box and black 'X' on card 1
	line (cardx(x)-10,cardy(y)-10)-(cardx(x)+10,cardy(y)+10),rgba(220,0,0,255),BF
	line (cardx(x)-7,cardy(y)-7)-(cardx(x)+7,cardy(y)+7),rgba(0,0,0,255)
	line (cardx(x)+7,cardy(y)-7)-(cardx(x)-7,cardy(y)+7),rgba(0,0,0,255)
	
	' top left - bottom right
	line (cardx(x)-7,cardy(y)-6)-(cardx(x)+6,cardy(y)+7),rgba(0,0,0,255)
	line (cardx(x)-6,cardy(y)-7)-(cardx(x)+7,cardy(y)+6),rgba(0,0,0,255)
	
	' top right - bottom left
	line (cardx(x)+6,cardy(y)-7)-(cardx(x)-7,cardy(y)+6),rgba(0,0,0,255)
	line (cardx(x)+7,cardy(y)-6)-(cardx(x)-6,cardy(y)+7),rgba(0,0,0,255)
	
	' red box and black 'X' on card 2
	line (cardx(RMBCardX)-10,cardy(RMBCardY)-10)-(cardx(RMBCardX)+10,cardy(RMBCardY)+10),rgba(220,0,0,255),BF
	line (cardx(RMBCardX)-7,cardy(RMBCardY)-7)-(cardx(RMBCardX)+7,cardy(RMBCardY)+7),rgba(0,0,0,255)
	line (cardx(RMBCardX)+7,cardy(RMBCardY)-7)-(cardx(RMBCardX)-7,cardy(RMBCardY)+7),rgba(0,0,0,255)
	
	' top left - bottom right
	line (cardx(RMBCardX)-7,cardy(RMBCardY)-6)-(cardx(RMBCardX)+6,cardy(RMBCardY)+7),rgba(0,0,0,255)
	line (cardx(RMBCardX)-6,cardy(RMBCardY)-7)-(cardx(RMBCardX)+7,cardy(RMBCardY)+6),rgba(0,0,0,255)
	
	' top right - bottom left
	line (cardx(RMBCardX)+6,cardy(RMBCardY)-7)-(cardx(RMBCardX)-7,cardy(RMBCardY)+6),rgba(0,0,0,255)
	line (cardx(RMBCardX)+7,cardy(RMBCardY)-6)-(cardx(RMBCardX)-6,cardy(RMBCardY)+7),rgba(0,0,0,255)
	
	screencopy
	sleep 800,1
	
	return
end sub

sub testCardNumbers() '                                                                                                                                                                Test Card Numbers
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' continue flipping the 2 cards or not depending on if the 2 card's numbers (or colors) are the same
	if cardSide((y*xs)+x)=1 then
		if cardSide((RMBCardY*xs)+RMBCardX)=1 then
			if cardValue1((y*xs)+x)=cardValue1((RMBCardY*xs)+RMBCardX) then
				return
			else
				displayCrosses()
				returnFromSwap=1
				return
			end if
		else
			if cardValue1((y*xs)+x)=cardValue2((RMBCardY*xs)+RMBCardX) then
				return
			else
				displayCrosses()
				returnFromSwap=1
				return
			end if
		end if
	else
		if cardSide((RMBCardY*xs)+RMBCardX)=1 then
			if cardValue2((y*xs)+x)=cardValue1((RMBCardY*xs)+RMBCardX) then
				return
			else
				displayCrosses()
				returnFromSwap=1
				return
			end if
		else
			if cardValue2((y*xs)+x)=cardValue2((RMBCardY*xs)+RMBCardX) then
				return
			else
				displayCrosses()
				returnFromSwap=1
				return
			end if
		end if
	end if
end sub

sub writeHighscoreTable() '                                                                                                                                                        Write Highscore Table
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ff = freefile()
	
	if open("files/highscores", for append, as ff) <> 0 then
		screen 0
		print "ERROR: the file 'highscores' could not be opened"
		end -1
	end if
	
	if lof(ff)=0 then
		print #ff,"Card Flipper - Highscores"
		print #ff,""
	end if

	tad(0)=left(date,2)
	tad(1)=mid(date,4,2)
	tad(2)=right(date,4)
	'print #ff,"entry:";str();" @ ";time;" -- ";tad(1);"-";tad(0);"-";tad(2)
	print #ff,"entry:";" @ ";time;" -- ";tad(1);"-";tad(0);"-";tad(2)
	print #ff,"--------------------------------------------------"
	print #ff,"Difficulty Level:  ";str(difficultyLevel)
	print #ff,"------------------------------"
	print #ff,"Cards Flipped:     ";str(winGame(2))
	print #ff,"Time Taken:        ";str(int(timeval/100));"s"
	' time limit -----\
	if timeLimit=0 then
	print #ff,"Time Limit:        ";"inf."
	else
	print #ff,"Time Limit:        ";str(timeLimit)
	end if
	' time limit -----/
	print #ff,"------------------------------"
	print #ff,"Total Score: ";str(score)
	print #ff,""
	
	close
end sub
