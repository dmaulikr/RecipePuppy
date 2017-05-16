import Alamofire
import AlamofireObjectMapper
import ObjectMapper
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
        let searchCriteria = searchController.searchBar.text!.trim()

        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler {dataTasks, _, _ in
            dataTasks.forEach {
                $0.cancel()
            }
        }

        Alamofire
            .request("\(Constants.baseUrl)\(searchCriteria)")
            .validate(statusCode: 200...200)
            .validate(contentType: ["application/json"])
            .responseObject { (response: DataResponse<RecipePuppyResponse>) in
                switch response.result {
                case .success:
                    self.recipes = (response.result.value?.recipes)!
                    self.tableView.reloadData()
                case .failure(let error):
                    if error.localizedDescription != "cancelled" {
                        self.presentAlert(title: Bundle.displayName(), message: error.localizedDescription)
                        self.recipes = []
                        self.tableView.reloadData()
                    }
                }
        }
    }
}
