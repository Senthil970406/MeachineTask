//
//  ViewController.swift
//  MeachineTask
//
//  Created by Senthilnathan M on 05/02/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func Submit(_ sender: Any) {
        let userDefaults : UserDefaults = UserDefaults.standard
        userDefaults.set(Username.text, forKey: "Username")
        userDefaults.set(Password.text, forKey: "Password")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DateScreenViewController") as! DateScreenViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}

