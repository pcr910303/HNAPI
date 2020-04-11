import Foundation

class Comment: Decodable {
    enum Color: String, CaseIterable {
        case c00
        case c5a
        case c73
        case c82
        case c88
        case c9c
        case cae
        case cbe
        case cce
        case cdd
    }

    // MARK: - Properties

    var id: Int
    var creation: Date
    var author: String
    var text: String
    var color: Color = .c00
    var children: [Comment]

    // MARK: - Decodable

    enum CodingKeys: String, CodingKey {
        case id
        case creation = "created_at_i"
        case author
        case text
        case children
    }

    required init(
        from decoder: Decoder
    ) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        creation = try container.decode(Date.self, forKey: .creation)
        do {
            text = try container.decode(String.self, forKey: .text)
            author = try container.decode(String.self, forKey: .author)
        } catch {
            // FIXME: Remove workaround of deleted comments
            text = ""
            author = ""
        }
        children = try container.decode([Comment].self, forKey: .children)
    }
}