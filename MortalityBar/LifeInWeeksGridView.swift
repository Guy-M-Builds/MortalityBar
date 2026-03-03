import SwiftUI

struct LifeInWeeksGridView: View {
    let weeksLived: Int
    let totalWeeks: Int
    let availableWidth: CGFloat

    private let columns = 52
    private let spacingRatio: CGFloat = 0.2 // spacing as fraction of cell size

    private var rows: Int {
        (totalWeeks + columns - 1) / columns
    }

    private var cellSize: CGFloat {
        // Fill the entire available width
        availableWidth / CGFloat(columns)
    }

    private var squareSize: CGFloat {
        cellSize * (1.0 - spacingRatio)
    }

    var body: some View {
        Canvas { context, size in
            let livedColor = Color(red: 0.55, green: 0.40, blue: 1.0)
            let remainingColor = Color.white.opacity(0.06)

            for week in 0..<totalWeeks {
                let col = week % columns
                let row = week / columns
                let x = CGFloat(col) * cellSize
                let y = CGFloat(row) * cellSize
                let rect = CGRect(x: x, y: y, width: squareSize, height: squareSize)
                let color = week < weeksLived ? livedColor : remainingColor
                context.fill(Path(rect), with: .color(color))
            }
        }
        .frame(
            width: availableWidth,
            height: CGFloat(rows) * cellSize
        )
    }
}
