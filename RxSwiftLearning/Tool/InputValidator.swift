//
//  InputValidator.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/1.
//  Copyright © 2021 WR. All rights reserved.
//

import Foundation
import RxSwift

class InputValidator {

}

extension InputValidator {
    //判断字符串是否符合语法法则
    class func isValidEmail(_ email: String) -> Bool {
        let regular = try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: [])
        if let re = regular {
            let range = NSRange(location: 0, length: email.count)
            let result = re.matches(in: email, options: [], range: range)
            return result.count > 0
        }
        return false
    }

    //判断密码字符个数>8
    class func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

}
