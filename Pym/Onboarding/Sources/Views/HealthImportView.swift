import PymCore
import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct HealthImportView: View {
    @ObservedObject var viewModel: HealthImportViewModel
    @State private var showingAlert = false
    let next: () -> Void

    private func handleHealthKitAuthorization() {
        viewModel.authorizeHealthKit { result in
            switch result {
            case .success:
                next()
            default:
                break
            }
        }
    }

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

            Button(action: handleHealthKitAuthorization) {
                Text("Allow using health data")
                    .bold()
                Spacer()
            }.buttonStyle(PrimaryButtonStyle())
                .padding(16)
                .alert(item: $viewModel.healthKitError) { error in
                    let errorTitle = Text("HealthKit error")
                    switch error {
                    case .notAvailableOnDevice:
                        return Alert(title: errorTitle, message: Text("Unfortunately, HealthKit is not available on your device."), dismissButton: .default(Text("Ok")) {
                            next()
                        })
                    case .dataTypeNotAvailable:
                        return Alert(title: errorTitle, message: Text("Unfourtunatelly, the needed HealthKit sources are not available."), dismissButton: .default(Text("Ok")) {
                            next()
                        })
                    default:
                        return Alert(title: errorTitle, message: Text("Error authorizing the app. Visit settings and give permissions."), dismissButton: .cancel())
                    }
                }

            Button(action: {
                showingAlert = true
            }, label: {
                Text("No thanks")
            })
                .foregroundColor(.black)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Are you sure?"), message: Text("Connecting with Apple Health greatly increases the accuracy of your experience."), primaryButton: .default(Text("Connect with Apple Health")), secondaryButton: .cancel(Text("Disable"), action: next))
                }
        }
    }
}

struct OnboardingImportView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory = ViewModelFactory()

        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            HealthImportView(viewModel: viewModelFactory.makeHealthImportViewModel(), next: {})
        }
    }
}
