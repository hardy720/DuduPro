//
//  CommentInfo.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/4/22.
//

import SwiftyJSON

struct CommentInfo: Codable {
    var comment: String = ""
    var person: String = ""
    var user_id: Int = 0
    var avatar_url: String!
    
    init(_ json: JSON) {
        avatar_url = json["avatar_url"].stringValue
        comment = json["comment"].stringValue
        person = json["person"].stringValue
        user_id = json["user_id"].intValue
    }
}

extension CommentInfo: Equatable {
    static func == (lhs: CommentInfo, rhs: CommentInfo) -> Bool {
        return (lhs.comment == rhs.comment) && (lhs.user_id == rhs.user_id)
    }
}

