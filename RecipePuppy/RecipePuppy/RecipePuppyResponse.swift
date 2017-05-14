import ObjectMapper

class RecipePuppyResponse: Mappable {
    var href: String?
    var results: [Result]?
    var title: String?
    var version: Double?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        href <- map["href"]
        results <- map["results"]
        title <- map["title"]
        version <- map["version"]
    }
}

class Result: Mappable {
    var href: String?
    var ingredients: String?
    var thumbnail: String?
    var title: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        href <- map["href"]
        ingredients <- map["ingredients"]
        thumbnail <- map["thumbnail"]
        title <- map["title"]
    }
}
