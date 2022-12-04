//
//  CharacterQuotesVC.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 27.11.2022.
//

import UIKit

class CharacterQuotesVC: UIViewController {
    
    @IBOutlet weak var quoteTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var noQuotesLabel: UILabel!
    
    
    var charName:String?
    var quoteList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        quoteTableView.delegate = self
        quoteTableView.dataSource = self
        getQuote(charName ?? "nil")
        // Do any additional setup after loading the view.
    }
    
    
    func getQuote(_ name:String){
        let encodedString = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: "https://www.breakingbadapi.com/api/quote?author=\(encodedString)")!)
        print(encodedString)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            do{
                let item = try JSONDecoder().decode([Quote].self, from: data!)
                for i in item{
                    self.quoteList.append(i.quote)
                }
                
                DispatchQueue.main.async {
                    self.quoteTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    if(self.quoteList.count < 1){
                        self.noQuotesLabel.isHidden = false
                    }
                }
            }catch{
                DispatchQueue.main.async{
                    self.activityIndicator.stopAnimating()
                    self.noQuotesLabel.text = "An Error Has Occured"
                    self.noQuotesLabel.isHidden = false
                }
                print(error.localizedDescription)
            }
        }.resume()
    }


}


extension CharacterQuotesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell")
        
        let obj = quoteList[indexPath.row]
        
        cell?.textLabel?.text = obj
        
        return cell ?? UITableViewCell()
        
    }
    
    
}


struct Quote: Codable {
    let quote_id:Int
    let quote:String
    let author:String
    let series:String
}

