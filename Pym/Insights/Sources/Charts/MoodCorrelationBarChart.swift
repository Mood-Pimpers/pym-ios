import PymCore
import SwiftUI
import SwiftUICharts

struct MoodCorrelationBarChart: View {
    private let positiveChartStyle = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color.greenGradientStart,
        secondGradientColor: Color.greenGradientEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray
    )
    private let negativeChartStyle = ChartStyle(
        backgroundColor: Color.white,
        accentColor: Color.redGradientStart,
        secondGradientColor: Color.redGradientEnd,
        textColor: Color.black,
        legendTextColor: Color.gray,
        dropShadowColor: Color.gray
    )

    @State var positiveCorrelationData: ChartData
    @State var negativeCorrelationData: ChartData

    private let maxHeight: CGFloat = 200

    public var body: some View {
        if !positiveCorrelationData.onlyPoints().isEmpty || !negativeCorrelationData.onlyPoints().isEmpty {
            HStack {
                BarChartView(data: positiveCorrelationData, title: "", style: positiveChartStyle)
                Divider()
                BarChartView(data: negativeCorrelationData, title: "", style: negativeChartStyle)
            }
            .frame(maxHeight: maxHeight)
        } else {
            VStack {
                Image.noCorrelation
                Text("No data for this time frame")
                    .foregroundColor(Color.lightGray)
                    .padding(.top, -20)
            }
        }
    }
}

struct MoodCorrelationBarChart_Previews: PreviewProvider {
    static var previews: some View {
        MoodCorrelationBarChart(positiveCorrelationData: ChartData(values: [("training", 5), ("weekend", 4), ("coffee", 3), ("socialize", 1)]), negativeCorrelationData: ChartData(values: [("driving", 1), ("tired", 2), ("fasting", 3), ("university", 4)]))

        MoodCorrelationBarChart(positiveCorrelationData: ChartData(values: [(String, Double)]()), negativeCorrelationData: ChartData(values: [(String, Double)]()))
    }
}
