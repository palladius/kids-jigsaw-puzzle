# [DONE] Adjacency Moves

And finally the super-complex feature - you can add to GH and check later if u wish. its this: once N tiles are ADJACENTS they create an island of adjacency (it could be 2, or 4, or even a weird L shape or more complex. As long as an "island" of 4-connected tiles are being DRAG AND DROPPED, they have to stay together.This is valid for tyhe part you move. if you BREAK an island landing on it, so be it (this is necessary or i believe we might have some puzzles UNSOLVABLE). when you move a full island, use some way to determine how the landed-upon tiles go to the source location - I trust you and i dont care much.

**Implementation Notes:**
- Implemented `getIsland` using BFS to find connected tiles.
- Implemented `moveIsland` to swap the island with the target location.
- Added visual feedback: Connected tiles have no border, unconnected tiles have a white border.
- Dragging an island moves all connected tiles together.


## UI 

Also to make this visually appealing.

