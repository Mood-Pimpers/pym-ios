import PymCore
import SwiftUI

struct HealthImportView: View {
    @ObservedObject var viewModel: HealthImportViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image.pymLogo
                    .resizable()
                    .frame(width: 64.0, height: 64.0)
                Text("+")
                Image.healthLogo
                    .resizable()
                    .frame(width: 64.0, height: 64.0)
            }
            Text("Use Apple Health?")
                .bold()
                .font(.title)
                .padding(8)
            Text("Increase further experience by showing health mood correlations.")
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: viewModel.handleHealthKitAuthorization) {
                Text("Allow using health data")
                    .bold()
                Spacer()
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(16)
            .alert(item: $viewModel.healthKitError, content: healthKitErrorAlert)

            Button(
                action: viewModel.toggleWarning,
                label: { Text("No thanks") }
            )
            .foregroundColor(.black)
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Connecting with Apple Health greatly increases the accuracy of your experience."),
                    primaryButton: .default(Text("Connect with Apple Health")),
                    secondaryButton: .cancel(Text("Disable"), action: viewModel.next)
                )
            }
        }
    }

    private func healthKitErrorAlert(error: HealthKitError?) -> Alert {
        let errorTitle = Text("HealthKit error")
        switch error {
        case .notAvailableOnDevice:
            return Alert(
                title: errorTitle,
                message: Text("Unfortunately, HealthKit is not available on your device."),
                dismissButton: .default(Text("Ok"), action: viewModel.next)
            )
        case .dataTypeNotAvailable:
            return Alert(
                title: errorTitle,
                message: Text("Unfourtunatelly, the needed HealthKit sources are not available."),
                dismissButton: .default(Text("Ok"), action: viewModel.next)
            )
        default:
            return Alert(
                title: errorTitle,
                message: Text("Error authorizing the app. Visit settings and give permissions."),
                dismissButton: .cancel()
            )
        }
    }
}

struct OnboardingImportView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = ViewModelFactory()

        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            HealthImportView(
                viewModel: viewModelFactory.makeHealthImportViewModel(
                    next: {}))
        }
    }
}
