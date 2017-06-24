
import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    
    var movie: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        let tlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        tlabel.text = movie.title
        tlabel.font = UIFont.boldSystemFont(ofSize: 20)
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel
        
        releaseDateLabel.text = "Release Date: \(movie.releaseDate)"
        popularityLabel.text = "Popularity: " + String(format:"%.2f", movie.popularity)
        overviewTextView.text = movie.overview
        posterImageView.kf.setImage(with: URL(string: movie.posterUrl))
    }

}
