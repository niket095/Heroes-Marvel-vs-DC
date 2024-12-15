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
    
    private var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hero")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    //MARK: - Setup
    private func setupCell() {
        
        addSubview(cellImageView)
    }
    
    //Cell Configure
    public func cellHeroConfigure(with model: HeroModelElement) {
        
        
        guard let url = model.thumbnail.url else { return }
        
        NetworkRequest.shared.requestData(url: url.absoluteString) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let dataImage = UIImage(data: data)
                self.cellImageView.layer.cornerRadius = 0
                self.cellImageView.image = dataImage
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellImageView.heightAnchor.constraint(equalToConstant: self.frame.height),
            cellImageView.widthAnchor.constraint(equalToConstant: self.frame.width)
        ])
    }
    
    
    //Error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
