import PymCore
import SwiftUI

public struct ExplorerView: View {
    @ObservedObject var model = CalendarModel()

    public init() {}

    public var body: some View {
//        VStack(alignment: .center) {
        //            VStack(alignment: .leading) {
//            ////                Text("Data Explorer")
//            ////                    .fontWeight(.bold)
//            ////                    .font(.system(size: 30))
//            ////                    .padding([.top, .leading], 15)
        //
        //                PymCalendarView()
        //                    .environmentObject(model)
        //            }
//            PymCalendarView()
//                .environmentObject(model)
        //                .padding(.bottom, -40)
//                .background(Color.primaryColor)
//                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
//
//            DayJournal(of: $model.selectedDate)
//        }

        GeometryReader { geometry in
            ZStack(alignment: .top) {
                let calendarBackgroundHeight: CGFloat = 425

                CalendarBackgroundLayer()
                    .frame(height: calendarBackgroundHeight)

                PymCalendarView()
                    .environmentObject(model)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .ignoresSafeArea()
    }
}

struct ExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorerView()
    }
}
