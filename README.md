# Card Flipper
A simple game of quick thinking, logical reasoning and memory.

# History
Original development stopped 2014-05-11. Feel free to open a pull request if you want to continue it!

# Compilation
You can compile the `.bas` (FreeBASIC) file with the [freebasic compiler](https://sourceforge.net/projects/fbc/files/ "FreeBASIC Compiler on SourceFourge") (last tested with `fbc` version 1.05.0):
```
fbc CardFlipper.bas
```

# Gameplay
Objective: eliminate all of the cards quickly (to gain a high score)

- There are 5 levels of difficulty, with the following differences (available in settings, defalts to 1 - easiest):
  - The range of numbers that can be on the cards (between 0-4 and 0-9)
  - The completion requirements (between 60/80 and 80/80 cards eliminated)

## Controls
**Core**:
- **Left-click-and-drag** across 3 or more cards with the same value to eliminate them
  - The more cards eliminated simultaineously, the more score the elimination is worth
- **Double-left-click** on a card to flip it
- **Right-click** on a card to select it, then **Right-click** on another card of the same upward-facing value to swap their positions

**Tools**:
- **Hover** over a card to see the value on both sides (in the top bar)
- **Left-click** on a card to highlight all other cards with the same number (on either side) as the upward facing value of the clicked card

# Known Issues
- `Continue` button doesn't always function correctly.

See the notes in `CardFlipper.bas` for other known issues.
