//
//  SimpleCollectionViewController.swift
//  SeSAC5MVVMBasic
//
//  Created by 이윤지 on 7/18/24.
//

import UIKit

/*
 Data: delegate/datasource(인덱스 기반) -> diffable(데이터 기반)
 Layout: height/flow -> compositional -> 14+ listConfiguration
Presentation: cell/view(dq리유즈어블 셀) -> CellRegistration
 
 
 
 register 메서드 대신에 누구를 쓰는가? CellRegistration
 
 */
/*
 DiffableDataSource<String, Fruit>. String은 뭔지? Hashable은 뭔지?
 Hashable 왜 써야됨?
 그럼 같은 데이터를 못 쓰는건가?? 한 리스트에?? UUID
 =>
 
 
 상식 UUID -> realm
 => UUID vs UDID(디바이스 아이디) 동일한 값
 
 UDID는 접근 못하여 private id라고 함
 
 UUID는 Fruit. realm
 UUID 앱을 삭제했다가 지우면 다시 생성된다.
 
 */
struct Fruit: Hashable, Identifiable { //5.3+
    let id = UUID() //앱을 삭제했다가 지우면 다시 생성된다. // 고유, 데이터 판별. 뷰x
    let name: String
    let count: Int
    let price: Int
}


class SimpleCollectionViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
        case sub
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    //    var registerarion: UICollectionView.CellRegistration<UICollectionViewListCell, Fruit>!
    
    //UICollectionViewDataSource =>
    //<섹션을 구분해 줄 데이터  타입, 셀에 들어가는 데이터 타입>
  
    var dataSource: UICollectionViewDiffableDataSource<Section, Fruit>! //numberOfItemsInSection, cellForItemAt
    
    let list = [
        Fruit(name: "사과", count: 10, price: 3000),
        Fruit(name: "사과", count: 11, price: 3000),
        Fruit(name: "샤인머스켓", count: 30, price: 14000),
        Fruit(name: "애플망고", count: 2, price: 9000),
        Fruit(name: "바나나", count: 100, price: 1000)
        ]
    
    private func configureDataSource() {
        var registerarion: UICollectionView.CellRegistration<UICollectionViewListCell, Fruit>!
        //collectionView.register > uicollectionview.cellregistration
        registerarion = UICollectionView.CellRegistration {cell, indexPath, itemIdentifier in
            
            //컬렉션뷰의 시스템 셀
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.secondaryText = itemIdentifier.price.formatted() + "원"
            content.textProperties.color = .blue
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .orange
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .yellow
            backgroundConfig.cornerRadius = 40
            backgroundConfig.cornerRadius = 40
            backgroundConfig.strokeColor = .systemRed
            backgroundConfig.strokeWidth = 20
            
            cell.backgroundConfiguration = backgroundConfig
            
          
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: registerarion, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    //Flow -> Compositional -> List Configuration
    func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .systemGreen
        configuration.showsSeparators = false
  
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
       
        
        configureDataSource()
        updateSnapshot()
       
    }
    
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Fruit>()
        snapshot.appendSections(Section.allCases)
       // snapshot.appendSections(["고래밥","고래밥"])
        snapshot.appendItems(list, toSection: .main)
        
        snapshot.appendItems([Fruit(name: "테스트", count: 5, price: 5)], toSection: .sub)
        dataSource.apply(snapshot) //리로드 데이타
    }
    
    
    
}

//
//extension SimpleCollectionViewController: UICollectionViewDataSource {
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    
//    //  1 custom cell + identifier + register
//    // => system cell +     x      + CellRegisteration
//    //  2. list[indexPath.item], cell.lame.name => itemIdentifier
//    // 3.
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 디큐리유즈어플셀 -> .dequeueConfiguredReusableCell
//        
//        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "df", for: indexPath) as! UICollectionViewCell
//        //        let data = list[indexPath.item]
//        
//        
//        let cell = collectionView.dequeueConfiguredReusableCell(using: registerarion, for: indexPath, item: list[indexPath.item])
//        
//        return cell
//    }
//    
//    
//}




//7월 22일 월요일 오후 1시 ~ 7월 29일 월요일 오후 11시 00분 00초
//월,수 9시30분~
//화,목 10시
//8월 2일 (금) DDP 새싹 매칭 데이 10시~18시
//
