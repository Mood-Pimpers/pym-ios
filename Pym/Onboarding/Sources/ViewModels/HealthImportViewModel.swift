import Foundation
import HealthKit
import PymCore
import SwiftUI

class HealthImportViewModel: ObservableObject {
    private let store: HKHealthStore
    let next: () -> Void

    @Published var healthKitError: HealthKitError?
    @Published var showingAlert = false

    init(
        healthStore: HKHealthStore,
        next: @escaping () -> Void
    ) {
        store = healthStore
        self.next = next
    }

    func toggleWarning() {
        showingAlert = true
    }

    func handleHealthKitAuthorization() {
        authorizeHealthKit { result in
            switch result {
            case .success: self.next()
            default: break
            }
        }
    }

    private func authorizeHealthKit(completion: @escaping (Result<Void, Error>) -> Void) {
        HealthKitAssistant.authorizeHealthKit { [weak self] authorized, error in
            guard authorized else {
                guard let self = self else { return }
                if let error = error {
                    completion(.failure(error))
                    DispatchQueue.main.async {
                        self.healthKitError = error
                    }
                } else {
                    print("HealthKit authorization failed")
                }
                return
            }

            completion(.success(()))
            print("HealthKit authorization successful")
        }
    }
}
