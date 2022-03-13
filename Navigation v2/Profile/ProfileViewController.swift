//
//  ProfileViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileView = {   // установка свойств View
        let view = ProfileView(frame: .zero)
        view.delegate = self   // установка делегата
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
  // private var heightConstraint: NSLayoutConstraint? //
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.setupNavigationBar()
       self.setupView()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
     
       
        
    }
    
    private func setupNavigationBar() {   // установка Navigation controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Профиль"
        
    }
    
    private func setupView() {     // установка view
        self.view.backgroundColor = .white
        self.view.addSubview(self.profileHeaderView)
        
        /// **Создания constrait  for View**
        
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
     //   self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 500)
       let heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 500)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, heightConstraint].compactMap({ $0 }))// объявление всех constrait и активирует расчет
    }
    
    
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func buttonPressed (textFieldIsVisible: Bool, completion: @escaping () -> Void) {
      // heightConstraint?.constant = textFieldIsVisible ? 214 : 170

        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

   


