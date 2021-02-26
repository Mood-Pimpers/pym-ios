import CoreData

public struct DataAccessController {
    public static let shared = DataAccessController()
    static var persistenceController = PersistenceController.shared

    private init() {
        if getActivities().isEmpty {
            DataAccessController.seedActivities()
        }
    }

    public func store(entry dto: MoodEntry) {
        let context = DataAccessController.persistenceController.container.viewContext
        let model = MoodEntryModel(context: context)
        model.id = dto.id
        model.date = dto.date
        model.feelings = dto.feelings
        model.rating = dto.rating
        dto.activities.forEach { activityName in
            var activity = self.getActivityBy(name: activityName)
            if activity == nil {
                activity = ActivityModel(context: context)
                activity!.name = activityName
            }
            model.addToActivities(activity!)
        }

        DataAccessController.persistenceController.saveContext()

        dto.id = model.id
    }

    public func getEntries(from startDate: Date, until endDate: Date) -> [MoodEntry] {
        let context = DataAccessController.persistenceController.container.viewContext

        let request = NSFetchRequest<MoodEntryModel>(entityName: MoodEntryModel.entityName)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)

        if let results = try? context.fetch(request) {
            return results.map { MoodEntry(from: $0) }
        } else {
            return []
        }
    }

    public func getActivities() -> [Activity] {
        let context = DataAccessController.persistenceController.container.viewContext

        let request = NSFetchRequest<ActivityModel>(entityName: ActivityModel.entityName)
        request.returnsObjectsAsFaults = false

        if let results = try? context.fetch(request) {
            return results.compactMap(\.name)
        } else {
            return []
        }
    }

    public func getEarliestEntry() -> MoodEntry? {
        let context = DataAccessController.persistenceController.container.viewContext

        let request = NSFetchRequest<MoodEntryModel>(entityName: MoodEntryModel.entityName)
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        let sortDescriptor = NSSortDescriptor(key: #keyPath(MoodEntryModel.date), ascending: true)
        request.sortDescriptors = [sortDescriptor]

        if let results = try? context.fetch(request) {
            return results.map { MoodEntry(from: $0) }.first
        } else {
            return nil
        }
    }

    private func getActivityBy(name activityName: Activity) -> ActivityModel? {
        let context = DataAccessController.persistenceController.container.viewContext

        let request = NSFetchRequest<ActivityModel>(entityName: ActivityModel.entityName)
        request.predicate = NSPredicate(format: "name = '\(activityName)'")
        request.fetchLimit = 1

        if let results = try? context.fetch(request),
           results.count == 1 {
            return results.first
        } else {
            return nil
        }
    }

    private static func seedActivities() {
        for activityName in ["work", "friends", "school", "relationship", "traveling", "food", "exercise", "weather", "hobbies", "shopping", "relaxing"] {
            let activity = ActivityModel(context: persistenceController.container.viewContext)
            activity.id = UUID()
            activity.name = activityName
        }
        persistenceController.saveContext()
    }
}

public extension DataAccessController {
    func getEntries(fromDay day: Date) -> [MoodEntry] {
        // ! force-cast justified, since nil is only returned when an unsupported date-component is passed -> day is supported.
        getEntries(from: day.beginning(of: .day)!, until: day.end(of: .day)!)
    }
}
