//
//  API.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 3/30/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import Foundation


class ZhihuItemModel: Mappable{
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title <- map["title"]
        ga_prefix <- map["ga_prefix"]
        images <- map["images"]
        multipic <- map["multipic"]
        type <- map["type"]
        id <- map["id"]
    }
    
	var title:  String?
	var ga_prefix: String?
	var images: String?
	var multipic: String?
	var type: Int?
	var id: Int?
}


class moyaTest1: Mappable{
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        create_time <- map["create_time"]
        title <- map["title"]
    }

    var create_time :  String?
    var title :  String?

}


class Moyatest2: Mappable{
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        create_time <- map["create_time"]
        title <- map["title"]
    }

    var create_time :  String?
    var title :  String?

}
