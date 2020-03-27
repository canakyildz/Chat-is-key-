//
//  LoginViewModel.swift
//  Chat is key!
//
//  Created by Apple on 17.03.2020.
//  Copyright © 2020 PHYSID. All rights reserved.
//

//Point of a view model is to help us compute certain things that are relative to user interface of our view. Everytime you have some sort of logic going on that involves changing UI properties or computing some sort of property for your view, you want to stick all that stuff to your view modal. And it keeps your view files cleaner. 

import Foundation

protocol AuthenticationProtocol { //we did it because it's best practise to use protocols in this kind of situations where we have common view components.
    var formIsValid: Bool { get }
}
struct LoginViewModel: AuthenticationProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false //it's only true ONLY if both of them is so
    }
}
