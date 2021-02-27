import PymCore
import SwiftUI

public struct ExplorerView: View {
    @ObservedObject var viewModel = ExplorerViewModel()

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                let calendarBackgroundHeight: CGFloat = 460

                CalendarBackgroundLayer()
                    .frame(height: calendarBackgroundHeight)

                PymCalendarView()
                    .environmentObject(viewModel)
                    .padding(10)

                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: calendarBackgroundHeight)

                    ScrollView {
                        DayJournal()
                            .environmentObject(viewModel)

                        Spacer()
                    }

                    Rectangle()
                        .foregroundColor(.clear)
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
