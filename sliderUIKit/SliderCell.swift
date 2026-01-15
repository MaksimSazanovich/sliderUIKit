//
//  SliderCell.swift
//  sliderUIKit
//
//  Created by Maksim on 15.01.26.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlide()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSlide() {
        titleLabel = createLabel(color: .white, font: .systemFont(ofSize: 20, weight: .black))
        textLabel = createLabel(color: .white, font: .systemFont(ofSize: 16, weight: .regular))

        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func createLabel(color: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        
        label.textColor = .white
        label.numberOfLines = 0
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
