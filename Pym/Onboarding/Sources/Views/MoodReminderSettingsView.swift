import PymCore
import SwiftUI

struct MoodReminderSettingsView: View {
    @StateObject var viewModel: MoodReminderSettingsViewModel

    var body: some View {
        VStack {
            Spacer()
            Image.duck
            Text("When should I remind you?")
                .bold()
                .font(.title)
                .padding(5)
                .multilineTextAlignment(.center)

            List {
                Section(content: {
                    EnableTimeView(title: "Morning", viewModel: viewModel.morning)
                    EnableTimeView(title: "Evening", viewModel: viewModel.evening)
                })
            }
            .listStyle(InsetGroupedListStyle())

            Spacer()
            Button(action: viewModel.saveAndNext) {
                Text("Get things ready!")
                    .bold()
                Spacer()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding(16)
    }
}

struct MoodReminderSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = ViewModelFactory()

        MoodReminderSettingsView(
            viewModel: viewModelFactory.makeMoodReminderSettingsViewModel(
                next: {}))
    }
}
