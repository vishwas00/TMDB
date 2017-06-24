
import XCTest

class MovieDetailViewControllerTests: XCTestCase {
    
    var movieDetailViewController: MovieDetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        movieDetailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailViewController.loadView()
    }
    
    override func tearDown() {
        movieDetailViewController = nil
        super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertNotNil(movieDetailViewController, "ViewController could not be loaded")
        XCTAssertNotNil(movieDetailViewController.view, "View could not be loaded")
    }
    
    func testIBOutlets() {
        XCTAssertNotNil(movieDetailViewController.posterImageView, "posterImageView outlet not connected")
        XCTAssertNotNil(movieDetailViewController.releaseDateLabel, "releaseDateLabel outlet not connected")
        XCTAssertNotNil(movieDetailViewController.popularityLabel, "popularityLabel outlet not connected")
        XCTAssertNotNil(movieDetailViewController.overviewTextView, "overviewTextView outlet not connected")
    }
}
