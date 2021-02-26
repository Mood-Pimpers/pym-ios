import CoreData
@testable import PymCore
import XCTest

class ModelTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFeelingArrayResolve1() throws {
        let entry = MoodEntryModel(context: PersistenceController.preview.container.viewContext)

        entry.feelingsValue = 30
        let expectedFeelings: Set<Feeling> = [.upset, .irritated, .clear, .curious]
        let actualFeelings = entry.feelings
        XCTAssertEqual(expectedFeelings.count, actualFeelings.count)
        XCTAssertEqual(expectedFeelings.sorted(), actualFeelings.sorted())
    }

    func testFeelingArrayResolve2() throws {
        let entry = MoodEntryModel(context: PersistenceController.preview.container.viewContext)

        let expectedFeelings: Set<Feeling> = [.angry, .enthusiastic, .worried, .irritated]
        entry.feelings = expectedFeelings
        let actualFeelings = entry.feelings

        XCTAssertEqual(expectedFeelings.count, actualFeelings.count)
        XCTAssertEqual(expectedFeelings.sorted(), actualFeelings.sorted())
    }

    func testRatingResolve() throws {
        let entry = MoodEntryModel(context: PersistenceController.preview.container.viewContext)

        for expectedRating in [MoodRating.bad, MoodRating.good, MoodRating.great, MoodRating.moderate, MoodRating.poor] {
            entry.rating = expectedRating
            XCTAssertEqual(expectedRating.rawValue, entry.ratingValue)
            XCTAssertEqual(expectedRating, entry.rating)
        }
    }
}
