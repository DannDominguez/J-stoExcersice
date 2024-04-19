// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let usersModel = try? JSONDecoder().decode(UsersModel.self, from: jsonData)

import Foundation

// MARK: - UsersModel
struct UsersModel: Codable {
    let results: [UserResult]?
    let info: Info
}

// MARK: - Info
struct Info: Codable, Hashable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct UserResult: Codable {
    let gender: String?
    let name: UserName?
    let location: Location?
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID?
    let picture: Picture
    let nat: String
}

// MARK: - Dob
struct Dob: Codable, Hashable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable, Hashable {
    let name, value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state, country: String
    let postcode: PostcodeValue
    let coordinates: Coordinates
    let timezone: Timezone
}

enum PostcodeValue: Codable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(PostcodeValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unexpected type for postcode"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let intValue):
            try container.encode(intValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}
// MARK: - Coordinates
struct Coordinates: Codable, Hashable {
    let latitude, longitude: String
}

// MARK: - Street
struct Street: Codable, Hashable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable, Hashable {
    let offset, description: String
}

// MARK: - Login
struct Login: Codable, Hashable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct UserName: Codable, Hashable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable, Hashable {
    let large, medium, thumbnail: String
}

