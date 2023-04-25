//
//  QuizProjectInUIKitTests.swift
//  QuizProjectInUIKitTests
//
//  Created by yosshi on 2023/04/23.
//

import XCTest
@testable import QuizProjectInUIKit

final class QuizProjectInUIKitTests: XCTestCase {

    func test_fetchQuizData_正常系() {
                
        let viewModel = ServiceManager(service: MockService(repos: [.mock1], error: nil))
        
        viewModel.getQuiz(category: "All") { result in
            
            switch result {
                
            case .success(let quizData):
                XCTAssertEqual(quizData, [QuizData.mock1])
                
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func test_fetchQuizData_異常系() {
        
        let viewModel = ServiceManager(service: MockService(repos: [.mock1], error: DummyError()))
        
        viewModel.getQuiz(category: "All") { result in
            
            switch result {
                
            case .success(_):
                XCTFail()

            case .failure(let error):
                XCTAssert(error is DummyError)
            }
        }
    }
    
    func test_repositoryGetHistoryModel_正常系() {
        
        let viewModel = RepositoryManager(repository: MockRepository(repos: [.mock1]))
        
        let model = viewModel.getHistoryInfoModels()
        
        XCTAssertEqual(model, [.mock1])
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
