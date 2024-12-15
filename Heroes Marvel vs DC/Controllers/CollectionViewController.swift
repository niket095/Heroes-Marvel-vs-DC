//
//  CollectionViewController.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

protocol SelectHeroProtocol: UIViewController {
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
    
    var heroArray = [HeroModelElement]()
    weak var selectHeroDelegate: SelectHeroProtocol?
    
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
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID,
                                                      for: indexPath) as! CollectionViewCell
        let model = heroArray[indexPath.row]
        cell.cellHeroConfigure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2.02,
               height: view.bounds.width / 2.00)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let model = heroArray[indexPath.row]
        
        selectHeroDelegate?.selectHero(image: model.thumbnail.url?.absoluteString ?? "")
    }
}

/*
 пример:
 в делегате коллекции, в методе, где обрабатывается нажатие на ячейку - с помощью протокола мы передаем картинку, которая находится в ячейке, которую нажал пользователь (картинка высчитана из массива с данными с помощью indexPath):
 
 func collectionView(___ didSelectItemAt___) {
 
 let cell = ...
 let image = someArray(indexPath.row)
 
 selectHeroDelegate?.selectHero(image: image)
 переменная-ссылкаНаПротокол.МетодПротокола(тип: картинка из ячейки)
 }
 
 */
