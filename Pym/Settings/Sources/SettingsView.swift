import PymCore
import SwiftUI

class EnableTimeViewModel: ObservableObject {
    @Published var isEnabled: Bool
    @Published var time: Date

    init(isEnabled: Bool, notifyOn time: Date) {
        self.isEnabled = isEnabled
        self.time = time
    }
}

struct EnableTimeView: View {
    let title: String
    @ObservedObject var viewModel: EnableTimeViewModel

    var body: some View {
        HStack {
            Toggle(title, isOn: $viewModel.isEnabled)
            DatePicker("Morning", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
        }
    }
}

class SettingsViewModel: ObservableObject {
    let dataAccess = DataAccessController.shared

    @Published var getsNotified: Bool
    @Published var morning: EnableTimeViewModel
    @Published var evening: EnableTimeViewModel

    @Published var showEreaseAllWarning = false

    init() {
        getsNotified = true
        morning = EnableTimeViewModel(isEnabled: true, notifyOn: Date())
        evening = EnableTimeViewModel(isEnabled: false, notifyOn: Date())
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
                        content: {
                            Toggle("Get Notifications", isOn: $viewModel.getsNotified)

                            if viewModel.getsNotified {
                                EnableTimeView(
                                    title: "Morning",
                                    viewModel: viewModel.morning
                                )

                                EnableTimeView(
                                    title: "Evening",
                                    viewModel: viewModel.evening
                                )
                            }
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
                .listStyle(GroupedListStyle())
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
