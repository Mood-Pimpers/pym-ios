import PymCore
import SwiftUI

struct DayJournal: View {
    @EnvironmentObject var viewModel: ExplorerViewModel

    var body: some View {
        if let date = viewModel.selectedDate,
           !viewModel.getMoodRatingsFor(day: date).isEmpty {
            let incidents = viewModel.getIncidents(forDay: date)
                .sorted { $0.timestamp < $1.timestamp }
            ZStack {
                VStack {
                    ForEach(incidents) {
                        IncidentView(incident: $0)
                            .padding([.horizontal], 15)
                    }
                }
            }
        }
    }
}

struct DayJournal_Previews: PreviewProvider {
    static let viewModel = ExplorerViewModel()

    static var previews: some View {
        GeometryReader { geometry in
            DayJournal()
                .environmentObject(viewModel)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.backgroundColor)
        }
    }
}
