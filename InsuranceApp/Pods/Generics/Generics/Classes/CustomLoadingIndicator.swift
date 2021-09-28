import UIKit

public extension UIView {
    public static let loadingViewTag = 1
    
    public func showLoading(style: UIActivityIndicatorView.Style = .medium, color: UIColor? = nil) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
        if color != nil {
            loading?.color = color
        }
        loading?.startAnimating()
        loading?.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    public func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
