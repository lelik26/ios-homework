//
//  PostViewController.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        let infoButton = UIBarButtonItem(title: "info" , style: .plain, target: self, action: #selector(didTapTransitionInfoButton))
        self.navigationItem.setRightBarButton(infoButton, animated: true)
        self.view.backgroundColor = .yellow
    }
    
    
    @objc func didTapTransitionInfoButton() {
        let infoVC = InfoViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
