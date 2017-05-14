import Foundation

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
