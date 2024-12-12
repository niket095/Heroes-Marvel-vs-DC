//
//  ViewController.swift
//  Heroes Marvel vs DC
//
//  Created by Nikita Putilov on 11.12.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.alpha = 0.8
        return imageView
    }()
    
    private var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hero")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var marvelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("MARVEL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tag = 0
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dcButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkGray
        button.setTitle("DC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tag = 1
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let marvelArray = ["1_1", "1_2"]
    private let dcArray = ["2_1", "2_2"]

    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundImageView)
        view.addSubview(heroImageView)
        view.addSubview(marvelButton)
        view.addSubview(dcButton)
        
        backgroundImageView.frame = view.bounds
    }
    
    private func setupArray(_ array: [String], label: String) {
        let vc = CollectionViewController()
        vc.title = label
        vc.heroArray = array
        vc.selectHeroDelegate = self
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 44
        }
        
        present(vc, animated: true)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            setupArray(marvelArray, label: "Select MARVEL hero")
        } else {
            setupArray(dcArray, label: "Select DC hero")
        }
    }
}


extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        heroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        heroImageView.widthAnchor.constraint(equalToConstant: 320),
        heroImageView.heightAnchor.constraint(equalToConstant: 320),
        
        marvelButton.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 30),
        marvelButton.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor),
        marvelButton.trailingAnchor.constraint(equalTo: heroImageView.centerXAnchor, constant: -10),
        marvelButton.heightAnchor.constraint(equalToConstant: 65),
        
        dcButton.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 30),
        dcButton.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor),
        dcButton.leadingAnchor.constraint(equalTo: heroImageView.centerXAnchor, constant: 10),
        dcButton.heightAnchor.constraint(equalToConstant: 65),
        
        ])
    }
}

extension MainViewController: SelectHero {
    func selectHero(image: String) {
        heroImageView.image = UIImage(named: image)
    }
}

