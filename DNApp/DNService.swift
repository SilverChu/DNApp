//
//  DNService.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/14.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import Alamofire

struct DNService {
    
    private static let baseURL = "https://www.designernews.co"
    private static let clientID = "750ab22aac78be1c6d4bbe584f0e3477064f646720f327c5464bc127100a1a6d"
    private static let clientSecret = "53e3822c49287190768e009a8f8e55d09041c5bf26d0ef982693f215c72d87da"
    
    private enum ResourcePath: CustomStringConvertible {
        case login
        case stories
        case storyId(storyId: String)
        case storyUpvote(storyId: String)
        case storyReply(storyId: String)
        case commentUpvote(commentId: String)
        case commentReply(commentId: String)
        
        var description: String {
            switch self {
            case .login: return "/oauth/token"
            case .stories: return "/api/v2/stories"
            case .storyId(let id): return "/api/v2/stories/\(id)"
            case .storyUpvote(let id): return "/api/v2/stories/\(id)/upvote"
            case .storyReply(let id): return "/api/v2/stories/\(id)/reply"
            case .commentUpvote(let id): return "/api/v2/comments/\(id)/upvote"
            case .commentReply(let id): return "/api/v2/comments/\(id)/reply"
            }
        }
    }
    
    static func storiesForSection(_ section: String, page: Int, completionHandler: @escaping (JSON) -> Void) {
        let urlString = baseURL + ResourcePath.stories.description + "/" + section
        let parameters = [ "page": String(page), "client_id": clientID ]
        
        Alamofire.request(urlString, method: .get, parameters: parameters).responseJSON { response in
            let stories = JSON(response.result.value ?? [])
            completionHandler(stories)
        }
    }
    
    static func loginWithEmail(email: String, password: String, completion: @escaping (_ token: String?) -> Void) {
        let urlString = baseURL + ResourcePath.login.description
        let parameters = [ "grant_type": "password",
                           "username": email,
                           "password": password,
                           "client_id": clientID,
                           "client_secret": clientSecret ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            let json = JSON(response.result.value!)
            let token = json["access_token"].string
            completion(token)
        }
    }
    
    static func upvoteStoryWithId(_ storyId: String, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.storyUpvote(storyId: storyId).description
        upvoteWithUrlString(urlString, token: token, completion: completion)
    }
    
    static func upvoteCommentWithId(_ commentId: String, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let urlString = baseURL + ResourcePath.commentUpvote(commentId: commentId).description
        upvoteWithUrlString(urlString, token: token, completion: completion)
    }
    
    private static func upvoteWithUrlString(_ urlString: String, token: String, completion: @escaping (_ successful: Bool) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request).responseJSON { response in
            let successful = response.response?.statusCode == 200
            completion(successful)
        }
    }
    
}
