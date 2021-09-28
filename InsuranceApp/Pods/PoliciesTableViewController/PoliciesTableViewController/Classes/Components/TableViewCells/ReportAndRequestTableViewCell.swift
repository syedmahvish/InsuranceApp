import UIKit
import Generics

class ReportAndRequestTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    private lazy var infoLabel = CustomLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(5)
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

// MARK: - Cell Configuration
extension ReportAndRequestTableViewCell {
    func configureCell(withInfo reportAndRequestViewModel : ReportAndRequestTableViewCellConfigurable) {
        guard let reportAndRequestModel = reportAndRequestViewModel.reportAndRequestModel else {
            return
        }
        infoLabel.labelWithText(withTittle: reportAndRequestModel.title ?? EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
    }
}

protocol ReportAndRequestTableViewCellConfigurable {
    var reportAndRequestModel: ReportAndRequestModel? { get }
}

class ReportAndRequestTableViewCellViewModel : ReportAndRequestTableViewCellConfigurable {
    var reportAndRequestModel: ReportAndRequestModel?
    
    init(reportAndRequestModel : ReportAndRequestModel) {
        self.reportAndRequestModel = reportAndRequestModel
        configureInformation()
    }
    
    private func configureInformation() {
        guard let infoModel = reportAndRequestModel else {
            return
        }
        reportAndRequestModel?.title = infoModel.title ?? EmptyTextConstant.emptyTextValue.rawValue
    }
}
