//
//  SignUpViewController.swift
//  AIAR
//
//  Created by 陈若鑫 on 25/03/2024.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore



class SignUpViewController : UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        //Hide error label
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        
        Utilities.styleTextField(lastNameTextField)
        
        Utilities.styleTextField(emailTextField)
        
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signUpButton)
    }
    
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if  Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else{
            //create the new user here
            //transition page
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName  = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email     = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password  = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password){(result, err) in
                if err != nil{
                    self.showError("Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["email": email, "firstname" : firstName, "lastname" : lastName,  "password": password, "uid": result!.user.uid]){(error) in
                        if error != nil{
                            self.showError("Faied in saving user data")
                        }
                    }
                    self.transitionToHome()
                    
                }
            }
        }
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
      let homeViewController = storyboard?.instantiateViewController(identifier: "Home")
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
    


