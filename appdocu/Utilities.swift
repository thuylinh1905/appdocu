import UIKit

class Utilities {

    static func changebutton(button :UIButton) {
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.gray.cgColor
    }
    
    static func buttonchangehome(button : UIButton) {
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
    }
    
    
    static func changetextfield(textfield : UITextField) {
        textfield.layer.cornerRadius = 20
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1.0
        textfield.layer.borderColor = UIColor.gray.cgColor
    }
    static func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
//    static func thongbao(mess : String){
//        let alert = UIAlertController(title: "thong bao", message: mess, preferredStyle: .actionSheet)
//        let action1 = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(action1)
//        self.alert.present(alert, animated: true, completion: nil)
//    }
}
