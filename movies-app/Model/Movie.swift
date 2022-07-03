//
//  Movie.swift
//  movies-app
//
//  Created by training on 30-06-22.
//

import Foundation

struct Movie: Hashable {

    var name: String
    var image: String
    var favorite: Bool
    var releaseDate: String
    var synopsis: String
    var genreIDS: [Int] = []

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.name == rhs.name
    }
}
