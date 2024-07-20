//
//  SimpleViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 이윤지 on 7/18/24.
//

import UIKit
import SnapKit


/*
 UITableViewDelegate, UITableViewDataSource: sys. cus
 UI컬렉션뷰 딜리게이트, 유아이컬렉션뷰 데이타소스: ststem x,
 - 지금은 list 형태 이지만 나중에 변경될 가능성
 - >>> 컬렉션뷰이지만 테이블뷰 처럼 쓸 수 있게 해줄게
 
 // 무엇 (어떤 데이터)을 어떤 (Flow)레이아웃으로 표현(셀 디자인)할 것인가?
 
 
 
 iOS13+
 
 */

class SimpleViewController: UIViewController {

    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
       
    }
    

}


extension SimpleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell")!
        
        var content = cell.defaultContentConfiguration()
        content.text = "aaaa"
        content.secondaryText = "343434"
        content.textProperties.color = .systemGreen
        content.image = UIImage(systemName: "star")
        content.imageProperties.tintColor = .red
        content.imageToTextPadding = 30
        cell.contentConfiguration = content
      
        return cell
    }
    
    
}

// ReusableView 프로토콜 정의
protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

// 프로토콜 기본 구현 제공
extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
