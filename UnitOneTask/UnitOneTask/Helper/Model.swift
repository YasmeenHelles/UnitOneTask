//
//  Model.swift
//  TawseelDriverApp
//
//  Created by Yasmeen on 3/26/21.
//  Copyright © 2021 Yasmeen. All rights reserved.
//

import Foundation
import AuthenticationServices

struct Slider{
    var imageURL : String
    var id : Int
    var name : String

    init(_ dictionary: [String:Any]){
        imageURL = dictionary["imageURL"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    }
}
