import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class RecipePuppyRequest {

    static func fetch(_ searchCriteria: String, completionHandler: @escaping ([Recipe]?, Error?) -> Void) {
        var errors: [Error?] = [nil, nil]
        var recipePuppyResponses: [RecipePuppyResponse?] = [nil, nil]

        let dispatchGroup = DispatchGroup()

        for page in 1...2 {
            let index = page - 1
            dispatchGroup.enter()
            Alamofire
                .request(Constants.baseUrl, parameters: ["p": "\(page)", "q": searchCriteria])
                .validate(statusCode: 200...200)
                .validate(contentType: ["text/javascript"])
                .responseObject { (response: DataResponse<RecipePuppyResponse>) in
                    switch response.result {
                    case .success:
                        recipePuppyResponses[index] = response.result.value!
                    case .failure(let error):
                        errors[index] = error
                    }
                    dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            var error: Error? = nil
            var recipes: [Recipe] = []

            if errors[0] != nil {
                error = errors[0]
            } else if errors[1] != nil {
                error = errors[1]
            } else {
                recipes += (recipePuppyResponses[0]?.recipes)!
                recipes += (recipePuppyResponses[1]?.recipes)!
            }

            completionHandler(recipes, error)
        }
    }
}
