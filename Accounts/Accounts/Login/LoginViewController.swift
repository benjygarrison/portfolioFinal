//
//  ViewController.swift
//  Accounts
//
//  Created by Ben Garrison on 1/30/22.
//

import UIKit

//Note:  the "Delegate in this title actually refers to the Protocol, not the Delegate" ->
protocol LoginViewControllerDelegate: AnyObject {
    func didLogIn()
}

protocol LogoutDelegate: AnyObject {
    func didLogOut()
}

class LoginViewController: UIViewController {
    
    //MARK: Properties
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var userName: String? {
        return loginView.userNameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    
    //MARK: ViewDIdLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        signInButton.configuration?.showsActivityIndicator = false
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
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0 // zero value makes it a multiline label
        errorMessageLabel.isHidden = true
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //To center view:
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1), // Note: multiplyer of one = 8 pts
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
            
            
        ])
        
    }
}

extension LoginViewController {
    @objc private func signInPressed(sender: UIButton) {
        errorMessageLabel.isHidden = true
        signIn()
        
    }
    
    private func signIn() {
        guard let userName = userName, let password = password else {
            assertionFailure("Username or password is nil.")
            return
        }
        
        
        if userName.isEmpty || password.isEmpty {
            configureView(withMessage: "Please enter a username and password.")
            return
        }
        
        if userName == "Benji" || password == "abc123" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogIn()
        } else {
            configureView(withMessage: "Invalid username or password.")
            return
        }
        
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

