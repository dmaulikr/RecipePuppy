import ObjectMapper

class RecipePuppyResponse: Mappable {
    var href: String?
    var recipes: [Recipe]?
    var title: String?
    var version: Double?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        href <- map["href"]
        recipes <- map["results"]
        title <- map["title"]
        version <- map["version"]
    }
}

class Recipe: Mappable {
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
