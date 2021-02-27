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

public struct EnableTimeView: View {
    public let title: String
    @ObservedObject public var viewModel: EnableTimeViewModel

    public init(title: String, viewModel: EnableTimeViewModel) {
        self.title = title
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Toggle(title, isOn: $viewModel.isEnabled)
            if viewModel.isEnabled {
                DatePicker(title, selection: $viewModel.time, displayedComponents: .hourAndMinute)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
            }
        }
    }
}
