//
//  CustomBasicViewController.swift
//  DiffableDataSource
//
//  Created by 이윤지 on 7/20/24.
//


//Diffable Data Source를 사용하여 UICollectionView를 설정하는 방법
import UIKit
import SnapKit

struct cafe: Hashable, Identifiable {
    let id = UUID() // 고유 ID, 데이터를 고유하게 식별하기 위함
    let name8 : String
    let count : Int
    let price: Int
}

//DiffableDataSource는 데이터의 스냅샷을 이용하여 UICollectionView의 상태를 관리합니다.
class CustomBasicCollectionViewController: UIViewController {
    
    // 3.1. 섹션 정의
    enum Section: CaseIterable {
        case main
        case sub
    }
    
    // 3.2. 컬렉션 뷰 생성 및 레이아웃 설정
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // 3.3. 데이터 소스 변수 선언
    var dataSource: UICollectionViewDiffableDataSource<Section, cafe>!
    
    // 3.4. 초기 데이터 리스트
    let list = [
        cafe(name8: "아메리카노", count: 1, price: 4500),
        cafe(name8: "라떼", count: 1, price: 5000),
        cafe(name8: "바닐라빈라떼", count: 30, price: 7000),
        cafe(name8: "디카페인아메리카노", count: 1, price: 5000),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints()
        configureDataSource()
        createLayout()
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
        var registerarion: UICollectionView.CellRegistration<UICollectionViewListCell, cafe>!
        
        
        registerarion = UICollectionView.CellRegistration {cell, IndexPath,itemIdentifier in
            // itemIdentifier 이 식별자는 DiffableDataSource에 의해 관리되며, 데이터의 변경 사항에 따라 자동으로 업데이트됩니다.
            // itemIdentifier는 cafe 타입의 객체입니다.
            //컬렉션뷰의 시스템 셀
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name8
            content.secondaryText = itemIdentifier.price.formatted() + "원"
            content.textProperties.color = .orange
            content.image = UIImage(systemName: "star.fill")
            
            cell.contentConfiguration  = content
            
            var backgroundCongig = UIBackgroundConfiguration.listGroupedCell()
            backgroundCongig.backgroundColor = .yellow
            backgroundCongig.cornerRadius = 40
            backgroundCongig.strokeColor = .systemRed
            backgroundCongig.strokeWidth = 20
            
            cell.backgroundConfiguration = backgroundCongig
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath,itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registerarion, for: indexPath,  item: itemIdentifier)
            
            return cell
        })
        
        }
                    
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .systemGreen
        configuration.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
        private func updateSnapshot() {
            var snapshot = NSDiffableDataSourceSnapshot<Section, cafe>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(list, toSection: .main)
            
            snapshot.appendItems([cafe(name8: "테스트", count: 5, price: 5)], toSection: .sub)
            dataSource.apply(snapshot) //리로드 데이터
            
        }
         }
