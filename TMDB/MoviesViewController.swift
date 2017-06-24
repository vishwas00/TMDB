
import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController, FilterViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let BaseUrl = "https://api.themoviedb.org/3/discover/movie?"
    var page = 1
    var totalFeedsOnServer = 0
    var minYear = ""
    var maxYear = ""
    var loader = MBProgressHUD()
    
    
    var movies = [MovieModel]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movies"
        
        
        let filterItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filterButtonTapped))
        
        navigationItem.rightBarButtonItem = filterItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "LoadMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "LoadMoreTableViewCell")
        tableView.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.estimatedRowHeight = 92
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        getMoviesFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- FilterViewDelegate methods
    
    func filtersSelected(minYear: String, maxYear: String) {
        
        self.minYear = minYear
        self.maxYear = maxYear
        
        page = 1
        movies.removeAll()
        tableView.reloadData()
        
        getMoviesFromServer()
    }
    
    
    
    //MARK:- BL Methods
    
    func filterButtonTapped()
    {
        guard let filterView = Bundle.main.loadNibNamed("FilterView", owner: nil, options: nil)?[0] as? FilterView else {
            return
        }
        filterView.frame = view.frame
        filterView.delegate = self
        
        self.view.addSubview(filterView)
    }
    
    
    func refreshData(sender: UIRefreshControl)
    {
        self.minYear = ""
        self.maxYear = ""

        page = 1;
        movies.removeAll()
        tableView.reloadData()
        
        getMoviesFromServer()
    }
    
    
    func isMoreDataAvailable() -> Bool {
        
        if(movies.count < totalFeedsOnServer)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    
    
    func showError(message: String)
    {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    //MARK:- Service methods
    
    func getMoviesFromServer()
    {
        let urlString = BaseUrl + "page=\(page)&sort_by=popularity.desc&language=en-US&api_key=62ec71865da3159056ee0a55fb09aed4&primary_release_date.gte=\(minYear)&primary_release_date.lte=\(maxYear)"
        
        
        if(page == 1)
        {
            loader = MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        
        AppServices.getRequest(urlString: urlString, successBlock: { [weak self] (response) in
            
            print(response)
            self?.loader.hide(animated: true)
            
            if(self?.refreshControl.isRefreshing)!
            {
                self?.refreshControl.endRefreshing()
            }
            
            guard let movies = response["results"] as? NSArray else{
                return
            }
            
            self?.totalFeedsOnServer = response["total_results"] as! Int
            
            for movie in movies
            {
                self?.movies.append(MovieModel(dictionary: movie as! NSDictionary))
            }
            
            self?.tableView.reloadData()
            
        }) {[weak self] (errorMessage) in
            self?.loader.hide(animated: true)
            self?.showError(message: errorMessage)
        }
        
    }
}



//MARK:- UITableView methods

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if((movies.count > 0) && isMoreDataAvailable() && !refreshControl.isRefreshing)
        {
            return movies.count+1;
        }
        else
        {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // for LoadMoreCell
        if ((indexPath.row == movies.count) && isMoreDataAvailable())
        {
            var loadMoreCell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableViewCell") as? LoadMoreTableViewCell
            if loadMoreCell == nil {
                loadMoreCell = LoadMoreTableViewCell(style: .default, reuseIdentifier: "LoadMoreTableViewCell")
            }
            loadMoreCell?.spinner.startAnimating()
            
            return loadMoreCell!
        }
        
        
        //For MovieCell
        var cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell
        if cell == nil {
            cell = MovieTableViewCell(style: .default, reuseIdentifier: "MovieTableViewCell")
        }
        
        let movie = movies[indexPath.row]
        
        cell?.configure(movie: movie)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (refreshControl.isRefreshing && (indexPath.row == movies.count)) // Pagination should not work if Pull-To-Refresh is working currently
        {
            let cell1 = cell as? LoadMoreTableViewCell;
            cell1?.spinner.isHidden = true;
            
            return
        }
        else if(indexPath.row == movies.count)
        {
            let cell1 = cell as? LoadMoreTableViewCell;
            cell1?.spinner.isHidden = false;
        }
        
        if((indexPath.row == movies.count) && isMoreDataAvailable())
        {
            page += 1
            getMoviesFromServer()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        {
            if indexPath.row < movies.count {
                
                movieDetailViewController.movie = movies[indexPath.row]
                navigationController?.pushViewController(movieDetailViewController, animated: true)
                
            }
            
            
        }
    }
}
