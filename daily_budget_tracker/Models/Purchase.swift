//
//  Post.swift
//  daily_budget_tracker
//
//  Created by Minseo Cho on 4/23/23.
//

import Foundation
import ParseSwift

struct Purchase: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    var caption: String?
    var title: String?
    var imageFile: ParseFile?
    var cost: Double?
    var user: User?
}
