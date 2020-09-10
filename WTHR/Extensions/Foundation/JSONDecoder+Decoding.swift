//
//  JSONDecoder+Decoding.swift
//  WTHR
//
//  Created by Гена Книжник on 26.05.2020.
//  Copyright © 2020 Hena. All rights reserved.
//

import Foundation

// MARK: - Safe Decoding

struct Safe<T: Decodable>: Decodable {
    
    let value: T?

    // MARK: Init
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            value = try container.decode(T.self)
        } catch {
            value = nil
        }
    }
    
}

// MARK: - KeyedDecodingContainer

extension KeyedDecodingContainer {
    
    // MARK: Object Decoding
    
    func decode<T: Decodable>(forKey key: Key, as type: T.Type = T.self) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
    func decodeIfPresent<T: Decodable>(forKey key: Key, as type: T.Type = T.self) throws -> T? {
        return try self.decodeIfPresent(T.self, forKey: key)
    }

    func decodeSafely<T: Decodable>(_ type: T.Type = T.self, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = try? decode(Safe<T>.self, forKey: key)
        return decoded?.value
    }

    func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type = T.self, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = try? decodeIfPresent(Safe<T>.self, forKey: key)
        return decoded?.value
    }
    
    // MARK: Array Decoding
    
    func decodeSafelyArray<T: Decodable>(of type: T.Type = T.self, forKey key: KeyedDecodingContainer.Key) -> [T] {
        let array = decodeSafely([Safe<T>].self, forKey: key)
        return array?.compactMap { $0.value } ?? []
    }
    
    func decodeSafelyNotEmptyArray<T: Decodable>(of type: T.Type = T.self, forKey key: KeyedDecodingContainer.Key) throws -> [T] {
        let array = decodeSafely([Safe<T>].self, forKey: key)
        let values = array?.compactMap { $0.value }
        if let valueArray = values, !valueArray.isEmpty {
            return valueArray
        }
        throw DecodingError.valueNotFound(T.self, DecodingError.Context(codingPath: [key], debugDescription: "Value not found at root level."))
    }
    
}

// MARK: - JSONDecoder

extension JSONDecoder {
    
    // MARK: Array Decoding
    
    func decodeSafelyArray<T: Decodable>(of type: T.Type, from data: Data) -> [T] {
        guard let array = try? decode([Safe<T>].self, from: data) else { return [] }
        return array.compactMap { $0.value }
    }
    
}
