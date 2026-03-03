import Foundation

// MARK: - Gender

enum Gender: String, CaseIterable, Identifiable {
    case male
    case female
    case nonBinary

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .nonBinary: return "Non-binary"
        }
    }
}

// MARK: - Country

struct Country: Identifiable, Hashable {
    let code: String
    let name: String
    let maleExpectancy: Double
    let femaleExpectancy: Double

    var id: String { code }

    func lifeExpectancy(for gender: Gender) -> Double {
        switch gender {
        case .male: return maleExpectancy
        case .female: return femaleExpectancy
        case .nonBinary: return (maleExpectancy + femaleExpectancy) / 2.0
        }
    }
}

// MARK: - Life Expectancy Database

/// WHO/World Bank life expectancy data (2023 estimates) by country and gender.
struct LifeExpectancyData {
    static let defaultCountryCode = "US"

    /// (countryCode, countryName, maleLifeExpectancy, femaleLifeExpectancy)
    private static let rawData: [(String, String, Double, Double)] = [
        ("AF", "Afghanistan", 61.0, 64.0),
        ("AL", "Albania", 76.0, 80.2),
        ("DZ", "Algeria", 75.1, 77.6),
        ("AR", "Argentina", 73.4, 79.7),
        ("AU", "Australia", 81.3, 85.2),
        ("AT", "Austria", 79.4, 84.2),
        ("BD", "Bangladesh", 71.2, 74.5),
        ("BE", "Belgium", 79.3, 83.8),
        ("BR", "Brazil", 72.0, 79.4),
        ("BG", "Bulgaria", 71.4, 78.5),
        ("CA", "Canada", 80.0, 84.4),
        ("CL", "Chile", 77.5, 82.6),
        ("CN", "China", 75.0, 80.5),
        ("CO", "Colombia", 73.7, 79.9),
        ("HR", "Croatia", 75.4, 81.7),
        ("CZ", "Czech Republic", 76.3, 82.1),
        ("DK", "Denmark", 79.6, 83.1),
        ("EG", "Egypt", 69.5, 74.2),
        ("ET", "Ethiopia", 63.7, 67.4),
        ("FI", "Finland", 79.2, 84.4),
        ("FR", "France", 79.5, 85.6),
        ("DE", "Germany", 78.7, 83.4),
        ("GH", "Ghana", 63.0, 65.3),
        ("GR", "Greece", 78.6, 83.7),
        ("HU", "Hungary", 73.1, 79.9),
        ("IS", "Iceland", 81.3, 84.2),
        ("IN", "India", 69.4, 72.0),
        ("ID", "Indonesia", 69.6, 73.7),
        ("IR", "Iran", 74.5, 77.6),
        ("IQ", "Iraq", 68.9, 73.2),
        ("IE", "Ireland", 80.5, 84.0),
        ("IL", "Israel", 81.0, 84.6),
        ("IT", "Italy", 80.5, 84.9),
        ("JP", "Japan", 81.5, 87.6),
        ("KE", "Kenya", 62.1, 66.7),
        ("KR", "South Korea", 80.3, 86.1),
        ("MY", "Malaysia", 73.8, 78.2),
        ("MX", "Mexico", 72.1, 78.2),
        ("MA", "Morocco", 74.0, 77.0),
        ("NL", "Netherlands", 80.2, 83.3),
        ("NZ", "New Zealand", 80.4, 83.5),
        ("NG", "Nigeria", 53.4, 55.6),
        ("NO", "Norway", 81.3, 84.5),
        ("PK", "Pakistan", 65.6, 67.7),
        ("PE", "Peru", 73.7, 79.2),
        ("PH", "Philippines", 67.4, 74.2),
        ("PL", "Poland", 74.1, 81.8),
        ("PT", "Portugal", 78.3, 84.0),
        ("RO", "Romania", 72.0, 79.2),
        ("RU", "Russia", 66.5, 77.6),
        ("SA", "Saudi Arabia", 74.8, 78.2),
        ("ZA", "South Africa", 61.5, 67.7),
        ("ES", "Spain", 80.3, 85.7),
        ("SE", "Sweden", 81.3, 84.8),
        ("CH", "Switzerland", 81.8, 85.4),
        ("TW", "Taiwan", 77.5, 83.7),
        ("TH", "Thailand", 73.2, 80.7),
        ("TR", "Turkey", 74.4, 80.0),
        ("UA", "Ukraine", 67.0, 77.2),
        ("AE", "United Arab Emirates", 77.1, 79.6),
        ("GB", "United Kingdom", 79.0, 82.9),
        ("US", "United States", 74.8, 80.2),
        ("VN", "Vietnam", 71.3, 79.4),
    ]

    static let countries: [Country] = rawData
        .map { Country(code: $0.0, name: $0.1, maleExpectancy: $0.2, femaleExpectancy: $0.3) }
        .sorted { $0.name < $1.name }

    static let countryByCode: [String: Country] = {
        Dictionary(uniqueKeysWithValues: countries.map { ($0.code, $0) })
    }()

    static func country(for code: String) -> Country? {
        countryByCode[code]
    }
}
