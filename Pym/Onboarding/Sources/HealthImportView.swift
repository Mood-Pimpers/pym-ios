import PymCore
import SwiftUI

struct HealthImportView: View {
    let next: () -> Void

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image("Pym Logo")
                    .resizable()
                    .frame(width: 64.0, height: 64.0)
                Text("+")
                Image("Health Logo")
                    .resizable()
                    .frame(width: 64.0, height: 64.0)
            }
            Text("Use Apple Health?")
                .bold()
                .font(.title)
                .padding(5)
            Text("Increase further experience by showing health mood correlations.").multilineTextAlignment(.center)

            Spacer()
            PrimaryButton(action: next) {
                Text("Allow using health data")
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

struct OnboardingImportView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            HealthImportView(next: {})
        }
    }
}
