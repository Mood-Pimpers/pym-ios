import PymCore
import SwiftUI

struct HealthImportView: View {
    @StateObject var viewModel = HealthImportViewModel()
    @State private var showingAlert = false
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

            Button(action: {
                showingAlert = true
            }, label: {
                Text("No thanks")
            }).foregroundColor(.black)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Are you sure?"), message: Text("Connecting with Apple Health greatly increases the accuracy of your experience."), primaryButton: .default(Text("Connect with Apple Health")), secondaryButton: .cancel(Text("Disable")))
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
