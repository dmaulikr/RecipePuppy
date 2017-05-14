import Alamofire
import AlamofireObjectMapper
import UIKit

class RootViewController: UITableViewController {

    var recipes = [Recipe]()

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        definesPresentationContext = true

        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self

        tableView.tableHeaderView = searchController.searchBar

        title = Bundle.displayName()
    }
}

// MARK: - UITableViewDataSource

extension RootViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = recipes[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UISearchResultsUpdating

extension RootViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let fullUrl = Constants.baseUrl + searchController.searchBar.text!.trim()
        Alamofire
            .request(fullUrl)
            .validate(statusCode: 200...200)
            .validate(contentType: ["text/javascript"])
            .responseObject { (response: DataResponse<RecipePuppyResponse>) in
                switch response.result {
                case .success:
                    let recipePuppyResponse = response.result.value
                    self.recipes = (recipePuppyResponse?.recipes)!
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentAlert(title: Bundle.displayName(), message: error.localizedDescription)
                }
            }
    }
}
