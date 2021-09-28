import UIKit
import SnapKit

open class CustomVerticalStack: UIStackView {
    
    public func addViewsWithDistributionProportionally(viewsDict : [ViewWithProportionality], spacing : CGFloat = 0) {
        axis = .vertical
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
                    make.height.equalTo(self.snp.height).multipliedBy(value)
                }
            }
        }
    }
}
