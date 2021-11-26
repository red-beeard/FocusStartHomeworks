//
//  ViewController.swift
//  CollectionAppWithArchitecture
//
//  Created by Red Beard on 26.11.2021.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private let customView: CollectionView!
    private let images: [Image]?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        self.customView = CollectionView(frame: UIScreen.main.bounds)
        self.images = Image.getImages()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        customView.loadView(controller: self)
        customView.setImages(images: self.images)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(customView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.customView.configuireView()
    }
    
    func cellPressed(with image: Image) {
        //        let photoVC = PhotoViewController()
        //        photoVC.image = self.images[indexPath.item]
        //        self.navigationController?.pushViewController(photoVC, animated: true)
    }

}

