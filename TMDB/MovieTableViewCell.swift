
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(movie: MovieModel)
    {
        self.movieTitleLabel.text = movie.title
        self.releaseDateLabel.text = "Release Date: \(movie.releaseDate)"
        self.popularityLabel.text = "Popularity: " + String(format:"%.2f", movie.popularity)
        posterImageView.kf.setImage(with: URL(string: movie.posterUrl))
        
        print("Poster url: \(movie.posterUrl)")
    }
}
