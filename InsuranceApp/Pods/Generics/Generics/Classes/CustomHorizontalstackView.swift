import UIKit
import SnapKit

public struct ViewWithProportionality {
    var view : UIView?
    var proportionValue : CGFloat?
    
    public init(view : UIView?, proportionValue : CGFloat?) {
        self.view = view
        self.proportionValue = proportionValue
    }
}


open class CustomHorizontalstackView: UIStackView {
    
    public func addViewsWithDistributionProportionally(viewsDict : [ViewWithProportionality], spacing : CGFloat = 0) {
        axis = .horizontal
        self.spacing = spacing
        distribution = .fillProportionally
        alignment = .fill
        
        for item in viewsDict {
            guard let view = item.view else {
                return
            }
            self.addArrangedSubview(view)
            if let value = item.proportionValue {
                view.snp.makeConstraints { make in
                    make.width.equalTo(self.snp.width).multipliedBy(value)
                }
            }
        }
    }
}
