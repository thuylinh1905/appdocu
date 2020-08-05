import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var buttongoogle: UIButton!
    @IBOutlet weak var buttonface: UIButton!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var buttonsigin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.changebutton(button: buttonsigin)
        Utilities.changebutton(button: buttongoogle)
        Utilities.changebutton(button: buttonface)
        Utilities.changetextfield(textfield: txtpass)
        Utilities.changetextfield(textfield: txtemail)
        navibutton()
    }

    func navibutton() {
           let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "back"), for: .normal)
           btnCancel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
           btnCancel.addTarget(self, action:  #selector(goToSettings), for: .touchUpInside)
           let leftBarButton = UIBarButtonItem()
           leftBarButton.customView = btnCancel
           self.navigationItem.leftBarButtonItem = leftBarButton
       }
       @objc func  goToSettings(){
           let delegate = UIApplication.shared.delegate as! AppDelegate
           delegate.gotoOnboarding()
       }
    
    @IBAction func login(_ sender: Any) {
        if var email = txtemail.text ,var  pass = txtpass.text{
            Auth.auth().signIn(withEmail: "linh01@gmail.com", password: "linh19051998") { (result, error) in
                if error != nil{
                    AlertView.instance.showAlert(title: "Error", message: "Tài khoản này chưa được tạo vui lòng đăng ký tài khoản", alertType: .failure)
                } else{
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.gototabbar()
                }
            }
        }
    }
    @IBAction func signin(_ sender: Any) {
    }
}
extension LoginViewController {
    func Alertcontroller(messege : String) {
        let alertcontroller = UIAlertController(title: "thong bao", message: messege, preferredStyle: .actionSheet)
        if messege == "dang nhap thanh cong" {
            let button1 = UIAlertAction(title: "OK", style: .default) { (action) in
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.gotoHome()
                self.txtemail.text = ""
                self.txtpass.text = ""
            }
            alertcontroller.addAction(button1)
        } else {
            let button2 = UIAlertAction(title: "Thu lai", style: .cancel){(action) in
                self.txtemail.text = ""
                self.txtpass.text = ""
            }
            alertcontroller.addAction(button2)
        }
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
}
