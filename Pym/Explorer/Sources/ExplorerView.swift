import PymCore
import SwiftUI

public struct ExplorerView: View {
    @StateObject var viewModel = ExplorerViewModel()

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                let calendarBackgroundHeight: CGFloat = 425

                CalendarBackgroundLayer()
                    .frame(height: calendarBackgroundHeight)

                PymCalendarView()
                    .environmentObject(viewModel)
                    .padding(10)

                VStack {
                    Color.clear
                        .frame(height: calendarBackgroundHeight)

                    ScrollView {
                        DayJournal()
                            .environmentObject(viewModel)

                        Spacer()
                    }

                    Color.clear
                        .frame(height: 100)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .ignoresSafeArea()
        .background(Color.backgroundColor)
    }
}

struct ExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerView()
    }
}
