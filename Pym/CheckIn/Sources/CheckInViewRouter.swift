import SwiftUI

class CheckInViewRouter: ObservableObject {
    @Published var currentPage: CheckInPage = .mood
}
