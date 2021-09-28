import Foundation

protocol QuotesDataProviderConfigurable {
    var quotesDatamodel : QuotesDataModel? {get}
    func loadData() -> QuotesDataModel?
}

class QuotesDataProvider : QuotesDataProviderConfigurable {
    public static let sharedInstance = QuotesDataProvider()
    var quotesDatamodel: QuotesDataModel?
    
    func loadData() -> QuotesDataModel? {
        var quoteModelArray = [QuoteModel]()
        quoteModelArray.append(QuoteModel(title: "Insurance 1"))
        quoteModelArray.append(QuoteModel(title: "Insurance 2"))
        quoteModelArray.append(QuoteModel(title: "Vechicle Insurance 1"))
        
        var quoteRequestPairArray = [QuoteRequestPair]()
        quoteRequestPairArray.append(QuoteRequestPair(requestTitle: "Auto", requestValueArray: [680,600,660]))
        quoteRequestPairArray.append(QuoteRequestPair(requestTitle: "Home", requestValueArray: [1180,1000,1260]))
        quoteRequestPairArray.append(QuoteRequestPair(requestTitle: "Health", requestValueArray: [680,800,890]))
        let quoteRequest = QuoteRequest(requestQuotation: quoteRequestPairArray)
        
        let quoteWorkDescriptionString = "We offer insurance by phone, online and through independent agents. Prices vary based on how you buy.National annual average insurance savings by new customers surveyed who saved with Progressive in 2020. Potential savings will vary.Discount varies, applies to the auto policy, and is not available in all states or situations.Customer selected due dates are available only for auto insurance policies where the customer has elected to pay via EFT.Insurance carrier Website ranking by Keynova Group - Scorecards 2017 – 2021.Comparison rates not available in all states or situations."
        
        var htmlString = """
            <ul id="questions" class="accordion" style="list-style-type: disc;">
            <li class="open">
            <div class="accordion-headline" tabindex="0">
            <h3>How do I add a vehicle to my policy?</h3>
            </div>
            <div class="accordion-content-container">
            <div class="accordion-content">
            <p>It's easy to add a vehicle to your policy using the <a href="https://geico.app.link/static/GEICOApp?~campaign=Campaign:Static:ContactUs:Main">GEICO Mobile</a> app.</p>
            <p>You can also use <a href="https://geico.app.link/static/vehicle/add?~campaign=Campaign:Static:ContactUs:Main">GEICO Express Services</a> to take care of your most common insurance <strong>transactions</strong>, with no login required, including adding a vehicle.</p>
            </div>
            </div>
            <div class="accordion-headline" tabindex="0">
            <h3>How do I get my ID cards?</h3>
            </div>
            <div class="accordion-content-container">
            <div class="accordion-content">
            <p>You can get your <a href="https://geico.app.link/static/idcard?~campaign=Campaign:Static:ContactUs:Main">digital ID cards</a> on GEICO Mobile or geico.com.</p>
            <p>Using GEICO Mobile, you can access your cards whether you're logged in or logged out. You can even store your ID cards in your Apple Wallet, too!</p>
            </div>
            </div>
            </li>
            </ul>
            <p>&nbsp;</p>
            <div class="accordion-headline" tabindex="0">
            <h3>Does GEICO offer accident forgiveness?</h3>
            </div>
            <div class="accordion-content-container">
            <div class="accordion-content">
            <p>Yes, we do offer accident forgiveness (not available in CA, CT, and MA). <a href="https://www.geico.com/auto-insurance/accident-forgiveness/">Learn more</a>.</p>
            <p>&nbsp;</p>
            <h3 id="radioquestion">What do you need help with today?</h3>
            <div class="radio-button-wrapper col-2">
            <div><label class="radio" for="payments"><label class="radio" for="payments"></label></label>
            <style>
            table {
              font-family: arial, sans-serif;
              font-size : 40;
              border-collapse: collapse;
              width: 100%;
            }

            td, th {
              border: 1px solid #dddddd;
              text-align: left;
              padding: 8px;
            }

            tr:nth-child(even) {
              background-color: #dddddd;
            }
            </style>
            <table>
              <tr>
                <th>Company</th>
                <th>Contact</th>
                <th>Country</th>
              </tr>
              <tr>
                <td>Alfreds Futterkiste</td>
                <td>Maria Anders</td>
                <td>Germany</td>
              </tr>
              <tr>
                <td>Centro comercial Moctezuma</td>
                <td>Francisco Chang</td>
                <td>Mexico</td>
              </tr>
              <tr>
                <td>Ernst Handel</td>
                <td>Roland Mendel</td>
                <td>Austria</td>
              </tr>
              <tr>
                <td>Island Trading</td>
                <td>Helen Bennett</td>
                <td>UK</td>
              </tr>
              <tr>
                <td>Laughing Bacchus Winecellars</td>
                <td>Yoshi Tannamuri</td>
                <td>Canada</td>
              </tr>
              <tr>
                <td>Magazzini Alimentari Riuniti</td>
                <td>Giovanni Rovelli</td>
                <td>Italy</td>
              </tr>
            </table>
            </div>
            </div>
            <p>&nbsp;</p>
            </div>
            </div>
            <h2>Quick Links</h2>
            <div class="row cards-container watermark-cards">
            <div class="col-sm-12 col-lg-offset-0 col-md-8 col-md-offset-2 col-lg-4 col-lg-offset-0">
            <div class="card">
            <div>
            <h3>Express Services</h3>
            <ul>
            <li><a href="https://ecams.geico.com/express?action=ET02">Get ID cards</a></li>
            <li><a href="https://ecams.geico.com/express?action=ET07">Policy documents</a></li>
            <li><a href="https://ecams.geico.com/express?action=ET01">Make a payment</a></li>
            <li><a href="https://ecams.geico.com/express?action=ET04">Add/Replace vehicle</a></li>
            <li><a href="https://ecams.geico.com/express?action=ET03">Go Paperless</a></li>
            </ul>
            </div>
            </div>
            </div>
            <div class="col-sm-12 col-lg-offset-0 col-md-8 col-md-offset-2 col-lg-4 col-lg-offset-0">
            <div class="card">
            <div>
            <h3>Claims Center</h3>
            <ul>
            <li><a href="https://geico.app.link/static/claims/dashboard?~campaign=Campaign:Static:ContactUs:Main">Track a claim</a></li>
            <li><a href="https://geico.app.link/static/claims?~campaign=Campaign:Static:ContactUs:Main">Report an incident</a></li>
            <li><a href="https://geico.app.link/static/claims/glass?~campaign=Campaign:Static:ContactUs:Main">Report glass-only damage</a></li>
            <li><a href="https://geico.app.link/static/claims/ers?~campaign=Static:ContactUs:Main">Request roadside assistance</a></li>
            <li><a href="https://www.geico.com/claims/find-a-repair-shop/">Find a repair location</a>&nbsp;</li>
            </ul>
            </div>
            </div>
            </div>
            <div class="col-sm-12 col-lg-offset-0 col-md-8 col-md-offset-2 col-lg-4 col-lg-offset-0">
            <div class="card">
            <h3>Get a Quote</h3>
            <ul>
            <li><a href="https://geico.app.link/static/quote/auto?~campaign=Campaign:Static:ContactUs:Main">Auto insurance</a></li>
            <li><a href="https://geico.app.link/staticNavigationContactUsNewQuote?~campaign=Campaign:Static:ContactUs:Main">Home, renters, or condo</a></li>
            <li><a href="https://geico.app.link/static/quote/cycle_atv?~campaign=Campaign:Static:ContactUs:Main">Motorcycle insurance</a></li>
            <li><a href="https://geico.app.link/staticNavigationContactUsNewQuote?~campaign=Campaign:Static:ContactUs:Main">Boat insurance</a></li>
            <li><a href="https://geico.app.link/staticNavigationContactUsNewQuote?~campaign=Campaign:Static:ContactUs:Main">Commercial insurance</a></li>
            </ul>
            <p>&nbsp;</p>
            <h3 id="radioquestion">&nbsp;</h3>
            <div class="radio-button-wrapper col-2">
            <div>&nbsp;</div>
            <div>&nbsp;</div>
            </div>
            </div>
            </div>
            </div>
            """
      
        let quoteWorks = QuoteWorks(workExplanationData: quoteWorkDescriptionString, htmlString: htmlString)
        quotesDatamodel = QuotesDataModel(quoteModel: quoteModelArray, quoteRequest: quoteRequest, quoteWorks: quoteWorks)
        return quotesDatamodel
    }
    
    
}
