//
//  ViewController.swift
//  Stocks
//
//  Created by Kukina Anastasia on 05.12.2020.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var companyPickerView: UIPickerView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companySymbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    //MARK: - private properties
    
    private var companies: [String : String] = [:]
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyPickerView.dataSource = self
        companyPickerView.delegate = self
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.requestMostActiveCompanies()
    }

    //MARK: IBOutletActions
    
    @IBAction func reloadCompanies(_ sender: Any) {
        
        self.requestMostActiveCompanies()
    }
    
    //MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.companies.keys.count
    }
    
    //MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(self.companies.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.requestQuoteUpdate()
    }
    
    //MARK: - Private methods
    
    private func loadLogo(for symbol: String) {
        
        
        let url = URL(string: "https://storage.googleapis.com/iex/api/logos/\(symbol).png")
        
        if let data = try? Data(contentsOf: url!) {
            if let image = UIImage(data: data) {
                
                self.logoImageView.image = image
            } else {
                self.logoImageView.image = UIImage()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Sorry!", message: "We have not logo of this company!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                }
            }
        } else {
            self.logoImageView.image = UIImage()
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Sorry!", message: "We have not logo of this company!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func requestMostActiveCompanies() {
        
        self.activityIndicator.startAnimating()
        
        let url = URL(string: "https://sandbox.iexapis.com/stable/stock/market/list/mostactive?token=Tsk_fb935c0821484857b4a2a5de1a00c4a2")
        
        let dataTask = URLSession.shared.dataTask(with: url!) {data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                DispatchQueue.main.async {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                    
                    var alert: UIAlertController!
                    
                    if statusCode != nil {
                        alert = UIAlertController(title: "Ooups!", message: "Network error, code: \(statusCode!)", preferredStyle: .alert)
                    } else {
                        alert = UIAlertController(title: "Ooups!", message: "Network error, check your internet connection!", preferredStyle: .alert)
                    }
                    
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            
            self.parseMostActiveCompanies(data: data)
        }
        
        dataTask.resume()
    }
    
    private func parseMostActiveCompanies(data: Data) {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [[String: Any]]
            else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ooups!", message: "Error with the https://sandbox.iexapis.com. We will fix it soon!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            
            for item in json {
                
                guard
                    let companyName = item["companyName"] as? String,
                    let companySymbol = item["symbol"] as? String
                else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ooups!", message: "Error with the https://sandbox.iexapis.com. We will fix it soon!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil)
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                
                companies[companyName] = companySymbol;
            }
            
            DispatchQueue.main.async {
                self.companyPickerView.reloadComponent(0)
                self.activityIndicator.stopAnimating()
                self.requestQuoteUpdate()
            }
            
        } catch {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Ooups!", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func requestQuoteUpdate() {
        
        self.activityIndicator.startAnimating()
        
        self.companyNameLabel.text = "-"
        self.companySymbolLabel.text = "-"
        self.priceLabel.text = "-"
        self.priceChangeLabel.text = "-"
        self.priceChangeLabel.textColor = .black
        let selectedRow = companyPickerView.selectedRow(inComponent: 0);
        let selectedSymbol = Array(self.companies.values)[selectedRow]
        self.requestQuote(for: selectedSymbol)
    }
    
    private func requestQuote(for symbol: String) {
        
        let url = URL(string: "https://sandbox.iexapis.com/stable/stock/\(symbol)/quote?token=Tsk_fb935c0821484857b4a2a5de1a00c4a2")
        
        let dataTask = URLSession.shared.dataTask(with: url!) {data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                DispatchQueue.main.async {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode
                    var alert: UIAlertController!
                    
                    if statusCode != nil {
                        alert = UIAlertController(title: "Ooups!", message: "Network error, code: \(statusCode!)", preferredStyle: .alert)
                    } else {
                        alert = UIAlertController(title: "Ooups!", message: "Network error, check your internet connection!", preferredStyle: .alert)
                    }
                    
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            
            self.parseQuote(data: data)
        }
        
        dataTask.resume()
    }
    
    private func parseQuote(data: Data) {
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double
            else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ooups!", message: "Error with the https://sandbox.iexapis.com. We will fix it soon!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            
            DispatchQueue.main.async {
                self.displayStockInfo(companyName: companyName,
                                      companySymbol: companySymbol,
                                      price: price,
                                      priceChange: priceChange)
            }
            
        } catch {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Ooups!", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func displayStockInfo(companyName: String, companySymbol: String, price: Double, priceChange: Double) {
        self.activityIndicator.stopAnimating()
        self.companyNameLabel.text = companyName
        self.companySymbolLabel.text = companySymbol
        self.priceLabel.text = "\(price) $"
        self.priceChangeLabel.text = "\(priceChange) $"
        
        if priceChange > 0 {
            self.priceChangeLabel.textColor = .systemGreen
        } else if priceChange < 0 {
            self.priceChangeLabel.textColor = .systemRed
        } else {
            self.priceChangeLabel.textColor = .black
        }
        
        self.loadLogo(for: companySymbol)
    }
}

