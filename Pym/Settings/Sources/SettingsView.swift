import PymCore
import SwiftUI

public struct SettingsView: View {
    @State private var text = ""
    @State private var notify = true
    @State private var onMorning = true
    @State private var morning = Date()

    public init() {}

    public var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                List {
                    Section(
                        header: Text("Mood Tracking Schedule"),
                        content: {
                            Toggle("Get Notifications", isOn: $notify)

                            if notify {
                                HStack {
                                    Toggle("Morning", isOn: $onMorning)
                                        .labelsHidden()
                                    DatePicker("Morning", selection: $morning, displayedComponents: .hourAndMinute)
                                }

                                HStack {
                                    Toggle("Evening", isOn: $onMorning)
                                        .labelsHidden()
                                    DatePicker("Evening", selection: $morning, displayedComponents: .hourAndMinute)
                                }
                            }
                        }
                    )

                    Section(
                        header: Text("Data Cleanup"),
                        content: {
                            Button(action: {}, label: {
                                Text("Erase my data")
                            })
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
