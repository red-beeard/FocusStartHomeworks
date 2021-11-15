//
//  DeveloperViewController.swift
//  myCV
//
//  Created by Red Beard on 12.11.2021.
//

import UIKit

class DeveloperViewController: UIViewController {
    
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
        skillViews = []
        
        for skill in person.skills {
            skillViews.append(SkillView(skill: skill))
        }
    }
    
    private func configuireLayout() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        skillViews.forEach { skillView in
            self.view.addSubview(skillView)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        var prevView: UIView = titleLabel
        for skillView in skillViews {
            NSLayoutConstraint.activate([
                skillView.topAnchor.constraint(equalTo: prevView.bottomAnchor, constant: 20),
                skillView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                skillView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                skillView.heightAnchor.constraint(equalToConstant: 100),
            ])
            
            prevView = skillView
        }
    }

}
