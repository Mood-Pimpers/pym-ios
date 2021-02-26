import SwiftUI

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
