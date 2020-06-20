# Tutorial

## Notation

Throughout this tutorial, certain notations will be used:

- The difficulty levels will be notated "L#", where the "#" is the difficulty level's number (1 to 5)
- Areas on the card board will be notated "(row-range, column-range)", where row-range and column-range are either a single number to indicate one row/column, or two numbers separated by a dash to indicate a range or rows/columns. These numbers are always 1-indexed and start from the top-left. If this sounds a bit technical, these examples should help clear things up:
  - The first card on the first row would be written as (1,1)
  - The last card on the last row would be written as (8,10)
  - The 4th card on the 2nd row would be written as (2,4)
  - The 3rd, 4th and 5th cards on the 2nd row would be written as (2,3-5).
  - The 2nd, 3rd, 4th and 5th cards down the 6th column would be written as (2-5,6)
- The values of cards will be notated "up-side/down-side", where "up-side" is the number on the card that is showing and "down-side" is the number that is hidden on the 'back' of the card

## The Basics

The objective of the game is to eliminate as many of the cards on an 8-by-10 board as quickly as possible to gain a high score.

There are 5 levels of difficulty, simply numbered 1 (easiest) to 5 (hardest). There are two variables between the difficulty levels:
  - The range of numbers that can be on the cards - between 0-4 (L1) and 0-9 (L5)
  - The completion requirements - between 60/80 cards eliminated (L1) and 80/80 cards eliminated (L5)

You can set the difficulty level and the amount of time you have (less time means you start with a higher score) in the "Game Options" tab in the settings menu, which can be accessed from the main menu. You can also set the time limit to 0 to have unlimited time, in which case your score will start at 0:

![Settings menu - Game Options tab](settings.png?raw=true "Settings menu - Game Options tab")

## How to Play

To demonstrate gameplay, let's use an example. This is how the game looks initially:

![Initial game view](tutorial-screenshots/1-start-game.png?raw=true "Initial game view")

You can see that (1,2-6) has two pairs of 4s next to each other, with a 1 in the middle. If we could change that 1 for a 4, we have a five-card set of 4s to eliminate for a fair amount of points. If we hover over the card with a 1 on its up-side it will show a white box around it, and the number on each side will be displayed in the top-left:

![The numbers on each side of the hovered card](tutorial-screenshots/2-displays-sides.png?raw=true "The numbers on each side of the hovered card")

We can see that the up-side (side 2, apparently) is 1, but the down-side is 4, which is what we want. We can double-left-click on (1,4) to flip it. Now we have a row of 4s:

![After flipping the one to a four](tutorial-screenshots/3-double-click-to-flip.png?raw=true "After flipping the 1 to a 4")

To eliminate the cards (and so gain score), left-click and drag across (1,2-6):

![Eliminating the row of 4s](tutorial-screenshots/4-eliminating-cards.png?raw=true "Eliminating the row of 4s")

You can eliminate 3 or more consecutive (ie. next to each other) cards with the same number face-up, either horizontally or vertically, but not both, and not diagonally. Back on our board, after eliminating some naturally occuring sets, we can see that (3,1-4) is a set of 2s, except (3,2) has 4/3 on it (shown by hoving over it):

![After removing a few sets](tutorial-screenshots/5-carry-on-row-3-col-1-to-4.png?raw=true "After removing a few sets")

If we can find a 4/2 or 3/2 card and swap on the 4 or 3, then flip the new card back over to its 2, we can get the 4-card set of 2s. We can swap cards of the same up-facing number by right-clicking on the first card (which will place a purple border around it), then right-clicking on the card we want to swap it with. In this case, we can swap (3,2) with (7,10) (which as 4/2 on it):

![Swapping (3,2) with (7,10)](tutorial-screenshots/6-swapping.png?raw=true "Swapping (3,2) with (7,10)")

Finally, flip the new card at (3,2) over to reveal its 2, then eliminate the set:

![(3,1-4) eliminated](tutorial-screenshots/7-there.png?raw=true "(3,1-4) eliminated")

Instead of checking the entire board for face-up and face-down values to swap, you can left-click on a card to reveal all cards with that number on - either face-up or face-down. If we select a card with a zero face-up to indicate all zeros, we can see 7 cards in (8,2-9) all have zeros, though not all of them are face-up. If we flip all of the cards that have a zero that is not face-up to make the zero face-up, then swap any cards with no zeros with other cards on the board that do have a zero, then we can eliminate the whole 9-card set for a massive score:

![Indicating all zeros and eliminating the bottom row](tutorial-screenshots/8-bottom-row-elimination.png?raw=true "Inidcating all zeros and eliminating the bottom row")

**Note**: The score increase is not reflected in the previous screenshot - only the elimination animation - but eliminating 9 cards in a row results in a score increase of 27! (3 score per card in the set)

On L1, you must eliminate 60 out of the 80 cards to win. When you win, the game will let you choose to either end the game or continue playing to get a higher score (if there are quickly-eliminatable cards on the board:

![Statistics page after game has ended](tutorial-screenshots/9-win-game.png?raw=true "Statistics page after game has ended")

**Note**: The previous screenshot is actually from the game used for the "Tips" section. Don't be fooled by the score shown: you can't get that many points from an endless game - only a timed one.

To end the game early, click "Pause" then "End Game". After the game has ended, in either way, it will display that game's statistics for the highscores table:

![Statistics page after game has ended](tutorial-screenshots/10-end-game.png?raw=true "Statistics page after game has ended")

**Note**: The above screenshot shows a very low score because I was typing this tutorial at the same time! You should go for a better score than that! :D

You may save that game's statistics to the highscore table if you wish.

# Tips
###### (If you're struggling on higher difficulties)

You'll find that the fewer cards that are left on the board, the harder it gets to eliminate more - especially on higher difficulty levels with a wider range of possible numbers on the cards. On L5, eliminating all of the cards requires a more careful strategy. I have found the best strategy to be lining up every row or column with a single number, like so:

![Rows one to four are each sets with a single number face-up](tips-screenshots/line-up-strategy.png?raw=true "Rows 1 to 4 are each sets with a single number face-up")

Rows are longer and there are more of them, so rows are usually a better idea to line up sets. However, it does depend on the cards you are dealt - if there is an almost-full column 1 and/or column 8 (ie. non-obstructing columns), then it is probably be a good idea to complete that/those column(s) and use 9- or 8-column horizontal sets instead. Either way, you get a fixed amount of score per card eliminated, so can only get up to 240 score (3 \* 8 \* 10) from card elimination regardless. Therefore, beyond eliminating more cards, the only way of getting a higher score is to set a lower time limit.

With practice, you should be able to complete a game in 540-600 seconds (9-10 minutes) without pausing the game to think too often. When making this tutorial, I managed to complete an L1 500-second limit game in 474 seconds:

![I reached a score of 2163 with 70 cards flipped](tips-screenshots/end-stats.png?raw=true "Score of 2163 with 70 cards flipped")

Some pausing is fine - especially later in the game - but be aware that as long as the game is paused, you can't see the cards' face-down values, except for your currently-highlighted number, like so:

![Pausing the game shows the currently active number indicator, but not other face-down numbers](tips-screenshots/pause-menu.png?raw=true "Pausing the game shows the currently active number indicator, but not other face-down numbers")

Therefore, you will need to remember the board (or parts of it) and/or use your active-time wisely.

**BEWARE**: One final warning: the game suffers from a bug where the "Continue" button on the pause menu has a chance to exit the game instead of continuing it! As such, try to avoid pausing, or you may find yourself quiting without intending to! Call it a feature to stop you from pausing too much (which could be considered cheating), not a bug :P
