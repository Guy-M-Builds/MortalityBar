import SwiftUI

private let accentPurple = Color(red: 0.55, green: 0.40, blue: 1.0)

struct PopoverView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        Group {
            if !appState.hasCompletedOnboarding {
                onboardingView
            } else if appState.showSettings {
                settingsWrapper
            } else {
                mainView
            }
        }
        .frame(width: 360)
        .background(Color(nsColor: .windowBackgroundColor))
    }

    // MARK: - Onboarding

    private var onboardingView: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("💀 MortalityBar")
                    .font(.system(size: 20, weight: .bold))

                Text("Tell us about yourself. We'll handle the existential dread.")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 14) {
                onboardingRow(emoji: "🎂", label: "Birthday") {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { appState.birthday },
                            set: { appState.birthday = $0 }
                        ),
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .labelsHidden()
                }

                onboardingRow(emoji: "🌍", label: "Country") {
                    Picker("", selection: Binding(
                        get: { appState.countryCode },
                        set: { appState.setCountry($0) }
                    )) {
                        ForEach(LifeExpectancyData.countries) { country in
                            Text(country.name).tag(country.code)
                        }
                    }
                    .labelsHidden()
                }

                onboardingRow(emoji: "👤", label: "Gender") {
                    Picker("", selection: Binding(
                        get: { appState.gender },
                        set: { appState.gender = $0 }
                    )) {
                        ForEach(Gender.allCases) { g in
                            Text(g.displayName).tag(g)
                        }
                    }
                    .labelsHidden()
                }
            }

            Button(action: { appState.completeOnboarding() }) {
                Text("Start My Countdown")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(accentPurple)
        }
        .padding(24)
    }

    private func onboardingRow<Content: View>(emoji: String, label: String, @ViewBuilder content: () -> Content) -> some View {
        HStack(spacing: 8) {
            Text(emoji)
                .font(.system(size: 16))
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .frame(width: 70, alignment: .leading)
            Spacer()
            content()
                .frame(maxWidth: 180)
        }
    }

    // MARK: - Settings Wrapper

    private var settingsWrapper: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingsView(appState: appState)

            Button(action: { appState.showSettings = false }) {
                Text("Back to My Countdown")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(accentPurple)
            .padding(24)
        }
    }

    // MARK: - Main View

    private var mainView: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let calc = appState.calculator {
                // Age section
                VStack(alignment: .leading, spacing: 6) {
                    Text("AGE")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .tracking(2)
                        .foregroundColor(accentPurple.opacity(0.7))

                    Text(calc.ageString)
                        .font(.system(size: 22, weight: .bold))
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 20)

                divider

                // Stats row
                HStack(alignment: .top, spacing: 0) {
                    statColumn(
                        label: "DAYS LEFT",
                        value: calc.daysRemaining.formatted()
                    )
                    statColumn(
                        label: "WEEKS LEFT",
                        value: calc.weeksRemaining.formatted()
                    )
                    statColumn(
                        label: "LIFE USED",
                        value: String(format: "%.1f%%", calc.percentLived)
                    )
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)

                divider

                // Reaper quote
                HStack(alignment: .top, spacing: 10) {
                    Text("💀")
                        .font(.system(size: 24))

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Reaper says")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(accentPurple.opacity(0.7))

                        Text(quoteForCalc(calc))
                            .font(.system(size: 13, design: .monospaced))
                            .italic()
                            .foregroundColor(.secondary.opacity(0.7))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)

                divider

                // Life in weeks grid
                VStack(alignment: .leading, spacing: 8) {
                    Text("YOUR LIFE IN WEEKS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .tracking(2)
                        .foregroundColor(accentPurple.opacity(0.7))

                    LifeInWeeksGridView(
                        weeksLived: calc.weeksLived,
                        totalWeeks: calc.totalWeeks,
                        availableWidth: 312
                    )
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)

                divider

                // Fun units
                VStack(alignment: .leading, spacing: 10) {
                    Text("IN OTHER UNITS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .tracking(2)
                        .foregroundColor(accentPurple.opacity(0.7))

                    funUnitsRow(calc: calc)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 18)

                divider

                // Bottom bar
                HStack {
                    Button(action: { appState.showSettings = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button(action: { NSApplication.shared.terminate(nil) }) {
                        HStack(spacing: 4) {
                            Text("Quit")
                            Image(systemName: "xmark.circle")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
            }
        }
    }

    // MARK: - Components

    private var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.06))
            .frame(height: 1)
            .padding(.horizontal, 24)
    }

    private func statColumn(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 10, weight: .semibold))
                .tracking(1.5)
                .foregroundColor(.secondary.opacity(0.6))

            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(accentPurple)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func funUnitsRow(calc: LifeCalculator) -> some View {
        let items: [(String, String)] = [
            ("Summers", "\(calc.summersRemaining)"),
            ("Fridays", calc.fridaysRemaining.formatted()),
            ("Mondays", calc.mondaysRemaining.formatted()),
            ("Sleeps", calc.sleepsRemaining.formatted()),
            ("Meals", calc.mealsRemaining.formatted()),
            ("Christmases", "\(calc.christmasesRemaining)"),
        ]

        return LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ], alignment: .leading, spacing: 12) {
            ForEach(items, id: \.0) { item in
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.1)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(accentPurple)
                    Text(item.0)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary.opacity(0.6))
                }
            }
        }
    }

    private func quoteForCalc(_ calc: LifeCalculator) -> String {
        Quotes.reaper(
            daysLeft: calc.daysRemaining,
            weeksLeft: calc.weeksRemaining,
            mondaysLeft: calc.mondaysRemaining,
            summersLeft: calc.summersRemaining,
            fridaysLeft: calc.fridaysRemaining,
            mealsLeft: calc.mealsRemaining
        )
    }
}
