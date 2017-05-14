import Alamofire
import UIKit

class RootViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self

        tableView.tableHeaderView = searchController.searchBar

        title = displayName()
    }
}

// MARK: - UITableViewDataSource

extension RootViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.detailTextLabel?.text = "detail text"
        cell.textLabel?.text = "text label"
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UISearchResultsUpdating

extension RootViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        Alamofire.request(Constants.baseUrl + searchController.searchBar.text!.trim()).responseJSON { response in
            print(response)
        }
    }
}

// MARK: - Helpers

extension RootViewController {

    func displayName() -> String {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String // swiftlint:disable:this force_cast
    }
}
