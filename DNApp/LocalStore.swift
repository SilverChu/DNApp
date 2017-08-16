//
//  LocalStore.swift
//  DNApp
//
//  Created by Silver Chu on 2017/8/15.
//  Copyright © 2017年 Meng To. All rights reserved.
//

import UIKit

struct LocalStore {

    static let userDefaults = UserDefaults.standard
    
    static func saveToken(_ token: String) {
        userDefaults.set(token, forKey: "tokenKey")
    }
    
    static func getToken() -> String? {
        return userDefaults.string(forKey: "tokenKey")
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: "tokenKey")
    }
    
    static func saveUpvotedStory(_ storyId: String) {
        appendId(storyId, toKey: "upvotedStoriesKey")
    }
    
    static func saveUpvotedComment(_ commentId: String) {
        appendId(commentId, toKey: "upvotedCommentsKey")
    }
    
    static func isStoryUpvoted(_ storyId: String) -> Bool {
        return arrayForKey("upvotedStoriesKey", containsId: storyId)
    }
    
    static func isCommentUpvoted(_ commentId: String) -> Bool {
        return arrayForKey("upvotedCommentsKey", containsId: commentId)
    }
    
    // MARK: Helper
    private static func arrayForKey(_ key: String, containsId id: String) -> Bool {
        let elements = userDefaults.array(forKey: key) as? [String] ?? []
        return elements.contains(id)
    }
    
    private static func appendId(_ id: String, toKey key: String) {
        let elements = userDefaults.array(forKey: key) as? [String] ?? []
        if !elements.contains(id) {
            userDefaults.set(elements + [id], forKey: key)
        }
    }
    
}
