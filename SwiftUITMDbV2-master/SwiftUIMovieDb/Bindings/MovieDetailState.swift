//
//  MovieDetailState.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 24/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

//上连接MovieDetailView，下连接MovieStore的fetchMovie方法

import SwiftUI

class MovieDetailState: ObservableObject {
    
    private let movieService: MovieService
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    //从MovieStore中继承了 fetchMovie 方法获取数据
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
