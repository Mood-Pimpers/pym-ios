import Foundation
import HealthKit

class ViewModelFactory {
    let healthStore = HKHealthStore()

    func makeHealthImportViewModel() -> HealthImportViewModel {
        HealthImportViewModel(healthStore: healthStore)
    }

    func makeMoodReminderIntroViewModel() -> MoodReminderIntroViewModel {
        MoodReminderIntroViewModel()
    }
}
