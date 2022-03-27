//
//  TodoAppTests.swift
//  TodoAppTests
//
//  Created by hungdat1234 on 3/19/22.
//

import XCTest
import Nimble
import RxSwift
@testable import TodoApp

class TodoAppTests: XCTestCase {
    
    var sut: TodoAppTests!
    private let disposeBag = DisposeBag()
    private var todoNetworkManager: TodoNetworkManagerProtocol!
    private var todoRepository: TodoRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        sut = TodoAppTests()
        todoNetworkManager = TodoNetworkManager()
        todoRepository = TodoRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - TEST FUNCTIONS
extension TodoAppTests {
    
    func testGetCallList_CallAPISuccessAndHaveData() {
        
        waitUntil(timeout: .seconds(3)) { done in
            self.todoNetworkManager.getCallList()
                .subscribe(onSuccess: { callList in
                    expect(callList.isEmpty).to(beFalse(), description: "Fetch call list and have data")
                    done()
                }, onFailure: { error in
                    print(error.localizedDescription)
                    expect(error)
                        .to(raiseException(),
                            description: "Fetch call list fail and call API error, need check again")
                    done()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    func testGetBuyList_CallAPISuccessAndHaveData() {
        
        waitUntil(timeout: .seconds(3)) { done in
            self.todoNetworkManager.getBuyList()
                .subscribe(onSuccess: { buyList in
                    expect(buyList.isEmpty).to(beFalse(), description: "Fetch buy list and have data")
                    done()
                }, onFailure: { error in
                    print(error.localizedDescription)
                    expect(error)
                        .to(raiseException(),
                            description: "Fetch buy list fail and call API error, need check again")
                    done()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    func testGetSellList_CallAPISuccessAndHaveData() {
        
        testGetBuyList_CallAPISuccessAndHaveData()
        
        waitUntil { done in
            self.todoRepository.getSellList()
                .subscribe(onSuccess: { sellList in
                    expect(sellList.isEmpty).to(beFalse(), description: "Fetch buy list and have data")
                    done()
                }, onFailure: { error in
                    print(error.localizedDescription)
                    expect(error)
                        .to(raiseException(),
                            description: "Fetch sell list fail from Core data, need check again")
                    done()
                })
                .disposed(by: self.disposeBag)
        }
    }
}
