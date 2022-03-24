//
//  Auth_user.swift
//  



import Foundation
import UIKit

struct Auth_User {

    
    static var User_Token: String {
        get {
            let ud = UserDefaults.standard
            return ud.value(forKey: "token") as? String ?? ""
        }
        set(token) {
            let ud = UserDefaults.standard
            ud.set(token, forKey: "token")
        }
    }

}
