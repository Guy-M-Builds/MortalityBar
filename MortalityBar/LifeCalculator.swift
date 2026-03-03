import Foundation

struct LifeCalculator {
    let birthday: Date
    let lifeExpectancyYears: Double

    private var calendar: Calendar { Calendar.current }
    private var now: Date { Date() }

    // MARK: - Core

    var deathDate: Date {
        calendar.date(byAdding: .day, value: Int(lifeExpectancyYears * 365.25), to: birthday) ?? birthday
    }

    var totalDays: Int {
        Int(lifeExpectancyYears * 365.25)
    }

    var daysLived: Int {
        max(0, calendar.dateComponents([.day], from: birthday, to: now).day ?? 0)
    }

    var daysRemaining: Int {
        max(0, totalDays - daysLived)
    }

    var weeksLived: Int {
        daysLived / 7
    }

    var weeksRemaining: Int {
        max(0, totalWeeks - weeksLived)
    }

    var totalWeeks: Int {
        totalDays / 7
    }

    var percentLived: Double {
        guard totalDays > 0 else { return 100.0 }
        return min(100.0, Double(daysLived) / Double(totalDays) * 100.0)
    }

    var percentRemaining: Double {
        max(0.0, 100.0 - percentLived)
    }

    // MARK: - Age String

    var ageComponents: (years: Int, months: Int, days: Int) {
        let comps = calendar.dateComponents([.year, .month, .day], from: birthday, to: now)
        return (comps.year ?? 0, comps.month ?? 0, comps.day ?? 0)
    }

    var ageString: String {
        let a = ageComponents
        return "\(a.years) years, \(a.months) months, \(a.days) days old"
    }

    var brutalAgeString: String {
        let a = ageComponents
        let hours = calendar.dateComponents([.hour], from: birthday, to: now).hour ?? 0
        return "\(a.years)y \(a.months)m \(a.days)d (\(hours.formatted()) hours)"
    }

    // MARK: - Fun Units

    var summersRemaining: Int {
        let yearsLeft = daysRemaining / 365
        return max(0, yearsLeft)
    }

    var sleepsRemaining: Int {
        daysRemaining
    }

    var fridaysRemaining: Int {
        daysRemaining / 7
    }

    var mondaysRemaining: Int {
        daysRemaining / 7
    }

    var christmasesRemaining: Int {
        daysRemaining / 365
    }

    var booksAt50PerYear: Int {
        daysRemaining / 365 * 50
    }

    var mealsRemaining: Int {
        daysRemaining * 3
    }

    var sunrisesRemaining: Int {
        daysRemaining
    }

    // MARK: - Today Progress

    var todayPercentGone: Double {
        let comps = calendar.dateComponents([.hour, .minute], from: now)
        let minutesSinceMidnight = Double(comps.hour ?? 0) * 60.0 + Double(comps.minute ?? 0)
        return minutesSinceMidnight / 1440.0 * 100.0
    }

    // MARK: - Factory

    static func create(birthday: Date, countryCode: String, gender: Gender) -> LifeCalculator? {
        guard let country = LifeExpectancyData.country(for: countryCode) else { return nil }
        let expectancy = country.lifeExpectancy(for: gender)
        return LifeCalculator(birthday: birthday, lifeExpectancyYears: expectancy)
    }
}
