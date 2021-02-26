import PymCore
import SwiftUI

struct MoodReminderIntroView: View {
    @StateObject var viewModel: MoodReminderIntroViewModel

    var body: some View {
        VStack {
            Spacer()
            Image.duck
            Text("Should I remind you to track your mood?")
                .bold()
                .font(.title)
                .padding(8)
                .multilineTextAlignment(.center)

            Spacer()
            Button(action: viewModel.continueWithNotifications) {
                Text("Yes, of course!")
                    .bold()
                Spacer()
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(16)

            Button(action: viewModel.toggleNotificationWarning) {
                Text("No thanks")
            }
            .foregroundColor(.black)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Studies show that people who got daily reminders are 88% more likely to keep their new habit."),
                primaryButton: .default(Text("Create a new habit")),
                secondaryButton: .cancel(Text("Disable"), action: viewModel.continueWithoutNotifications)
            )
        }
    }
}

struct MoodReminderIntroView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = ViewModelFactory()

        MoodReminderIntroView(
            viewModel: viewModelFactory.makeMoodReminderIntroViewModel(
                next: { status in print(status) }))
    }
}
