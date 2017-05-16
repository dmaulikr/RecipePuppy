# RecipePuppy

An app using the [RecipePuppy API](http://www.recipepuppy.com/about/api/).

## Notes

Create local git repository. I prefer to use [SourceTree](https://www.sourcetreeapp.com/).

Create gitignore file. I often use the [GitHub templates](https://github.com/github/gitignore/blob/master/Swift.gitignore).

Install [fastlane](https://fastlane.tools/).

Use fastlane to register an app on the Apple developer portal.

```bash
fastlane produce create --app_identifier uk.co.quimarche.RecipePuppy --app_name "XC uk co quimarche RecipePuppy" --skip_itc --team_id 2798U5523H --username chris@quimarche.co.uk
```

Use Xcode to create a new project, choosing Single View Application, Swift, Universal, unit and UI tests. This could be scripted with something like [xcodeproj](https://github.com/CocoaPods/Xcodeproj) for better cross-project standardisation.

Change the project deployment target. I only have an iPhone 4 running iOS 9.3.5 to hand. Generally, I'd aim to support the latest two major version numbers of iOS.

Use fastlane to create a development provisioning profile on the Apple developer portal. I typically develop on one machine and build on another. Match removes the hassle of keeping certificates in sync.

```bash
fastlane match development --app_identifier uk.co.quimarche.RecipePuppy --git_url git@bitbucket.org:quimarche/fastlanematch.git --username chris@quimarche.co.uk
```

Install [SwiftLint](https://github.com/realm/SwiftLint) and integrate it with Xcode. It helps to standardise style and conventions. Henceforth always open the workspace rather than the project. Now build the workspace, configure SwiftLint as required and correct outstanding warnings and errors.

Install [FauxPas](http://fauxpasapp.com/) and integrate it with Xcode. It helps to standardise maintainability and style. Now build the workspace, configure FauxPas as required and correct outstanding warnings and errors.

Create gym file. The app can now be built and packaged from the command line. This might be useful when implementing continuous integration.

```bash
fastlane gym --scheme RecipePuppy --skip_package_ipa
```

Create scan file. The app can now be tested against the specified devices from the command line. This might be useful when implementing continuous integration.

```bash
fastlane scan
```

Remove cruft. The standard Xcode project is rather messy. It might be better to have a standardised in-house template.

Add placeholders for AppIcon and LaunchImage.

Programmatically open root view controller. Note, I've chosen to wrap the search list in a navigation controller; it's a given that the next step would be to select a recipe and drill down to the detail.

Programmatically add a search controller.

Install [Alamofire](https://github.com/Alamofire/Alamofire). We'll use this common open-source library to make HTTP requests.

Make a HTTP request to the RecipePuppy API. Doing so requires that we have to configure NSAppTransportSecurity. Note, I'd prefer to use HTTPS but RecipePuppy doesn't support it. I'd also prefer to use the top-level domain but RecipePuppy is using a HTTP 301 to permanently redirect to the www subdomain. Finally, I'd rather not use the less secure NSAllowsArbitraryLoads.

Install [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper). We'll use this common open-source library to map HTTP responses to Swift objects.

Map the HTTP response.

Refactor Bundle.displayName().

Add error handling.

Display recipes.

Install [AlamofireNetworkActivityIndicator](https://github.com/Alamofire/AlamofireNetworkActivityIndicator). We'll use this common open-source library to make HTTP requests.

The requirements state "Only the first 20 results of a search are displayed." The RecipePuppy API returns recipes in pages of 10, therefore we may need to make two requests.

Add unit tests.

Add UI tests.

Create micro-service to refactor the multi-fetch and provide a HTTPS end-point.

Refactor app to use micro-service. This allows me to configure NSAppTransportSecurity to use only HTTPS. If also abstracts the multi-fetch processing away to the micro-service. In the real world, I'd expect to have iOS, Android and web apps, and maybe even a Windows Phone app. With the micro-service we only need to code/maintain the multi-fetch once, not once per platform. It also allows use to use techniques such as caching and logging. Obviously it's not as performant on the free platform I've chosen, but this can be addressed later.

## Todo

As the project grows I'd expect some refactoring but, for this short working demonstrator, I'd rather not refactor prematurely. Other changes I'd consider might include increasing separation of concerns via dependency injection, string localisation, using RxSwift, and changes to the UI to inform the user that no matches have been found.

Clearly the app will need some launch images and other graphical assets for deployment to iTunesConnect.

If the app is to be distributed for user acceptance testing I'd consider TestFlight (iOS only) or HockeyApp (iOS and Android). Fastlane provides great support for distributing both ad hoc and App Store builds: taking screenshots, uploading metadata and signing and uploading packages.

Finally, I noticed the RecipePuppy API behaves a little curiously when entering two or more terms, e.g. [?q=garlic%20omelet](http://www.recipepuppy.com/api/?q=garlic%20omelet).
