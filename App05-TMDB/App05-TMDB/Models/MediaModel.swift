//
//  MediaModel.swift
//  App05-TMDB
//
//  Created by Alumno on 27/09/21.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class MediaModel: ObservableObject {
    
    @Published var genres = [Genre]()
    @Published var moviesNowPlaying = [Media]()
    @Published var seriesNowPlaying = [Media]()
    
    init() {
        loadGenres()
        loadMoviesNowPlaying()
        // loadSeriesNowPlaying()
    }
    
    func loadGenres() {
        
        genres.removeAll()
        let URL = "\(tmdbURL)genre/movie/list?api_key=\(apikey)&language=en-US"
        
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            var genre: Genre
            
            for i in json["genres"] {
                genre = Genre(
                    id: i.1["id"].intValue,
                    name: i.1["name"].stringValue)
                self.genres.append(genre)
            }
        }
        
    }
    
    func loadMoviesNowPlaying() {
        
        genres.removeAll()
        let URL = "\(tmdbURL)/movie/now_playing?api_key=\(apikey)&language=en-US"
        
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            var movie: Media
            
            for i in json["results"] {
                movie = Media (
                    id: i.1["id"].intValue,
                    title: i.1["title"].stringValue,
                    overview: i.1["overview"].stringValue,
                    poster: i.1["poster_path"].stringValue,
                    rating: i.1["vote_average"].doubleValue,
                    genres: [],
                    releaseDate: i.1["release_date"].stringValue)
                for j in i.1["genre_ids"] {
                    if let index = self.genres.firstIndex(where: {$0.id == j.1.intValue}) {
                        movie.genres.append(self.genres[index].name)
                    }
                }
                self.moviesNowPlaying.append(movie)
            }
        }
        
    }
    
    func loadSeriesNowPlaying() {
        
        genres.removeAll()
        let URL = "\(tmdbURL)genre/movie/list?api_key=\(apikey)&language=en-US"
        
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            var genre: Genre
            
            for i in json["genres"] {
                genre = Genre(
                    id: i.1["id"].intValue,
                    name: i.1["name"].stringValue)
                self.genres.append(genre)
            }
        }
        
    }
    
    func loadMoviePosters(id: Int, handler: @escaping(_ returnedImages: [String]) -> ()) {
        
        let URL = "\(tmdbURL)/movie/\(id)/images?api_key=\(apikey)"
        
        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            var images = [String]()
            
            for i in json["posters"] {
                if(i.1["width"].intValue == 2000) {
                    images.append(i.1["file_path"].stringValue)
                }
            }
            
            handler(images)
        }
    }
    
    func loadMovieTrailers(id: Int, handler: @escaping(_ returnedTrailers: [Trailer]) -> ()) {
        
        let URL = "\(tmdbURL)/movie/\(id)/videos?api_key=\(apikey)&language=en-US"

        AF.request(URL, method: .get, encoding: URLEncoding.default, headers: HTTPHeaders(headers)).responseData { data in
            
            let json = try! JSON(data: data.data!)
            
            var trailers = [Trailer]()
            var trailer: Trailer
            
            for i in json["results"] {
                trailer = Trailer(
                    id: i.1["id"].stringValue,
                    name: i.1["name"].stringValue,
                    key: i.1["id"].stringValue,
                    type: i.1["type"].stringValue
                )
                trailers.append(trailer)
            }
            trailers.sort(by: {$0.type > $1.type})
            handler(trailers)
        }
        
    }
    
}
