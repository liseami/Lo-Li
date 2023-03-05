//
//  User.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2022/9/9.
//

import Foundation

struct UserInfo: Convertible {
    var id: String = ""
    var session_token: String = ""
    var username: String = ""
    var objectId: String = ""
    var avatar: String = ""
    var avatarBase64String = ""
    var userbio: String = ""
    var avatarObjectId: String = ""
    var createdAt: String = ""
    var needBaseInfo: Bool = true
    var brithday: String = "yyyy-MM-dd"
    var gender: Int = 1 // 1 男 0 女
    var uiimage: String = ""
}
