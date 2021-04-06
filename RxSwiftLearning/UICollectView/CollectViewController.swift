//
//  CollectViewController.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/1.
//  Copyright © 2021 WR. All rights reserved.
//

import UIKit
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa
import Moya

fileprivate let kCollectCell: String = "collectCell"

class CollectViewController: UIViewController {

    var searchBar: UISearchBar!
    var rxCollectView: UICollectionView!
    fileprivate lazy var bag = DisposeBag()
    fileprivate lazy var dataVM:CollectViewModel = CollectViewModel(searchText: self.searchText)

    var searchText: Observable<String> {
        //输入后间隔0.5秒搜索,在主线程运行
        let time = DispatchTimeInterval.seconds(Int(0.5))
        return searchBar.rx.text.orEmpty.throttle(time, scheduler: MainScheduler.instance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setUpSearchBar()
        setUpCollectionView()
        // Do any additional setup after loading the view.
    }

    func setUpSearchBar() -> Void {
        searchBar = UISearchBar()
        searchBar.accessibilityIdentifier = "searchTextBar"
        self.view.addSubview(searchBar)
        searchBar.backgroundColor = UIColor.white
        searchBar.tintColor = UIColor.white
        searchBar.snp.makeConstraints { (make) in
            make.topMargin.equalToSuperview().offset(10)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
    }

    func setUpCollectionView() -> Void {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 300, height: 200)
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)

        rxCollectView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.view.addSubview(rxCollectView)
        rxCollectView.snp.makeConstraints { (make) in
           make.left.right.bottom.equalTo(self.view)
           make.top.equalTo(self.searchBar.snp.bottom)
        }
        rxCollectView.backgroundColor = UIColor.white
        //0.加载collectionViewCell
        rxCollectView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectCell)

        //1.设置代理
        //1-1. 绑定cell
        let dataSource = RxCollectionViewSectionedReloadDataSource<ModelSection>(configureCell:{(dataSource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectCell, for: indexPath) as! CollectionViewCell
            cell.listModel = item
            return cell
        })
        self.dataVM.wyVariable.asDriver().drive(self.rxCollectView.rx.items(dataSource: dataSource)).disposed(by: self.bag)
    }
}

extension CollectViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleLabel.text = "CollectViewList"
        titleLabel.textColor = UIColor.black
        navigationItem.titleView = titleLabel
    }
}
