//
//  Title.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 07/12/22.
//

import Foundation

struct TitlesResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Equatable {
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
    
}


//adult = 0;
//"backdrop_path" = "/53BC9F2tpZnsGno2cLhzvGprDYS.jpg";
//"genre_ids" =             (
//    14,
//    28,
//    12
//);
//id = 736526;
//"media_type" = movie;
//"original_language" = no;
//"original_title" = Troll;
//overview = "Deep inside the mountain of Dovre, something gigantic awakens after being trapped for a thousand years. Destroying everything in its path, the creature is fast approaching the capital of Norway. But how do you stop something you thought only existed in Norwegian folklore?";
//popularity = "1101.705";
//"poster_path" = "/9z4jRr43JdtU66P0iy8h18OyLql.jpg";
//"release_date" = "2022-12-01";
//title = Troll;
//video = 0;
//"vote_average" = "6.9";
//"vote_count" = 359;
