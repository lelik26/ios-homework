//
//  InfoViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var transitionButtonAlert: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        button.setTitle("Внимание Тревога ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(alertClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "Информация"
        self.setupViewAlert()
       
        
    }
    private func setupViewAlert() {
        self.view.addSubview(self.transitionButtonAlert)
        self.activateConstraintsAlert()
    }
    
     private func activateConstraintsAlert() {
      
        self.transitionButtonAlert.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250).isActive = true
        self.transitionButtonAlert.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.transitionButtonAlert.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        self.transitionButtonAlert.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    @objc func alertClicked() {
        let alert = UIAlertController(title: "Внимание", message: "Удалить профиль?", preferredStyle: .alert)
        let agreeButton = UIAlertAction(title: "Да", style: .default, handler: nil)
        let disagreeButton = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alert.addAction(agreeButton)
        alert.addAction(disagreeButton)
        present(alert, animated: true, completion: nil)
       // print("alert work")
    }

}
