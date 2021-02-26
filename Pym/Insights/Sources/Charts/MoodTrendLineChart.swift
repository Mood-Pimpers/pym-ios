import PymCore
import SwiftUI
import SwiftUICharts

enum Weekday: Int, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday

    var shortLabel: String {
        switch self {
        case .monday: return "M"
        case .tuesday: return "T"
        case .wednesday: return "W"
        case .thursday: return "T"
        case .friday: return "F"
        case .saturday: return "S"
        case .sunday: return "S"
        }
    }
}

struct MoodTrendLineChart: View {
    private let lastGradientColors = GradientColor(start: Color.grayGradientStart, end: Color.grayGradientEnd)
    private let currentGradientColors = GradientColor(start: Color.blackGradientStart, end: Color.blackGradientEnd)

    @State var last: [Double]
    @State var current: [Double]

    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    VStack {
                        Image.moodGreat
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                        Image.moodGood
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                        Image.moodModerate
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                        Image.moodPoor
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                        Image.moodBad
                            .resizable()
                            .frame(width: 15.0, height: 15.0)
                    }
                    .padding(.top, 60)

                    MultiLineChartView(data: [
                        (last, lastGradientColors),
                        (current, currentGradientColors)
                    ],
                    title: "",
                    style: Styles.lineChartStyleOne,
                    form: CGSize(width: geometry.size.width - 70, height: 200),
                    rateValue: 5,
                    dropShadow: false, stepSize: 12)
                }
                HStack {
                    Spacer()
                    ForEach(Weekday.allCases, id: \.rawValue) { value in
                        Text(value.shortLabel)
                            .fontWeight(.bold)
                            .font(Font.system(size: 16))
                            .foregroundColor(Color.lightGray)
                        Spacer()
                    }
                }
                .padding(.top, -30)
            }.foregroundColor(Color.lightGray)
        }
    }
}

struct MoodTrendLineChart_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrendLineChart(last: (0 ..< 12).map { _ in .random(in: 1 ... 5) }, current: (0 ..< 6).map { _ in .random(in: 1 ... 5) })
    }
}
