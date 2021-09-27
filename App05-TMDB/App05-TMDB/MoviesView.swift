//
//  MoviesView.swift
//  App05-TMDB
//
//  Created by Alumno on 27/09/21.
//
import Foundation
import SwiftUI
import Kingfisher

struct MoviesView: View {
    
    @StateObject var mediaModel: MediaModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(mediaModel.moviesNowPlaying) { movie in
                    NavigationLink(destination: MediaDetailView(media: movie)) {
                        MediaRowView(media: movie)
                    }
                }
            }
            .navigationBarTitle("Movies", displayMode: .inline)
        }
    }
}


struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(mediaModel: MediaModel())
    }
}



