//
//  CustomTableViewController.swift
//  DiffableDataSource
//
//  Created by 이윤지 on 7/20/24.
//

import UIKit
import SnapKit

class CustomTableViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HiCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HiCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration() //이건 뭐지 -> 기본적인 테이블뷰 셀의 콘텐츠 구성을 손쉽게 설정할 수 있도록 도와주는 것.  이 메서드는 UITableViewCell의 인스턴스에서 호출되며, 기본 텍스트, 이미지, 그리고 추가적인 속성들을 설정할 수 있는 UIListContentConfiguration 객체를 반환함. 메서드는 iOS 14 이상에서 사용.
        
        content.text = "안녕 반가워요"
        content.secondaryText = "세컨더리 텍스트"
        content.textProperties.color = .systemGreen
        content.image = UIImage(systemName: "star")
        content.imageProperties.tintColor = .red
        content.imageToTextPadding = 30
        
        cell.contentConfiguration = content
        
        return cell
    }
}
