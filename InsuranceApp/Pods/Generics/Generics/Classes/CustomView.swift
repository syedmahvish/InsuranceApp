import UIKit

open class CustomView: UIView {
    
    func createViewWithButton(imageString : String, borderWidth : CGFloat = 0, cornerRadius : CGFloat = 0){
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor.blue.cgColor
        let button = UIButton()
        button.setImage(UIImage(named: imageString), for: .normal)
        button.isUserInteractionEnabled = false
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}
