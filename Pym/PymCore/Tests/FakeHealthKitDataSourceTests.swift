@testable import PymCore
import XCTest

class FakeHealthKitDataSourceTests: XCTestCase {
    func testStoreEntryTest() throws {
        let startDate = Date().adding(.day, value: -1)
        let endDate = Date()
        let dataSource = FakeHealthKitDataSource()
        let expectedEvents = dataSource.getEvents(from: startDate, until: endDate)
        let repeatedEvents = dataSource.getEvents(from: startDate, until: endDate)

        let sortingLogic = { (lhs: ExternalEvent, rhs: ExternalEvent) -> Bool in lhs.id.uuidString < rhs.id.uuidString }

        XCTAssertEqual(expectedEvents.sorted(by: sortingLogic), repeatedEvents.sorted(by: sortingLogic))
    }
}
