//
//  TableModel.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/1.
//  Copyright © 2021 WR. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources

struct ResponseBasicInfo: Mappable {
    var dataStatus:DataStatus?
    var list:[ListData]?

    init(map: Map) {
        dataStatus  <- map["DataStatus"]
        list <- map["Data"]
    }

    mutating func mapping(map: Map) {
        dataStatus  <- map["DataStatus"]
        list <- map["Data"]
    }
}

struct DataStatus: Mappable {
    var statusCode: Int?
    var statusDescription: String?
    var responseDateTime :String?
    var dataTotalCount:Int?

    init(map: Map) {
        statusCode <- map["StatusCode"]
        statusDescription <- map["StatusDescription"]
        responseDateTime <- map["ResponseDateTime"]
        dataTotalCount <- map["DataTotalCount"]
    }

    mutating func mapping(map: Map) {
       statusCode <- map["StatusCode"]
       statusDescription <- map["StatusDescription"]
       responseDateTime <- map["ResponseDateTime"]
       dataTotalCount <- map["DataTotalCount"]
    }
}

struct ListData: Mappable {
    var code: String?
    var weatherDate: String?
    var weatherRegion :WeatherRegion?
    var weatherInfo:String?
    var temperatureHigh:Int = 0
    var temperatureLow:Int = 0
    init(map: Map) {
        code <- map["Code"]
        weatherDate <- map["WeatherDate"]
        weatherRegion <- map["WeatherRegion"]
        weatherInfo <- map["WeatherInfo"]
        temperatureHigh <- map["TemperatureHigh"]
        temperatureLow <- map["TemperatureLow"]
    }

    mutating func mapping(map: Map) {
        code <- map["Code"]
        weatherDate <- map["WeatherDate"]
        weatherRegion <- map["WeatherRegion"]
        weatherInfo <- map["WeatherInfo"]
        temperatureHigh <- map["TemperatureHigh"]
        temperatureLow <- map["TemperatureLow"]
    }
}

struct WeatherRegion: Mappable {
    var reginType: String?
    var code: String?
    var provinceCode :String?
    var provinceName :String?
    var cityCode :String?
    var cityName :String?

    init?(map: Map) {
       reginType <- map["ReginType"]
       code <- map["Code"]
       provinceCode <- map["ProvinceCode"]
       provinceName <- map["ProvinceName"]
       cityCode <- map["CityCode"]
       cityName <- map["CityName"]
    }

    mutating func mapping(map: Map) {
        reginType <- map["ReginType"]
        code <- map["Code"]
        provinceCode <- map["ProvinceCode"]
        provinceName <- map["ProvinceName"]
        cityCode <- map["CityCode"]
        cityName <- map["CityName"]
    }
}


//MARK: SectionModel
struct ModelSection {
    // items就是rows
    var items: [Item]

    // 你也可以这里加你需要的东西，比如 headerView 的 title
}

extension ModelSection: SectionModelType {
    // 重定义 Item 的类型为
    typealias Item = ListData
    init(original: ModelSection, items: [ModelSection.Item]) {
        self = original
        self.items = items
    }
}
