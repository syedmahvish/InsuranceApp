import UIKit

open class CustomButton: UIButton {
    
    public func blueButtonWithSystemFontandTittle(withText text : String, fontSize size : CGFloat) {
        setTitle(text, for: .normal)
        setTitleColor(.blue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        layer.borderWidth = 2
        layer.borderColor = UIColor.blue.cgColor
        layer.cornerRadius = 10
    }
    
    public func buttonWithText(withText text : String, fontSize size : CGFloat, andImage imageString : String?, height : CGFloat) {
        if let image = imageString {
            contentHorizontalAlignment = .left
            setTitle(text, for: .normal)
            addRightIcon(image: UIImage(named: image) ?? nil, with: height)
            setTitleColor(.black, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: size)
        }
    }
    
    private func addRightIcon(image: UIImage?, with height : CGFloat) {
        let imageView = UIImageView(image: image)
        addSubview(imageView)
        let length = CGFloat(height)
        titleEdgeInsets.right += length
        imageView.snp.makeConstraints { make in
            make.left.equalTo(self.titleLabel!.snp.right).offset(10)
            make.centerY.equalTo(self.titleLabel!.snp.centerY)
            make.height.width.equalTo(length/2)
        }
    }
}
