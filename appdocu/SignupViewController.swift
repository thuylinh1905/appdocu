import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

class SignupViewController: UIViewController {
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var imgage: UIImageView!
    var uploadimage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgage.layer.cornerRadius = 100
        navibutton()
    }
    
    func navibutton() {
        let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "back"), for: .normal)
        btnCancel.addTarget(self, action:  #selector(goToSettings), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    @objc func  goToSettings(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gotoOnboarding()
    }
    func alert(thongbao : String) {
        let alert = UIAlertController(title: "thong bao", message: thongbao, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "OK", style: .cancel) { (action) in
            let loginviewcontroller = LoginViewController()
            self.navigationController?.pushViewController(loginviewcontroller, animated: true)
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func test(_ sender: Any) {
        guard let imageData =  uploadimage!.jpegData(compressionQuality: 0.5 ) else {
            return
        }
        if let email = txtemail.text , let pass = txtpass.text , let phone = txtphone.text {
            Auth.auth().createUser(withEmail: email, password: pass , completion: { user , error in
                if let firebaseerror = error {
                    self.alert(thongbao: "khong the tao tai khoan")
                    print(firebaseerror.localizedDescription)
                    return
                }
                if let user = user {
                    var dic: Dictionary<String, Any> = ["uid" : user.user.uid,
                                                        "email" : user.user.email!,
                                                        "phone" : phone,
                                                        "image" : "",
                                                        "status" :""]
                    
                    let storageRef = Storage.storage().reference(forURL: "gs://appdocu-2c67f.appspot.com")
                    let storageProfileRef = storageRef.child("imageProfile").child(user.user.uid)
                    let metaData = StorageMetadata()
                    metaData.contentType = "image/jpg"
                    storageProfileRef.putData(imageData, metadata: metaData, completion: {
                        (storagemetadata,error) in
                        if error != nil{
                            print(error?.localizedDescription)
                            return
                        }
                        storageProfileRef.downloadURL(completion: {
                            (url,error) in
                            if let ImageUrl = url?.absoluteString {
                                print(ImageUrl)
                                dic["image"] = ImageUrl
                                Database.database().reference().child("users")
                                    .child(user.user.uid).updateChildValues(dic) { (error, ref) in
                                        if error == nil {
                                            print("Done")
                                        }
                                }
                            }
                        })
                    })
                }
                //                 } else{
                //                    let db = Firestore.firestore()
                //                    db.collection("users").addDocument(data: ["phone" : phone  ,"uid" : user!.user.uid ]){ error in
                //                        if let firebserro = error {
                //                            self.alert(thongbao: "khong the them truong")
                //                            print(firebserro.localizedDescription)
                //                            return
                //                        }
                //                        self.alert(thongbao: "da tao tai khoan")
                //                                     print("success")
                //                    }
                //                }
            })
        }
    }
    
    @IBAction func changeimage(_ sender: Any) {
        let imgepickview = UIImagePickerController()
        let alert = UIAlertController(title: "thong bao", message: "ban co muon mo may anh", preferredStyle: .alert)
        let button1 = UIAlertAction(title: "OK", style: .default) { (action) in
            imgepickview.sourceType = .photoLibrary
            imgepickview.delegate = self
            //            imgepickview.modalPresentationStyle = .overFullScreen
            imgepickview.isEditing = true
            self.present(imgepickview, animated: true, completion: nil)
        }
        let button2 = UIAlertAction(title: "THOAT", style: .cancel, handler: nil
        )
        alert.addAction(button1)
        alert.addAction(button2)
        self.present(alert, animated: true, completion: nil)
    }
}
extension SignupViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgage.image = img
            uploadimage = img
        }
        self.dismiss(animated: true, completion: nil)
    }
}
