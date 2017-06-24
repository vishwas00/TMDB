
import XCTest


class TMDBUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
       
        app = XCUIApplication()
        app.launch()


        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testScreenTitle()
    {
        XCTAssert(app.navigationBars["Movies"].exists)
    }
    
    func testFilterButton() {
        
        let filterButton = app.navigationBars["Movies"].buttons["filter"]
        filterButton.tap()
        XCTAssertTrue(filterButton.exists, "Filter button does not exists")
    }
    
    func testFilterView()
    {
        let filterButton = app.navigationBars["Movies"].buttons["filter"]
        let minYearTextField = app.textFields["Min Year"]
        let maxYearTextField = app.textFields["Max Year"]
        
        filterButton.tap()
        
        minYearTextField.tap()
        minYearTextField.typeText("1990")
        
        maxYearTextField.tap()
        maxYearTextField.typeText("2000")
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
    }
    
    
    
    func testMovieCellsCreation()
    {
        let cells = app.tables.cells
        XCTAssert(cells.count > 0, "Cells cound not be created")
    }
    
    
    func testMovieCellDisplay()
    {
        let cell = app.tables.cells.element(boundBy: 0)
        let title = cell.staticTexts.element(boundBy: 0).label
        let releaseDate: String = cell.staticTexts.element(boundBy: 1).label
        let poplarity: String = cell.staticTexts.element(boundBy: 2).label
        
        XCTAssertTrue(title.characters.count > 0, "Movie title cound not be displayed")
        XCTAssertTrue(releaseDate.contains("Release Date"), "Release date cound not be displayed")
        XCTAssertTrue(poplarity.contains("Popularity"), "Popularity cound not be displayed")
    }
    
    
    func testPullToRefresh()
    {
        let firstCell = app.tables.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
            start.press(forDuration: 0, thenDragTo: finish)
    }
    
    
    
//    func testMovieDetail()
//    {
//        let cell = app.tables.cells.element(boundBy: 0)
//       
//        sleep(2)
//        cell.tap()
//        
//        let title = app.staticTexts.element(boundBy: 0).label
//        let releaseDate: String = app.staticTexts.element(boundBy: 1).label
//        let poplarity: String = app.staticTexts.element(boundBy: 2).label
//        
//        
//        XCTAssertTrue(title.characters.count > 0, "Movie title cound not be displayed")
//        XCTAssertTrue(releaseDate.contains("Release Date"), "Release date cound not be displayed")
//        XCTAssertTrue(poplarity.contains("Popularity"), "Popularity cound not be displayed")
//    }
   
    
}
