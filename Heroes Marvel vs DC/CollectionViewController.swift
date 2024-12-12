//
//  CollectionViewController.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

protocol SelectHero: UIViewController {
    func selectHero(image: String)
}

class CollectionViewController: UIViewController {

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.alpha = 0.6
    
        return imageView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = true
        return collectionView
    }()
    
    var heroArray = [String]()
    weak var selectHeroDelegate: SelectHero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView)
        
        backgroundImageView.frame = view.bounds
        collectionView.frame = view.bounds
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell",
                                                      for: indexPath)
        let model = heroArray[indexPath.row]
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: model)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = cell.contentView.bounds
        imageView.layer.cornerRadius = 44
        imageView.clipsToBounds = true
        
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2.02,
               height: view.bounds.width / 2.00)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell",
                                                      for: indexPath)
    
        let model = heroArray[indexPath.row]
        
        selectHeroDelegate?.selectHero(image: model)
    }
}
