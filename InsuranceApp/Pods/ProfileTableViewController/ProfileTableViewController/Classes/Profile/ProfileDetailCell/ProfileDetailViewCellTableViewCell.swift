import UIKit

class ProfileDetailViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    var profileDetailView : ProfileDetailView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profileDetailView = ProfileDetailView(frame: .zero)
        profileDetailView?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(profileDetailView!)
        
        profileDetailView?.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(10)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
