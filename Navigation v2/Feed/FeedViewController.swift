//
//  ViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class FeedViewController: UIViewController {


    private lazy var transitionButtonFirst: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitle("ButtonFirst", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var transitionButtonSecond: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        button.setTitle("ButtonSecond", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackButtonView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
    private func setupView() {
        self.view.addSubview(self.stackButtonView)
        self.stackButtonView.addArrangedSubview(self.transitionButtonFirst)
        self.stackButtonView.addArrangedSubview(self.transitionButtonSecond)
        self.activateConstraints()
    }
    
    private func activateConstraints() {
        
        NSLayoutConstraint.activate([
            self.stackButtonView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.stackButtonView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackButtonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.stackButtonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.stackButtonView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//            self.stackButtonView.heightAnchor.constraint(equalToConstant: 200),
//            self.stackButtonView.widthAnchor.constraint(equalToConstant: 200),
        ].compactMap({ $0 }))
        
    }
    
    @objc private func didTapTransitionButton() {
        let postVC = PostViewController()
        postVC.post = Post(title: "Мой Пост")
        navigationController?.pushViewController(postVC, animated: true)
    }
}
struct Post {
    
    let title: String
}
