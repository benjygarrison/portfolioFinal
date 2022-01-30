//
//  ViewController.swift
//  Accounts
//
//  Created by Ben Garrison on 1/30/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: Properties
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    
    //MARK: ViewDIdLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }


}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .tinted()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInPressed), for: .primaryActionTriggered)
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        
        //To center view:
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1), // Note: multiplyer of one = 8 pts
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        
        
    }
}

extension LoginViewController {
    @objc private func signInPressed(sender: UIButton) {
        print("button tapped")
    }
    
}

