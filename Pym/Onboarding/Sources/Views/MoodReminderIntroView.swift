import PymCore
import SwiftUI

struct MoodReminderIntroView: View {
    @StateObject var viewModel: MoodReminderIntroViewModel
    @State private var showingAlert = false
    let next: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Image("Duck")
            Text("Should I remind you to track your mood?")
                .bold()
                .font(.title)
                .padding(5)
                .multilineTextAlignment(.center)

            Spacer()
            Button(action: next) {
                Text("Yes, of course!")
                    .bold()
                Spacer()
            }.buttonStyle(PrimaryButtonStyle())
                .padding(16)

            Button(action: {
                showingAlert = true
            }, label: {
                Text("No thanks")
            }).foregroundColor(.black)
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Are you sure?"), message: Text("Studies show that people who got daily reminders are 88% more likely to keep their new habit."), primaryButton: .default(Text("Create a new habit")), secondaryButton: .cancel(Text("Disable")))
        }
    }
}

struct MoodReminderIntroView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = ViewModelFactory()

        MoodReminderIntroView(viewModel: viewModelFactory.makeMoodReminderIntroViewModel(), next: {})
    }
}
