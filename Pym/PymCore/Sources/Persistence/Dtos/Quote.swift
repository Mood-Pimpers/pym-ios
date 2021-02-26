import Foundation

public struct Quote: Identifiable {
    public let id: Int
    public let text: String
    public let author: String
    public let url: (_ width: Int, _ heigth: Int) -> URL

    public init(id: Int, text: String, author: String, url: @escaping (Int, Int) -> URL) {
        self.id = id
        self.text = text
        self.author = author
        self.url = url
    }
}
