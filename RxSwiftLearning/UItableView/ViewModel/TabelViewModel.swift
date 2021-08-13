//
//  TabelViewModel.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/1.
//  Copyright © 2021 WR. All rights reserved.
//

import Foundation
import Moya
import RxRelay
import RxSwift
import RxBlocking

class TabelViewModel {

    fileprivate lazy var bag : DisposeBag = DisposeBag()

    lazy var wyVariable: BehaviorRelay<[ListData]> = {
        return BehaviorRelay(value: self.getListData(""))
    }()

    var searchText: Observable<String>
    init(searchText: Observable<String>) {
        self.searchText = searchText
        self.searchText.subscribe(onNext: { (str: String) in
            _ = self.getListData(str)
        }).disposed(by: bag)
    }

    deinit {
        print("----------------------")
    }

}

extension TabelViewModel {
    fileprivate func getListData(_ text:String) -> [ListData] {
//        let networkTool =  MoyaProvider<NetworkTool>()
//        let apiHelper = NetworkHelper(moyaProvider: networkTool)
        let apiHelper =   NetworkHelper();
        
        apiHelper.fetchBasicInfo().subscribe(onNext: { [unowned self] (data) in
            if text.count > 0 {
                let datas = data.list?.filter { (dataS) -> Bool in
                    //model是否包含搜索字符串
                    return (dataS.weatherDate!.contains(text))
                }
                //修改value值,重新发出事件
                self.wyVariable.accept(datas!)
            } else {
               self.wyVariable.accept(data.list!)
            }
        }, onError: { (error) in
                print("error",error)
        }).disposed(by: bag)
        return []
    }
}
