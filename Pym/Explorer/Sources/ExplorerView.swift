import PymCore
import SwiftUI

public struct ExplorerView: View {
    @ObservedObject var model = CalendarModel()

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                let calendarBackgroundHeight: CGFloat = 425

                CalendarBackgroundLayer()
                    .frame(height: calendarBackgroundHeight)

                PymCalendarView()
                    .environmentObject(model)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: calendarBackgroundHeight)

                    DayJournal(of: $model.selectedDate)

                    ContentCard { alignment in
                        alignment.top(.leading) {
                            Text("top leading")
                        }

                        alignment.top {
                            Text("top center")
                        }

                        Text("centered text")

                        alignment.bottom {
                            Text("The text is at the bottom")
                        }
                    }

                    Spacer()
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
