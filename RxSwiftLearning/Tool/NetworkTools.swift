//
//  NetworkTools.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/1.
//  Copyright © 2021 WR. All rights reserved.
//

import Foundation
import Moya


//请求枚举类型
enum NetworkToolEndpoint {
    case getListData
}

struct NetworkTool {
    let endpoint: NetworkToolEndpoint
}

//请求返回状态
enum NetworkRequestState: Int {
    case success = 200
    case error
}
//请求参数
extension NetworkTool : TargetType {

    var task: Task {
        switch endpoint {
        case .getListData:
           return  .requestPlain
        }
    }

    var headers: [String : String]? {
        ["Accept":"application/json"]
    }

    //统一基本的url
    var baseURL: URL {
        return (URL(string: "https://api.gugudata.com/weather/weatherinfo/demo"))!
    }

    //path字段会追加至baseURL后面
    var path: String {
        switch endpoint {
        case .getListData:
            return ""
        }
    }

    //请求的方式
    var method: Moya.Method {
        switch endpoint {
        case .getListData:
            return .get
        }
    }

    //参数编码方式(这里使用URL的默认方式)
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    //用于单元测试
    var sampleData : Data {
        return Data()
    }

    //请求参数(会在请求时进行编码)
    var parameters: [String: Any]? {
        return nil
    }

    //是否执行Alamofire验证，默认值为false
    var validate: Bool {
        return false
    }
}

