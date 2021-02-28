import PymCore
import SwiftUI
import SwiftUICharts

public struct TrendIndicator: View {
    @Binding var percentage: Double

    public var body: some View {
        if percentage > 0 {
            Image.arrowUp
        } else if percentage == 0 {
            Circle()
                .fill(Color.lightGray)
                .frame(width: 5, height: 5)
        } else {
            Image.arrowDown
        }
    }
}

public struct InsightsView: View {
    @ObservedObject var viewModel = InsightsViewModel()

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
                            TrendIndicator(percentage: $viewModel.moodPercentage)
                            Text(String(format: "%.0f%%", viewModel.moodPercentage))
                            Spacer()
                        }
                        .padding(.leading, leadingPadding)
                        .padding(.top, -10)

                        MoodTrendLineChart(last: $viewModel.lastWeekMoodEntries, current: $viewModel.currentWeekMoodEntries)
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
                        .padding(.top, 10)

                        ContentCard { alignment in
                            alignment.top(.leading) {
                                Text(viewModel.dateTitle)
                                    .contentCardTitle()
                            }

                            alignment.bottom(.leading) {
                                HStack(spacing: 10) {
                                    Text(viewModel.formattedStartWeekDate)
                                    Text("-")
                                    Text(viewModel.formattedEndWeekDate)
                                }
                                .font(.system(size: 15, weight: Font.Weight.light))
                                .contentCardSubtitle()
                            }

                            alignment.center(.trailing) {
                                HStack {
                                    Button(action: viewModel.previousWeek) {
                                        Image.chevronLeft
                                    }
                                    Spacer()
                                        .frame(maxWidth: 20)
                                    Button(action: viewModel.nextWeek) {
                                        Image.chevronRight
                                    }.disabled(viewModel.nextWeekDisabled)
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
            MoodCorrelationBarChart(positiveCorrelationData: $viewModel.positiveCorrelationValues, negativeCorrelationData: $viewModel.negativeCorrelationValues)
            Spacer().frame(maxHeight: 120)
        }
        .transition(.opacity)
        .onAppear {
            viewModel.calculateDates()
        }
    }
}

struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}
