import UIKit
import Generics

class SchedulePaymentTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    private lazy var dateLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        return label
    }()
    
    private lazy var amountLabel : CustomLabel = {
        let label = CustomLabel()
        label.labelWithText(withTittle: EmptyTextConstant.emptyTextValue.rawValue, fontSize: 17, color: .blue)
        label.textAlignment = .right
        return label
    }()
    private lazy var hStack : UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.alignment = .fill
        return hStack
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
        hStack.addArrangedSubview(dateLabel)
        hStack.addArrangedSubview(amountLabel)
        contentView.addSubview(hStack)
    }
    
    private func setupConstraints() {
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}

extension SchedulePaymentTableViewCell {
    func configureCell(with schedulePaymentPlanViewModel : SchedulePaymentTableViewCellConfigurable) {
        guard let scheduleModel = schedulePaymentPlanViewModel.schedulePaymentPlanModel else {
            return
        }
        dateLabel.text = scheduleModel.date
        amountLabel.text = scheduleModel.amount
    }
}

protocol SchedulePaymentTableViewCellConfigurable {
    var selectPaymentPlanModel : SelectPaymentPlanModel? {get}
    var schedulePaymentPlanModel : SchedulePaymentPlanModel? {get}
}

class SchedulePaymentTableViewCellViewModel : SchedulePaymentTableViewCellConfigurable {
    var selectPaymentPlanModel : SelectPaymentPlanModel?
    var schedulePaymentPlanModel : SchedulePaymentPlanModel?
    
    init(selectPaymentPlanModel : SelectPaymentPlanModel) {
        self.selectPaymentPlanModel = selectPaymentPlanModel
    }
    
    init(schedulePaymentPlanModel : SchedulePaymentPlanModel) {
        self.schedulePaymentPlanModel = schedulePaymentPlanModel
    }
}
