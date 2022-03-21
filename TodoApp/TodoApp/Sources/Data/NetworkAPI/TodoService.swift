//
//  TodoService.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import UIKit
import Moya

enum TodoService {
    case getCallList
    case getBuyList
}

extension TodoService: TargetType {
    
    var baseURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "https://my-json-server.typicode.com/imkhan334/demo-1")!
    }
    
    var path: String {
        switch self {
        case .getCallList:
            return "/call"
        case .getBuyList:
            return "/buy"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCallList:
            return .get
        case .getBuyList:
            return .get
        }
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        Data()
    }
    
}
