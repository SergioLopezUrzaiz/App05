//
//  TMDBLogin.swift
//  App05-TMDB
//
//  Created by Alumno on 27/09/21.
//

import Foundation
import SwiftUI

let apikey = "9ede1a3fae7f654c8e95f8151bc682fa"

let apiauth = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZWRlMWEzZmFlN2Y2NTRjOGU5NWY4MTUxYmM2ODJmYSIsInN1YiI6IjYxNTFkNmY2MTQwYmFkMDA4YzkzMTFhMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B5FdNPbvsnCecgQN6eBgy8xE6dW5V56oe0nzCJNmPvE"

let headers = [
    "Authorization": "Bearer \(apiauth)",
    "Accept": "appliaction/json",
    "Content-Type": "application/json"
]

let tmdbURL = "https://api.themoviedb.org/3/"
let imageURL = "https://image.tmdb.org/t/p/original"
