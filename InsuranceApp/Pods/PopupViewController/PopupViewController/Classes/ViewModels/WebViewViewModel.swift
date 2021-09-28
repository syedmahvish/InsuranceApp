import Foundation

public struct WebViewModel {
    var htmlString : String?
    var buttonTitle : String?
    var viewTitle : String?
    
    public init(htmlString : String, buttonTitle : String, viewTitle : String) {
        self.htmlString = htmlString
        self.buttonTitle = buttonTitle
        self.viewTitle = viewTitle
    }
}

public protocol WebViewViewModelConfigurable {
    var webViewModel : WebViewModel? {get}
}

public class WebViewViewModel : WebViewViewModelConfigurable {
    public var webViewModel : WebViewModel?
    
    public init(webViewModel : WebViewModel) {
        self.webViewModel = webViewModel
    }
}
