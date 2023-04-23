//
//  QuizData.swift
//  QuizProjectInUIKit
//
//  Created by yosshi on 2023/04/23.
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
    
    var answersArr: [String]?
    
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
    
    func setAnswersArr() -> [String] {
        var arr = [String]()
        
        if let safeA = self.answerA {
            arr.append(safeA)
        }
        if let safeB = self.answerB {
            arr.append(safeB)
        }
        if let safeC = self.answerC {
            arr.append(safeC)
        }
        if let safeD = self.answerD {
            arr.append(safeD)
        }
        if let safeE = self.answerE {
            arr.append(safeE)
        }
        if let safeF = self.answerF {
            arr.append(safeF)
        }
                
        return arr
    }
}

struct CorrectAnswers: Decodable, Equatable {
    var answerACorrect: Bool = false
    var answerBCorrect: Bool = false
    var answerCCorrect: Bool = false
    var answerDCorrect: Bool = false
    var answerECorrect: Bool = false
    var answerFCorrect: Bool = false
        
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
    }

    init(answerACorrect: Bool, answerBCorrect: Bool,  answerCCorrect: Bool,  answerDCorrect: Bool,  answerECorrect: Bool,  answerFCorrect: Bool) {
        self.answerACorrect = answerACorrect
        self.answerBCorrect = answerBCorrect
        self.answerCCorrect = answerCCorrect
        self.answerDCorrect = answerDCorrect
        self.answerECorrect = answerECorrect
        self.answerFCorrect = answerFCorrect
    }
    
    init() {}
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

//[
//    {
//        "id": 536,
//        "question": "HTML documents are saved in",
//        "description": null,
//        "answers": {
//            "answer_a": "Special binary format",
//            "answer_b": "Machine language codes",
//            "answer_c": "ASCII text",
//            "answer_d": "None of above",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "false",
//            "answer_b_correct": "false",
//            "answer_c_correct": "true",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": "answer_a",
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "HTML"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Medium"
//    },
//    {
//        "id": 659,
//        "question": "Which command can be used to display file contents in octal?",
//        "description": null,
//        "answers": {
//            "answer_a": "od",
//            "answer_b": "octal",
//            "answer_c": "oshow",
//            "answer_d": "oct",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": "answer_a",
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "BASH"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Medium"
//    },
//    {
//        "id": 704,
//        "question": "What is LILO w.r.t linux?",
//        "description": null,
//        "answers": {
//            "answer_a": "LILO means linux loader, which loads the kernel into memory and starts the OS.",
//            "answer_b": "LILO means linux loader, which loads the OS into memory and starts the GUI.",
//            "answer_c": "LILO means linux loader, which loads the GUI into memory so the user can see what's going on.",
//            "answer_d": "LILO means linux loader, which loads the software into memory and starts the kernel then the OS.",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": null,
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "Linux"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Hard"
//    },
//    {
//        "id": 691,
//        "question": "Which operator can be used to throw a process into background?",
//        "description": null,
//        "answers": {
//            "answer_a": "&",
//            "answer_b": "&&",
//            "answer_c": "|",
//            "answer_d": "||",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": null,
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "BASH"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Easy"
//    },
//    {
//        "id": 685,
//        "question": "What is UMASK?",
//        "description": null,
//        "answers": {
//            "answer_a": "UMASK is a Unix environment variable, which automatically sets file permissions created files.",
//            "answer_b": "UMASK is a Unix environment variable, which automatically sets the file visibility.",
//            "answer_c": "UMASK is a Unix environment variable, which not really used anymore and is considered legacy.",
//            "answer_d": "UMASK is a Unix environment variable, which is replaced by the chmod command now however it's still largely used.",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": null,
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "BASH"
//            },
//            {
//                "name": "Linux"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Easy"
//    },
//    {
//        "id": 690,
//        "question": "How can we list out all currently executing background processes?",
//        "description": null,
//        "answers": {
//            "answer_a": "ps -e",
//            "answer_b": "top",
//            "answer_c": "ps faux",
//            "answer_d": "proccess -aux",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": null,
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "BASH"
//            },
//            {
//                "name": "Linux"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Easy"
//    },
//    {
//        "id": 705,
//        "question": "Deployment Controllers are part of",
//        "description": null,
//        "answers": {
//            "answer_a": "Master Controller Manager",
//            "answer_b": "kube-scheduler",
//            "answer_c": "etcd manager",
//            "answer_d": "API Controller Manager",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": "answer_a",
//        "explanation": "A Deployment provides declarative updates for Pods and ReplicaSets.You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.",
//        "tip": null,
//        "tags": [
//            {
//                "name": "Kubernetes"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Easy"
//    },
//    {
//        "id": 745,
//        "question": "How to show the metrics for a given node in Kubernetes?",
//        "description": null,
//        "answers": {
//            "answer_a": "kubectl ps node my-node",
//            "answer_b": "kubectl resources node my-node",
//            "answer_c": "kubectl top node my-node",
//            "answer_d": "kubectl uptime node my-node",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "false",
//            "answer_b_correct": "false",
//            "answer_c_correct": "true",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": "answer_a",
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "Kubernetes"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Easy"
//    },
//    {
//        "id": 1072,
//        "question": "If we wish to mount a directory with Read Only option, which of the following is correct",
//        "description": null,
//        "answers": {
//            "answer_a": "mount -t ext4 -o noexect,ro /path/to-dir /mnt/folder",
//            "answer_b": "mount ext4 -no-read-only /path/to-dir /mnt/folder",
//            "answer_c": "mount -t ext4 -o noexect,ro /mnt/folder /path/to-dir",
//            "answer_d": "mount ext4 -no-read-only /mnt/folder /path/to-dir",
//            "answer_e": "mount ext4 noexect,ro /path/to-dir /mnt/folder",
//            "answer_f": "mount ext4 -no-read-only /mnt/folder /path/to-dir"
//        },
//        "multiple_correct_answers": "true",
//        "correct_answers": {
//            "answer_a_correct": "true",
//            "answer_b_correct": "false",
//            "answer_c_correct": "false",
//            "answer_d_correct": "true",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": null,
//        "explanation": null,
//        "tip": null,
//        "tags": [
//            {
//                "name": "Linux"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Medium"
//    },
//    {
//        "id": 709,
//        "question": "Which special namespace is used for special purposes like bootstrapping a cluster?",
//        "description": null,
//        "answers": {
//            "answer_a": "default",
//            "answer_b": "kube-public",
//            "answer_c": "kube-private",
//            "answer_d": "kube-default",
//            "answer_e": null,
//            "answer_f": null
//        },
//        "multiple_correct_answers": "false",
//        "correct_answers": {
//            "answer_a_correct": "false",
//            "answer_b_correct": "true",
//            "answer_c_correct": "false",
//            "answer_d_correct": "false",
//            "answer_e_correct": "false",
//            "answer_f_correct": "false"
//        },
//        "correct_answer": "answer_a",
//        "explanation": "The kube-public namespace is created automatically and is readable by all users (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.",
//        "tip": null,
//        "tags": [
//            {
//                "name": "Kubernetes"
//            }
//        ],
//        "category": "Linux",
//        "difficulty": "Easy"
//    }
//]
