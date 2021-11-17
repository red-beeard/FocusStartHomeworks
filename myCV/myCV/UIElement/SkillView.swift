//
//  SkillView.swift
//  myCV
//
//  Created by Red Beard on 14.11.2021.
//

import UIKit

final class SkillView: UIView {
    
    private enum Metrics {
        static let smallIndent = CGFloat(10)
        static let mediumIndent = CGFloat(20)
        
        static let sizeImageView = CGFloat(80)
        
        static let titleLabelFontSize = CGFloat(20)
        static let decriptionFontSize = CGFloat(10)
    }
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(skill: Skill) {
        self.init(frame: .zero)
        configuireView(with: skill)
        configuireLayout()
    }
    
    private func configuireView(with skill: Skill) {
        backgroundColor = .white
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        
        configuireImageView(with: skill.language)
        configuireTitleLabel(with: skill.language)
        configuireDescriptionLabel(with: skill.description)
    }
    
    private func configuireImageView(with nameOfImage: String) {
        let image = UIImage(named: nameOfImage)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configuireTitleLabel(with title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configuireDescriptionLabel(with description: String) {
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: Metrics.decriptionFontSize, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configuireLayout() {
        let vStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        
        self.addSubview(imageView)
        self.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Metrics.sizeImageView),
            imageView.widthAnchor.constraint(equalToConstant: Metrics.sizeImageView),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.smallIndent),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.smallIndent)
        ])
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Metrics.mediumIndent),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.mediumIndent),
            vStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
