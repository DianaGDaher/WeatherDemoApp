//  
//  LocalWeatherView.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

class LocalWeatherView: UIViewController {
    
    // OUTLETS HERE
    @IBOutlet weak var cityLabel: UILabel! {
        didSet {
            cityLabel.font = UIFont.boldSystemFont(ofSize: 25)
            cityLabel.textColor = .black
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
    var viewModel = LocalWeatherViewModel()
    var tableArray = [TableRow]()
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
        Utils.addPullDownToRefreshToView(vc: self, view: self.tableView, action: #selector(refreshData))
        self.viewModel.protocolDelegate = self
        self.viewModel.getCurrentCity()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @objc func refreshData() {
        self.viewModel.getCurrentCity(showLoading: false)
    }
    
}
extension LocalWeatherView: LocalWeatherViewProtocol {
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    func removeRefreshLoader() {
        Utils.endRefreshingOnView(view: self.tableView)
    }
    
    func renderForecastValues(array: [TableRow]) {
        self.tableArray = array
        self.tableView.reloadData()
    }
    
    func updateCityName(name: String) {
        self.navigationItem.title = name
    }
}
extension LocalWeatherView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableArray[section].day ?? ""
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray[section].weatherList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.identifier) as? DailyWeatherCell else { return UITableViewCell() }
        let item = tableArray[indexPath.section].weatherList?[indexPath.row]
        let timeAndDescText = Utils.appendAttributedStrings(
            (text: "\(Utils.timeStringFromTimeInterval(item?.dt ?? TimeInterval(0)))\n",
                color: .gray,
                font: UIFont.systemFont(ofSize: 15)),
            (text: (item?.weather?[0].weatherDescription ?? "").capitalizingFirstLetter(),
             color: .black,
             font: UIFont.systemFont(ofSize: 20)))
        cell.leftTopLabel.attributedText = timeAndDescText
        cell.leftbottomLabel.text = "Wind speed:".localized() + " \(item?.wind?.speed ?? 0) \(Utils.getWindSpeedUnit())"
        
        let tempText = Utils.appendAttributedStrings(
            (text: "\(item?.main?.tempMax ?? 0)\(Utils.getTempUnit())\n",
                color: .gray,
                font: UIFont.systemFont(ofSize: 20)),
            (text: "\(item?.main?.tempMin ?? 0)\(Utils.getTempUnit())",
                color: .gray,
                font: UIFont.systemFont(ofSize: 15)))
        cell.rightLabel.attributedText = tempText
        return cell
    }
}

extension LocalWeatherView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

