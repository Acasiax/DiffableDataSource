//
//  TravelListViewController.swift
//  DiffableDataSource
//
//  Created by 이윤지 on 7/21/24.
//

import UIKit
import SnapKit

// User 모델 정의
struct User: Hashable, Identifiable {
    let id = UUID()
    let username: String
    let message: String
    let date: String
    let imageName: String
}

class TravelListViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    let list = [
            User(username: "Hue", message: "왜요? 요즘 코딩이 대세인데", date: "24.01.12", imageName: "person"),
            User(username: "Jack", message: "깃허브는 푸시하셨나요?", date: "24.01.12", imageName: "person"),
            User(username: "Bran", message: "과제 화이팅!", date: "24.01.11", imageName: "person"),
            User(username: "Den", message: "벌써 퇴근하세요?ㅎㅎㅎㅎㅎ", date: "24.01.10", imageName: "person"),
            User(username: "내옆의앞자리에개발잘하는친구", message: "내일 모닝콜 해주실분~~", date: "24.01.09", imageName: "person"),
            User(username: "심심이", message: "아닛 주말과제라닛", date: "24.01.08", imageName: "person")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints()
        configureDataSource()
        updateSnapshot()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<TravelListViewCell, User> { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
    }
}

// CollectionViewCell 정의
class TravelListViewCell: UICollectionViewListCell {
    let userImageView = UIImageView()
    let usernameLabel = UILabel()
    let messageLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        userImageView.layer.cornerRadius = 20
        userImageView.clipsToBounds = true
        
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .gray
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
        
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalTo(userImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(4)
            make.leading.equalTo(usernameLabel)
            make.trailing.equalTo(usernameLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(4)
            make.leading.equalTo(usernameLabel)
            make.trailing.equalTo(usernameLabel)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(with user: User) {
        userImageView.image = UIImage(systemName: user.imageName)
        usernameLabel.text = user.username
        messageLabel.text = user.message
        dateLabel.text = user.date
    }
}
