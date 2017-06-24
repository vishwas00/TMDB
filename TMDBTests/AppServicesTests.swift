
import XCTest

class AppServicesTests: XCTestCase {
    
    let BaseUrl = "https://api.themoviedb.org/3/discover/movie?"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetMoviesAPI() {
        
        let expectation = XCTestExpectation(description: "GetMoviesFromServerExpectation")
        
        let url = BaseUrl + "page=1&sort_by=popularity.desc&language=en-US&api_key=62ec71865da3159056ee0a55fb09aed4"
        AppServices.getRequest(urlString: url, successBlock: { (response) in
            
            let movies = response["results"] as AnyObject as? NSArray
            XCTAssert((movies?.count)! > 0, "No movies found")
            
            expectation.fulfill()
            
        }) { (errorMessage) in
            XCTAssertNil(errorMessage, "API not working")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testGetMoviesAPIWithYearFilter() {
        
        let expectation = XCTestExpectation(description: "GetMoviesFromServerExpectation")
        
        let minYear = 1990, maxYear = 2000
        let url = BaseUrl + "page=1&sort_by=popularity.desc&language=en-US&api_key=62ec71865da3159056ee0a55fb09aed4&primary_release_date.gte=\(minYear)&primary_release_date.lte=\(maxYear)"
        AppServices.getRequest(urlString: url, successBlock: { (response) in
            
            let movies = response["results"] as AnyObject as? NSArray
            XCTAssert((movies?.count)! > 0, "No movies found")
            
            expectation.fulfill()
            
        }) { (errorMessage) in
            XCTAssertNil(errorMessage, "API not working")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    
    //MARK:- Performance test
    
    func testPerformanceGetMoviesAPI() {
        
        self.measure {
            
            let expectation = XCTestExpectation(description: "testPerformanceGetMoviesAPI")
            
            let url = self.BaseUrl + "page=1&sort_by=popularity.desc&language=en-US&api_key=62ec71865da3159056ee0a55fb09aed4"
            AppServices.getRequest(urlString: url, successBlock: { (response) in
                
                expectation.fulfill()
                
            }) { (errorMessage) in
                expectation.fulfill()
            }
            
            self.wait(for: [expectation], timeout: 5)
        }
    }
    
}
