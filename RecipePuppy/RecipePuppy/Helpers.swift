import Foundation
import UIKit

extension Bundle {

    static func displayName() -> String {
        return self.main.infoDictionary![kCFBundleNameKey as String] as! String // swiftlint:disable:this force_cast
    }
}

extension String {

    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension UIViewController {

    func presentAlert(title: String, message: String) {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func pushWebView(href: String) {
        let webViewController = WebViewController(href: href)

        navigationController?.pushViewController(webViewController, animated: true)
    }
}
