//
//  ViewController.swift
//  sliderUIKit
//
//  Created by Maksim on 15.01.26.
//

import UIKit

class ViewController: UIViewController {
    
    private let sliderData: [SliderItem] = [
        SliderItem(color: .brown, title: "Slide 1", text: "lorem ipsum dolor sit amet consectetur adipiscing elit. ", animationName: "Space Runner"),
        SliderItem(color: .orange, title: "Slide 2", text: "ipsum dolor sit amet consectetur adipiscing elit.sit amet consectetur adipiscing ", animationName: "space x f"),
        SliderItem(color: .gray, title: "Slide 3", text: "Оно конечно прикольно, только ios разработка потихоньку схлопывается в РФ, самое время переходить на флаттер какой-нибудь :)", animationName: "space boy developer.json")
    ]
    
    private var pagers: [UIView] = []
    private var currentSlide = 0
    private var previousSlide = 0
    private var widthAnchor: NSLayoutConstraint?
    
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
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.backgroundColor = .clear
        
        return button
    }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var nextButton: UIView = {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
        
        let nextImage = UIImageView()
        nextImage.image = UIImage(systemName: "chevron.right.circle.fill")
        nextImage.tintColor = .white
        nextImage.contentMode = .scaleAspectFit
        nextImage.translatesAutoresizingMaskIntoConstraints = false
        
        nextImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        nextImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        let button = UIView()
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        button.addSubview(nextImage)
        
        nextImage.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        nextImage.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupControll()
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
    
    private func setupControll() {
        
        view.addSubview(hStack)
            
        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill
        pagerStack.translatesAutoresizingMaskIntoConstraints = false
        
        for tag in 1...sliderData.count {
            let pager = UIView()
            pager.tag = tag
            pager.translatesAutoresizingMaskIntoConstraints = false
            pager.backgroundColor = .white
            pager.layer.cornerRadius = 5
            pager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender: ))))
            self.pagers.append(pager)
            pagerStack.addArrangedSubview(pager)
        }
        
        vStack.addArrangedSubview(pagerStack)
        vStack.addArrangedSubview(skipButton)
        
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(nextButton)
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    @objc func nextSlide() {
        print("nextSlide")
    }
    
    @objc func scrollToSlide(sender: UIGestureRecognizer) {
        if let index = sender.view?.tag {
            collectionView.scrollToItem(at: IndexPath(row: index - 1, section: 0), at: .centeredHorizontally, animated: true)
            
            previousSlide = currentSlide
            currentSlide = index - 1
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell {
            
            cell.contentView.backgroundColor = sliderData[indexPath.row].color
            cell.titleLabel.text = sliderData[indexPath.item].title
            cell.textLabel.text = sliderData[indexPath.item].text
            
            //.setunAnimation(animationName: sliderData[indexPath.item].animationName)
            
            return cell
        }
       
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        previousSlide = currentSlide
        currentSlide = indexPath.item
        
//        print("willDisplay current slide: \(currentSlide)")
//        print("willDisplay previous slide: \(previousSlide)")
        
        pagers.forEach { page in
            
            page.constraints.forEach { constraint in
                page.removeConstraint(constraint)
            }
            
            let tag = page.tag
            let viewTag = indexPath.item + 1
            
            if tag == viewTag {
                UIView.animate(withDuration: 0.3) {page.layer.opacity = 1}
                UIView.animate(withDuration: 0.3) {self.widthAnchor = page.widthAnchor.constraint(equalToConstant: 20)}
            } else {
                UIView.animate(withDuration: 0.3) {page.layer.opacity = 0.5}
                UIView.animate(withDuration: 0.3) {self.widthAnchor = page.widthAnchor.constraint(equalToConstant: 10)}
            }
            
            widthAnchor?.isActive = true
            page.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
    }
    
   func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//       print("didDisplay current slide: \(currentSlide)")
//       print("didDisplay indexPath.item: \(indexPath.item)")
//       print("didDisplay previous slide: \(previousSlide)")
       
       if currentSlide == indexPath.item {
           
           currentSlide = previousSlide
           
           pagers.forEach { page in
               
               page.constraints.forEach { constraint in
                   page.removeConstraint(constraint)
               }
               
               let tag = page.tag
               let viewTag = currentSlide + 1
               
               if tag == viewTag {
                   UIView.animate(withDuration: 0.3) {page.layer.opacity = 1}
                   UIView.animate(withDuration: 0.3) {self.widthAnchor = page.widthAnchor.constraint(equalToConstant: 20)}
               } else {
                   UIView.animate(withDuration: 0.3) {page.layer.opacity = 0.5}
                   UIView.animate(withDuration: 0.3) {self.widthAnchor = page.widthAnchor.constraint(equalToConstant: 10)}
               }
               
               widthAnchor?.isActive = true
               page.heightAnchor.constraint(equalToConstant: 10).isActive = true
           }
       }
    }
}

struct SliderItem {
    var color: UIColor
    var title: String
    var text: String
    var animationName: String
}
