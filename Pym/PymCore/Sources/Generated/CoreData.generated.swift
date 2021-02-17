// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable superfluous_disable_command implicit_return
// swiftlint:disable sorted_imports
import CoreData
import Foundation

// swiftlint:disable attributes file_length vertical_whitespace_closing_braces
// swiftlint:disable identifier_name line_length type_body_length

// MARK: - Activity

public class Activity: NSManagedObject {
    public class var entityName: String {
        "Activity"
    }

    public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
    }

    @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        NSFetchRequest<Activity>(entityName: entityName)
    }

    @nonobjc public class func makeFetchRequest() -> NSFetchRequest<Activity> {
        NSFetchRequest<Activity>(entityName: entityName)
    }

    // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var entries: Set<MoodEntry>?
    // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Entries

public extension Activity {
    @objc(addEntriesObject:)
    @NSManaged func addToEntries(_ value: MoodEntry)

    @objc(removeEntriesObject:)
    @NSManaged func removeFromEntries(_ value: MoodEntry)

    @objc(addEntries:)
    @NSManaged func addToEntries(_ values: Set<MoodEntry>)

    @objc(removeEntries:)
    @NSManaged func removeFromEntries(_ values: Set<MoodEntry>)
}

// MARK: - MoodEntry

public class MoodEntry: NSManagedObject {
    public class var entityName: String {
        "MoodEntry"
    }

    public class func entity(in managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
    }

    @available(*, deprecated, renamed: "makeFetchRequest", message: "To avoid collisions with the less concrete method in `NSManagedObject`, please use `makeFetchRequest()` instead.")
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodEntry> {
        NSFetchRequest<MoodEntry>(entityName: entityName)
    }

    @nonobjc public class func makeFetchRequest() -> NSFetchRequest<MoodEntry> {
        NSFetchRequest<MoodEntry>(entityName: entityName)
    }

    // swiftlint:disable discouraged_optional_boolean discouraged_optional_collection
    @NSManaged public var date: Date
    @NSManaged public var feelingsValue: Int16
    @NSManaged public var id: UUID
    @NSManaged public var ratingValue: Int16
    @NSManaged public var activities: Set<Activity>
    // swiftlint:enable discouraged_optional_boolean discouraged_optional_collection
}

// MARK: Relationship Activities

public extension MoodEntry {
    @objc(addActivitiesObject:)
    @NSManaged func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged func addToActivities(_ values: Set<Activity>)

    @objc(removeActivities:)
    @NSManaged func removeFromActivities(_ values: Set<Activity>)
}

// swiftlint:enable identifier_name line_length type_body_length
