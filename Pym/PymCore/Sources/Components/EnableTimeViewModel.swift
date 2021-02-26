import SwiftUI

public class EnableTimeViewModel: ObservableObject {
    public var onChange: (() -> Void)?

    @Published public var isEnabled: Bool {
        didSet { callOnChange() }
    }

    @Published public var time: Date {
        didSet { callOnChange() }
    }

    public init(isEnabled: Bool, notifyOn time: Date) {
        self.isEnabled = isEnabled
        self.time = time
    }

    private func callOnChange() {
        if let onChange = onChange {
            onChange()
        }
    }
}
