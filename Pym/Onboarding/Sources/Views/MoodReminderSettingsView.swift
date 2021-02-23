import PymCore
import SwiftUI

struct MoodReminderSettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var morningReminder = Date()
    @State private var eveningReminder = Date()

    let next: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Image("Duck")
            Text("When should I remind you?")
                .bold()
                .font(.title)
                .padding(5)
                .multilineTextAlignment(.center)

            HStack {
                Text("Morning")
                DatePicker("", selection: $morningReminder, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .colorMultiply(colorScheme == .dark ? .black : .white)
                    .colorInvert()
            }

            HStack {
                Text("Evening")
                DatePicker("", selection: $eveningReminder, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .colorMultiply(colorScheme == .dark ? .black : .white)
                    .colorInvert()
            }

            Spacer()
            Button(action: next) {
                Text("Get things ready!")
                    .bold()
                Spacer()
            }.buttonStyle(PrimaryButtonStyle())
                .padding(16)
        }
    }
}

struct MoodReminderSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MoodReminderSettingsView(next: {})
    }
}
