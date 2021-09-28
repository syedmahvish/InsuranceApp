import UIKit
import Generics

class UpcomingBillsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)    
    private lazy var upcomingBillsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upcomingBillsImageView)
        
        upcomingBillsImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
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
    
    func configureCell(with billsModel : UpcomingBillsModel) {
        upcomingBillsImageView.image = UIImage(named: billsModel.billsImageString ?? "")
    }
}

protocol UpcomingBillsTableViewCellConfigurable {
    var upcomingBillsModel : UpcomingBillsModel? { get }
}

class UpcomingBillsTableViewCellViewModel : UpcomingBillsTableViewCellConfigurable {
    var upcomingBillsModel : UpcomingBillsModel?
    
    init(upcomingBillsModel : UpcomingBillsModel?) {
        self.upcomingBillsModel = upcomingBillsModel
    }
}


