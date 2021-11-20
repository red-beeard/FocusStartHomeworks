//
//  TableViewController.swift
//  CollectionApp
//
//  Created by Red Beard on 20.11.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    private enum Metrics {
        static let rowHeight = CGFloat(100)
    }
    
    private let images = Image.getImages()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Фотографии"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .systemBackground
        
        self.tableView.rowHeight = Metrics.rowHeight
        self.tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = images.count / 2
        return section == 0 ? numberOfRowsInSection : self.images.count - numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Первая секция" : nil
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return section == 0 ? nil : "Вторая секция"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        cell.imageData = self.images[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoVC = PhotoViewController()
        photoVC.image = self.images[indexPath.row]
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
}
