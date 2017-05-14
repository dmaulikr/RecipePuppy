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
        RecipePuppyRequest.fetch(searchCriteria) { (recipes: [Recipe]?, error: Error?) in
            if error != nil {
                self.presentAlert(title: Bundle.displayName(), message: (error?.localizedDescription)!)
            } else {
                self.recipes = recipes!
                self.tableView.reloadData()
            }
        }
    }
}
