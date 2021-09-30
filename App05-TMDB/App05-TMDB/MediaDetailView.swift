//
//  MediaDetailView.swift
//  App05-TMDB
//
//  Created by Alumno on 27/09/21.
//

import SwiftUI
import Kingfisher

struct MediaDetailView: View {
    
    var media: Media
    @StateObject var mediaModel: MediaModel
    @State var posters = [String]()
    @State var trailers = [Trailer]()
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text(media.overview)
                    HStack {
                        ForEach(media.genres, id: \.self) { g in
                            Text(g)
                                .font(.caption)
                                .padding()
                        }
                    }
                    if(trailers.count > 0) {
                        NavigationLink(destination: TrailersView(trailers: $trailers), label: {
                            Label("Trailer", systemImage: "play.tv")
                        })
                    }
                    if(posters.count > 0) {
                        TabView {
                            ForEach(posters, id:\.self) { poster in
                                KFImage(URL(string: "\(imageURL)\(poster)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .frame(width: geo.size.width-40, height: geo.size.width/0.667)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    }
        
                    KFImage(URL(string: "\(imageURL)\(media.poster)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width - 40)
                }
                .padding(.horizontal,20)
                .navigationBarTitle("\(media.title)", displayMode: .inline)
            }
            .onAppear {
                mediaModel.loadMoviePosters(id: media.id, handler: { (returnedImages) in
                    self.posters.removeAll()
                    self.posters.append(contentsOf: returnedImages)
                })
                mediaModel.loadMovieTrailers(id: media.id, handler: { (returnedTrailers) in
                    self.trailers.removeAll()
                    self.trailers.append(contentsOf: returnedTrailers)
                })
            }
        }
    }
}

struct MediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailView(media: Media.dummy, mediaModel: MediaModel())
    }
}
