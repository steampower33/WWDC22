import Foundation

public enum State {
    case alive
    case dead
}

public struct Cell {
    public let x: Int
    public let y: Int
    public var state: State

    // add public initializer
    public init(x: Int, y: Int, state: State) {
        self.x = x
        self.y = y
        self.state = state
    }

    public func isNext(to cell: Cell) -> Bool {
        switch (abs(self.x - cell.x), abs(self.y - cell.y)) {
        case (1, 1), (0, 1), (1, 0):
            return true
        default:
            return false
        }
    }
}
