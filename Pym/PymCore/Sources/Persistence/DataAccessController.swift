import CoreData

public typealias ChangeListener = (Date) -> Void

public struct DataAccessController {
    public static var shared = DataAccessController()
    static var persistenceController = PersistenceController.shared

    private var changeListeners: [ChangeListener] = []

    private init() {
        if getActivities().isEmpty {
            DataAccessController.seedActivities()
        }
    }

    public func store(entry dto: MoodEntry) {
        let context = DataAccessController.persistenceController.container.viewContext
        let model = MoodEntryModel(context: context)
        model.id = dto.id
        model.date = dto.timestamp
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

        for listener in changeListeners {
            listener(dto.timestamp)
        }
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

    @discardableResult
    public func deleteAllEntries() -> Bool {
        let context = DataAccessController.persistenceController.container.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: MoodEntryModel.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            return true
        } catch {
            return false
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

    public func getQuotes() -> [Quote] {
        [
            Quote(
                id: 1,
                text: "Be yourself; everyone else is already taken.",
                author: "Oscar Wilde",
                url: { width, height in URL(string: "https://images.unsplash.com/photo-1540206395-68808572332f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
            ),
            Quote(
                id: 2,
                text: "Life is what happens when you’re busy making other plans.",
                author: "John Lennon",
                url: { width, height in URL(string: "https://images.unsplash.com/photo-1446329813274-7c9036bd9a1f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
            ),
            Quote(
                id: 3,
                text: "This is a really long quote, that doesn't make any sense but I just wanted to test it!",
                author: "Daniel Bauer",
                url: { width, height in URL(string: "https://images.unsplash.com/photo-1470770903676-69b98201ea1c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
            ),
            Quote(
                id: 4,
                text: "White photo to see that fade ;)",
                author: "Daniel Bauer",
                url: { width, height in URL(string: "https://images.unsplash.com/photo-1543751737-d7cf492060cd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=\(width)&h=\(height)&q=80")! }
            )
        ]
    }

    public mutating func addChangeListener(_ changeListener: @escaping ChangeListener) {
        changeListeners.append(changeListener)
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
