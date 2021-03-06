//
//  TodoNetworkManager.swift
//  TodoApp
//
//  Created by hungdat1234 on 3/19/22.
//

import RxSwift
import Moya

protocol TodoNetworkManagerProtocol {
    
    func getCallList() -> Single<[UserCall]>
    func getBuyList() -> Single<[ItemNoted]>
}

struct TodoNetworkManager: TodoNetworkManagerProtocol {
    
    private var provider: MoyaProvider<TodoService>!
    
    init() {
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        provider = MoyaProvider<TodoService>(plugins: [plugin])
    }
}

// MARK: - PUBLIC FUNCTIONS
extension TodoNetworkManager {
    
    func getCallList() -> Single<[UserCall]> {
        return provider.rx
            .request(.getCallList)
            .filterSuccessfulStatusAndRedirectCodes() // filters status codes that are in the 200-300 range
            .map([UserCall].self)
    }
    
    func getBuyList() -> Single<[ItemNoted]> {
        return provider.rx
            .request(.getBuyList)
            .filterSuccessfulStatusAndRedirectCodes() // filters status codes that are in the 200-300 range
            .map([ItemNoted].self)
    }
}
