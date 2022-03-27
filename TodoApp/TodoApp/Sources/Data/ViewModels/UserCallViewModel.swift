//
//  UserCallViewModel.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/27/22.
//

import Foundation

struct UserCallViewModel {
    
    private let userCall: UserCall
    
    init(userCall: UserCall) {
        self.userCall = userCall
    }
    
    func getName() -> String {
        return userCall.name ?? ""
    }
    
    func getPhoneNumber() -> String {
        return userCall.number ?? ""
    }
    
}
