import AlamofireNetworkActivityIndicator
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var href: String!

    convenience init(href: String) {
        self.init()

        self.href = href
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = WKWebView(frame: view.frame, configuration: WKWebViewConfiguration())

        (view as! WKWebView).navigationDelegate = self // swiftlint:disable:this force_cast
        (view as! WKWebView).load(URLRequest(url: URL(string: href)!)) // swiftlint:disable:this force_cast
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController {

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NetworkActivityIndicatorManager.shared.decrementActivityCount()
        self.presentAlert(title: Bundle.displayName(), message: error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NetworkActivityIndicatorManager.shared.decrementActivityCount()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NetworkActivityIndicatorManager.shared.incrementActivityCount()
    }
}
