//
//  ViewController.swift
//  Accounts
//
//  Created by Ben Garrison on 1/30/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }


}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(loginView)
        
        //To center view:
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1), // Note: multiplyer of one = 8 pts
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        
    }
    
}

