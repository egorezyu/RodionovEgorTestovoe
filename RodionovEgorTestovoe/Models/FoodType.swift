//
//  FoodType.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import Foundation
/*
 "status": Bool,
 "menuList": [
 {
 "menuID": String,
 "image": String,
 "name": String,
 "subMenuCount": String
 }
 ]
 */
struct FoodType : Decodable{
    var status : Bool
    var menuList : [MenuList]
    enum CodingKeys: String, CodingKey {

        case status   = "status"
        case menuList = "menuList"
      
      }
}
struct MenuList : Decodable{
    var menuID : String
    var image : String
    var name : String
    var subMenuCount : Int
    enum CodingKeys: String, CodingKey {

        case menuID       = "menuID"
        case image        = "image"
        case name         = "name"
        case subMenuCount = "subMenuCount"
      
      }
}
