//
//  SettingViewController.swift
//  DiffableDataSource
//
//  Created by 이윤지 on 7/20/24.
//

import UIKit
import SnapKit


struct SettingItem: Hashable, Identifiable {
    let id = UUID() // 고유 ID, 데이터를 고유하게 식별하기 위함
    let name: String
    let detail: String?
    let icon: String
}

// DiffableDataSource는 데이터의 스냅샷을 이용하여 UICollectionView의 상태를 관리합니다.
class SettingViewController: UIViewController {
    
    // 3.1. 섹션 정의
    enum Section: CaseIterable {
        case main
        case sub
    }
    
    // 3.2. 컬렉션 뷰 생성 및 레이아웃 설정
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // 3.3. 데이터 소스 변수 선언
    var dataSource: UICollectionViewDiffableDataSource<Section, SettingItem>!
    
    // 3.4. 초기 데이터 리스트
    let list = [
        SettingItem(name: "방해 금지 모드", detail: nil, icon: "moon.fill"),
        SettingItem(name: "수면", detail: nil, icon: "bed.double.fill"),
        SettingItem(name: "업무", detail: "09:00 - 06:00", icon: "briefcase.fill"),
        SettingItem(name: "개인 시간", detail: nil, icon: "person.fill"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints()
        configureDataSource()
        updateSnapshot()
    }
    
    // 3.6. 제약 조건 설정 메서드
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    // 3.7. 데이터 소스 구성 메서드
    private func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, SettingItem>!
        
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            // itemIdentifier 이 식별자는 DiffableDataSource에 의해 관리되며, 데이터의 변경 사항에 따라 자동으로 업데이트됩니다.
            // itemIdentifier는 SettingItem 타입의 객체입니다.
            // 컬렉션뷰의 시스템 셀
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.detail
            content.image = UIImage(systemName: itemIdentifier.icon)
            
            cell.contentConfiguration  = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .systemBackground
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
                    
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .systemGroupedBackground
        configuration.showsSeparators = true
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SettingItem>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)
        
        snapshot.appendItems([SettingItem(name: "모든 기기에서 공유", detail: "하이", icon: "star.fill")], toSection: .sub)
        dataSource.apply(snapshot) // 리로드 데이터
    }
}
