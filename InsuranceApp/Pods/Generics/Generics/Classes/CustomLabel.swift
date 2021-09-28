import UIKit

open class CustomLabel: UILabel {
    
    public func labelWithBlueColorAndSystemFont(withTittle text : String, fontSize : Float) {
        self.text = text
        textColor = .blue
        numberOfLines = 0
        font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
    }
    
    public func errorLabelWithSystemFont(withTittle text : String) {
        self.text = text
        textColor = .red
        textAlignment = .center
        numberOfLines = 0
        font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    public func labelWithText(withTittle text : String, fontSize : Float, color : UIColor) {
        self.text = text
        textColor = color
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
}
