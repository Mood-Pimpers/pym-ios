import SwiftUI

public class ModalService: ObservableObject {
    public static let shared = ModalService()

    @Published public var showMoodCheckin = false

    private init() {}

    public func toggleMoodCheckin() {
        showMoodCheckin.toggle()
    }
}
