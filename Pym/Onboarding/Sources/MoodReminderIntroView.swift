import PymCore
import SwiftUI

struct MoodReminderIntroView: View {
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
            PrimaryButton(action: next) {
                Text("Yes, of course!")
                    .bold()
                Spacer()
            }
            .padding(16)

            Button(action: {}, label: {
                Text("No thanks")
            }).foregroundColor(.black)
        }
    }
}

struct MoodReminderIntroView_Previews: PreviewProvider {
    static var previews: some View {
        MoodReminderIntroView(next: {})
    }
}
