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
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(mediaModel.moviesNowPlaying) { movie in
                        NavigationLink(destination: MediaDetailView(media: movie, mediaModel: mediaModel)) {
                            MediaRowView(media: movie, width: geo.size.width)
                        }
                    }
                }
                .navigationBarTitle("Movies", displayMode: .inline)
            }
        }
     
    }
}


struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(mediaModel: MediaModel())
    }
}



