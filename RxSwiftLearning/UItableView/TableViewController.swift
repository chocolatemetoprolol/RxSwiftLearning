//
//  TableViewController.swift
//  RxSwiftLearning
//
//  Created by lovechocolate on 2021/4/1.
//  Copyright © 2021 WR. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Moya

fileprivate let kCellID: String = "dataCell"

class TableViewController: UIViewController {

    var searchBar: UISearchBar!
    var rxTableView: UITableView!
    fileprivate lazy var bag = DisposeBag()
    fileprivate lazy var dataVM:TabelViewModel = TabelViewModel(searchText: self.searchText)

    var searchText: Observable<String> {
        //输入后间隔0.5秒搜索,在主线程运行
        let time = DispatchTimeInterval.seconds(Int(0.5))
        return searchBar.rx.text.orEmpty.throttle(time, scheduler: MainScheduler.instance)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavigationBar()
        setUpSearchBar()
        setUpTableView()
        bindData()
        // Do any additional setup after loading the view.
    }

    func setUpTableView() -> Void {
           rxTableView = UITableView(frame: .zero, style: .plain)
           self.view.addSubview(rxTableView)
           rxTableView.snp.makeConstraints { (make) in
               make.left.right.bottom.equalTo(self.view)
               make.top.equalTo(self.searchBar.snp.bottom)
           }
           rxTableView.backgroundColor = UIColor.white
           rxTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: kCellID)
           // 3.监听UITableView的点击
           rxTableView.rx.modelSelected(ListData.self).subscribe { (event: Event<ListData>) in
            self.gotoNext(event.element!)
           }.disposed(by: bag)
           rxTableView.rx.setDelegate(self).disposed(by: bag)
       }

       func gotoNext(_ time:ListData) -> Void {
        let collectVc = CollectViewController()
        self.navigationController?.pushViewController(collectVc, animated: true)
       }

       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }

       func bindData() -> Void {
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(0.5))) {
            self.dataVM.wyVariable.asDriver().drive(self.rxTableView.rx.items(cellIdentifier:kCellID, cellType: TableViewCell.self)) { (_, model, cell) in
                   DispatchQueue.main.async {
                       cell.listModel = model
                   }
               }.disposed(by: self.bag)
           }
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
}

extension TableViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleLabel.text = "TableViewList"
        titleLabel.textColor = UIColor.black
        navigationItem.titleView = titleLabel
    }
}

extension TableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}
