import PymCore
import SwiftUI
import SwiftUICharts

enum Periodicity: String, Equatable, CaseIterable {
    case weekly = "Weekly"
    case monthly = "Monthly"
}

public struct TrendIndicator: View {
    @Binding var percentage: Double

    public var body: some View {
        if percentage > 0 {
            Image.arrowUp
        } else {
            Image.arrowDown
        }
    }
}

public struct InsightsView: View {
    @State var periodicitySelection: Periodicity = .weekly
    @State var moodPercentage = 5.5

    private let leadingPadding: CGFloat = 20

    public init() {}

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .fill(Color.primaryColor)
                        .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                        .scaleEffect(1.5)
                        .offset(y: -100)
                    VStack {
                        Picker("", selection: $periodicitySelection) {
                            ForEach(Periodicity.allCases, id: \.rawValue) { value in
                                Text(value.rawValue)
                                    .tag(value)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: 200)

                        Title("Mood trend")
                            .padding(.leading, leadingPadding)

                        HStack {
                            Text("Average Mood".uppercased())
                            TrendIndicator(percentage: $moodPercentage)
                            Text(String(format: "%.0f%%", moodPercentage))
                            Spacer()
                        }
                        .padding(.leading, leadingPadding)
                        .padding(.top, -10)

                        MoodTrendLineChart(last: (0 ..< 12).map { _ in .random(in: 1 ... 5) }, current: (0 ..< 6).map { _ in .random(in: 1 ... 5) })
                            .frame(maxHeight: 200)
                            .padding(.top, -50)

                        HStack {
                            Spacer()
                            Spacer()
                            Circle()
                                .frame(width: 5, height: 5)
                            Text("current week")
                            Spacer()
                            Circle()
                                .fill(Color.lightGray)
                                .frame(width: 5, height: 5)
                            Text("last week")
                                .foregroundColor(Color.lightGray)
                            Spacer()
                            Spacer()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            Text("Charts")
        }
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}
