import PymCore
import SwiftUI

struct WelcomeView: View {
    let next: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Image.duck
            Text("Hi, I'm Pym!")
                .bold()
                .font(.title)
                .padding(8)
            Text("Your personal mood tracker.")

            Spacer()
            Button(action: next) {
                Text("Start your journey")
                    .bold()
                Spacer()
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(16)
        }
    }
}

struct OnboardingWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(next: {})
    }
}
