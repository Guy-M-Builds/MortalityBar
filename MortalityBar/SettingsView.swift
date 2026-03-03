import SwiftUI
import ServiceManagement

private let accentPurple = Color(red: 0.55, green: 0.40, blue: 1.0)

struct SettingsView: View {
    @ObservedObject var appState: AppState
    @State private var launchAtLogin = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("SETTINGS")
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(2)
                .foregroundColor(accentPurple.opacity(0.7))

            VStack(spacing: 14) {
                // Birthday
                settingRow(emoji: "🎂", label: "Birthday") {
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

                // Country
                settingRow(emoji: "🌍", label: "Country") {
                    Picker("", selection: Binding(
                        get: { appState.countryCode },
                        set: { appState.setCountry($0) }
                    )) {
                        ForEach(LifeExpectancyData.countries) { country in
                            Text("\(country.name)")
                                .tag(country.code)
                        }
                    }
                    .labelsHidden()
                }

                // Gender
                settingRow(emoji: "👤", label: "Gender") {
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

                // Display Format
                settingRow(emoji: "📊", label: "Display") {
                    Picker("", selection: Binding(
                        get: { appState.displayFormat },
                        set: { appState.displayFormat = $0 }
                    )) {
                        ForEach(DisplayFormat.allCases) { fmt in
                            Text(fmt.label).tag(fmt)
                        }
                    }
                    .labelsHidden()
                }
            }

            // Toggles
            VStack(alignment: .leading, spacing: 10) {
                Toggle(isOn: Binding(
                    get: { appState.roundUp },
                    set: { appState.setRoundUp($0) }
                )) {
                    HStack(spacing: 6) {
                        Text("🔢")
                        Text("Round up numbers")
                            .font(.system(size: 13))
                    }
                }

                Toggle(isOn: $launchAtLogin) {
                    HStack(spacing: 6) {
                        Text("🚀")
                        Text("Launch at login")
                            .font(.system(size: 13))
                    }
                }
                .onChange(of: launchAtLogin) { newValue in
                    do {
                        if newValue {
                            try SMAppService.mainApp.register()
                        } else {
                            try SMAppService.mainApp.unregister()
                        }
                    } catch {
                        launchAtLogin = !newValue
                    }
                }
                .onAppear {
                    launchAtLogin = SMAppService.mainApp.status == .enabled
                }
            }
        }
        .padding(24)
    }

    private func settingRow<Content: View>(emoji: String, label: String, @ViewBuilder content: () -> Content) -> some View {
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
}
