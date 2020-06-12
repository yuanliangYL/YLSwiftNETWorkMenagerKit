//
//  NDimen_API.swift
//  NewDimension
//
//  Created by AlbertYuan on 2020/5/29.
//  Copyright © 2020 Albert. All rights reserved.
//

import Foundation
import Moya

//API枚举信息
enum API{

    //获取城市列表
    case getCityList //无参数
    //获取首页信息
    case getHomePage(parameters: [String:Any]) //参数字典形式

    //case register(email:String,password:String)//参数拼接形式
    case getMethodTemporary
}


extension API:TargetType{

    var baseURL: URL {
        switch self {
        case .getHomePage: //针对特殊接口修改URL
            return URL.init(string:"https://api.91tumi.com/")!
        default:
            return URL.init(string:(Moya_baseURL))!
        }
    }


    var path: String {
        switch self {
        case .getCityList:
            return "appsys/sitelist.go"
        case .getHomePage:
            return "apphome/nindex.go"
        default :
            return ""
        }

    }


    var method: Moya.Method {
        switch self {
        //指定接口请求方法
        case .getMethodTemporary:
            return .get
        default:
            return .post
        }
    }


    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    //    该条请API求的方式,把参数之类的传进来
    var task: Task {
        //        return .requestParameters(parameters: nil, encoding: JSONArrayEncoding.default)
        switch self {
        case .getCityList, .getMethodTemporary:
            return .requestPlain

        case let .getHomePage(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
        //图片上传
        //        case .uploadHeadImage(let parameters, let imageDate):
        //            ///name 和fileName 看后台怎么说，   mineType根据文件类型上百度查对应的mineType
        //            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
        //                                             fileName: "hangge.png", mimeType: "image/png")
        //            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        //        }
        //可选参数https://github.com/Moya/Moya/blob/master/docs_CN/Examples/OptionalParameters.md
        //        case .users(let limit):
        //        var params: [String: Any] = [:]
        //        params["limit"] = limit
        //        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }


    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }

}
