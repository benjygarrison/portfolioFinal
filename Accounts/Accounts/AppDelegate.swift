//
//  AppDelegate.swift
//  Accounts
//
//  Created by Ben Garrison on 1/30/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //window?.rootViewController = LoginViewController()
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        window?.rootViewController = onboardingContainerViewController
        
        //window?.rootViewController = OnboardingViewController(imageName: "laptopMan", labelText: "Welcome to the Accounts app!")
        
        return true
        
    }


}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogIn() {
        print("didLogIn")
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("didOnboard")
    }
    
    
}
