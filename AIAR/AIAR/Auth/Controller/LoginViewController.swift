//
//  LoginViewController.swift
//  AIAR
//
//  Created by 陈若鑫 on 25/03/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController : UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        //validate text field
        //sign in the user
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //can't sign in
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                self.transitionToWelcome()
            }
        }
    }
    
    func transitionToWelcome(){
        let welcomeController = storyboard?.instantiateViewController(withIdentifier: "Welcome")
        view.window?.rootViewController = welcomeController
        view.window?.makeKeyAndVisible()
    }
    
}
