//
//  ViewController.swift
//  SampleCollection
//
//  Created by 松丸真 on 2022/02/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let sampleModel = SampleModel()
    private let disposeBag = DisposeBag()
    
    private let data = BehaviorRelay<[SectionModel]>(value: [])
    
    // DataSource
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>
    private lazy var dataSource = DataSource { _, collectionView, indexPath, item in
        switch item {
        case .tops(let item):
            return collectionView.dequeueReusableCell(for: indexPath, cellType: TopCollectionViewCell.self)
        case .middles(let item):
            return collectionView.dequeueReusableCell(for: indexPath, cellType: MiddleCollectionViewCell.self)
        case .foots(let item):
            return collectionView.dequeueReusableCell(for: indexPath, cellType: FootCollectionViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bind()
    }

    private func configView() {
        collectionView.do {
            $0.rx.setDelegate(self).disposed(by: disposeBag)
            $0.register(cellType: TopCollectionViewCell.self)
            $0.register(cellType: MiddleCollectionViewCell.self)
            $0.register(cellType: FootCollectionViewCell.self)
        }
    }
    
    private func bind() {
        data.accept(sampleModel.data())
        
        data.asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // padding
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // top bottom
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // left, right
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.bounds
        switch indexPath.section {
        case 0:
            return CGSize(width: size.width, height: 200)
        case 1:
            return CGSize(width: size.width, height: 100)
        case 2:
            return CGSize(width: size.width, height: 300)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
