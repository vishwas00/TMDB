
import XCTest

class MovieModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieModel()  {
        
        let dict = NSMutableDictionary()
        dict.setObject("Mission Impossible", forKey: "title" as NSCopying)
        dict.setObject("Its a great movie", forKey: "overview" as NSCopying)
        dict.setValue(9.5, forKey: "popularity")
        
        let movie = MovieModel(dictionary: dict)
        
        XCTAssertNotNil(movie, "Model could not be created")
        XCTAssert(movie.title == dict["title"] as! String, "Title initialisation failed")
        XCTAssert(movie.overview == dict["overview"] as! String, "Overview initialisation failed")
        XCTAssert(movie.popularity == 9.5, "Popularity initialisation failed")
    }
    
}
