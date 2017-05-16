import ObjectMapper

class RecipePuppyResponse: Mappable {
    var recipes: [Recipe]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        recipes <- map["recipes"]
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
