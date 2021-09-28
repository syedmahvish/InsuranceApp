import UIKit
import CustomDropDown
import Generics

class ProfileStateDropDownTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    
    lazy var infoLabel = CustomLabel()
    lazy var stateDropDownButton = CustomDropDownButton(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var viewItems = [ViewWithProportionality]()
        var viewItem = ViewWithProportionality(view: infoLabel, proportionValue: 0.5)
        viewItems.append(viewItem)
        viewItem = ViewWithProportionality(view: stateDropDownButton, proportionValue: 0.7)
        stateDropDownButton.configureButton(withFrame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width * 0.7, height: self.frame.height))
        viewItems.append(viewItem)
        let stackview = CustomHorizontalstackView()
        stackview.addViewsWithDistributionProportionally(viewsDict: viewItems, spacing: 5)
        contentView.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

