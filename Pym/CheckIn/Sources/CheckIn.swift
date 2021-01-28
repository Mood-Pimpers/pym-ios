//
//  CheckIn.swift
//  CheckIn
//
//  Created by Daniel Bauer on 21.12.20.
//

import PymCore
import SwiftUI

public struct MoodView: View {
    @StateObject var viewRouter: ViewRouter

    public var body: some View {
        VStack {
            Text("MOOD")
            Spacer()

            PrimaryButton(action: next) {
                Text("continue")
                    .bold()
                Spacer()
            }
            .padding(16)
        }
    }

    private func next() {
        viewRouter.currentPage = .feeling
    }
}

struct FeelingView: View {
    @StateObject var viewRouter: ViewRouter

    public var body: some View {
        VStack {
            Text("FEELING")
            Spacer()

            PrimaryButton(action: next) {
                Text("continue")
                    .bold()
                Spacer()
            }
            .padding(16)
        }
    }

    private func next() {
        viewRouter.currentPage = .activity
    }
}

struct ActivityView: View {
    @Environment(\.presentationMode) var presentationMode

    public var body: some View {
        VStack {
            Text("ACTIVITY")
            Spacer()

            PrimaryButton(action: finish) {
                Text("finish")
                    .bold()
                Spacer()
            }
            .padding(16)
        }
    }

    private func finish() {
        presentationMode.wrappedValue.dismiss()
    }
}

enum Test {
    case mood
    case feeling
    case activity
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Test = .mood
}

public struct CheckInView: View {
    // @State private var current: Test = .mood
    @StateObject var viewRouter = ViewRouter()

    public init() {}

    public var body: some View {
        VStack {
            HStack(spacing: 8) {
                (viewRouter.currentPage == .mood ? Color.primaryColor : Color.neutralLightColor)
                    .cornerRadius(4)

                (viewRouter.currentPage == .feeling ? Color.primaryColor : Color.neutralLightColor)
                    .cornerRadius(4)

                (viewRouter.currentPage == .activity ? Color.primaryColor : Color.neutralLightColor)
                    .cornerRadius(4)
            }
            .frame(maxWidth: .infinity, maxHeight: 8.0)
            .padding(8)

            Spacer()
            switch viewRouter.currentPage {
            case .mood: MoodView(viewRouter: viewRouter)
            case .feeling: FeelingView(viewRouter: viewRouter)
            case .activity: ActivityView()
            }
            Spacer()
        }
    }
}

#if DEBUG
    struct CheckInView_Previews: PreviewProvider {
        static var previews: some View {
            CheckInView()
        }
    }
#endif
