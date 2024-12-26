//
//  CollectionViewController.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

protocol SelectHeroProtocol: UIViewController {
    func selectHero(image: UIImage, name: String)
}

class CollectionViewController: UIViewController {
    
    //MARK: - UI elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.alpha = 0.2
        return imageView
    }()
    
    var petLabel: UILabel = {
        let label = UILabel()
        label.text = "Select pet"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var isUsingArray = true
    var petArray = [UIImage]()
    var catArray = [UIImage]()
    weak var selectHeroDelegate: SelectHeroProtocol?
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - Setup
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(petLabel)
        view.addSubview(collectionView)
        
        backgroundImageView.frame = view.bounds
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            petLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            petLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            petLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: petLabel.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        petArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellID,
                                                      for: indexPath) as! CollectionViewCell
        
        let model = petArray[indexPath.row]
        cell.cell2HeroConfigure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2.10,
               height: view.bounds.width / 2.10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        
        guard let image = cell?.cellImageView.image else { return }
        
        selectHeroDelegate?.selectHero(image: image, name: "DOG!")
    }
}
