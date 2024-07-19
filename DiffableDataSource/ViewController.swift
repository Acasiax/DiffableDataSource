//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by 이윤지 on 7/19/24.
//

import UIKit

struct Item: Hashable {
    let id: UUID
    let title: String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}

class ViewController: UIViewController {
    
    enum Section {
        case main
        case version
    }
    
    var tableView: UITableView! = nil
    var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
        applySnapshot()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            return cell
        }
    }
    
    func applySnapshot() {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            
            // Main 섹션 항목 추가
            snapshot.appendSections([.main])
            let mainItems = [
                Item(title: "공지사항"),
                Item(title: "실험실")
            ]
            snapshot.appendItems(mainItems, toSection: .main)
            
            // Version 섹션 항목 추가
            snapshot.appendSections([.version])
            let versionItems = [
                Item(title: "버전정보")
            ]
            snapshot.appendItems(versionItems, toSection: .version)
            
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
