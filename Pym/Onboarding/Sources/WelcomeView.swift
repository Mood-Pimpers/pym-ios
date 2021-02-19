import PymCore
import SwiftUI

struct WelcomeView: View {
    let next: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Image("Duck")
            Text("Hi, I'm Pym!")
                .bold()
                .font(.title)
                .padding(5)
            Text("Your personal mood tracker.")

            Spacer()
            PrimaryButton(action: next) {
                Text("Start your journey")
                    .bold()
                Spacer()
            }
            .padding(16)
        }
    }
}

struct OnboardingWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(next: {})
    }
}
