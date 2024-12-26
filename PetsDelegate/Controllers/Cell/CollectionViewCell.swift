//
//  CollectionViewCell.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 14.12.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let cellID = "CollectionViewCell"
    
    //MARK: - UI elements
    
     var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hero")
        imageView.clipsToBounds = true
         imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    //MARK: - Setup
    private func setupCell() {
        addSubview(cellImageView)
    }
    
    public func cell2HeroConfigure(with image: UIImage) {
        cellImageView.image = image
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
      
            
            cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            cellImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            cellImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}