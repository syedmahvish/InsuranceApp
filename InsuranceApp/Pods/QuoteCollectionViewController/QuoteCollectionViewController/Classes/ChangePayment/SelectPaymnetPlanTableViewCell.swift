import UIKit
import Generics

class SelectPaymnetPlanTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    private lazy var nameLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
        setupConstraints()
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
    
    private func layoutViews() {
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
    }
}

extension SelectPaymnetPlanTableViewCell {
    func configureCell(with selectPaymentPlanViewModel : SelectPaymnetPlanTableViewCellConfigurable) {
        guard let selectPaymentPlanModel = selectPaymentPlanViewModel.selectPaymentPlanModel else {
            return
        }
        nameLabel.text = selectPaymentPlanModel.name
        self.accessoryType = selectPaymentPlanModel.isSelected ? .checkmark : .none
    }
}

protocol SelectPaymnetPlanTableViewCellConfigurable {
    var selectPaymentPlanModel : SelectPaymentPlanModel? {get}
}

class SelectPaymnetPlanTableViewCellViewModel : SelectPaymnetPlanTableViewCellConfigurable {
    var selectPaymentPlanModel : SelectPaymentPlanModel?
    
    init(selectPaymentPlanModel : SelectPaymentPlanModel) {
        self.selectPaymentPlanModel = selectPaymentPlanModel
    }
}
