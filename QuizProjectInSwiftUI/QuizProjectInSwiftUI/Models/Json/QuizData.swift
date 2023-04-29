//
//  QuizData.swift
//  QuizProjectSwiftUI
//
//  Created by yosshi on 2023/04/29.
//

import Foundation

struct QuizData: Decodable, Equatable {
    let id: Int
    let question: String
    let answers: Answers
    let multipleCorrectAnswers: String
    let correctAnswers: CorrectAnswers
    let explanation: String?
}

struct Answers: Decodable, Equatable {
    let answerA: String?
    let answerB: String?
    let answerC: String?
    let answerD: String?
    let answerE: String?
    let answerF: String?
    
    var answersArr: [PloblemAnswer]?
    
    enum AnswersType: Int, CaseIterable {
        case answerA = 0
        case answerB
        case answerC
        case answerD
        case answerE
        case answerF
    }
    
    enum CodingKeys: CodingKey {
        case answerA
        case answerB
        case answerC
        case answerD
        case answerE
        case answerF
        case dic
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.answerA = try container.decodeIfPresent(String.self, forKey: .answerA)
        self.answerB = try container.decodeIfPresent(String.self, forKey: .answerB)
        self.answerC = try container.decodeIfPresent(String.self, forKey: .answerC)
        self.answerD = try container.decodeIfPresent(String.self, forKey: .answerD)
        self.answerE = try container.decodeIfPresent(String.self, forKey: .answerE)
        self.answerF = try container.decodeIfPresent(String.self, forKey: .answerF)
        
        self.answersArr = self.setAnswersArr()
    }
    
    init(answerA: String?, answerB: String?, answerC: String?, answerD: String?, answerE: String?, answerF: String?, dic: [String : String]? = nil) {
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.answerE = answerE
        self.answerF = answerF
        
        self.answersArr = self.setAnswersArr()
    }
    
    func setAnswersArr() -> [PloblemAnswer] {
        var arr = [PloblemAnswer]()
        
        if let safeA = self.answerA {
            arr.append(PloblemAnswer(answer: safeA, type: .answerA))
        }
        if let safeB = self.answerB {
            arr.append(PloblemAnswer(answer: safeB, type: .answerB))
        }
        if let safeC = self.answerC {
            arr.append(PloblemAnswer(answer:safeC, type: .answerC))
        }
        if let safeD = self.answerD {
            arr.append(PloblemAnswer(answer:safeD, type: .answerD))
        }
        if let safeE = self.answerE {
            arr.append(PloblemAnswer(answer:safeE, type: .answerE))
        }
        if let safeF = self.answerF {
            arr.append(PloblemAnswer(answer:safeF, type: .answerF))
        }
                
        return arr
    }
}

struct PloblemAnswer: Equatable {
    var type: Answers.AnswersType
    
    var answer: String
    var checked: Bool = false

    init(answer: String, type: Answers.AnswersType) {
        self.answer = answer
        self.type = type
    }
}


struct CorrectAnswers: Decodable, Equatable {
    var answerACorrect: Bool = false
    var answerBCorrect: Bool = false
    var answerCCorrect: Bool = false
    var answerDCorrect: Bool = false
    var answerECorrect: Bool = false
    var answerFCorrect: Bool = false
        
    var correctAnswersArr: [Answers.AnswersType: Bool]?
    
    enum CodingKeys: CodingKey {
        case answerACorrect
        case answerBCorrect
        case answerCCorrect
        case answerDCorrect
        case answerECorrect
        case answerFCorrect
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.answerACorrect = try container.decode(String.self, forKey: .answerACorrect).toBool()!
        self.answerBCorrect = try container.decode(String.self, forKey: .answerBCorrect).toBool()!
        self.answerCCorrect = try container.decode(String.self, forKey: .answerCCorrect).toBool()!
        self.answerDCorrect = try container.decode(String.self, forKey: .answerDCorrect).toBool()!
        self.answerECorrect = try container.decode(String.self, forKey: .answerECorrect).toBool()!
        self.answerFCorrect = try container.decode(String.self, forKey: .answerFCorrect).toBool()!
        
        self.correctAnswersArr = self.setCorrectAnswersArr()
    }

    init(answerACorrect: Bool, answerBCorrect: Bool,  answerCCorrect: Bool,  answerDCorrect: Bool,  answerECorrect: Bool,  answerFCorrect: Bool) {
        self.answerACorrect = answerACorrect
        self.answerBCorrect = answerBCorrect
        self.answerCCorrect = answerCCorrect
        self.answerDCorrect = answerDCorrect
        self.answerECorrect = answerECorrect
        self.answerFCorrect = answerFCorrect
        
        self.correctAnswersArr = self.setCorrectAnswersArr()
    }
    
    init() {}
    
    func setCorrectAnswersArr() -> [Answers.AnswersType: Bool] {
        var arr = [Answers.AnswersType: Bool]()
        
        arr[.answerA] = self.answerACorrect
        arr[.answerB] = self.answerBCorrect
        arr[.answerC] = self.answerCCorrect
        arr[.answerD] = self.answerDCorrect
        arr[.answerE] = self.answerECorrect
        arr[.answerF] = self.answerFCorrect
        
        return arr
    }
}

extension CorrectAnswers {
    
    ///  答えのいずれかはtrueであることをチェックする
    /// - Returns: true(正しいデータ), false(不正なデータ)
    func checkCorrectAnswers() -> Bool {
        if !answerACorrect && !answerBCorrect && !answerCCorrect && !answerDCorrect && !answerECorrect && !answerFCorrect {
            return false
        }
        return true
    }
}
