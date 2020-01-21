//
//  SearchView.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

class SearchView: UIViewController {
    
    // OUTLETS HERE
    @IBOutlet weak var inputTextField: UITextField! {
        didSet {
            inputTextField.delegate = self
            inputTextField.placeholder = "eg.cities".localized()
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: DailyWeatherCell.identifier, bundle: nil), forCellReuseIdentifier: DailyWeatherCell.identifier)
        }
    }
    // VARIABLES HERE
    var viewModel = SearchViewModel()
    var tableArray = [SearchModel]()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.center = self.view.center
        indicator.style = .gray
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        self.viewModel.protocolDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Other".localized()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension SearchView: SearchViewProtocol {
    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func renderTableValues(array: [SearchModel]) {
        self.tableArray = array
        self.tableView.reloadData()
    }
}
extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.identifier) as? DailyWeatherCell else { return UITableViewCell() }
        let item = tableArray[indexPath.row]
        let cityWeather = Utils.appendAttributedStrings(
            (text: "\(item.name ?? "")\n",
            color: .black,
            font: UIFont.boldSystemFont(ofSize: 20)),
            (text: (item.weather?[0].weatherDescription ?? "").capitalizingFirstLetter(),
             color: .black,
             font: UIFont.systemFont(ofSize: 20)))
        cell.leftTopLabel.attributedText = cityWeather
        cell.leftbottomLabel.text = "Wind speed:".localized() + " \(item.wind?.speed ?? 0) \(Utils.getWindSpeedUnit())"
        let temperatureText = Utils.appendAttributedStrings(
            (text: "\(item.main?.tempMax ?? 0)\(Utils.getTempUnit())\n",
            color: .black,
            font: UIFont.systemFont(ofSize: 20)),
            (text: "\(item.main?.tempMin ?? 0)\(Utils.getTempUnit())",
             color: .black,
             font: UIFont.systemFont(ofSize: 15)))
        cell.rightLabel.attributedText = temperatureText
        return cell
    }
}

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.viewModel.userDidFinish(inputText: textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.viewModel.checkValidEntry(txtFieldText: textField.text ?? "", newInput: string)
    }
}
