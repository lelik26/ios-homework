//
//  ProfileHeaderView.swift
//  Navigation v2
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject { // добавляем протокол с функцией didTapStatusButton с активным текстовым полем
    func buttonPressed(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView {
    



    private lazy var avatarImageView: UIImageView = {    // установка изображения
        let imageView = UIImageView(image: UIImage(named: "smurf.jpg"))
       
        imageView.backgroundColor = .clear
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.text = "Смурф"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray

   
        label.text = "Waiting for something"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var stackLabelView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10 //зазор между лабел
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.titleLabel?.textColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.setTitle("Show Status", for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.setTitle("Set Status", for: .selected)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint?
    private var buttonPressTopConstraint: NSLayoutConstraint?// выносим констрейт в свойство и делаем опционально
    weak var delegate: ProfileHeaderViewProtocol?  // добавляем делегат
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.placeholder = statusLabel.text   //"Enter some status here"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.backgroundColor = .white
        textField.addTarget(self, action: #selector(statusTextChanged(_:) ), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // нет установки XIB
        
    }
    
    private func drawSelf() {
        self.backgroundColor = .lightGray
        
        self.addSubview(self.setStatusButton)
        self.addSubview(self.textField)
        self.addSubview(self.avatarImageView)
        self.addSubview(self.stackLabelView)
        
        self.stackLabelView.addArrangedSubview(self.fullNameLabel)
        self.stackLabelView.addArrangedSubview(self.statusLabel)
        

        let topImageConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingImageConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let heightImageConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 90)

        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        
        let topStackViewConstraint = self.stackLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leadingStackViewConstraint = self.stackLabelView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 10)
        let trailingStackViewConstraint = self.stackLabelView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heighStackViewtConstraint = self.stackLabelView.heightAnchor.constraint(equalToConstant: 61)
        
        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.avatarImageView.leadingAnchor)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.stackLabelView.trailingAnchor)
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
//        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        

        
        
        NSLayoutConstraint.activate([topImageConstraint, leadingImageConstraint, heightImageConstraint,imageViewAspectRatio,topStackViewConstraint, leadingStackViewConstraint, trailingStackViewConstraint, heighStackViewtConstraint,buttonTopConstraint,leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint, ].compactMap({ $0 })) // объявление всех constrait и активирует расчет
    }
    @objc private func buttonPressed(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if self.textField.isHidden {
            self.addSubview(self.textField)
           

            self.buttonTopConstraint?.isActive = false // Необходимо деактивировать констрейнт, иначе будет конфликт констрейнтов, и Auto Layout не сможет однозначно определить фреймы textField'а.

            let topConstraint = self.textField.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 34)
            let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor)
            let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 40) // Не указав высоту textField'а, получается неоднозначность/неопределенность констрейнтов. Auto Layout на основе этой неопределенности имеет множество решений (height для stackView, textField), выбирая оптимальное, а не необходимое, то есть вместо 34pts для textField'а растягивается stackView.
            self.buttonPressTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.stackLabelView.bottomAnchor, constant: 90)
            self.buttonPressTopConstraint?.priority = UILayoutPriority(rawValue: 999)


            

            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonPressTopConstraint
            ].compactMap({ $0 }))  // self.buttonTopConstraint
        }
               else {
                   self.textField.isHidden = false
      //  #warning("Убрать textField из вью!")
              }
        
        self.delegate?.buttonPressed(textFieldIsVisible: self.textField.isHidden) { [weak self] in
        self?.textField.isHidden.toggle()
        }
    }
    
    private var statusText: String?
    @objc private func statusTextChanged (_ textField: UITextField) {
      
        statusText = textField.text!
        statusLabel.text = statusText
    }
    
}





 
