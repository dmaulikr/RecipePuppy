import UIKit

class RootViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

// MARK: - Helpers

extension RootViewController {

    func displayName() -> String {
        return Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String // swiftlint:disable:this force_cast
    }
}
