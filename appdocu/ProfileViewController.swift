import UIKit
import FirebaseAuth
import  FirebaseDatabase
import FirebaseStorage
import Kingfisher

class ProfileViewController: UIViewController {
    
    //    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var phone : UITextField!
    @IBOutlet weak var imageview: UIImageView!
    var ref: DatabaseReference!
    var datahandle : DatabaseHandle!
    //    var valuedata : [String:Any]!
    
    var modelusers = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.layer.cornerRadius = 75
        truyenve()
        //        truyeninfor()
        //        tableuser.register(UINib(nibName: "ProfileTableViewCell", bundle: .main), forCellReuseIdentifier: "usertableviewcell")
    }
    @IBAction func Signout(){
        do {
            try Auth.auth().signOut()
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.gotoOnboarding()
        } catch let error {
            print(error)
        }
    }
    //    func truyenve() {
    //        ref = Database.database().reference()
    //        datahandle =  ref.child("users").child(Auth.auth().currentUser?.uid ?? "").observe(.value) { (snapshot) in
    //            for user in snapshot.children.allObjects as! [DataSnapshot] {
    //                let users = user.value as? [String : AnyObject]
    //                let email = users?["email"]
    //                let image = users?["image"]
    //                let phone = users?["phone"]
    //                let status = users?["status"]
    //                let listuser = UserModel(email: email as! String, image: image as! String, phone: phone as! String, status: status as! String)
    //                self.modelusers.append(listuser)
    //                print(self.modelusers)
    //            }
    //            self.tableuser.reloadData()
    //        }
    //    }
    
    func truyenve() {
        ref = Database.database().reference()
        if let userid = Auth.auth().currentUser?.uid {
            ref.child("users").child(userid).observe(.value , with:  { (snapshot) in
                print(snapshot.value)
                let dictionary = snapshot.value as! NSDictionary
                let email = dictionary["email"] as? String
                let phone = dictionary["phone"] as? String
                if let profileimage = dictionary["image"] as? String {
                    if let url = URL(string: profileimage){
                        KingfisherManager.shared.retrieveImage(with: url as! Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                            self.imageview.image = image
                        }
                    }
                }
                self.email.text = email
                self.phone.text = phone
            })

        }
        
    }
    
}


