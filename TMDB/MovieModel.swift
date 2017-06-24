
import UIKit

class MovieModel {

    var title = ""
    var popularity = 0.0
    var releaseDate = ""
    var overview = ""
    var posterUrl = ""
    
    init(dictionary: NSDictionary)
    {
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        
        if let popularity = dictionary["popularity"] as? Double {
            self.popularity = popularity
        }
        
        if let releaseDate = dictionary["release_date"] as? String {
            self.releaseDate = releaseDate
        }
        
        if let overview = dictionary["overview"] as? String {
            self.overview = overview
        }

        if let path = dictionary["poster_path"] as? String {
            let baseUrl = "http://image.tmdb.org/t/p/w500"
            self.posterUrl = baseUrl + path
        }
    }
    
}
