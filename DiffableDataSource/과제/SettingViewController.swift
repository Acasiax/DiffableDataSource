//
//  SetViewController.swift
//  DiffableDataSource
//
//  Created by 이윤지 on 7/20/24.
//


import UIKit
import SnapKit

class SettingViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HiCell")
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
        navigationItem.title = "설정"
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3 // 전체 설정 섹션의 행 수
        case 1:
            return 4 // 개인 설정 섹션의 행 수
        case 2:
            return 1 // 기타 섹션의 행 수
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "전체 설정"
        case 1:
            return "개인 설정"
        case 2:
            return "기타"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HiCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            let items = ["공지사항", "실험실", "버전 정보"]
            content.text = items[indexPath.row]
        case 1:
            let items = ["개인/보안", "알림", "채팅", "멀티프로필"]
            content.text = items[indexPath.row]
        case 2:
            let items = ["고객센터/도움말"]
            content.text = items[indexPath.row]
        default:
            content.text = ""
        }
        
        cell.contentConfiguration = content
        return cell
    }
}
