import PymCore
import SwiftUI
import SwiftUICharts

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
    @State var moodPercentage = 5.5

    private let leadingPadding: CGFloat = 20
    private let titleTopPadding: CGFloat = 50

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
                        Title("Mood trend")
                            .padding(.leading, leadingPadding)
                            .padding(.top, titleTopPadding)

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

                        ContentCard { alignment in
                            alignment.top(.leading) {
                                Text("CURRENT WEEK")
                                    .font(.system(size: 20, weight: Font.Weight.bold))
                                    .padding([.top, .leading], 10)
                            }

                            alignment.bottom(.leading) {
                                HStack(spacing: 15) {
                                    Text("25. JAN")
                                        .font(.system(size: 15, weight: Font.Weight.light))
                                    Text("-")
                                        .font(.system(size: 15, weight: Font.Weight.light))
                                    Text("31. JAN")
                                        .font(.system(size: 15, weight: Font.Weight.light))
                                }
                                .padding([.bottom, .leading], 10)
                            }

                            alignment.center(.trailing) {
                                HStack {
                                    Image.chevronLeft
                                    Spacer()
                                        .frame(maxWidth: 20)
                                    Image.chevronRight
                                }
                                .padding([.trailing], 20)
                            }
                        }
                        .neomorph()
                        .padding([.leading, .trailing], 30)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            MoodCorrelationBarChart(positiveCorrelationData: ChartData(values: [("training", 5), ("weekend", 4), ("coffee", 3), ("socialize", 1)]), negativeCorrelationData: ChartData(values: [("driving", 1), ("tired", 2), ("fasting", 3), ("university", 4)]))
            Spacer().frame(maxHeight: 100)
        }
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}
