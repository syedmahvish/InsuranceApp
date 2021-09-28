import UIKit
import SnapKit
import CustomDropDown

class ShowDropDownTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)  
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
    
    func configureShowView(view : CustomDropDown, height : CGFloat) {
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(height)
        }
    }
}
