//
//  ContentView.swift
//  App05-TMDB
//
//  Created by Alumno on 27/09/21.
//

import SwiftUI

struct TMDBView: View {
    
    @StateObject var mediaModel = MediaModel()
    
    var body: some View {
        NavigationView {
            TabView {
                MoviesView(mediaModel: mediaModel)
                    .tabItem {
                        Label("Movies", systemImage: "film.fill")
                    }
                SeriesView()
                    .tabItem {
                        Label("Series", systemImage: "tv.fill")
                    }
            }
            .navigationBarTitle("CineTec", displayMode: .inline)
        }
    }
}

struct TMDBView_Previews: PreviewProvider {
    static var previews: some View {
        TMDBView()
    }
}
