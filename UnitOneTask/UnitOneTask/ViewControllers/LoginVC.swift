//
//  LoginVC.swift
//  UnitOneTask
//
//  Created by Helles, Yasmeen on 24/03/2022.
//

import UIKit
import FirebaseAuth
import KWVerificationCodeView
class LoginVC: UIViewController {
    @IBOutlet weak var btnSendCode: UIButton!
    @IBOutlet weak var viewCode: KWVerificationCodeView!
    @IBOutlet weak var customCodeView: UIView!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var viewVerficationCode: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var txtMobile: UITextField!
    private var verificationID = ""
    private var verificationCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    func setupViews(){
        self.btnSignIn.setRounded(radius: 10)
        viewMobile.setRounded(radius: 5)
        customCodeView.setRounded(radius: 10)
        btnSendCode.setRounded(radius: 10)
        viewMobile.setBorder(width: 1, color: "412362".color)
        
    }
    @IBAction func closeVC(_ sender: Any) {
        self.dismissVC()
    }
    
    @IBAction func closeVCView(_ sender: Any) {
        viewVerficationCode.isHidden = true
    }
    @IBAction func loginUserBYMobile(_ sender: UIButton) {
        var mobileNo = self.txtMobile.text ?? ""
        guard !mobileNo.isEmpty else {
            return
        }
        if mobileNo.starts(with: "0")  {
            mobileNo = String(mobileNo.dropFirst())
        }
        if !mobileNo.starts(with: "59")  || mobileNo.starts(with: "56") {
            return
        }
        mobileNo = "+970"+mobileNo
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(mobileNo, uiDelegate: nil) { verificationID, error in
              if let error = error {
                print(error.localizedDescription)
                return
              }
              self.verificationID = verificationID!
              Auth_User.User_Token = verificationID!
              self.viewVerficationCode.isHidden = false
//
    }
    
    }
    @IBAction func sendVerfiyCode(_ sender: UIButton) {
        self.verificationCode = viewCode!.getVerificationCode()
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: self.verificationID,
            verificationCode: self.verificationCode
        )
        self.goToApp()
    }
       

     func goToApp() {
        let vc: YHNavigationVC = AppDelegate.StoryBoard.instanceVC()
               UIApplication.shared.windows.first?.rootViewController = vc
               UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
