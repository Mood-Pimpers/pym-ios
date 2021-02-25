import Foundation
import HealthKit

public enum HealthKitError: Error, Identifiable {
    public var id: HealthKitError { self }

    case notAvailableOnDevice
    case dataTypeNotAvailable
    case authorizationError
}

public class HealthKitAssistant {
    public class func authorizeHealthKit(completion: @escaping (Bool, HealthKitError?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, .notAvailableOnDevice)
            return
        }

        guard
            let sleepAnalysis = HKObjectType.categoryType(forIdentifier: .sleepAnalysis),
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) != nil
        else {
            completion(false, .dataTypeNotAvailable)
            return
        }

        let shareTypes: Set<HKSampleType> = []
        let readTypes: Set<HKObjectType> = [sleepAnalysis,
                                            HKObjectType.workoutType()]

        let healthStore = HKHealthStore()
        healthStore.requestAuthorization(toShare: shareTypes,
                                         read: readTypes) { success, _ in
            guard success else {
                return completion(false, .authorizationError)
            }

            // an app cannot determine whether or not a user has granted permission to read HealthKit data
            return completion(true, nil)
        }
    }
}
