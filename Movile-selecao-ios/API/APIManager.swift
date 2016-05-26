//
//  APIManager.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 2/26/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Alamofire

// MARK: Typealiases
typealias MSIShowsResultBlock = (([Show]?, ErrorType?) -> Void)

class APIManager {
    
    static let sharedInstance = APIManager()
    
    // MARK: Private enums
    private enum TraktStatusCodes: Int {
        case Success = 200
        case Success1 = 201 // new resource created (POST)
        case Success2 = 204 // no content to return (DELETE)
        case BadRequest = 400 //request couldn't be parsed
        case Unauthorized = 401 // OAuth must be provided
        case Forbidden = 403 // invalid API key or unapproved app
        case NotFound = 404 // method exists, but no record found
        case MethodNotFound = 405 //method doesn't exist
        case Conflict = 409 // resource already created
        case PreconditionFailed = 412 // use application/json content type
        case UnprocessableEntity = 422 // validation errors
        case RateLimitExceeded = 429
        case ServerError = 500
        case ServiceUnavailable = 503 // server overloaded
        case ServiceUnavailable1 = 520 // Cloudflare error
        case ServiceUnavailable2 = 521 // Cloudflare error
        case ServiceUnavailable3 = 522 // Cloudflare error
    }
    
    // MARK: Private constants
    private static let Endpoint = "https://api-v2launch.trakt.tv/"
    private static let ClientID = "205ea1b047c1b90e76cac3cdba9b957d70c4489cfb0c603cfca290487743a8a3"
    private static let ClientSecret = "4813a965f1946210f60f8c4dc429dddf4148ac714969fc54864d26b5afd7a078"
    private let RequiredHeaders: [String:String] = [
        "Content-Type": "application/json",
        "trakt-api-key": APIManager.ClientID,
        "trakt-api-version": "2"
    ]
    
    private struct Action {
        private enum Shows: String, CustomStringConvertible {
            case Trending = "shows/trending?extended=images"
            
            var description: String {
                return APIManager.Endpoint + self.rawValue
            }
        }
    }
    
    // MARK: Public methods
    func getTrendingShowsWithBlock(block: MSIShowsResultBlock) {
        let requestURL = Action.Shows.Trending.description
        Alamofire.request(.GET, requestURL, headers: RequiredHeaders).responseJSON { (response: Response<AnyObject, NSError>) in
            switch response.result {
            case .Success(let value):
                if let showsArray = value as? [[String : AnyObject]] {
                    var shows = [Show]()
                    for showDictionary in showsArray {
                        let show = Show(dictionary: showDictionary)
                        shows += [show]
                    }
                    block(shows, nil)
                }
                
                
            case .Failure(let error):
                block(nil, error)
            }
        }
    }
    
}