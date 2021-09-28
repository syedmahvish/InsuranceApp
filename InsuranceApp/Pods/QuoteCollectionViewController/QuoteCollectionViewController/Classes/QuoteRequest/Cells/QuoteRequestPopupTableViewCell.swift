import UIKit
import Generics

class QuoteRequestPopupTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = String(describing: self)
    lazy var button : CustomButton = {
        let button = CustomButton()
        button.isHidden = true
        button.blueButtonWithSystemFontandTittle(withText: "", fontSize: 15)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    var delegate : CurrentPaymentPlanSelectionConfigurable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .blue
        detailTextLabel?.textColor = .gray
        
        contentView.addSubview(button)
        addConstraints()
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
    
    private func addConstraints() {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
        }
    }
}

extension QuoteRequestPopupTableViewCell {
    func configureCell(withUpdatePayment quoteUpdatePaymentMethodViewModel : QuoteUpdatePaymentMethodConfigurable) {
        guard let quoteUpdatePaymentMethod = quoteUpdatePaymentMethodViewModel.quoteUpdatePaymentMethod else {
            return
        }
        textLabel?.text = quoteUpdatePaymentMethod.cardName
        detailTextLabel?.text = quoteUpdatePaymentMethod.cardNumber
        button.isHidden = true
    }
    
    func configureCell(withSchedulePayment quoteSchedulePaymentViewModel : QuoteSchedulePaymentConfigurable, indexPathForButton : IndexPath? = nil) {
        guard let quoteSchedulePayment = quoteSchedulePaymentViewModel.quoteSchedulePayment else {
            return
        }
        textLabel?.text = quoteSchedulePayment.scheduleType
        detailTextLabel?.text = quoteSchedulePayment.scheduleDetail
        button.isHidden = false
        button.setTitle(quoteSchedulePayment.actionName, for: .normal)
        if let indexPath = indexPathForButton {
            button.tag = Int("\(indexPath.section)\(indexPath.row)") ?? -1
        }
    }
    
    @objc func buttonTapped() {
        delegate?.showAndEditCurrentPaymentPlan(index: button.tag)
    }
    
}

protocol CurrentPaymentPlanSelectionConfigurable {
    func showAndEditCurrentPaymentPlan(index : Int)
}

extension CurrentPaymentPlanSelectionConfigurable {
    func showAndEditCurrentPaymentPlan(index : Int) {}
}

protocol QuoteRequestPopupTableViewCellConfigurable {
    var quoteUpdatePaymentMethod : QuoteUpdatePaymentMethodConfigurable? {get}
    var quoteSchedulePayment : QuoteSchedulePaymentConfigurable? {get}
}

class QuoteRequestPopupTableViewCellViewModel : QuoteRequestPopupTableViewCellConfigurable {
    var quoteUpdatePaymentMethod: QuoteUpdatePaymentMethodConfigurable?
    var quoteSchedulePayment: QuoteSchedulePaymentConfigurable?
    
    init(quoteUpdatePaymentMethod : QuoteUpdatePaymentMethodConfigurable) {
        self.quoteUpdatePaymentMethod = quoteUpdatePaymentMethod
    }
    
    init(quoteSchedulePayment : QuoteSchedulePaymentConfigurable) {
        self.quoteSchedulePayment = quoteSchedulePayment
    }
}

protocol QuoteUpdatePaymentMethodConfigurable {
    var quoteUpdatePaymentMethod : QuoteUpdatePaymentMethod? {get}
}

class QuoteUpdatePaymentMethodViewModel : QuoteUpdatePaymentMethodConfigurable {
    var quoteUpdatePaymentMethod : QuoteUpdatePaymentMethod?
    
    init(quoteUpdatePaymentMethod : QuoteUpdatePaymentMethod) {
        self.quoteUpdatePaymentMethod = quoteUpdatePaymentMethod
    }
}

protocol QuoteSchedulePaymentConfigurable {
    var quoteSchedulePayment : QuoteSchedulePayment? {get}
}

class QuoteSchedulePaymentViewModel : QuoteSchedulePaymentConfigurable {
    var quoteSchedulePayment : QuoteSchedulePayment?
    
    init(quoteSchedulePayment : QuoteSchedulePayment) {
        self.quoteSchedulePayment = quoteSchedulePayment
    }
}

