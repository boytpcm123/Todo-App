//
//  TodoNetworkManager.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import RxSwift
import Moya

struct TodoNetworkManager {
    
    static let shared = TodoNetworkManager()
    
    private var provider: MoyaProvider<TodoService>!
    
    private init() {
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        provider = MoyaProvider<TodoService>(plugins: [plugin])
    }
    
    func getCallList() -> Single<[UserCall]> {
        return provider.rx
            .request(.getCallList)
            .filterSuccessfulStatusAndRedirectCodes() // filters status codes that are in the 200-300 range
            .map([UserCall].self)
    }
    
    func getBuyList() -> Single<[ItemNoted]> {
        return provider.rx
            .request(.getCallList)
            .filterSuccessfulStatusAndRedirectCodes() // filters status codes that are in the 200-300 range
            .map([ItemNoted].self)
    }
}
