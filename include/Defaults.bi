' Default values for variables in "CardFlipperVariables.bas"
' --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
' Note: this file must be written in the FreeBASIC Language, because it is included in the main file

' Settings
' game settings
difficultyLevel=1 ' Difficulty Level
timeLimit=0 ' Time Limit

' user preferences
optionSigint=1 ' whether ctrl+C is an interpreted sequence of charactors that ends the program immediately (sigint)
optionSelectionType=0 ' type of card highlighting (eg. solid box, moving dashed box) for "highlight all cards with the currently upward facing number of card clicked on"
'                   ^ -- 0 = solid box; 1 = moveing dashed box
optionAutoWriteStatsToFile=0 ' whether to automatically write statistics to highscores file without prompting at the statistics 'page'

' colorPalette (array) 
' Syntax:       rgba(red,green,blue,alpha) [' [(general color name)] comment explaning what it's for and where it occurs]
colorPalette(0)=rgba(100,120,50,255)  ' (dark green) color for cards themselves
colorPalette(1)=rgba(0,0,0,255)       ' (black) color for numbers on cards
colorPalette(2)=rgba(255,255,255,255) ' (white) color for highlighting hovered over card
colorPalette(3)=rgba(220,0,0,255)     ' (red) color for single left click (highlight all cards with the currently upward facing number of card clicked on)
'old: colorPalette(3)=rgba(0,30,160,255)    ' (dark blue) color for single left click (highlight all cards with the currently upward facing number of card clicked on)
colorPalette(4)=rgba(220,0,220,255)   ' (purple) color for single right click (swich 2 cards)
colorPalette(5)=rgba(0,255,0,255)     ' (green) color for selecting cards to clear (click and drag to clear card set)
colorPalette(6)=rgba(255,0,0,255)     ' (red) color for buttons
colorPalette(7)=rgba(255,255,255,255) ' (white) color for button text
