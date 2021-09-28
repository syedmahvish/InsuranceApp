import UIKit

open class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding.left, dy: padding.top)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding.left, dy: padding.top)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding.left, dy: padding.top)
    }
    
    public func textFieldWithBorderAndPlaceHolder(placeHoldertext : String?, textValue : String?) {
        textColor = .black
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        font = UIFont.systemFont(ofSize: FontConstant.FONT_SIZE_20.rawValue)
        placeholder = placeHoldertext
        text = textValue
    }
    
    public func textFieldWithPlaceHolder(placeHoldertext : String?, textValue : String?) {
        textColor = .black
        font = UIFont.systemFont(ofSize: FontConstant.FONT_SIZE_17.rawValue)
        placeholder = placeHoldertext
        text = textValue
    }
}
