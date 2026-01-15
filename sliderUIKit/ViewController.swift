//
//  ViewController.swift
//  sliderUIKit
//
//  Created by Maksim on 15.01.26.
//

import UIKit

class ViewController: UIViewController {
    
    private let sliderData: [SliderItem] = [
        SliderItem(color: .brown, title: "Slide 1", text: "lorem ipsum dolor sit amet consectetur adipiscing elit. ", animationName: ""),
        SliderItem(color: .orange, title: "Slide 2", text: "ipsum dolor sit amet consectetur adipiscing elit.sit amet consectetur adipiscing ", animationName: ""),
        SliderItem(color: .gray, title: "Slide 3", text: "Оно конечно прикольно, только ios разработка потихоньку схлопывается в РФ, самое время переходить на флаттер какой-нибудь :)", animationName: "")
    ]
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(SliderCell.self, forCellWithReuseIdentifier: "cell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    private func setupCollection() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell {
            
            cell.contentView.backgroundColor = sliderData[indexPath.row].color
            cell.titleLabel.text = sliderData[indexPath.row].title
            cell.textLabel.text = sliderData[indexPath.item].text
            
            return cell
        }
       
        return UICollectionViewCell()
        
    }
}

struct SliderItem {
    var color: UIColor
    var title: String
    var text: String
    var animationName: String
}
