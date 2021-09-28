import Foundation

struct QuoteRequest {
    var requestQuotation : [QuoteRequestPair]?
}

struct QuoteRequestPair {
    var requestTitle : String?
    var requestValueArray : [Int]?
}
