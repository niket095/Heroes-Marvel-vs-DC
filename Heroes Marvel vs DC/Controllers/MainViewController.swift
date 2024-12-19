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
//imageView.image = UIImage(named: "hero")
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
    
    private var dcArray = [Int]()
    private var codeArray: [Int] = [201, 102313, 23200, 101, 203, 202, 205, 226, 204, 207, 218, 206, 100, 208, 402, 400, 102, 505, 406, 401, 407, 404, 408, 418, 405, 403, 409, 300, 301, 302, 303, 304, 305, 306, 307, 308, 410, 411, 412, 413, 414, 415, 417, 416, 420, 421, 422, 423, 424, 425, 428, 426, 429, 430, 431, 440, 444, 449, 450, 451, 460, 463, 524, 464, 497, 496, 495, 498, 494, 499, 500, 502, 501, 503, 506, 507, 508, 509, 510, 511, 521, 527, 419, 504, 999]
    private var marvelArray = [HeroMarvelModel]()
    private var petsArray = [UIImage]()
    private var petsCatsArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMArvelArray()
     
        setupViews()
        setConstraints()
        setupDcArray()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundImageView)
        view.addSubview(heroImageView)
        view.addSubview(marvelButton)
        view.addSubview(dcButton)
        
        backgroundImageView.frame = view.bounds
    }
 
    private func setupArray(_ array: [UIImage], flag: Bool, label: String) {
        let vc = CollectionViewController()
        vc.heroLabel.text = label
        vc.isUsingArray = flag
        vc.heroArray.removeAll()
        vc.heroArray = array
        fetchAllHTTPPetsImages(pet: flag)
        vc.marvelArray = marvelArray
        vc.selectHeroDelegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 44
        }
        
        present(vc, animated: true)
    }
    
    private func setupMArvelArray() {
        NetworkDataFetch.shared.fetchMarvelHeroes { [weak self] heroes, error in
            guard let self = self, let heroes = heroes else {
                print("Error fetching heroes: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.marvelArray = heroes
            }
        }
    }
    
    private func setupDcArray() {
        
        //        NetworkRequest.shared.fetchHTTPDogImage(statusCode: 100) { code, image in
        //            if let image = image {
        //                DispatchQueue.main.async {
        //                    self.heroImageView.image = image
        //                }
        //                } else {
        //                    print("123141")
        //                }
        //            }
        //        }
    }
    
    func fetchAllHTTPPetsImages(pet: Bool) {
      //  let statusCodes = 100...599
        codeArray.sort()
        for statusCode in codeArray {
          
            if pet == true {
                NetworkRequest.shared.fetchHTTPDogImage(statusCode: statusCode) { code, image in
                    if let image = image {
                    //    DispatchQueue.main.async {
                            self.petsArray.append(image)
                           
                    //    }
                    } else {
                        self.petsArray.append(UIImage(named: "2_1")!)
                       // heroImageView.image = UIImage(named: "2_1")
                        print("No image for \(statusCode)!")
                    }
                }
            } else if pet == false {
                NetworkRequest.shared.fetchHTTPCatImage(statusCode: statusCode) { code, image in
                    if let image = image {
                     //   DispatchQueue.main.async {
                            self.petsCatsArray.append(image)
                      //  }
                    } else {
                        print("No image for \(statusCode)!")
                    }
                }
            }
            
           
        }
    }
//        NetworkDataFetch.shared.fetchHeroes { [weak self] heroes in
//            guard let self = self, let heroes = heroes else {
//              //  print("Error fetching heroes: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self.dcArray1 = heroes
//                print(self.dcArray1)
//            }
//        }
    
    
    @objc private func buttonTapped(_ sender: UIButton) {
            if sender.tag == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.setupArray(self.petsCatsArray, flag: false, label: "Select CAT hero")
                }
            } else {
                setupArray(petsArray, flag: true, label: "Select DOG hero")
            }
        }
    }

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        heroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        heroImageView.widthAnchor.constraint(equalToConstant: view.frame.width - 10),
        heroImageView.heightAnchor.constraint(equalToConstant: 420),
        
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

extension MainViewController: SelectHeroProtocol {
    func selectHero(image: UIImage, name: String) {
        heroImageView.image = image
    }
}

