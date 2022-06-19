import Foundation
import UIKit

public typealias Rule = (Cell) -> Cell
public let defaultRules = [
    { Cell(x: $0.x, y: $0.y, state: .dead) },
    { Cell(x: $0.x, y: $0.y, state: .dead) },
    { $0 },
    { Cell(x: $0.x, y: $0.y, state: .dead) },
    { $0 },
    { Cell(x: $0.x, y: $0.y, state: .alive) },
    { Cell(x: $0.x, y: $0.y, state: .dead) },
    { Cell(x: $0.x, y: $0.y, state: .dead) }
]

public class GameScene: UIView {

    var game: Game = Game(size: 100, wanted: [1, 2, 3], opt: "Random", rules: defaultRules)
    var cellSize: Int = 10
    var wanted: [Int] = []
    var opt: String = "Random"

    public convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        self.init(frame: frame)
    }

    public convenience init(gameSize: Int, cellSize: Int, wanted: Array<Int>, opt: String, rules: [Rule?] = defaultRules) {
        let frame = CGRect(x: 0, y: 0, width: gameSize * cellSize, height: gameSize * cellSize)
        self.init(frame: frame)
        self.game = Game(size: gameSize, wanted: wanted, opt: opt, rules: rules)
        self.cellSize = cellSize
        self.wanted = wanted
        self.opt = opt
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()

        for cell in game.cells {
            let rect = CGRect(x: cell.x * cellSize, y: cell.y * cellSize, width: cellSize, height: cellSize)
            let color = cell.state == .alive ? UIColor.black.cgColor : UIColor.white.cgColor
            context?.addRect(rect)
            context?.setFillColor(color)
            context?.fill(rect)
        }

        context?.restoreGState()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.updateCells()
        setNeedsDisplay()
    }
}

public class Game {

    public var cells = [Cell]()
    public let size: Int
    public var wanted: Array<Int>
    public var opt: String
    private var rules: [Rule?]
    
    public init(size: Int, wanted: Array<Int>, opt: String, rules: [Rule?]) {
        self.size = size
        self.wanted = wanted.sorted(by: <)
        self.opt = opt
        self.rules = rules
        
        var selectState = 0
        var idx = 1
        var cnt = 0

        if opt == "Random"{
            for y in 0..<self.size {
                for x in 0..<self.size {
                    let randomState = arc4random_uniform(5)
                    let cell = Cell(x: x, y: y, state: randomState == 0 ? .alive : .dead)
                    cells.append(cell)
                    idx += 1
                }
            }
        }
        else{
            for y in 0..<self.size {
                for x in 0..<self.size {
                    if cnt < self.wanted.count && idx == self.wanted[cnt]{
                        selectState = 0
                        cnt += 1
                    }
                    else{
                        selectState = 1
                    }
                    
                    let cell = Cell(x: x, y: y, state: selectState == 0 ? .alive : .dead)
                    cells.append(cell)
                    idx += 1
                }
            }
        }
    }
    
    public func updateCells() {
        var updatedCells = [Cell]()
        let liveCells = cells.filter { $0.state == .alive }

        for cell in cells {
            let livingNeighbors = liveCells.filter { $0.isNext(to: cell) }

            switch livingNeighbors.count {
            case 1 where cell.state == .alive:
                guard let mutatedCell = rules[0]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 1 where cell.state == .dead:
                guard let mutatedCell = rules[1]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 2 where cell.state == .alive:
                guard let mutatedCell = rules[2]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 2 where cell.state == .dead:
                guard let mutatedCell = rules[3]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 3 where cell.state == .alive:
                guard let mutatedCell = rules[4]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 3 where cell.state == .dead:
                guard let mutatedCell = rules[5]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 4 where cell.state == .alive:
                guard let mutatedCell = rules[6]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            case 4 where cell.state == .dead:
                guard let mutatedCell = rules[7]?(cell) else { continue }
                updatedCells.append(mutatedCell)
            default:
                let deadCell = Cell(x: cell.x, y: cell.y, state: .dead)
                updatedCells.append(deadCell)
            }
        }

        cells = updatedCells
    }

}
