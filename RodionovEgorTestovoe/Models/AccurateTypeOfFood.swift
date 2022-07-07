//
//  AccurateTypeOfFood.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import Foundation
/*
 {
 "status": Bool,
 "menuList": [
 {
 "id": String,
 "image": String,
 "name": String,
 "content": String,
 "price": String,
 "weight": String,
 "spicy": String
 }
 ]
 */
struct AccurateTypeOfFood : Codable{
    var status : Bool
    var menuList : [MenuListForAccurateFood]?
}
struct MenuListForAccurateFood : Codable{
    var id : String
    var image : String
    var name : String
    var content : String
    var price : String
    var weight : String
    var spice : String?
}
