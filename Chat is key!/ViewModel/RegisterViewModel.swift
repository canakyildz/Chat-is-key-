//
//  RegisterViewModel.swift
//  Chat is key!
//
//  Created by Apple on 17.03.2020.
//  Copyright © 2020 PHYSID. All rights reserved.
//

import Foundation

struct RegisterViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false //it's only true ONLY if both of them is so
    }
}
