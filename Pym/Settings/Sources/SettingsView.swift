import Combine
import PymCore
import SwiftUI

class EnableTimeViewModel: ObservableObject {
    var onChange: (() -> Void)?

    @Published var isEnabled: Bool {
        didSet { callOnChange() }
    }

    @Published var time: Date {
        didSet { callOnChange() }
    }

    init(isEnabled: Bool, notifyOn time: Date) {
        self.isEnabled = isEnabled
        self.time = time
    }

    private func callOnChange() {
        if let onChange = onChange {
            onChange()
        }
    }
}

struct EnableTimeView: View {
    let title: String
    @ObservedObject var viewModel: EnableTimeViewModel

    var body: some View {
        VStack {
            Toggle(title, isOn: $viewModel.isEnabled)
            if viewModel.isEnabled {
                DatePicker(title, selection: $viewModel.time, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            }
        }
    }
}

class SettingsViewModel: ObservableObject {
    private let dataAccess = DataAccessController.shared
    private let notificationService = NotificationService.shared
    // TODO: Use service instead?
    private let defaults = UserDefaults.standard

    @Published var notificationStatus = NotificationAuthorizationStatus.notAsked

    @Published var morning: EnableTimeViewModel
    @Published var evening: EnableTimeViewModel

    @Published var showEreaseAllWarning = false

    init() {
        morning = EnableTimeViewModel(
            isEnabled: defaults.bool(forKey: "notify.morning.enabled"),
            notifyOn: UserDefaults.standard.object(forKey: "notify.morning.time") as? Date ?? Date()
        )

        evening = EnableTimeViewModel(
            isEnabled: defaults.bool(forKey: "notify.evening.enabled"),
            notifyOn: UserDefaults.standard.object(forKey: "notify.evening.time") as? Date ?? Date()
        )

        morning.onChange = update
        evening.onChange = update
    }

    private func update() {
        update(identifier: "morning", morning, content: notificationService.morningNotification)
        update(identifier: "evening", evening, content: notificationService.eveningNotification)
    }

    private func update(identifier: String, _ viewModel: EnableTimeViewModel, content: UNMutableNotificationContent) {
        defaults.set(viewModel.isEnabled, forKey: "notify.\(identifier).enabled")
        defaults.set(viewModel.time, forKey: "notify.\(identifier).time")

        notificationService.remove(withIdentifier: "notify.\(identifier)")
        if viewModel.isEnabled {
            notificationService.schedule(
                identifier: "notify.\(identifier)",
                on: viewModel.time,
                content: content
            )
        }
    }

    func ereaseAllData() {
        // TODO: How to handle errors here?
        dataAccess.deleteAllEntries()
    }
}

public struct SettingsView: View {
    @ObservedObject private var viewModel = SettingsViewModel()

    public init() {}

    public var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                List {
                    Section(
                        header: Text("Mood Tracking Schedule"),
                        footer: HStack {
                            if viewModel.notificationStatus == .error {
                                Text("Not allowed :(")
                            }
                        },
                        content: {
                            EnableTimeView(
                                title: "Morning",
                                viewModel: viewModel.morning
                            )

                            EnableTimeView(
                                title: "Evening",
                                viewModel: viewModel.evening
                            )
                        }
                    )

                    Section(
                        header: Text("Data Cleanup"),
                        content: {
                            Button(
                                action: { viewModel.showEreaseAllWarning = true },
                                label: { Text("Erase my data") }
                            )
                            .alert(
                                isPresented: $viewModel.showEreaseAllWarning,
                                content: {
                                    Alert(
                                        title: Text("Erease all entries?"),
                                        primaryButton: .destructive(
                                            Text("Delete All"),
                                            action: viewModel.ereaseAllData
                                        ),
                                        secondaryButton: .cancel(
                                            Text("Cancel"))
                                    )
                                }
                            )
                        }
                    )
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
