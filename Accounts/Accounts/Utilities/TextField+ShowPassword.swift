//
//  TextField+ShowPassword.swift
//  Accounts
//
//  Created by Ben Garrison on 2/8/22.
//

import UIKit

let showPasswordButton = UIButton(type: .custom)

extension UITextField {
    
    func enableShowPassword() {
        showPasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        showPasswordButton.addTarget(self, action: #selector(showPasswordView), for: .touchUpInside)
        rightView = showPasswordButton
        rightViewMode = .always
    }
    
    @objc func showPasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
    }
}
