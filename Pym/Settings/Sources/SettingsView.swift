import Combine
import PymCore
import SwiftUI

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
                            .accentColor(.red)
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
            .navigationBarTitle("Settings", displayMode: .automatic)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
