//
//  Movie.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int? //for movie detail
    let releaseDate: String?
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVideoResponse?
    
    //年份格式化
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    //时分格式化（电影时长）
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    //补全横幅卡片图片的http头
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    //补全垂直卡片图片的http头
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    //电影类型 like Action 【genre (文学、艺术、电影或音乐的)体裁，类型】
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    //vote average投票平均评分（用于star显示）
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "★"
        }
        return ratingText
    }

    //vote average投票平均评分（用于数字显示：7/10）
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    //年份格式化，调用yearFormatter
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    //时分格式化（电影时长），调用durationFormatter
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    //电影演员Movie Cast
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    //电影工作人员（除了演员之外的工作人员）
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    //导演director
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    //制片人producer
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
    
    //电影剧本作家screen Writer
    var screenWriters: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story" }
    }
    
    //电影预告片Trailers
    var youtubeTrailers: [MovieVideo]? {
        videos?.results.filter { $0.youtubeURL != nil }
    }
}

//Movie 的子结构
struct MovieGenre: Decodable {
    
    let name: String
}

//Movie 的子结构
struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

//Movie 的子子结构
//电影演员Movie Cast
struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

//Movie 的子子结构
//电影工作人员（除了演员之外的工作人员）
struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

//Movie 的子结构
struct MovieVideoResponse: Decodable {
    
    let results: [MovieVideo]
}

//Movie 的子子结构
struct MovieVideo: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
