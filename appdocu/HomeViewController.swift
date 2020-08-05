import UIKit
import  FirebaseDatabase
import Kingfisher
import FirebaseStorage


struct imagebanner1 {
    var image : String!
    var image1 : String!
    init(image : String , image1 : String) {
        self.image = image
        self.image1 = image1
    }
}
//struct menuhome {
//    var image : String!
//    init(image : String) {
//        self.image = image
//    }
//}
//struct hinhanh {
//    var hinhanh2: String!
//    init(hinhanh2 : String) {
//        self.hinhanh2 = hinhanh2
//    }
//}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionview : UICollectionView!
    var ref: DatabaseReference!
    var datahandle : DatabaseHandle!
    @IBOutlet weak var imagebanner : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationitem()
        truyenve()
        
        
    }
    
    func navigationitem() {
        let butsearch = UIButton()
        butsearch.setImage(UIImage(named: "search"), for: .normal)
        butsearch.addTarget(self, action:  #selector(gotosearch), for: .touchUpInside)
        let leftBarButton1 = UIBarButtonItem()
        leftBarButton1.customView = butsearch
        
        self.navigationItem.rightBarButtonItem = leftBarButton1
        
        
        let butmess = UIButton()
        butmess.setImage(UIImage(named: "upload"), for: .normal)
        butmess.addTarget(self, action: #selector(upload), for: .touchUpInside)
        let leftbarbutton2 = UIBarButtonItem()
        leftbarbutton2.customView = butmess
        
        self.navigationItem.leftBarButtonItem = leftbarbutton2
        
        
    }
    
    func truyenve() {
        let ref = Database.database().reference()
        ref.child("banner").observe(.value) { (snashot) in
            let dictionary = snashot.value as! NSDictionary
            let image = dictionary["imagebanner"] as? String
            let image1 = dictionary["imagebanner2"] as? String
            let hinh = [imagebanner1(image: image as! String, image1: image1 as! String)]
            print(hinh)
            if  let image = dictionary["imagebanner"] as? String {
                if let url = URL(string: image){
                    KingfisherManager.shared.retrieveImage(with: url as! Resource, options: nil, progressBlock: nil) { (image, error, cache, imageurl) in
                        self.imagebanner.image = image
                    }
                }
            }
        }
    }
    
    @objc func gotosearch(){
    }
    @objc func upload(){
        let dellegate = UIApplication.shared.delegate as! AppDelegate
        dellegate.gotoupload()
    }
}
