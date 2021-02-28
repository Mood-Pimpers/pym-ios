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

    @Binding var positiveCorrelationData: ChartData
    @Binding var negativeCorrelationData: ChartData

    private let maxHeight: CGFloat = 200

    public var body: some View {
        if !positiveCorrelationData.onlyPoints().isEmpty || !negativeCorrelationData.onlyPoints().isEmpty {
            HStack {
                if !positiveCorrelationData.onlyPoints().isEmpty {
                    BarChartView(data: positiveCorrelationData, title: "", style: positiveChartStyle)
                }
                if !positiveCorrelationData.onlyPoints().isEmpty, !negativeCorrelationData.onlyPoints().isEmpty {
                    Divider()
                }
                if !negativeCorrelationData.onlyPoints().isEmpty {
                    BarChartView(data: negativeCorrelationData, title: "", style: negativeChartStyle)
                }
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
    @State static var positiveCorrelationData = ChartData(values: [("training", 5), ("weekend", 4), ("coffee", 3), ("socialize", 1)])
    @State static var negativeCorrelationData = ChartData(values: [("driving", 1), ("tired", 2), ("fasting", 3), ("university", 4)])

    static var previews: some View {
        MoodCorrelationBarChart(positiveCorrelationData: $positiveCorrelationData, negativeCorrelationData: $negativeCorrelationData)
    }
}
