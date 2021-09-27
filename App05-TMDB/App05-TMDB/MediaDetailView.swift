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
                    KFImage(URL(string: "\(imageURL)\(media.poster)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width - 40)
                }
                .padding(.horizontal,20)
                .navigationBarTitle("\(media.title)", displayMode: .inline)
            }
        }
    }
}

struct MediaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailView(media: Media.dummy)
    }
}
