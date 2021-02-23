import Foundation
import HealthKit
import PymCore
import SwiftUI

class HealthImportViewModel: ObservableObject {
    @Published var healthKitError: HealthKitError?
    private let store: HKHealthStore

    init(healthStore: HKHealthStore) {
        store = healthStore
    }

    public func authorizeHealthKit(completion: @escaping (Result<Void, Error>) -> Void) {
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
