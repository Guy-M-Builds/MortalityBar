import SwiftUI

@main
struct MortalityBarApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        MenuBarExtra {
            PopoverView(appState: appState)
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "hourglass")
                Text(appState.currentStatusText)
            }
        }
        .menuBarExtraStyle(.window)
    }
}
