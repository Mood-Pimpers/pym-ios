import SwiftUI

struct MoodView: View {
    public var body: some View {
        Text("Mood")
    }
}

struct FeelingView: View {
    public var body: some View {
        Text("Feeling")
    }
}

struct ActivityView: View {
    public var body: some View {
        Text("Activity")
    }
}

public struct CheckInView: View {
    public init() {}

    public var body: some View {
        TabView {
            MoodView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Menu")
                }
            FeelingView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
                }
            ActivityView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Order")
                }
        }
        .tabViewStyle(PageTabViewStyle()) {
            Text("seas")
        }
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
