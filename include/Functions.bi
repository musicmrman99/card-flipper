' Functions for "CardFlipper.bas"
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
sub endProgram() '                                                                                                                                                                           End Program
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' closing game window vertical graphics
	for i as integer = 1 to (graphheight/2)+40
		sigint()
		
		' grey
		if i<(graphheight/2)+1 then
			line (0,0)-(graphwidth,i),rgba(160,170,180,255),BF
			line (0,graphheight)-(graphwidth,graphheight-i),rgba(160,170,180,255),BF
		else
			sleep 1
		end if
		
		' black
		line (0,-40)-(graphwidth,i-40),rgba(0,0,0,255),BF
		line (0,graphheight+40)-(graphwidth,(graphheight-i)+40),rgba(0,0,0,255),BF
	
		sleep 2
		screencopy
	next i
	
	sleep 250,1
	endp()
end sub

sub selectExact(variable as string) '                                                                                                                                                       Select Exact
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' Darken screen
	imgtmp=imagecreate(graphwidth,graphheight)
	line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,255,0),BF
	
	for i as integer = 1 to 30
		sigint()
		
		line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,0,2),BF
		put (0,0),imgtmp,alpha
		
		sleep 10,1
		screencopy
	next i
	
	' Background
	line ((graphwidth/2)-100,(graphheight/2)-50)-((graphwidth/2)+100,(graphheight/2)+50),rgba(0,0,0,255),BF
	line ((graphwidth/2)-95,(graphheight/2)-45)-((graphwidth/2)+95,(graphheight/2)+45),rgba(50,50,50,255),BF
	
	' Text / Text box
	if variable="timeLimit" then
		draw string ((graphwidth/2)-(len("Time Limit")/2)*8,(graphheight/2)-15),"Time Limit",rgba(220,220,220,255)
	end if
	
	line ((graphwidth/2)-80,(graphheight/2)+0)-((graphwidth/2)+80,(graphheight/2)+20),rgba(255,255,255,255),BF ' white text box
	
	screencopy
	
	' reset vars
	cpos=142
	rstring=""
	for i as integer = 0 to ubound(cstring)-1
		cstring(i)=""
	next i
	
	do
		sigint()
		
		getmouse(mousex,mousey, ,mouseb)
		
		' Text box / Curser
		line ((graphwidth/2)-80,(graphheight/2)+0)-((graphwidth/2)+80,(graphheight/2)+20),rgba(255,255,255,255),BF ' white text box
		line (cpos,(graphheight/2)+2)-(cpos,(graphheight/2)+18),rgba(0,0,0,255) ' Cursers
		
		' print text
		for i as integer = 0 to ubound(cstring)-1
			draw string ((graphwidth/2)-78+(i*8),(graphheight/2)+5),str(cstring(i)),rgba(0,0,0,255)
		next i
		
		' qwertyuiop = (16-25); asdfghjkl = (30-38); zxcvbnm = (44-50)
		for i as integer = 0 to 89
			' Enter
			if multikey(28) then exit do
			
			' Backspace
			if multikey(14) and ((cpos-142)/8)>lbound(cstring) then 'and not cpos<150 then
				cpos-=8
				cstring(((cpos-142)/8))=""
				
				do
					tmp=0
					
					for i as integer = 0 to 89
						if multikey(14) then tmp+=1
					next i
					
					if tmp=0 then exit do
					
					sleep 10,1
				loop
				
				exit for
			end if
			
			' Other keys
			if multikey(i) and ((cpos-142)/8)<ubound(cstring) and not multikey(14) then
				if not multikeyValueSet(i)="" then
					cstring((cpos-142)/8)=multikeyValueSet(i)
					cpos+=8
				end if
				
				do
					tmp=0
					
					for i as integer = 0 to 89
						if multikey(i) then tmp+=1
					next i
					
					if tmp=0 then exit do
					
					sleep 10,1
				loop
			end if
		next i
		
		screencopy
		
		sleep 10,1
	loop
	
	' combine all letters in cstring and place them in rstring
	for i as integer = 0 to ubound(cstring)-1
		rstring=rstring+cstring(i)
	next i
end sub

sub windowDoorsHoriz(openAt as string) '                                                                                                                                         Window Doors Horizontal
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' horizontal closing doors graphics
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	for i as integer = 1 to (graphwidth/2)+40+1
		sigint()
		
		' grey
		if i<(graphwidth/2)+1 then
			line (0,0)-(i,graphheight),rgba(160,170,180,255),BF
			line (graphwidth,0)-(graphwidth-i,graphheight),rgba(160,170,180,255),BF
		else
			sleep 1
		end if
		
		' black
		line (-40,0)-(i-40,graphheight),rgba(0,0,0,255),BF
		line (graphwidth+40,0)-((graphwidth-i)+40,graphheight),rgba(0,0,0,255),BF
	
		sleep 1
		screencopy
	next i
	
	sleep 250
	
	' opening horizontal doors graphics
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	for i as integer = (graphwidth/2)+40+1 to 0 step -1
		sigint()
		
		if openAt="mainMenu" then
			' Main Menu Graphics
			' Background
			line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF
			
			' Top Bar (including title)
			line (0,0)-(graphwidth,50),rgba(0,0,0,255),BF
			draw string ((graphwidth/2)-((len("Main Menu")/2)*8),20),"Main Menu",rgba(255,255,255,255) ' main menu text
			
			' Top button
			line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
			draw string ((graphwidth/2)-((len("Start Game")/2)*8),(graphheight/2)-3),"Start Game",rgba(255,255,255,255) ' top button text
			
			' Middle button
			line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
			draw string ((graphwidth/2)-((len("Configure Settings")/2)*8),(graphheight/2)+27),"Configure Settings",rgba(255,255,255,255) ' middle button text
			
			' Bottom button
			line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
			draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' bottom button text
		elseif openAt="configSettings" then
			currentCategory="gameOptions"
			
			' Window Boarder
			line (0,0)-(graphwidth,graphheight),rgba(0,0,0,255),BF
			
			' Background
			line (10,10)-(graphwidth-10,graphheight-10),rgba(180,190,200,255),BF
			
			' Return button graphics
			line (190,18)-(400,38),rgba(220,0,0,255),BF
			draw string (295-((len("Return")/2)*8),18+7),"Return",rgba(0,0,0,255)
			
			' Seperators
			' ----------------------------------------------------------------------------------------------------
			line (160,0)-(165,graphheight),rgba(0,0,0,255),BF ' Vertical Seperator
			line (160,45)-(graphwidth,50),rgba(0,0,0,255),BF ' Horizontal Seperator
			
			' Categories
			' ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
			' Game Options
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=15        ' x1
			xyindent(1)=15+(0*45) ' y1
			xyindent(2)=155       ' x2
			xyindent(3)=55+(0*45) ' y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' Game Options button graphics
			line (xyindent(0)+10,xyindent(1)+12)-(xyindent(2)-10,xyindent(3)-12),rgba(220,0,0,255),BF
			draw string (xyindent(0)+((xyindent(2)-xyindent(0))/2)-((len("Game Options")/2)*8),xyindent(1)+((xyindent(3)-xyindent(1))/2)-3),"Game Options",rgba(0,0,0,255)
			
			' Preferences
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=15        ' x1
			xyindent(1)=15+(1*45) ' y1
			xyindent(2)=155       ' x2
			xyindent(3)=55+(1*45) ' y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' Preferences button graphics
			line (xyindent(0)+10,xyindent(1)+12)-(xyindent(2)-10,xyindent(3)-12),rgba(220,0,0,255),BF
			draw string (xyindent(0)+((xyindent(2)-xyindent(0))/2)-((len("Preferences")/2)*8),xyindent(1)+((xyindent(3)-xyindent(1))/2)-3),"Preferences",rgba(0,0,0,255)
			
			if mousex>xyindent(0)+10 and mousex<xyindent(2)-10 and mousey>xyindent(1)+12 and mousey<xyindent(3)-12 and mouseb=1 then
				currentCategory="preferences"
			end if
			
			' Colors
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=15        ' x1
			xyindent(1)=15+(2*45) ' y1
			xyindent(2)=155       ' x2
			xyindent(3)=55+(2*45) ' y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' Colors button graphics
			line (xyindent(0)+10,xyindent(1)+12)-(xyindent(2)-10,xyindent(3)-12),rgba(220,0,0,255),BF
			draw string (xyindent(0)+((xyindent(2)-xyindent(0))/2)-((len("Colors")/2)*8),xyindent(1)+((xyindent(3)-xyindent(1))/2)-3),"Colors",rgba(0,0,0,255)
			
			if mousex>xyindent(0)+10 and mousex<xyindent(2)-10 and mousey>xyindent(1)+12 and mousey<xyindent(3)-12 and mouseb=1 then
				currentCategory="colors"
			end if
			
			' Game Options
			' ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			if currentCategory="gameOptions" then
				' Difficulty
				' ----------------------------------------------------------------------------------------------------
				xyindent(0)=175       ' x1
				xyindent(1)=15+(1*45) ' y1
				xyindent(2)=415       ' x2
				xyindent(3)=55+(1*45) ' y2
				
				' indentation
				line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
				line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
				line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
				line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
				line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
				
				' indicator
				draw string (xyindent(0)+10,xyindent(1)+7),"Difficulty: "+str(difficultyLevel),rgba(255,255,255,255)
				
				' buttons to change difficulty
				line (xyindent(0)+23,xyindent(1)+17)-(xyindent(0)+38,xyindent(3)-8),rgba(220,0,0,255),BF
				line (xyindent(0)+43,xyindent(1)+17)-(xyindent(0)+58,xyindent(3)-8),rgba(220,0,0,255),BF
				line (xyindent(0)+63,xyindent(1)+17)-(xyindent(0)+78,xyindent(3)-8),rgba(220,0,0,255),BF
				line (xyindent(0)+83,xyindent(1)+17)-(xyindent(0)+98,xyindent(3)-8),rgba(220,0,0,255),BF
				line (xyindent(0)+103,xyindent(1)+17)-(xyindent(0)+118,xyindent(3)-8),rgba(220,0,0,255),BF
				
				draw string (xyindent(0)+28,xyindent(1)+22),"1",rgba(0,0,0,255)
				draw string (xyindent(0)+48,xyindent(1)+22),"2",rgba(0,0,0,255)
				draw string (xyindent(0)+68,xyindent(1)+22),"3",rgba(0,0,0,255)
				draw string (xyindent(0)+88,xyindent(1)+22),"4",rgba(0,0,0,255)
				draw string (xyindent(0)+108,xyindent(1)+22),"5",rgba(0,0,0,255)
				
				' Time Limit
				' ----------------------------------------------------------------------------------------------------
				xyindent(0)=175       ' x1
				xyindent(1)=15+(2*45) ' (60) y1
				xyindent(2)=415       ' x2
				xyindent(3)=55+(2*45) ' (100) y2
				
				' indentation
				line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
				line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
				line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
				line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
				line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
				
				' indicator
				draw string (xyindent(0)+10,xyindent(1)+7),"Time Limit: "+str(timeLimit),rgba(255,255,255,255)
				
				' buttons to change time limit
				line (xyindent(0)+10,xyindent(1)+17)-(xyindent(0)+55,xyindent(3)-8),rgba(220,0,0,255),BF ' left
				line (xyindent(0)+60,xyindent(1)+17)-(xyindent(2)-60,xyindent(3)-8),rgba(220,0,0,255),BF ' centre
				line (xyindent(2)-55,xyindent(1)+17)-(xyindent(2)-10,xyindent(3)-8),rgba(220,0,0,255),BF ' right
				
				' left and right arrows
				draw string (xyindent(0)+30,xyindent(1)+21),"<",rgba(0,0,0,255)
				draw string (xyindent(2)-35,xyindent(1)+21),">",rgba(0,0,0,255)
				
				' symbolistic text box for centre button
				line (xyindent(0)+62,xyindent(3)-13)-(xyindent(2)-62,xyindent(3)-18),rgba(255,255,255,255),BF ' box
				line (xyindent(0)+64,xyindent(3)-14)-(xyindent(0)+64,xyindent(3)-17),rgba(0,0,0,255) ' curser (79,83)-(79,86)
			end if
		elseif openAt="statisticsPage" then
			' Background
			line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF
			
			' Title
			line (0,0)-(graphwidth,50),rgba(0,0,0,255),BF
			draw string ((graphwidth/2)-((len("Game Statistics")/2)*8),20),"Game Statistics",rgba(255,255,255,255) ' main menu text
			
			' indentation
			' old: line (15,60)-(155,100),rgba(160,170,180,255),BF ' background
			line (15,65)-(425,565),rgba(160,170,180,255),BF ' background
			line (15,65)-(425,67),rgba(150,160,170,255),BF ' top
			line (15,65)-(17,565),rgba(150,160,170,255),BF ' left
			line (15,563)-(425,565),rgba(130,140,150,255),BF ' bottom
			line (423,65)-(425,565),rgba(130,140,150,255),BF ' right
			
			' main menu button
			line (310,530)-(410,550),rgba(255,0,0,255),BF
			draw string (360-((len("Main Menu")/2)*8),530+7),"Main Menu",rgba(0,0,0,255)
			
			' save game statistics to 'highscores' file button
			if gameStatSaved=0 then
				line (210,530)-(300,550),rgba(255,0,0,255),BF
				draw string ((255-(len("Save Stats")/2)*8),530+7),"Save Stats",rgba(0,0,0,255)
			else
				line (210,530)-(300,550),rgba(192,0,0,255),BF
				draw string ((255-(len("Save Stats")/2)*8),530+7),"Save Stats",rgba(0,0,0,255)
				draw string (220,553),"saved",rgba(0,0,0,255)
			end if
			
			' Game Statistics
			' ----------------------------------------------------------------------------------------------------
			draw string (30,80+(0*12)),"Difficulty Level:   "+str(difficultyLevel),rgba(0,0,0,255) ' difficulty level
			draw string (30,80+(1*12)),"------------------------------",rgba(0,0,0,255) ' seperator
			draw string (30,80+(2*12)),"Cards Flipped:      "+str(winGame(2)),rgba(0,0,0,255) ' cards flipped
			draw string (30,80+(3*12)),"Time Taken:         "+str(int(timeval/100)),rgba(0,0,0,255) ' time taken
			' time limit -----\
			if timeLimit=0 then
			draw string (30,80+(4*12)),"Time Limit:         "+"inf.",rgba(0,0,0,255)
			else
			draw string (30,80+(4*12)),"Time Limit:         "+str(timeLimit),rgba(0,0,0,255)
			end if
			' time limit -----/
			draw string (30,80+(5*12)),"------------------------------",rgba(0,0,0,255) ' seperator
			draw string (30,80+(6*12)),"Total Score:        "+str(score),rgba(0,0,0,255) ' total score
		else
			screen 0
			print "ERROR: the variable 'openAt' holds the illegal value '";openAt;"'."
			end
		end if
		
		' Opening window
		' grey
		line (0,0)-(i,graphheight),rgba(160,170,180,255),BF
		line (graphwidth,0)-(graphwidth-i,graphheight),rgba(160,170,180,255),BF
			
		' black
		line (-40,0)-(i-40,graphheight),rgba(0,0,0,255),BF
		line (graphwidth+40,0)-((graphwidth-i)+40,graphheight),rgba(0,0,0,255),BF
	
		sleep 1
		screencopy
	next i
	
end sub

sub configSettings() '                                                                                                                                                              Config Game Settings
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	windowDoorsHoriz("configSettings")
	
	do
		sigint()
		
		getmouse(mousex,mousey, ,mouseb)
		
		' Return button if statement
		if mousex>190 and mousex<400 and mousey>18 and mousey<38 and mouseb=1 then
			while mouseb=1
				getmouse(mousex,mousey, ,mouseb)
			wend
			
			windowDoorsHoriz("mainMenu")
			return
		end if
		
		' Window Boarder
		line (0,0)-(graphwidth,graphheight),rgba(0,0,0,255),BF
		
		' Background
		line (10,10)-(graphwidth-10,graphheight-10),rgba(180,190,200,255),BF
		
		' Return button graphics
		line (190,18)-(400,38),rgba(220,0,0,255),BF
		draw string (295-((len("Return")/2)*8),18+7),"Return",rgba(0,0,0,255)
		
		' Seperators
		' ----------------------------------------------------------------------------------------------------
		line (160,0)-(165,graphheight),rgba(0,0,0,255),BF ' Vertical Seperator
		line (160,45)-(graphwidth,50),rgba(0,0,0,255),BF ' Horizontal Seperator
		
		' Categories
		' ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		' Game Options
		' ----------------------------------------------------------------------------------------------------
		xyindent(0)=15        ' x1
		xyindent(1)=15+(0*45) ' y1
		xyindent(2)=155       ' x2
		xyindent(3)=55+(0*45) ' y2
		
		' indentation
		line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
		line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
		line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
		line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
		line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
		
		' Game Options button graphics
		line (xyindent(0)+10,xyindent(1)+12)-(xyindent(2)-10,xyindent(3)-12),rgba(220,0,0,255),BF
		draw string (xyindent(0)+((xyindent(2)-xyindent(0))/2)-((len("Game Options")/2)*8),xyindent(1)+((xyindent(3)-xyindent(1))/2)-3),"Game Options",rgba(0,0,0,255)
		
		if mousex>xyindent(0)+10 and mousex<xyindent(2)-10 and mousey>xyindent(1)+12 and mousey<xyindent(3)-12 and mouseb=1 then
			currentCategory="gameOptions"
		end if
		
		' Preferences
		' ----------------------------------------------------------------------------------------------------
		xyindent(0)=15        ' x1
		xyindent(1)=15+(1*45) ' y1
		xyindent(2)=155       ' x2
		xyindent(3)=55+(1*45) ' y2
		
		' indentation
		line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
		line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
		line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
		line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
		line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
		
		' Preferences button graphics
		line (xyindent(0)+10,xyindent(1)+12)-(xyindent(2)-10,xyindent(3)-12),rgba(220,0,0,255),BF
		draw string (xyindent(0)+((xyindent(2)-xyindent(0))/2)-((len("Preferences")/2)*8),xyindent(1)+((xyindent(3)-xyindent(1))/2)-3),"Preferences",rgba(0,0,0,255)
		
		if mousex>xyindent(0)+10 and mousex<xyindent(2)-10 and mousey>xyindent(1)+12 and mousey<xyindent(3)-12 and mouseb=1 then
			currentCategory="preferences"
		end if
		
		' Colors
		' ----------------------------------------------------------------------------------------------------
		xyindent(0)=15        ' x1
		xyindent(1)=15+(2*45) ' y1
		xyindent(2)=155       ' x2
		xyindent(3)=55+(2*45) ' y2
		
		' indentation
		line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
		line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
		line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
		line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
		line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
		
		' Colors button graphics
		line (xyindent(0)+10,xyindent(1)+12)-(xyindent(2)-10,xyindent(3)-12),rgba(220,0,0,255),BF
		draw string (xyindent(0)+((xyindent(2)-xyindent(0))/2)-((len("Colors")/2)*8),xyindent(1)+((xyindent(3)-xyindent(1))/2)-3),"Colors",rgba(0,0,0,255)
		
		if mousex>xyindent(0)+10 and mousex<xyindent(2)-10 and mousey>xyindent(1)+12 and mousey<xyindent(3)-12 and mouseb=1 then
			currentCategory="colors"
		end if
		
		' Game Options
		' ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if currentCategory="gameOptions" then
			' Difficulty
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=175       ' x1
			xyindent(1)=15+(1*45) ' y1
			xyindent(2)=415       ' x2
			xyindent(3)=55+(1*45) ' y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' indicator
			draw string (xyindent(0)+10,xyindent(1)+7),"Difficulty: "+str(difficultyLevel),rgba(255,255,255,255)
			
			' buttons to change difficulty
			line (xyindent(0)+23,xyindent(1)+17)-(xyindent(0)+38,xyindent(3)-8),rgba(220,0,0,255),BF
			line (xyindent(0)+43,xyindent(1)+17)-(xyindent(0)+58,xyindent(3)-8),rgba(220,0,0,255),BF
			line (xyindent(0)+63,xyindent(1)+17)-(xyindent(0)+78,xyindent(3)-8),rgba(220,0,0,255),BF
			line (xyindent(0)+83,xyindent(1)+17)-(xyindent(0)+98,xyindent(3)-8),rgba(220,0,0,255),BF
			line (xyindent(0)+103,xyindent(1)+17)-(xyindent(0)+118,xyindent(3)-8),rgba(220,0,0,255),BF
			
			draw string (xyindent(0)+28,xyindent(1)+22),"1",rgba(0,0,0,255)
			draw string (xyindent(0)+48,xyindent(1)+22),"2",rgba(0,0,0,255)
			draw string (xyindent(0)+68,xyindent(1)+22),"3",rgba(0,0,0,255)
			draw string (xyindent(0)+88,xyindent(1)+22),"4",rgba(0,0,0,255)
			draw string (xyindent(0)+108,xyindent(1)+22),"5",rgba(0,0,0,255)
			
			' if buttons clicked
			if mousex>xyindent(0)+23 and mousex<xyindent(0)+38 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then difficultyLevel=1
			if mousex>xyindent(0)+43 and mousex<xyindent(0)+58 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then difficultyLevel=2
			if mousex>xyindent(0)+63 and mousex<xyindent(0)+78 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then difficultyLevel=3
			if mousex>xyindent(0)+83 and mousex<xyindent(0)+98 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then difficultyLevel=4
			if mousex>xyindent(0)+103 and mousex<xyindent(0)+118 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then difficultyLevel=5
			
			' Time Limit
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=175       ' x1
			xyindent(1)=15+(2*45) ' (60) y1
			xyindent(2)=415       ' x2
			xyindent(3)=55+(2*45) ' (100) y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' indicator
			draw string (xyindent(0)+10,xyindent(1)+7),"Time Limit: "+str(timeLimit),rgba(255,255,255,255)
			
			' buttons to change time limit
			line (xyindent(0)+10,xyindent(1)+17)-(xyindent(0)+55,xyindent(3)-8),rgba(220,0,0,255),BF ' left
			line (xyindent(0)+60,xyindent(1)+17)-(xyindent(2)-60,xyindent(3)-8),rgba(220,0,0,255),BF ' centre
			line (xyindent(2)-55,xyindent(1)+17)-(xyindent(2)-10,xyindent(3)-8),rgba(220,0,0,255),BF ' right
			
			' left and right arrows
			draw string (xyindent(0)+30,xyindent(1)+21),"<",rgba(0,0,0,255)
			draw string (xyindent(2)-35,xyindent(1)+21),">",rgba(0,0,0,255)
			
			' symbolistic text box for centre button
			line (xyindent(0)+62,xyindent(3)-13)-(xyindent(2)-62,xyindent(3)-18),rgba(255,255,255,255),BF ' box
			line (xyindent(0)+64,xyindent(3)-14)-(xyindent(0)+64,xyindent(3)-17),rgba(0,0,0,255) ' curser (79,83)-(79,86)
			
			' if buttons clicked
			if mousex>xyindent(0)+10 and mousex<xyindent(0)+55 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb>0 and mouseb<3 then
				if mouseb=1 then
					timeLimit-=100
				elseif mouseb=2 then
					timeLimit-=10
				end if
				
				sleep 50
				if timeLimit<0 then timeLimit=0
			end if
			
			' select exact ammount
			if mousex>xyindent(0)+60 and mousex<xyindent(2)-60 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb>0 then
				selectExact("timeLimit")
				timeLimit=valint(rstring)
				if timeLimit<0 then timeLimit=0
				if timeLimit>5000 then timeLimit=5000
			end if
			
			' increase
			if mousex>xyindent(2)-55 and mousex<xyindent(2)-10 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb>0 and mouseb<3 then
				if mouseb=1 then
					timeLimit+=100
				elseif mouseb=2 then
					timeLimit+=10
				end if
				
				sleep 50
				if timeLimit>5000 then timeLimit=5000
			end if
		end if
		
		' Preferences
		' ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if currentCategory="preferences" then
			' Selection type
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=175       ' x1
			xyindent(1)=15+(1*45) ' (105) y1
			xyindent(2)=415       ' x2
			xyindent(3)=55+(1*45) ' (145) y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' indicator
			if optionSelectionType=0 then
				draw string (xyindent(0)+10,xyindent(1)+7),"Selection Type: "+"Solid",rgba(255,255,255,255)
			elseif optionSelectionType=1 then
				draw string (xyindent(0)+10,xyindent(1)+7),"Selection Type: "+"Dashed",rgba(255,255,255,255)
			end if
			
			' buttons to change time limit
			line (xyindent(0)+10,xyindent(1)+17)-(xyindent(0)+65,xyindent(3)-8),rgba(220,0,0,255),BF ' left
			line (xyindent(2)-65,xyindent(1)+17)-(xyindent(2)-10,xyindent(3)-8),rgba(220,0,0,255),BF ' right
			
			' choices
			draw string (xyindent(0)+37-((len("Solid")/2)*8),xyindent(1)+21),"Solid",rgba(0,0,0,255)
			draw string (xyindent(2)-37-((len("Dashed")/2)*8),xyindent(1)+21),"Dashed",rgba(0,0,0,255)
			
			' if buttons clicked
			if mousex>xyindent(0)+10 and mousex<xyindent(0)+65 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then
				optionSelectionType=0
			end if
			
			if mousex>xyindent(2)-65 and mousex<xyindent(2)-10 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then
				optionSelectionType=1
			end if
			
			' Auto write stats (to file)
			' ----------------------------------------------------------------------------------------------------
			xyindent(0)=175       ' x1
			xyindent(1)=15+(2*45) ' (150) y1
			xyindent(2)=415       ' x2
			xyindent(3)=55+(2*45) ' (195) y2
			
			' indentation
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(3)),rgba(160,170,180,255),BF ' background
			line (xyindent(0),xyindent(1))-(xyindent(2),xyindent(1)+2),rgba(150,160,170,255),BF ' top
			line (xyindent(0),xyindent(1))-(xyindent(0)+2,xyindent(3)),rgba(150,160,170,255),BF ' left
			line (xyindent(0),xyindent(3)-2)-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' bottom
			line (xyindent(2)-2,xyindent(1))-(xyindent(2),xyindent(3)),rgba(130,140,150,255),BF ' right
			
			' indicator
			if optionAutoWriteStatsToFile=0 then
				draw string (xyindent(0)+10,xyindent(1)+7),"Auto write stats: "+"Off",rgba(255,255,255,255)
			else
				draw string (xyindent(0)+10,xyindent(1)+7),"Auto write stats: "+"On",rgba(255,255,255,255)
			end if
			
			' buttons to change time limit
			line (xyindent(0)+10,xyindent(1)+17)-(xyindent(0)+65,xyindent(3)-8),rgba(220,0,0,255),BF ' left
			line (xyindent(2)-65,xyindent(1)+17)-(xyindent(2)-10,xyindent(3)-8),rgba(220,0,0,255),BF ' right
			
			' choices
			draw string (xyindent(0)+37-((len("Off")/2)*8),xyindent(1)+21),"Off",rgba(0,0,0,255)
			draw string (xyindent(2)-37-((len("On")/2)*8),xyindent(1)+21),"On",rgba(0,0,0,255)
			
			' if buttons clicked
			if mousex>xyindent(0)+10 and mousex<xyindent(0)+65 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then
				optionAutoWriteStatsToFile=0
			end if
			
			if mousex>xyindent(2)-65 and mousex<xyindent(2)-10 and mousey>xyindent(1)+17 and mousey<xyindent(3)-8 and mouseb=1 then
				optionAutoWriteStatsToFile=1
			end if
		end if
		
		' Colors
		' ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		if currentCategory="colors" then
			
		end if
		
		sleep 10,1
		screencopy
	loop
end sub

sub mainMenu() '                                                                                                                                                                               Main Menu
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	do
		sigint()
		
		' Background
		line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF
		
		' Title
		line (0,0)-(graphwidth,50),rgba(0,0,0,255),BF
		draw string ((graphwidth/2)-((len("Main Menu")/2)*8),20),"Main Menu",rgba(255,255,255,255) ' main menu text
		
		' when mouse hovering over a button, 'indent' that button a little
		' top button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-10 and mousey<(graphheight/2)+10 then ' if top button hovered over
			line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
			line ((graphwidth/2)-98,(graphheight/2)-8)-((graphwidth/2)+98,(graphheight/2)+8),rgba(220,0,0,255),BF ' top button a little darker and indented
			draw string ((graphwidth/2)-((len("Start Game")/2)*8),(graphheight/2)-3),"Start Game",rgba(255,255,255,255) ' top button text
		else
			line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
			draw string ((graphwidth/2)-((len("Start Game")/2)*8),(graphheight/2)-3),"Start Game",rgba(255,255,255,255) ' top button text
		end if
		
		' middle button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+20 and mousey<(graphheight/2)+40 then ' if middle button hovered over
			line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
			line ((graphwidth/2)-98,(graphheight/2)+22)-((graphwidth/2)+98,(graphheight/2)+38),rgba(220,0,0,255),BF ' middle button a little darker and indented
			draw string ((graphwidth/2)-((len("Configure Settings")/2)*8),(graphheight/2)+27),"Configure Settings",rgba(255,255,255,255) ' middle button text
		else
			line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
			draw string ((graphwidth/2)-((len("Configure Settings")/2)*8),(graphheight/2)+27),"Configure Settings",rgba(255,255,255,255) ' middle button text
		end if
		
		' bottom button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+50 and mousey<(graphheight/2)+70 then ' if bottom button hovered over
			line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
			line ((graphwidth/2)-98,(graphheight/2)+52)-((graphwidth/2)+98,(graphheight/2)+68),rgba(220,0,0,255),BF ' bottom button a little darker and indented
			draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' bottom button text
		else
			line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
			draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' bottom button text
		end if
		
		getmouse(mousex,mousey, ,mouseb)
		
		if mouseb=1 then
			while mouseb=1
				sigint()
				
				' when mouse hovering over a button, 'indent' that button a lot
				' top button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-10 and mousey<(graphheight/2)+10 then ' if top button hovered over
					line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
					line ((graphwidth/2)-98,(graphheight/2)-8)-((graphwidth/2)+98,(graphheight/2)+8),rgba(220,0,0,255),BF ' top button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)-7)-((graphwidth/2)+97,(graphheight/2)+7),rgba(192,0,0,255),BF ' top button a lot darker and indented
					draw string ((graphwidth/2)-((len("Start Game")/2)*8),(graphheight/2)-3),"Start Game",rgba(255,255,255,255) ' top button text
				else
					line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
					draw string ((graphwidth/2)-((len("Start Game")/2)*8),(graphheight/2)-3),"Start Game",rgba(255,255,255,255) ' top button text
				end if
				
				' middle button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+20 and mousey<(graphheight/2)+40 then ' if middle button hovered over
					line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
					line ((graphwidth/2)-98,(graphheight/2)+22)-((graphwidth/2)+98,(graphheight/2)+38),rgba(220,0,0,255),BF ' middle button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)+23)-((graphwidth/2)+97,(graphheight/2)+37),rgba(192,0,0,255),BF ' middle button a lot darker and indented
					draw string ((graphwidth/2)-((len("Configure Settings")/2)*8),(graphheight/2)+27),"Configure Settings",rgba(255,255,255,255) ' middle button text
				else
					line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
					draw string ((graphwidth/2)-((len("Configure Settings")/2)*8),(graphheight/2)+27),"Configure Settings",rgba(255,255,255,255) ' middle button text
				end if
				
				' bottom button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+50 and mousey<(graphheight/2)+70 then ' if bottom button hovered over
					line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
					line ((graphwidth/2)-98,(graphheight/2)+52)-((graphwidth/2)+98,(graphheight/2)+68),rgba(220,0,0,255),BF ' bottom button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)+53)-((graphwidth/2)+97,(graphheight/2)+67),rgba(192,0,0,255),BF ' bottom button a lot darker and indented
					draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' bottom button text
				else
					line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
					draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' bottom button text
				end if
				
				screencopy
				
				getmouse(mousex,mousey, ,mouseb)
			wend
			
			' Start the game
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-10 and mousey<(graphheight/2)+10 then ' if top button released on
				exit do
			end if
			
			' open game configuration screen
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+20 and mousey<(graphheight/2)+40 then ' if middle button released on
				configSettings()
			end if
			
			' End Program
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+50 and mousey<(graphheight/2)+70 then ' if bottom button released on
				endProgram()
			end if
		end if
		
		sleep 10,1
		screencopy
	loop
end sub

sub endGame(calledFrom as string) '                                                                                                                                                             End Game
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if calledFrom="inGame" or calledFrom="pauseGame" or calledFrom="winGameQuestion" or calledFrom="timeLimitReached" or calledFrom="configSettings" then
	else ' if called from any unknown point
		screen 0
		print "ERROR: the variable 'calledFrom' holds the illegal value '";calledFrom;"'."
		endp()
	end if
	
	' 'close' window and 'open' it again with scoreboard showing, or main menu showing if being called from configSettings()
	' ----------------------------------------------------------------------------------------------------
	
	if calledFrom="configSettings" then
		windowDoorsHoriz("mainMenu")
	else
		windowDoorsHoriz("statisticsPage")
		
		' Statistics Page
		' /----------------------------------------------------------------------------------------------------\
		do
			sigint()
			
			getmouse(mousex,mousey, ,mouseb)
			
			' General Graphics
			' ----------------------------------------------------------------------------------------------------
			' Background
			line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF
			
			' Title
			line (0,0)-(graphwidth,50),rgba(0,0,0,255),BF
			draw string ((graphwidth/2)-((len("Game Statistics")/2)*8),20),"Game Statistics",rgba(255,255,255,255) ' main menu text
			
			' indentation
			' old: line (15,60)-(155,100),rgba(160,170,180,255),BF ' background
			line (15,65)-(425,565),rgba(160,170,180,255),BF ' background
			line (15,65)-(425,67),rgba(150,160,170,255),BF ' top
			line (15,65)-(17,565),rgba(150,160,170,255),BF ' left
			line (15,563)-(425,565),rgba(130,140,150,255),BF ' bottom
			line (423,65)-(425,565),rgba(130,140,150,255),BF ' right
			
			' main menu button
			line (310,530)-(410,550),rgba(255,0,0,255),BF
			draw string (360-((len("Main Menu")/2)*8),530+7),"Main Menu",rgba(0,0,0,255)
			
			' save game statistics to 'highscores' file button
			if gameStatSaved=0 then
				line (210,530)-(300,550),rgba(255,0,0,255),BF
				draw string ((255-(len("Save Stats")/2)*8),530+7),"Save Stats",rgba(0,0,0,255)
			else
				line (210,530)-(300,550),rgba(192,0,0,255),BF
				draw string ((255-(len("Save Stats")/2)*8),530+7),"Save Stats",rgba(0,0,0,255)
				draw string (220,553),"saved",rgba(0,0,0,255)
			end if
			
			' main menu button if statement
			if mousex>310 and mousex<410 and mousey>530 and mousey<550 and mouseb=1 then
				while mouseb=1
					sigint()
					getmouse(mousex,mousey, ,mouseb)
					sleep 10,1
				wend
				
				exit do
			end if
			
			' Game Statistics
			' ----------------------------------------------------------------------------------------------------
			draw string (30,80+(0*12)),"Difficulty Level:   "+str(difficultyLevel),rgba(0,0,0,255) ' difficulty level
			draw string (30,80+(1*12)),"------------------------------",rgba(0,0,0,255) ' seperator
			draw string (30,80+(2*12)),"Cards Flipped:      "+str(winGame(2)),rgba(0,0,0,255) ' cards flipped
			draw string (30,80+(3*12)),"Time Taken:         "+str(int(timeval/100)),rgba(0,0,0,255) ' time taken
			' time limit -----\
			if timeLimit=0 then
			draw string (30,80+(4*12)),"Time Limit:         "+"inf.",rgba(0,0,0,255)
			else
			draw string (30,80+(4*12)),"Time Limit:         "+str(timeLimit),rgba(0,0,0,255)
			end if
			' time limit -----/
			draw string (30,80+(5*12)),"------------------------------",rgba(0,0,0,255) ' seperator
			draw string (30,80+(6*12)),"Total Score:        "+str(score),rgba(0,0,0,255) ' total score
			
			if gameStatSaved=0 then
				' save game statistics button if statement
				if mousex>210 and mousex<300 and mousey>530 and mousey<550 and mouseb=1 then
					while mouseb=1
						sigint()
						getmouse(mousex,mousey, ,mouseb)
						sleep 10,1
					wend
					
					draw string (220,553),"saving...",rgba(0,0,0,255)
					screencopy
					writeHighscoreTable() ' write statistics to the 'highscores' file
					
					gameStatSaved=1
				end if
			end if
			
			sleep 10,1
			screencopy
		loop
		
		if optionAutoWriteStatsToFile=1 then writeHighscoreTable() ' don't prompt, always write statistics to the 'highscores' file after every game
		' \----------------------------------------------------------------------------------------------------/
		
		windowDoorsHoriz("mainMenu")
	end if
	
	' return to main menu
	returnToPreLoop=1
end sub

sub pauseGame(calledFrom as string) '                                                                                                                                                         Pause Game
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' Darken screen
	imgtmp=imagecreate(graphwidth,graphheight)
	line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,255,0),BF
	
	for i as integer = 1 to 30
		sigint()
		
		line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,0,2),BF
		put (0,0),imgtmp,alpha
		
		sleep 10,1
		screencopy
	next i
	
	' Titles and buttons
	draw string ((graphwidth/2)-50,230),"Game Paused",rgba(255,255,255,255)
	
	line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' 1st button (top)
	line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' 2nd button
	line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' 3rd button
	
	draw string ((graphwidth/2)-((len("Continue")/2)*8),(graphheight/2)-3),"Continue",rgba(255,255,255,255) ' 1st button (top) text
	draw string ((graphwidth/2)-((len("End Game")/2)*8),(graphheight/2)+27),"End Game",rgba(255,255,255,255) ' 2nd button text
	draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' 3rd button text
	
	screencopy
	
	do
		sigint()
		
		getmouse(mousex,mousey, ,mouseb)
		
		' when mouse hovering over a button, 'indent' that button a little
		' top button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-10 and mousey<(graphheight/2)+10 then ' if top button hovered over
			line ((graphwidth/2)-98,(graphheight/2)-8)-((graphwidth/2)+98,(graphheight/2)+8),rgba(220,0,0,255),BF ' top button a little darker and indented
			draw string ((graphwidth/2)-((len("Continue")/2)*8),(graphheight/2)-3),"Continue",rgba(255,255,255,255) ' 1st button (top) text
		else
			line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
			draw string ((graphwidth/2)-((len("Continue")/2)*8),(graphheight/2)-3),"Continue",rgba(255,255,255,255) ' 1st button (top) text
		end if
		
		' middle button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+20 and mousey<(graphheight/2)+40 then ' if middle button hovered over
			line ((graphwidth/2)-98,(graphheight/2)+22)-((graphwidth/2)+98,(graphheight/2)+38),rgba(220,0,0,255),BF ' middle button a little darker and indented
			draw string ((graphwidth/2)-((len("End Game")/2)*8),(graphheight/2)+27),"End Game",rgba(255,255,255,255) ' 2nd button text
		else
			line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
			draw string ((graphwidth/2)-((len("End Game")/2)*8),(graphheight/2)+27),"End Game",rgba(255,255,255,255) ' 2nd button text
		end if
		
		' bottom button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+50 and mousey<(graphheight/2)+70 then ' if bottom button hovered over
			line ((graphwidth/2)-98,(graphheight/2)+52)-((graphwidth/2)+98,(graphheight/2)+68),rgba(220,0,0,255),BF ' bottom button a little darker and indented
			draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' 3rd button text
		else
			line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
			draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' 3rd button text
		end if
		
		if mouseb=1 then
			while mouseb=1
				sigint()
				
				' when mouse is depressed and hovering over a button, 'indent' that button a lot
				' top button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-10 and mousey<(graphheight/2)+10 then ' if top button clicked on
					line ((graphwidth/2)-98,(graphheight/2)-8)-((graphwidth/2)+98,(graphheight/2)+8),rgba(220,0,0,255),BF ' top button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)-7)-((graphwidth/2)+97,(graphheight/2)+7),rgba(192,0,0,255),BF ' top button a lot darker and indented
					draw string ((graphwidth/2)-((len("Continue")/2)*8),(graphheight/2)-3),"Continue",rgba(255,255,255,255) ' 1st button (top) text
				else
					line ((graphwidth/2)-100,(graphheight/2)-10)-((graphwidth/2)+100,(graphheight/2)+10),rgba(255,0,0,255),BF ' top button
					draw string ((graphwidth/2)-((len("Continue")/2)*8),(graphheight/2)-3),"Continue",rgba(255,255,255,255) ' 1st button (top) text
				end if
				
				' middle button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+20 and mousey<(graphheight/2)+40 then ' if middle button clicked on
					line ((graphwidth/2)-98,(graphheight/2)+22)-((graphwidth/2)+98,(graphheight/2)+38),rgba(220,0,0,255),BF ' middle button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)+23)-((graphwidth/2)+97,(graphheight/2)+37),rgba(192,0,0,255),BF ' middle button a lot darker and indented
					draw string ((graphwidth/2)-((len("End Game")/2)*8),(graphheight/2)+27),"End Game",rgba(255,255,255,255) ' 2nd button text
				else
					line ((graphwidth/2)-100,(graphheight/2)+20)-((graphwidth/2)+100,(graphheight/2)+40),rgba(255,0,0,255),BF ' middle button
					draw string ((graphwidth/2)-((len("End Game")/2)*8),(graphheight/2)+27),"End Game",rgba(255,255,255,255) ' 2nd button text
				end if
				
				' bottom button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+50 and mousey<(graphheight/2)+70 then ' if bottom button clicked on
					line ((graphwidth/2)-98,(graphheight/2)+52)-((graphwidth/2)+98,(graphheight/2)+68),rgba(220,0,0,255),BF ' bottom button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)+53)-((graphwidth/2)+97,(graphheight/2)+67),rgba(192,0,0,255),BF ' bottom button a lot darker and indented
					draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' 3rd button text
				else
					line ((graphwidth/2)-100,(graphheight/2)+50)-((graphwidth/2)+100,(graphheight/2)+70),rgba(255,0,0,255),BF ' bottom button
					draw string ((graphwidth/2)-((len("End Program")/2)*8),(graphheight/2)+57),"End Program",rgba(255,255,255,255) ' 3rd button text
				end if
				
				screencopy
				
				getmouse(mousex,mousey, ,mouseb)
			wend
			
			' Continue Game
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-10 and mousey<(graphheight/2)+10 then ' if 1st button released on
				exit do
			end if
			
			' Quit game and show scoreboard
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+20 and mousey<(graphheight/2)+40 then ' if 2nd button released on
				endGame("pauseGame")
				return
			end if
			
			' End the program
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+50 and mousey<(graphheight/2)+70 then ' if 3rd button released on
				endProgram()
			end if
		end if
		
		sleep 10,1
		screencopy
	loop
end sub

sub topBar(calledfrom1 as string, calledfrom2 as string) '                                                                                                                                       Top Bar
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' Top bar
	line (0,0)-(graphwidth,50),rgba(0,0,0,255),BF
	
	' In Game
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	if calledfrom1="inGame" or calledFrom1="clearCardSet" then
		' Indicators on top bar
		scoreUpdate() ' update the score
		draw string (280,6),"Cards Flipped: "+str(winGame(2)),rgba(255,255,255,255)
		draw string (280,16),"Time Playing:  "+str(int(timeval/100))+"s",rgba(255,255,255,255)
		draw string (280,26),"Total Score:   "+str(score),rgba(255,255,255,255)
		
		if calledfrom2="mouseControl" then
			for y as integer = 0 to 7
				for x as integer = 0 to 9
					sigint()
					
					if mousex>cardx(x)-15 and mousex<cardx(x)+15 and mousey>cardy(y)-25 and mousey<cardy(y)+25 then
						draw string (5,5),"Side 1: "+str(cardValue1((y*xs)+x)) ' draw value of 1st side of card
						draw string (5,17),"Side 2: "+str(cardValue2((y*xs)+x)) ' draw value of 2nd side of card
					end if
				next x
			next y
		end if
		
		' "Pause" button if statement will be before the screen is cleared at this subroutine's call point
		
		' "Pause" button graphics
		line (10,28)-(70,48),rgba(255,0,0,255),BF
		draw string (20,28+7),"Pause",rgba(0,0,0,255)
		
		' "Win" button graphics (shows after you have won the game on the current dificulty)
		if winGame(3)=0 then
			' button
			line (80,28)-(140,48),rgba(255,0,0,255),BF
			draw string (290,18+7),"Win",rgba(0,0,0,255)
			
			' arrows pointing towards button maths
			if int(timeval/50)-(arrowtimer(1))=1 then
				arrowtimer(1)=int(timeval/50)
				
				arrowtimer(0)+=1
				if arrowtimer(0)=4 then arrowtimer(0)=1
			end if
			
			' arrows pointing towards button graphics
			if arrowtimer(0)=1 then draw string (240,18+7),">  ",rgba(220,20,20,255)
			if arrowtimer(0)=2 then draw string (240,18+7)," > ",rgba(220,20,20,255)
			if arrowtimer(0)=3 then draw string (240,18+7),"  >",rgba(220,20,20,255)
		end if
	else
		screen 0
		print "ERROR: the variable 'calledFrom1' holds the illegal value '";calledFrom1;"'."
		end
	end if
end sub

sub winGameQuestion() '                                                                                                                                                                Win Game Question
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' Darken screen
	imgtmp=imagecreate(graphwidth,graphheight)
	line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,255,0),BF
	
	for i as integer = 1 to 30
		sigint()
		
		line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,0,2),BF
		put (0,0),imgtmp,alpha
		
		sleep 10,1
		screencopy
	next i
	
	winGame(3)=0
	
	'line (graphwidth/2,0)-(graphwidth/2,graphheight),rgba(0,255,0,255) ' green line down the middle of the screen (for getting text and things centred)
	
	' Graphics
	' Titles
	draw string ((graphwidth/2)-27,230),"You Win",rgba(255,255,255,255)
	draw string ((graphwidth/2)-57,240),"Continue Game?",rgba(255,255,255,255)
	
	' Buttons
	line ((graphwidth/2)-100,(graphheight/2)-25)-((graphwidth/2)+100,(graphheight/2)-5),rgba(255,0,0,255),BF ' top button
	line ((graphwidth/2)-100,(graphheight/2)+5)-((graphwidth/2)+100,(graphheight/2)+25),rgba(255,0,0,255),BF ' bottom button
	
	draw string ((graphwidth/2)-30,(graphheight/2)-20),"End Game",rgba(255,255,255,255) ' top button text
	draw string ((graphwidth/2)-30,(graphheight/2)+10),"Continue",rgba(255,255,255,255) ' bottom button text
	
	' Information
	line (10,330)-(430,420),rgba(20,20,20,255),BF
	
	'                                    |                                               |
	draw string ((graphwidth/2)-180,340),"You have cleared enough cards to have won the",rgba(255,255,255,255) ' line 1 of information
	draw string ((graphwidth/2)-180,350),"game on this difficulty level. However you may",rgba(255,255,255,255) ' line 2 of information
	draw string ((graphwidth/2)-180,360),"continue this game to get more points by",rgba(255,255,255,255) ' line 3 of information
	draw string ((graphwidth/2)-180,370),"clicking 'Continue'. To end the game if you",rgba(255,255,255,255) ' line 4 of information
	draw string ((graphwidth/2)-180,380),"continue, click the 'Win' button at the top",rgba(255,255,255,255) ' line 5 of information
	draw string ((graphwidth/2)-180,390),"right. Or end the game now by clicking",rgba(255,255,255,255) ' line 6 of information
	draw string ((graphwidth/2)-180,400),"'End Game'.",rgba(255,255,255,255) ' line 7 of information
	'                                    |                                               |
	
	screencopy
	
	do
		sigint()
		
		getmouse(mousex,mousey, ,mouseb)
		
		' when left mouse button hovering over a button, 'indent' that button a little
		' top button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-25 and mousey<(graphheight/2)-5 then ' if top button hovered over
			line ((graphwidth/2)-98,(graphheight/2)-23)-((graphwidth/2)+98,(graphheight/2)-7),rgba(220,0,0,255),BF ' top button a little darker and indented
			draw string ((graphwidth/2)-30,(graphheight/2)-20),"End Game",rgba(255,255,255,255) ' top button text
		else
			line ((graphwidth/2)-100,(graphheight/2)-25)-((graphwidth/2)+100,(graphheight/2)-5),rgba(255,0,0,255),BF ' top button
			draw string ((graphwidth/2)-30,(graphheight/2)-20),"End Game",rgba(255,255,255,255) ' top button text
		end if
		
		' bottom button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+5 and mousey<(graphheight/2)+25 then ' if bottom button hovered over
			line ((graphwidth/2)-98,(graphheight/2)+7)-((graphwidth/2)+98,(graphheight/2)+23),rgba(220,0,0,255),BF ' bottom button a little darker and indented
			draw string ((graphwidth/2)-30,(graphheight/2)+10),"Continue",rgba(255,255,255,255) ' bottom button text
		else
			line ((graphwidth/2)-100,(graphheight/2)+5)-((graphwidth/2)+100,(graphheight/2)+25),rgba(255,0,0,255),BF ' bottom button
			draw string ((graphwidth/2)-30,(graphheight/2)+10),"Continue",rgba(255,255,255,255) ' bottom button text
		end if
		
		' Quit game and show scoreboard
		if mouseb=1 then
			while mouseb=1
				sigint()
				
				' when left mouse button is depressed and hovering over a button, 'indent' that button a lot
				' top button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-25 and mousey<(graphheight/2)-5 then ' if top button clicked on
					line ((graphwidth/2)-98,(graphheight/2)-23)-((graphwidth/2)+98,(graphheight/2)-7),rgba(220,0,0,255),BF ' top button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)-22)-((graphwidth/2)+97,(graphheight/2)-8),rgba(192,0,0,255),BF ' top button a lot darker and indented
					draw string ((graphwidth/2)-30,(graphheight/2)-20),"End Game",rgba(255,255,255,255) ' top button text
				else
					line ((graphwidth/2)-100,(graphheight/2)-25)-((graphwidth/2)+100,(graphheight/2)-5),rgba(255,0,0,255),BF ' top button
					draw string ((graphwidth/2)-30,(graphheight/2)-20),"End Game",rgba(255,255,255,255) ' top button text
				end if
				
				' bottom button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+5 and mousey<(graphheight/2)+25 then ' if bottom button clicked on
					line ((graphwidth/2)-98,(graphheight/2)+7)-((graphwidth/2)+98,(graphheight/2)+23),rgba(220,0,0,255),BF ' bottom button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)+8)-((graphwidth/2)+97,(graphheight/2)+22),rgba(192,0,0,255),BF ' bottom button a lot darker and indented
					draw string ((graphwidth/2)-30,(graphheight/2)+10),"Continue",rgba(255,255,255,255) ' bottom button text
				else
					line ((graphwidth/2)-100,(graphheight/2)+5)-((graphwidth/2)+100,(graphheight/2)+25),rgba(255,0,0,255),BF ' bottom button
					draw string ((graphwidth/2)-30,(graphheight/2)+10),"Continue",rgba(255,255,255,255) ' bottom button text
				end if
				
				screencopy
				
				getmouse(mousex,mousey, ,mouseb)
			wend
			
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-25 and mousey<(graphheight/2)-5 then ' if top button clicked on
				endGame("winGameQuestion")
				return
			end if
			
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)+5 and mousey<(graphheight/2)+25 then ' if bottom button clicked on
				exit do
			end if
		end if
		
		sleep 10,1
		screencopy
	loop
end sub

sub timeLimitReached() '                                                                                                                                                               Win Game Question
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' Darken screen
	imgtmp=imagecreate(graphwidth,graphheight)
	line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,255,0),BF
	
	for i as integer = 1 to 30
		sigint()
		
		line imgtmp,(0,0)-(graphwidth,graphheight),rgba(0,0,0,2),BF
		put (0,0),imgtmp,alpha
		
		sleep 10,1
		screencopy
	next i
	
	' Graphics
	' Title
	draw string ((graphwidth/2)-((len("You have ran out of time")/2)*8),230),"You have ran out of time",rgba(255,255,255,255)
	
	' Button
	line ((graphwidth/2)-100,(graphheight/2)-25)-((graphwidth/2)+100,(graphheight/2)-5),rgba(255,0,0,255),BF ' button
	draw string ((graphwidth/2)-((len("Show Statistics")/2)*8),(graphheight/2)-20),"Show Statistics",rgba(255,255,255,255) ' button text
	
	screencopy
	
	do
		sigint()
		
		getmouse(mousex,mousey, ,mouseb)
		
		' when left mouse button hovering over a button, 'indent' that button a little
		' top button
		if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-25 and mousey<(graphheight/2)-5 then ' if button hovered over
			line ((graphwidth/2)-98,(graphheight/2)-23)-((graphwidth/2)+98,(graphheight/2)-7),rgba(220,0,0,255),BF ' button a little darker and indented
			draw string ((graphwidth/2)-((len("Show Statistics")/2)*8),(graphheight/2)-20),"Show Statistics",rgba(255,255,255,255) ' button text
		else
			line ((graphwidth/2)-100,(graphheight/2)-25)-((graphwidth/2)+100,(graphheight/2)-5),rgba(255,0,0,255),BF ' button
			draw string ((graphwidth/2)-((len("Show Statistics")/2)*8),(graphheight/2)-20),"Show Statistics",rgba(255,255,255,255) ' button text
		end if
		
		' Quit game and show scoreboard
		if mouseb=1 then
			while mouseb=1
				sigint()
				
				' when left mouse button is depressed and hovering over a button, 'indent' that button a lot
				' top button
				if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-25 and mousey<(graphheight/2)-5 then ' if button clicked on
					line ((graphwidth/2)-98,(graphheight/2)-23)-((graphwidth/2)+98,(graphheight/2)-7),rgba(220,0,0,255),BF ' top button a little darker and indented
					line ((graphwidth/2)-97,(graphheight/2)-22)-((graphwidth/2)+97,(graphheight/2)-8),rgba(192,0,0,255),BF ' top button a lot darker and indented
					draw string ((graphwidth/2)-((len("Show Statistics")/2)*8),(graphheight/2)-20),"Show Statistics",rgba(255,255,255,255) ' top button text
				else
					line ((graphwidth/2)-100,(graphheight/2)-25)-((graphwidth/2)+100,(graphheight/2)-5),rgba(255,0,0,255),BF ' top button
					draw string ((graphwidth/2)-((len("Show Statistics")/2)*8),(graphheight/2)-20),"Show Statistics",rgba(255,255,255,255) ' top button text
				end if
				
				screencopy
				
				getmouse(mousex,mousey, ,mouseb)
			wend
			
			if mousex>(graphwidth/2)-100 and mousex<(graphwidth/2)+100 and mousey>(graphheight/2)-25 and mousey<(graphheight/2)-5 then ' if top button clicked on
				endGame("timeLimitReached")
				return
			end if
		end if
		
		sleep 10,1
		screencopy
	loop
end sub

sub clearCardSet() '                                                                                                                                                                      Clear Card Set
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' Card Selection
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	while mouseb=1
		sigint()
		
		timeval+=1
		
		getmouse(mousex,mousey, ,mouseb)
		
		' Pause button if statement
		if mousex>340 and mousex<400 and mousey>18 and mousey<38 and mouseb=1 then
			while mouseb=1
				sigint()
				
				getmouse(mousex,mousey, ,mouseb)
			wend
			
			pauseGame("clearCardSet")
			if returnToPreLoop=1 then
				return
			end if
		end if
		
		' Or middle click to Pause
		if mouseb=4 then
			while mouseb=4
				sigint()
				
				getmouse(mousex,mousey, ,mouseb)
				sleep 10,1
			wend
			
			pauseGame("clearCardSet")
			if returnToPreLoop=1 then
				return
			end if
		end if
		
		' Background
		line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF
		
		topBar("clearCardSet", "mouseControl")
		
		' Continue being selected after LMB is released (green box)
		' arrows pointing towards button maths
		if int(timeval/20)-(highlightTimer(1))=1 then
			highlightTimer(1)=int(timeval/20)
			
			highlightTimer(0)+=1
			if highlightTimer(0)=5 then highlightTimer(0)=1
		end if
		
		' draw the boxes
		if LMB=1 then
			for y as integer = 0 to 7
				for x as integer = 0 to 9
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
		
		' draw boxes around cards in the direction of the mouse (in relation to the originally selected card) for as far as the mouse goes in that direction
		' --------------------------------------------------
		CADCSDir=0 ' originally selected card or diagonal
		
		if mousey<cardy(y)-25 and mousex>cardx(x)-15 and mousex<cardx(x)+15 then
			CADCSDir=1 ' up
		elseif mousex<cardx(x)-15 and mousey>cardy(y)-25 and mousey<cardy(y)+25 then
			CADCSDir=2 ' left
		elseif mousey>cardy(y)+25 and mousex>cardx(x)-15 and mousex<cardx(x)+15 then
			CADCSDir=3 ' down
		elseif mousex>cardx(x)+15 and mousey>cardy(y)-25 and mousey<cardy(y)+25 then
			CADCSDir=4 ' right
		else
			CADCSDir=0 ' position not recognised
		end if
		
		' reset the selected card set to 0
		for i as integer = 0 to 79
			'if not i=CADStartCard then CADCardSet(i)=0
			CADCardSet(i)=0
		next i
		
		' find if boxes should be drawn around cards above the originally selected card, and if so how many
		if CADCSDir=1 then ' up
			for i as integer = y to 0 step -1
				if mousey<cardy(i)+25 then
					CADCardSet((i*xs)+x)=1
					CADLastCardInSet=i
				end if
			next i
		end if
		
		' find if boxes should be drawn around cards to the left of the originally selected card, and if so how many
		if CADCSDir=2 then ' left
			for i as integer = x to 0 step -1
				if mousex<cardx(i)+15 then
					CADCardSet((y*xs)+i)=1
					CADLastCardInSet=i
				end if
			next i
		end if
		
		' find if boxes should be drawn around cards below the originally selected card, and if so how many
		if CADCSDir=3 then ' down
			for i as integer = y to ys-1
				if mousey>cardy(i)-25 then
					CADCardSet((i*xs)+x)=1
					CADLastCardInSet=i
				end if
			next i
		end if
		
		' find if boxes should be drawn around cards to the left of the originally selected card, and if so how many
		if CADCSDir=4 then ' right
			for i as integer = x to xs-1
				if mousex>cardx(i)-15 then
					CADCardSet((y*xs)+i)=1
					CADLastCardInSet=i
				end if
			next i
		end if
		
		' draw boxes around cards in the direction of the mouse (in relation to the originally selected card) for as far as the mouse goes in that direction
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				if CADCardSet((y*xs)+x)=1 and not CADStartCard=(y*xs)+x then
					line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),rgba(0,255,0,255),BF
					circle (cardx(x),cardy(y)),12,rgba(50,50,200,255), , ,0.1,F
				end if
			next x
		next y
		
		line (cardx(x)-16,cardy(y)-26)-(cardx(x)+16,cardy(y)+26),colorPalette(2),BF ' white around originally selected card
		
		' Add in cards and numbers on cards (or cards colors)
		if CLOcolor=0 then
			for y as integer = 0 to 7
				for x as integer = 0 to 9
					' Cards backgrounds
					if not ARC((y*xs)+x)=1 then line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),colorPalette(0),BF
					
					' Numbers on cards
					if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
					if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
				next x
			next y
		end if
		
		sleep 10,1
		screencopy
	wend
	
	' check if all selected cards meet the nessisary conditions (there are more than 3 of them, they are all the same number, they haven't already been cleard, etc...)
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	' all the same number / haven't already been cleared (comes under all the same number because both numbers of any card that has been cleared are changed to be <0 and unique)
	' --------------------------------------------------
	if cardSide(CADStartCard)=1 then
		CADCSVals(0)=cardValue1(CADStartCard)
	else
		CADCSVals(0)=cardValue2(CADStartCard)
	end if
	
	CADCSCC=0
	
	for i as integer = 0 to 79
		if CADCardSet(i)=1 and not CADStartCard=i then
			if cardSide(i)=1 then
				CADCSCC+=1
				CADCSVals(CADCSCC)=cardValue1(i)
			else
				CADCSCC+=1
				CADCSVals(CADCSCC)=cardValue2(i)
			end if
		end if
	next i
	
	for i as integer = 1 to CADCSCC
		if CADCSVals(i)=CADCSVals(0) then
		else
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
			
			screencopy
			sleep 500
			return
		end if
	next i
	
	' more than 3 of them
	' --------------------------------------------------
	if CADCSCC+1<3 then
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
			
			screencopy
			sleep 500
			return
	end if
	
	' crossbar graphics
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	' grow crossbar
	' --------------------------------------------------
	if CADCSDir=1 or CADCSDir=3 then
		tmp=16 ' vertical
	elseif CADCSDir=2 or CADCSDir=4 then
		tmp=10 ' horizontal
	else
		tmp=6
	end if
	
	' --------------------------------------------------
	
	for i as integer = 0 to (CADCSCC+1)*tmp step 2
		sigint()
		
		' Pause button if statement
		if mousex>340 and mousex<400 and mousey>15 and mousey<35 and mouseb=1 then
			pauseGame("clearCardSet")
			if returnToPreLoop=1 then
				return
			end if
		end if
		
		topBar("clearCardSet", "")
		
		' Add in cards and numbers on cards (or cards colors)
		if CLOcolor=0 then
			for y as integer = 0 to 7
				for x as integer = 0 to 9
					' Cards backgrounds
					if not ARC((y*xs)+x)=1 then line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),colorPalette(0),BF
					
					' Numbers on cards
					if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
					if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
				next x
			next y
		end if
		
		' create new circle
		if CADCSDir=1 or CADCSDir=3 then ' vertical
			circle (cardx(x),(cardy(y)+cardy(CADLastCardInSet))/2),i*2,rgba(10,200,255,255), , ,(i+1)/2,F
			circle (cardx(x),(cardy(y)+cardy(CADLastCardInSet))/2),i,rgba(8,160,200,255), , ,(i+1)/2,F
		else ' horizontal
			circle ((cardx(x)+cardx(CADLastCardInSet))/2,cardy(y)),i*2,rgba(10,200,255,255), , ,((i+1)/2)^-1,F
			circle ((cardx(x)+cardx(CADLastCardInSet))/2,cardy(y)),i,rgba(8,160,200,255), , ,((i+1)/2)^-1,F
		end if
		
		sleep 10,1
		screencopy
	next i
	
	' shrink crossbar
	' --------------------------------------------------
	for i as integer = (CADCSCC+1)*tmp to 0 step -2
		sigint()
		
		' Pause button if statement
		if mousex>340 and mousex<400 and mousey>15 and mousey<35 and mouseb=1 then
			pauseGame("clearCardSet")
			if returnToPreLoop=1 then
				return
			end if
		end if
		
		topBar("clearCardSet", "")
		
		' remove old circle
		if CADCSDir=1 or CADCSDir=3 then ' vertical
			circle (cardx(x),(cardy(y)+cardy(CADLastCardInSet))/2),(i+2)*2,rgba(180,190,200,255), , ,(i+3)/2,F
		else ' horizontal
			circle ((cardx(x)+cardx(CADLastCardInSet))/2,cardy(y)),(i+2)*2,rgba(180,190,200,255), , ,((i+3)/2)^-1,F
		end if
		
		' Add in cards and numbers on cards (or cards colors)
		if CLOcolor=0 then
			for y as integer = 0 to 7
				for x as integer = 0 to 9
					' Cards backgrounds
					if not ARC((y*xs)+x)=1 then line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),colorPalette(0),BF
					
					' Numbers on cards
					if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
					if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
				next x
			next y
		end if
		
		' create new circle
		if CADCSDir=1 or CADCSDir=3 then ' vertical
			circle (cardx(x),(cardy(y)+cardy(CADLastCardInSet))/2),i*2,rgba(10,200,255,255), , ,(i+1)/2,F
			circle (cardx(x),(cardy(y)+cardy(CADLastCardInSet))/2),i,rgba(8,160,200,255), , ,(i+1)/2,F
		else ' horizontal
			circle ((cardx(x)+cardx(CADLastCardInSet))/2,cardy(y)),i*2,rgba(10,200,255,255), , ,((i+1)/2)^-1,F
			circle ((cardx(x)+cardx(CADLastCardInSet))/2,cardy(y)),i,rgba(8,160,200,255), , ,((i+1)/2)^-1,F
		end if
		
		sleep 10,1
		screencopy
	next i
	
	' remove the cards
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	for i as integer = 15 to 0 step -1
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				sigint()
				
				if CADCardSet((y*xs)+x)=1 then
					' blank all cards in selected set
					line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),rgba(180,190,200,255),BF
					
					' shrink all cards in selected set
					line (cardx(x)-i,cardy(y)-25)-(cardx(x)+i,cardy(y)+25),colorPalette(0),BF
				end if
				screencopy
			next x
		next y
		sleep 10,1
	next i
	
	for y as integer = 0 to 7
		for x as integer = 0 to 9
			if CADStartCard=(y*xs)+x then
				' blank the originally selected card
				line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),rgba(180,190,200,255),BF
			end if
			
			if CADCardSet((y*xs)+x)=1 then
				' blank all cards in selected set
				line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),rgba(180,190,200,255),BF
			end if
		next x
	next y
	
	' make sure they stay gone
	' ------------------------------------------------------------------------------------------------------------------------------------------------------
	' add the selected card set to the previously selected card sets
	for i as integer = 0 to 79
		if CADCardSet(i)=1 then ARC(i)=1
	next i
	
	' make sure you can't use the selected cards again
	for i as integer = 0 to 79
		if CADCardSet(i)=1 then
			NUCN-=1
			cardValue1(i)=NUCN
			cardValue2(i)=NUCN
		end if
	next i
	
	screencopy
end sub

sub flipCard() '                                                                                                                                                                               Flip Card
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' put graphics back on screen before adding to them (after line 178: --"line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF"-- in CardFlipper.bas)
	' Continue being selected after LMB is released (green box)
	' arrows pointing towards button maths
	if int(timeval/20)-(highlightTimer(1))=1 then
		highlightTimer(1)=int(timeval/20)
		
		highlightTimer(0)+=1
		if highlightTimer(0)=5 then highlightTimer(0)=1
	end if
	
	' draw the boxes
	if LMB=1 then
		for y as integer = 0 to 7
			for x as integer = 0 to 9
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
	
	if CLOcolor=0 then
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				' Cards backgrounds
				if not ARC((y*xs)+x)=1 then line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),colorPalette(0),BF
				
				' Numbers on cards
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
			next x
		next y
	end if
	
	' remove the card
	for i as integer = 15 to 1 step -1
		sigint()
		
		' blank the cards
		line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),rgba(180,190,200,255),BF ' first card clicked
		
		' cards shrink
		line (cardx(x)-i,cardy(y)-25)-(cardx(x)+i,cardy(y)+25),colorPalette(0),BF ' first card clicked
		
		sleep 10,1
		screencopy
	next i
	
	' do the maths
	if cardSide((y*xs)+x)=1 then
		cardSide((y*xs)+x)=2
	else
		cardSide((y*xs)+x)=1
	end if
	
	' put the card back on the screen
	for i as integer = 1 to 15
		sigint()
		
		' card grows
		line (cardx(x)-i,cardy(y)-25)-(cardx(x)+i,cardy(y)+25),colorPalette(0),BF ' first card clicked
		
		sleep 10,1
		screencopy
	next i
	
	' put numbers back on the screen
	if CLOcolor=0 then
		' Numbers on cards
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
			next x
		next y
	end if
	
	screencopy
end sub

sub swapCard() '                                                                                                                                                                               Swap Card
' -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	' put graphics back on screen before adding to them (after line 178: --"line (0,0)-(graphwidth,graphheight),rgba(180,190,200,255),BF"-- in CardFlipper.bas)
	' Continue being selected after LMB is released (green box)
	' arrows pointing towards button maths
	if int(timeval/20)-(highlightTimer(1))=1 then
		highlightTimer(1)=int(timeval/20)
		
		highlightTimer(0)+=1
		if highlightTimer(0)=5 then highlightTimer(0)=1
	end if
	
	' draw the boxes
	if LMB=1 then
		for y as integer = 0 to 7
			for x as integer = 0 to 9
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
	
	if CLOcolor=0 then
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				' Cards backgrounds
				if not ARC((y*xs)+x)=1 then line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),colorPalette(0),BF
				
				' Numbers on cards
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
			next x
		next y
	end if
	
	' continue flipping the 2 cards or not depending on if the 2 card's numbers (or colors) are the same
	testCardNumbers()
	if returnFromSwap=1 then
		returnFromSwap=0
		return
	end if
	
	' remove the 2 cards
	for i as integer = 15 to 1 step -1
		sigint()
		
		' blank the cards
		line (cardx(x)-15,cardy(y)-25)-(cardx(x)+15,cardy(y)+25),rgba(180,190,200,255),BF ' first card clicked
		line (cardx(RMBCardX)-15,cardy(RMBCardY)-25)-(cardx(RMBCardX)+15,cardy(RMBCardY)+25),rgba(180,190,200,255),BF ' second card clicked
		
		' cards shrink
		line (cardx(x)-i,cardy(y)-25)-(cardx(x)+i,cardy(y)+25),colorPalette(0),BF ' first card clicked
		line (cardx(RMBCardX)-i,cardy(RMBCardY)-25)-(cardx(RMBCardX)+i,cardy(RMBCardY)+25),colorPalette(0),BF ' second card clicked
		
		sleep 10,1
		screencopy
	next i
	
	' do the maths
	' flip the 2 card's 1st value
	tmp=cardValue1((y*xs)+x)
	cardValue1((y*xs)+x)=cardValue1((RMBCardY*xs)+RMBCardX)
	cardValue1((RMBCardY*xs)+RMBCardX)=tmp
	
	' flip the 2 card's 2nd value
	tmp=cardValue2((y*xs)+x)
	cardValue2((y*xs)+x)=cardValue2((RMBCardY*xs)+RMBCardX)
	cardValue2((RMBCardY*xs)+RMBCardX)=tmp
	
	' flip the 2 card's sides
	tmp=cardSide((y*xs)+x)
	cardSide((y*xs)+x)=cardSide((RMBCardY*xs)+RMBCardX)
	cardSide((RMBCardY*xs)+RMBCardX)=tmp
	
	' put the 2 cards back in
	for i as integer = 1 to 15
		sigint()
		
		' cards grow
		line (cardx(x)-i,cardy(y)-25)-(cardx(x)+i,cardy(y)+25),colorPalette(0),BF ' first card clicked
		line (cardx(RMBCardX)-i,cardy(RMBCardY)-25)-(cardx(RMBCardX)+i,cardy(RMBCardY)+25),colorPalette(0),BF ' second card clicked
		
		sleep 10,1
		screencopy
	next i
	
	' put numbers back on screen
	if CLOcolor=0 then
		' Numbers on cards
		for y as integer = 0 to 7
			for x as integer = 0 to 9
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=1 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue1((y*xs)+x)),colorPalette(1)
				if not ARC((y*xs)+x)=1 and cardSide((y*xs)+x)=2 then draw string (cardx(x)-3,cardy(y)-4),str(cardValue2((y*xs)+x)),colorPalette(1)
			next x
		next y
	end if
	
	screencopy
end sub
