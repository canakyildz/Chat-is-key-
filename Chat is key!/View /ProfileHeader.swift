//
//  ProfileHeader.swift
//  Chat is key!
//
//  Created by Apple on 19.03.2020.
//  Copyright © 2020 PHYSID. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func dismissController()
}

class ProfileHeader: UIView {
    
    
    
    // MARK: - Properties
    
    var user: User? {
        
        didSet {
            populateUserData()
        }
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3.0
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let usernameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 20)
           label.textColor = .white
           label.textAlignment = .center
           return label
       }()
    

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
      configureUI()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss() {
        delegate?.dismissController()
           
       }
    
    // MARK: - Helpers
    
    func populateUserData() {
        guard let user = user else { return }
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = "@" + user.username
        
        guard let url = URL(string: user.profileImageUrl) else { return }
        profileImageView.sd_setImage(with: url)
    }
    
    func configureUI() {
        configureGradientLayer()
        
        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.layer.cornerRadius = 200 / 2
        
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 96)
        
        let stack = UIStackView(arrangedSubviews:  [fullnameLabel,usernameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 16)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor,left: leftAnchor,paddingTop: 44,paddingLeft: 12)
        dismissButton.setDimensions(height: 22, width: 22)
    }
    
    func configureGradientLayer() {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor(red: 0.2509489954, green: 0.2509984672, blue: 0.2509458363, alpha: 1), UIColor(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)]
    //        gradient.colors = #colorLiteral
            gradient.locations = [0, 1]
            layer.addSublayer(gradient)
            gradient.frame = frame
        }

}


