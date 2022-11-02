//
//  PeopleListModel.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/15/22.
//

import Foundation
import RxSwift

struct PeopleListModel {
    let data = Observable.just([
        People(name: "张三", age: 18),
        People(name: "李四", age: 28),
        People(name: "王五", age: 38),
        People(name: "赵柳", age: 48),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
        People(name: "你好", age: 58),
    ])
}
