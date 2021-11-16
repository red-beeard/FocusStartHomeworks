//
//  DeveloperViewController.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

final class DeveloperViewController: UIViewController {
    
    private enum Metrics {
        static let mediumIndent = CGFloat(20)
        static let largeIndent = CGFloat(40)
        
        static let heightSkillView = CGFloat(100)
    }
    
    var person: Person!
    
    private var titleLabel: UILabel!
    private var skillViews: [SkillView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuireTitleLabel()
        configuireSkillViews()
        configuireLayout()
    }
    
    private func configuireTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Мои скиллы"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    private func configuireSkillViews() {
        skillViews = person.skills.map { SkillView(skill: $0) }
    }
    
    private func configuireLayout() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        skillViews.forEach { skillView in
            self.view.addSubview(skillView)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metrics.largeIndent),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        var prevView: UIView = titleLabel
        for skillView in skillViews {
            NSLayoutConstraint.activate([
                skillView.topAnchor.constraint(equalTo: prevView.bottomAnchor, constant: Metrics.mediumIndent),
                skillView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.mediumIndent),
                skillView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.mediumIndent),
                skillView.heightAnchor.constraint(equalToConstant: Metrics.heightSkillView),
            ])
            
            prevView = skillView
        }
    }

}
