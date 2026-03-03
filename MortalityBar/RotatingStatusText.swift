import Foundation

enum DisplayFormat: Int, CaseIterable, Identifiable {
    case daysLeft = 0
    case percentRemains = 1
    case mondaysLeft = 2
    case todayPercent = 3

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .daysLeft: return "Days remaining"
        case .percentRemains: return "% life remaining"
        case .mondaysLeft: return "Mondays left"
        case .todayPercent: return "Today's % gone"
        }
    }
}

struct RotatingStatusText {
    static func text(for format: DisplayFormat, calculator: LifeCalculator, roundUp: Bool) -> String {
        switch format {
        case .daysLeft:
            let days = roundUp ? ((calculator.daysRemaining + 99) / 100) * 100 : calculator.daysRemaining
            return "≈\(days.formatted()) days left"

        case .percentRemains:
            let pct = String(format: "%.1f", calculator.percentRemaining)
            return "\(pct)% life remaining"

        case .mondaysLeft:
            return "~\(calculator.mondaysRemaining.formatted()) Mondays to go"

        case .todayPercent:
            let pct = String(format: "%.0f", calculator.todayPercentGone)
            return "\(pct)% of today gone"
        }
    }

    static func nextFormat(after current: DisplayFormat) -> DisplayFormat {
        let allCases = DisplayFormat.allCases
        let nextIndex = (current.rawValue + 1) % allCases.count
        return allCases[nextIndex]
    }
}
