//
//  Encode+Extension.swift
//  PicFlow
//
//  Created by Lê Đình Phục on 11/10/25.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any] {
                return dictionary
            }
        } catch {
            throw NSError()
        }
        throw NSError()
    }
}


extension Decodable {
    init(fromDictionary: Any) throws {
        do {
            let decoder: JSONDecoder = JSONDecoder()
            let jsonData = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
            self = try decoder.decode(Self.self, from: jsonData)
        } catch {
            throw NSError()
        }
    }
}
