// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
    public static let backgroundColor = ColorAsset(name: "BackgroundColor")
    public static let blackColor = ColorAsset(name: "BlackColor")
    public static let chartNegativeColor = ColorAsset(name: "ChartNegativeColor")
    public static let chartPositiveColor = ColorAsset(name: "ChartPositiveColor")
    public static let dropShadowColor = ColorAsset(name: "DropShadowColor")
    public static let duckFinish = ImageAsset(name: "DuckFinish")
    public enum Mood {
        public static let moodBad = ImageAsset(name: "MoodBad")
        public static let moodGood = ImageAsset(name: "MoodGood")
        public static let moodGreat = ImageAsset(name: "MoodGreat")
        public static let moodModerate = ImageAsset(name: "MoodModerate")
        public static let moodPoor = ImageAsset(name: "MoodPoor")
    }

    public static let neutralLightColor = ColorAsset(name: "NeutralLightColor")
    public enum Onboarding {
        public static let duck = ImageAsset(name: "Duck")
        public static let healthLogo = ImageAsset(name: "Health Logo")
        public static let pymLogo = ImageAsset(name: "Pym Logo")
    }

    public static let primaryColor = ColorAsset(name: "PrimaryColor")
    public enum TabBar {
        public static let add = ImageAsset(name: "Add")
        public static let explorer = ImageAsset(name: "Explorer")
        public static let home = ImageAsset(name: "Home")
        public static let insights = ImageAsset(name: "Insights")
        public static let settings = ImageAsset(name: "Settings")
    }

    public static let whiteColor = ColorAsset(name: "WhiteColor")
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
    public fileprivate(set) var name: String

    #if os(macOS)
        public typealias Color = NSColor
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias Color = UIColor
    #endif

    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    public private(set) lazy var color: Color = {
        guard let color = Color(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()

    fileprivate init(name: String) {
        self.name = name
    }
}

public extension ColorAsset.Color {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    convenience init?(asset: ColorAsset) {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            self.init(named: NSColor.Name(asset.name), bundle: bundle)
        #elseif os(watchOS)
            self.init(named: asset.name)
        #endif
    }
}

public struct ImageAsset {
    public fileprivate(set) var name: String

    #if os(macOS)
        public typealias Image = NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        public typealias Image = UIImage
    #endif

    public var image: Image {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            let image = Image(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            let name = NSImage.Name(self.name)
            let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
            let image = Image(named: name)
        #endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
}

public extension ImageAsset.Image {
    @available(macOS, deprecated,
               message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
    convenience init?(asset: ImageAsset) {
        #if os(iOS) || os(tvOS)
            let bundle = BundleToken.bundle
            self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            self.init(named: NSImage.Name(asset.name))
        #elseif os(watchOS)
            self.init(named: asset.name)
        #endif
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}

// swiftlint:enable convenience_type
