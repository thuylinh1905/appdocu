import UIKit
import FirebaseAuth
import  FirebaseDatabase
import FirebaseFirestore
import Kingfisher

struct loaimon {
    var ten : String!
    var hinhanh : String!
    init(ten : String, hinhanh : String) {
        self.ten = ten
        self.hinhanh = hinhanh
    }
}

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ts: UIImageView!
    @IBOutlet var select: UIView!
    @IBOutlet weak var txtmota: UITextField!
    @IBOutlet weak var txttenquan: UITextField!
    @IBOutlet weak var txtdiachi: UITextField!
    @IBOutlet weak var txtgiatien: UITextField!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var loaidoan: UIButton!
    var mon = ""
    var uploadimage : UIImage? = nil
    var loaimonve = [loaimon]()
    var selectedindex : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        self.tableview.register(UINib(nibName: "FoodTableViewCell", bundle: .main), forCellReuseIdentifier: "foodtableviewcell")
        self.truyenmonan()
    }
    
    @IBAction func tr(_ sender: Any) {
        self.view.addSubview(select)
        select.center = self.view.center
        self.showAnimate()
    }
    
    @IBAction func agree(_ sender: Any) {
        loaidoan.titleLabel?.text = mon
        self.select.removeFromSuperview()
    }
    @IBAction func outviewtp(_ sender: Any) {
        self.select.removeFromSuperview()
    }
    func navibutton() {
        let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "back"), for: .normal)
        btnCancel.addTarget(self, action:  #selector(gotohome), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnCancel
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    @objc func gotohome(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.gototabbar()
    }
    @IBAction func opengarelly(_ sender: Any) {
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
    @IBAction func dangbai(_ sender: Any) {
        let mota = txtmota.text
        let giatien = txtgiatien.text
        let diachi = txtdiachi.text
        let tenquan = txttenquan.text
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        guard let key = ref.child("location").child("2").childByAutoId().key else { return }
        let post = ["uid": userID!,
                    "mota": mota!,
                    "giatien": giatien!,
                    "diachi": diachi!,
                    "tenquan" : tenquan!] as [String: Any]
        let childUpdates = ["/location/\(key)": post,
                            "/user-posts/\(String(describing: userID))/\(key)/": post]
        ref.updateChildValues(childUpdates)
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
}
extension PostViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            image.image = img
            uploadimage = img
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    func truyenmonan() {
        let db = Firestore.firestore()
        db.collection("loaimon").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dictionary = document.data()
                    let tenmon = dictionary["tenloaimon"] as! String
                    let image = dictionary["hinhanh"] as! String
                    let mangloaimon = loaimon(ten: tenmon, hinhanh: image)
                    self.loaimonve.append(mangloaimon)
                    
                }
            }
            print(self.loaimonve)
            self.tableview.reloadData()
        }
    }
}
extension PostViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.loaimonve.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "foodtableviewcell", for: indexPath) as! FoodTableViewCell
        cell.truyenve(loaimon1: loaimonve[indexPath.row])
        if self.selectedindex?.row == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0;
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Các loại món ăn"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoodTableViewCell
        mon = cell.tenmon.text ?? ""
        self.selectedindex = indexPath
        self.tableview.reloadData()
    }
}
