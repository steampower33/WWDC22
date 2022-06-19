/*:
 ## Hello My name is SeungMin Lee
 
 From now on, I will tell you about Conray's Game of Life.
 _ _ _
 ## What is the Conray's Game of Life?
 
 The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970.
 _ _ _
 ## So What is the Cellular Automaton?
 A cellular automata or cellular automata (singular cellular automaton) is a discrete model covered in computability theory, mathematics, physics, complex systems, mathematical biology, and microstructural modeling.
 _ _ _
 ## About Game of Life
 
 First of all, this game is not played by human will. The progress of the life game is completely determined only by the initial value entered for the first time.

 The cells then rotate on the grid and interact with neighboring cells to have a state of “dead” or “live”.
 
 very cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each step in time, the following transitions occur:
 1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
 2. Any live cell with two or three live neighbours lives on to the next generation.
 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
 
 Cells change their shape over time through these rules. Finally, there are shapes that occur in common, and we look at how they are created.
 
 There are shapes that are finally created and shapes that are made bulky through the process. Please take a look at it with that in mind.
 
 # Now let's try it.
 */
import UIKit
import PlaygroundSupport
/*:
 
 # Try 1
 By setting this "Random" option, random cells are generated.
 If you uncomment view.autoRun(), autoclick is executed
 Unless you uncomment view.autoRun(), you have to click the screen to proceed.
 
 Click on 45 line to run try1.
 Click on the screen until the shapes barely change.
 */
let try1 = GameScene(gameSize: 50, cellSize: 10, wanted:[], opt:"Random")
PlaygroundPage.current.liveView = try1



/*:
 # Wait!
 ![Beehive](Beehive.png)
 ![Blinker](Blinker.png)
 ![Block](Block.png)
 ![Loaf](Loaf.png)
 ![Tub](Tub.png)
 
 They are called Beehive, Blinker, Block, Loaf, and Tub in that order.
 These are patterns that occur as the game progresses, and other than these patterns, there are also patterns with repetition from the process.

 For more reference https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
 
 Anyway, from now on, unlike before, we can directly select the cell location and try to apply a new rule, not the existing Rule in Conway's Game of Life.
 */


/*:
 # Try 2
 From here, unlike before, we can directly select the location of the cell and proceed.
 
 In try1, cells were generated at random locations.
 This time, let's set the wanted array to create a cell in the desired location.
 
 A world size of 50 means creating a 50x50 2D vector.

 Choose from a number from 0 to 2449
 
 Click on 82 line to run try1.
 Click on the screen until the shapes barely change.
 */
let try2 = GameScene(gameSize: 50, cellSize: 10, wanted:[1266,1267,1268,1269], opt:"")
PlaygroundPage.current.liveView = try2


/*:
 # Try 3
 
 We can now change the Rule to be applied directly.

 The basic cell type is Cell(x: $0.x, y: $0.y, state: .alive), +1 or -1 can be added to $0.x and $0.y, and the state is .alive or .alive. Dead can be set by selecting one of the two.
 
 # Let's see how cells survive and die by applying various rules!
 
 ### tips: Of course, you can also add cells to the desired position through wanted array, or you can distribute cells evenly on the screen by adding "Random" to opt.
 */

let rules: [Rule?] = [
    { Cell(x: $0.x, y: $0.y - 1, state: .alive) },
    { Cell(x: $0.x, y: $0.y - 1, state: .alive) },
    { $0 },
    { Cell(x: $0.y, y: $0.x - 1, state: .alive) },
    { $0 },
    { Cell(x: $0.y, y: $0.x - 1, state: .dead) },
    { $0 },
    { $0 },
]

let try3 = GameScene(gameSize: 50, cellSize: 10, wanted: [], opt: "Random", rules: rules)
PlaygroundPage.current.liveView = try3
