@testable import PymCore
import XCTest

class DataAccessControllerTests: XCTestCase {
    override func setUpWithError() throws {
        DataAccessController.persistenceController = PersistenceController.preview
    }

    override func tearDownWithError() throws {}

    func testStoreEntryTest() throws {
        let exptectedEntry = MoodEntry(date: Date(), rating: .bad, feelings: [.angry, .confused], activities: ["tennis", "programming", "work"])
        DataAccessController.shared.store(entry: exptectedEntry)

        let actualEntries = DataAccessController.shared.getEntries(from: Date() - 10 * 60, until: Date() + 10 * 60)
        XCTAssertEqual(1, actualEntries.count)

        let actualEntry = actualEntries.first
        XCTAssertNotNil(actualEntry)
        XCTAssertEqual(exptectedEntry.activities.sorted(), actualEntry?.activities.sorted())
        XCTAssertEqual(exptectedEntry.date, actualEntry?.date)
        XCTAssertEqual(exptectedEntry.feelings.sorted(), actualEntry?.feelings.sorted())
        XCTAssertEqual(exptectedEntry.id, actualEntry?.id)
        XCTAssertEqual(exptectedEntry.rating, actualEntry?.rating)
    }

    func testActivitiesSeed() throws {
        let activities = DataAccessController.shared.getActivities()
        XCTAssertLessThan(0, activities.count)
    }

    func testGetEarliestEntryDate() throws {
        let boundary = 10
        for index in 1 ... boundary {
            let date = Date().adding(.month, value: -index)
            DataAccessController.shared.store(entry: MoodEntry(date: date, rating: MoodRating.allCases.randomElement()!, feelings: Set<Feeling>(), activities: Set<Activity>()))
        }

        let expectedEarliestDate = Date().adding(.month, value: -boundary)

        let earliestEntry = DataAccessController.shared.getEarliestEntry()
        XCTAssertNotNil(earliestEntry)

        let actualEarliestDate = earliestEntry!.date
        XCTAssertEqual(expectedEarliestDate.era, actualEarliestDate.era)
        XCTAssertEqual(expectedEarliestDate.year, actualEarliestDate.year)
        XCTAssertEqual(expectedEarliestDate.month, actualEarliestDate.month)
        XCTAssertEqual(expectedEarliestDate.day, actualEarliestDate.day)
    }
}
