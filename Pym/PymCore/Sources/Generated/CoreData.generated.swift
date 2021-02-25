// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable superfluous_disable_command implicit_return
// swiftlint:disable sorted_imports
import CoreData
import Foundation

// swiftlint:disable attributes file_length vertical_whitespace_closing_braces
// swiftlint:disable identifier_name line_length type_body_length

// MARK: - ActivityModel

public class ActivityModel: NSManagedObject {
    public class var entityName: String {
        "ActivityModel"
    }

    public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
    }

    @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityModel> {
        NSFetchRequest<ActivityModel>(entityName: entityName)
    }

    @nonobjc public class func makeFetchRequest() -> NSFetchRequest<ActivityModel> {
        NSFetchRequest<ActivityModel>(entityName: entityName)
    }

    // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var entries: Set<MoodEntryModel>?
    // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Entries

public extension ActivityModel {
    @objc(addEntriesObject:)
    @NSManaged func addToEntries(_ value: MoodEntryModel)

    @objc(removeEntriesObject:)
    @NSManaged func removeFromEntries(_ value: MoodEntryModel)

    @objc(addEntries:)
    @NSManaged func addToEntries(_ values: Set<MoodEntryModel>)

    @objc(removeEntries:)
    @NSManaged func removeFromEntries(_ values: Set<MoodEntryModel>)
}

// MARK: - MoodEntryModel

public class MoodEntryModel: NSManagedObject {
    public class var entityName: String {
        "MoodEntryModel"
    }

    public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
    }

    @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodEntryModel> {
        NSFetchRequest<MoodEntryModel>(entityName: entityName)
    }

    @nonobjc public class func makeFetchRequest() -> NSFetchRequest<MoodEntryModel> {
        NSFetchRequest<MoodEntryModel>(entityName: entityName)
    }

    // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
    @NSManaged public var date: Date
    @NSManaged public var feelingsValue: Int32
    @NSManaged public var id: UUID
    @NSManaged public var ratingValue: Int16
    @NSManaged public var activities: Set<ActivityModel>
    // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Activities

public extension MoodEntryModel {
    @objc(addActivitiesObject:)
    @NSManaged func addToActivities(_ value: ActivityModel)

    @objc(removeActivitiesObject:)
    @NSManaged func removeFromActivities(_ value: ActivityModel)

    @objc(addActivities:)
    @NSManaged func addToActivities(_ values: Set<ActivityModel>)

    @objc(removeActivities:)
    @NSManaged func removeFromActivities(_ values: Set<ActivityModel>)
}

// swiftlint:enable identifier_name line_length type_body_length
