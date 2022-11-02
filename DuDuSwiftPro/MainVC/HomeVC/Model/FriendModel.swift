//
//  FriendModel.swift
//  SwiftPro
//
//  Created by 夕阳西下 on 2020/6/28.
//  Copyright © 2020 夕阳西下. All rights reserved.
//

import Foundation
import HandyJSON

struct FriendModel: HandyJSON {
    var text: String = ""
    var video_id: NSNumber = 0
    var username: String = ""
    var nickname: String = ""
    var uid: NSNumber = 0
    var avatar: String = ""
    var first_image: String = ""
    var video: String = ""
    var send_time: NSNumber = 0
}
