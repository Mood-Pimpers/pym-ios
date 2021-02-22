import PymCore
import SwiftUI

public struct MoodView: View {
    @StateObject var viewRouter: CheckInViewRouter
    @State private var mood: Int?

    public var body: some View {
        VStack {
            Title("How are you feeling?")
            HStack {
                ForEach(1 ..< 6) { index in
                    SelectableElement(
                        isSelected: mood == index,
                        content: { Text("\(index)") },
                        action: { mood = index }
                    )
                }
            }

            Spacer()

            Button(action: next, label: {
                Text("continue")
                    .bold()
                Spacer()
                Image(systemName: "arrow.right")
            })
                .buttonStyle(PrimaryButtonStyle())
                .disabled(mood == nil)
                .padding(16)
        }
        .padding(16)
    }

    private func next() {
        viewRouter.currentPage = .feeling
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView(viewRouter: CheckInViewRouter())
    }
}
