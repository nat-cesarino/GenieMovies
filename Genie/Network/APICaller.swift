//
//  APICaller.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 06/12/22.
//

import Foundation

enum APIError: Error {
    case failedToGetData
    case failedToGetRequestToken
    case failedToValidateLogin
    case failedToCreateSessionId
    case failedToGetFavoriteMovies
    case failedToMarkFavorite
    case failedToGetAccountDetails
}

class APICaller {
    
    static let shared = APICaller()
    static let tmdbApiKey = "21b6645187b681d20c7cec8d277555b7"
    
    enum Endpoints {
        static let tmdbBaseUrl = "https://api.themoviedb.org/3/"
        static let apiKeyParam = "?api_key=\(APICaller.tmdbApiKey)"
        
        // General requests
        case getTrendingMovies
        case getTrendingTv
        case getUpcomingMovies
        case getPopularMovies
        case getTopRatedMovies
        case getNowPlayingMovies
        case search(String)
        
        var stringValue: String {
            switch self {
            case .getTrendingMovies: return Endpoints.tmdbBaseUrl + "trending/movie/day" + Endpoints.apiKeyParam
            case .getTrendingTv: return Endpoints.tmdbBaseUrl + "trending/tv/day" + Endpoints.apiKeyParam
            case .getUpcomingMovies: return Endpoints.tmdbBaseUrl + "movie/upcoming" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .getPopularMovies: return Endpoints.tmdbBaseUrl + "movie/popular" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .getTopRatedMovies: return Endpoints.tmdbBaseUrl + "movie/top_rated" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .getNowPlayingMovies: return Endpoints.tmdbBaseUrl + "movie/now_playing" + Endpoints.apiKeyParam + "&language=en-US&page=1"
            case .search(let query): return Endpoints.tmdbBaseUrl + "search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }

    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.getTrendingMovies.url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(results.results))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.failedToGetData))
                }
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.getTrendingTv.url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.getUpcomingMovies.url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.getPopularMovies.url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.getTopRatedMovies.url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getNowPlayingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.getNowPlayingMovies.url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func search(query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: Endpoints.search(query).url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
