import Foundation
import SwiftUI
import Combine

final class AppState: ObservableObject {
    // MARK: - Persisted Settings

    @AppStorage("birthdayInterval") var birthdayInterval: Double = 0
    @AppStorage("countryCode") var countryCode: String = LifeExpectancyData.defaultCountryCode
    @AppStorage("genderRaw") var genderRaw: String = Gender.male.rawValue
    @AppStorage("displayFormatRaw") var displayFormatRaw: Int = DisplayFormat.daysLeft.rawValue
    @AppStorage("roundUp") var roundUp: Bool = false
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    // MARK: - Computed Settings

    var birthday: Date {
        get { Date(timeIntervalSince1970: birthdayInterval) }
        set {
            birthdayInterval = newValue.timeIntervalSince1970
            updateStatusText()
        }
    }

    var gender: Gender {
        get { Gender(rawValue: genderRaw) ?? .male }
        set {
            genderRaw = newValue.rawValue
            updateStatusText()
        }
    }

    var displayFormat: DisplayFormat {
        get { DisplayFormat(rawValue: displayFormatRaw) ?? .daysLeft }
        set {
            displayFormatRaw = newValue.rawValue
            updateStatusText()
        }
    }

    // MARK: - Published State

    @Published var currentStatusText: String = "MortalityBar"
    @Published var showSettings: Bool = false

    // MARK: - Timer

    private var rotationTimer: Timer?
    private var refreshTimer: Timer?

    // MARK: - Calculator

    var calculator: LifeCalculator? {
        guard hasCompletedOnboarding else { return nil }
        return LifeCalculator.create(
            birthday: birthday,
            countryCode: countryCode,
            gender: gender
        )
    }

    // MARK: - Init

    init() {
        updateStatusText()
        startTimers()
    }

    deinit {
        rotationTimer?.invalidate()
        refreshTimer?.invalidate()
    }

    // MARK: - Timers

    private func startTimers() {
        // Rotate display format every 3 minutes
        rotationTimer = Timer.scheduledTimer(withTimeInterval: 180, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.displayFormatRaw = RotatingStatusText.nextFormat(after: self.displayFormat).rawValue
            self.updateStatusText()
        }

        // Refresh every 60 seconds for "today %" accuracy
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.updateStatusText()
        }
    }

    // MARK: - Update

    func updateStatusText() {
        guard let calc = calculator else {
            currentStatusText = "MortalityBar"
            return
        }
        currentStatusText = RotatingStatusText.text(
            for: displayFormat,
            calculator: calc,
            roundUp: roundUp
        )
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
        showSettings = false
        updateStatusText()
    }

    func setCountry(_ code: String) {
        countryCode = code
        updateStatusText()
    }

    func setRoundUp(_ value: Bool) {
        roundUp = value
        updateStatusText()
    }
}
