//
//  MoviesViewControllerTests.swift

import XCTest

class MoviesViewControllerTests: XCTestCase {
    
    var moviesViewController: MoviesViewController!
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        moviesViewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
        moviesViewController.loadView()
    }
    
    override func tearDown() {
        
        moviesViewController = nil
        super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertNotNil(moviesViewController, "ViewController could not be loaded")
        XCTAssertNotNil(moviesViewController.view, "View could not be loaded")
        XCTAssertNotNil(moviesViewController.tableView, "TableView could not be loaded")
    }
    
    func testTableViewProtocolsConformance()
    {
        XCTAssertTrue(moviesViewController.conforms(to: UITableViewDataSource.self), "does not conforms to UITableViewDataSource")
        XCTAssertTrue(moviesViewController.conforms(to: UITableViewDelegate.self), "does not conforms to UITableViewDelegate")
    }
    
    func testMethodsExistence()
    {
        XCTAssertTrue(moviesViewController.responds(to: #selector(MoviesViewController.showError)), "showError method not found")
        XCTAssertTrue(moviesViewController.responds(to: #selector(MoviesViewController.isMoreDataAvailable)), "isMoreDataAvailable method not found")
        XCTAssertTrue(moviesViewController.responds(to: #selector(MoviesViewController.refreshData(sender:))), "refreshData method not found")
        XCTAssertTrue(moviesViewController.responds(to: #selector(MoviesViewController.getMoviesFromServer)), "getMoviesFromServer method not found")
    }
    
}
