' Variables for "CardFlipper.bas"
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
' Universal
' ----------------------------------------------------------------------------------------------------
' Screen size
dim shared graphwidth as integer = 440
dim shared graphheight as integer = 580

' Mouse
' ----------------------------------------------------------------------------------------------------
dim shared mousex as integer ' mouse x position
dim shared mousey as integer ' mouse y position
dim shared mouseb as integer ' mouse buttons

' Swaping cards (Right Mouse Button)
dim shared RMB as integer ' Right Mouse Button
dim shared RMBCardX as integer
dim shared RMBCardY as integer

' Highlighting cards with the same numbers (Left Mouse Button)
dim shared LMB as integer ' Left Mouse Button
dim shared highlightCardNumber as integer = -1

' Cards
' ----------------------------------------------------------------------------------------------------
' Card positions
dim shared xs as integer = 10 ' x size (number of colums of cards)
dim shared ys as integer = 8 ' y size (number of rows of cards)

dim shared cardx(xs) as integer ' card positions in pixels
dim shared cardy(ys) as integer ' card positions in pixels

for i as integer = 0 to 9
	cardx(i)=(i+1)*40
next i
for i as integer = 0 to 7
	cardy(i)=((i+1)*60)+50
next i

' Card values and side information
dim shared cardValue1(80) as integer ' value on first side of cards
dim shared cardValue2(80) as integer ' value on second side of cards
dim shared cardSide(80) as integer ' which side each card is facing

for i as integer = 0 to 79
	cardSide(i)=1
next i

' Clearing card sets (Click and Drag)
dim shared CADStartCard as integer ' card originally clicked on
dim shared CADCardSet(80) as integer ' Click And Drag Card Set - which cards are selected
dim shared CADCSDir as integer ' Click And Drag Card Set Direction - on which axis are the selected cards and which direction on that axis
dim shared CADCSVals(xs) as integer ' Click And Drag Card Set Values - values of cards in the selected set (if they are the same)
dim shared CADCSCC as integer ' Click And Drag Card Set Current Card
dim shared CADLastCardInSet as integer

dim shared ARC(80) as integer ' All Removed Cards
dim shared NUCN as integer ' Non-Usable Cards Numbers - assign this var's value to cards when they are cleared (gradually gets smaller) so the cards can't be used again

' Settings
' ----------------------------------------------------------------------------------------------------
' Game Settings
' --------------------------------------------------
dim shared difficultyLevel as integer = 1 ' Difficulty level (at least 1)

' User Preferences
' --------------------------------------------------
' on/off options
dim shared optionSigint as byte ' whether ctrl+C is an interpreted sequence of charactors that ends the program immediately (sigint)
dim shared optionSelectionType as byte ' type of card highlighting (eg. solid box, moving dashed box) for "highlight all cards with the currently upward facing number of card clicked on"
dim shared optionAutoWriteStatsToFile as byte ' whether to automatically write statistics to highscores file without prompting at the statistics 'page'

' other preferences
dim shared colorPalette(7) as integer ' Colors for highlighting cards with various actions (swap cards, highlight same numbered cards, etc...)

' Other related variables
' --------------------------------------------------
dim shared xyindent(4) as integer ' (0)=x1; (2)=y1; (1)=x2; (3)=y2
dim shared currentCategory as string ' the currently showing category in configSettings()
currentCategory="gameOptions"

' selectExact() vars
dim shared cpos as integer = 142 ' curser position - (graphwidth/2)-78
dim shared cstring(20) as string ' current string
dim shared rstring as string ' return string
dim shared multikeyValueSet(90) as string * 12 = { _
"", "", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "", _ '15
"", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[", "]", "", _ '29
"", "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'", "~", "", _ '43
"\", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "", "*", "", _ '57
" ", "", "", "", "", "", "", "", "", "", "", "","", "", "", "", "", _ '74
 "-", "", "","", "+", "", "", "", "", "", "","", "", "", "" } '89

' Statistics, Time and Score
' ----------------------------------------------------------------------------------------------------
dim shared score as integer ' score (for calculation to determin score, see the begining of "CardFlipperFunctions.bi")

' Timer
dim shared timeval as integer
dim shared timeLimit as integer ' time before you fail the game, 0 = no time limit

' Timers for specific purposes
dim shared arrowtimer(2) as integer ' timer for the arrows pointing to the 'win' button
dim shared highlightTimer(2) as integer ' timer for the boxes around highlighted cards with same number

' Statistics (at end of game)
dim shared winGame(4) as integer
winGame(0)=0 ' changes from 0 to 1 when you have cleared enough cards to win on the current difficulty level - '1' means 'win' and '0' means 'lose'
winGame(1)=55+(difficultyLevel*5) ' number of cards needed to be flipped before you win on different dificulty levels (eg. on L1, 55+(1*5) = 60 cards)
winGame(2)=0 ' total number of cards flipped
winGame(3)=1 ' whether to ask if you want to continue or end the game when you have 'won' (cleared enough cards) the game (depending on difficulty level)

dim shared WSTF as byte ' Write Statistics To File - whether to write the last game's statistics to the 'highscores' file after a game
dim shared gameStatSaved as byte ' if game statistics have already been saved

' Misc
' ----------------------------------------------------------------------------------------------------
' temporary variables
dim shared tmp as integer
dim shared imgtmp as any ptr ' temporary image buffer (for alpha to work)

' return to/from variables
dim shared returnFromSwap as integer
dim shared returnToPreLoop as byte

' used so the program can send the x (0 to 9) and y (0 to 7) values of the card currently being acted on to subroutines (you can't use 'shared' when defining vars in 'for' statements)
dim shared x as integer
dim shared y as integer

dim shared tad(3) as string ' time and date
