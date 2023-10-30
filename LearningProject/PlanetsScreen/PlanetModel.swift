import Foundation

struct Planet: Codable {
    var name: String
    var diameter: String
    var population: String
    var films: [String]
}

struct PlanetResult: Codable {
    var count: Int
    var next: String?
    var results: [Planet]
}
