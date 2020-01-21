//  
//  LandingView.swift
//  WeatherForecast
//
//  Created by Diana on 1/19/20.
//  Copyright © 2020 Diana Daher. All rights reserved.
//

import UIKit

class LandingView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var bgImageView: UIImageView! {
        didSet {
            bgImageView.image = UIImage(named: "landingBg")
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
            titleLabel.textAlignment = .center
            titleLabel.textColor = .white
            titleLabel.text = "Weather Forecast".localized()
        }
    }
    @IBOutlet weak var unitSegment: UISegmentedControl! {
        didSet {
            unitSegment.tintColor = .darkGray
            unitSegment.setTitle(Constants.degree, forSegmentAt: 0)
            unitSegment.setTitle(Constants.fahrenheit, forSegmentAt: 1)
            if UserDefaults.standard.bool(forKey: UserDefaults_KEYS.UD_IS_IMPERIAL) {
                unitSegment.selectedSegmentIndex = 1
            }
            unitSegment.addTarget(self, action: #selector(changeUnits), for: .valueChanged)
        }
    }
    @IBOutlet weak var myCityButton: UIButton! {
        didSet {
            myCityButton.setTitle("Current City".localized(), for: .normal)
            myCityButton.setTitleColor(.white, for: .normal)
            myCityButton.backgroundColor = .lightGray
            myCityButton.layer.cornerRadius = 5
            myCityButton.addTarget(self, action: #selector(openLocalView), for: .touchUpInside)
        }
    }
    @IBOutlet weak var otherCitiesButton: UIButton! {
        didSet {
            otherCitiesButton.setTitle("Other Cities".localized(), for: .normal)
            otherCitiesButton.setTitleColor(.white, for: .normal)
            otherCitiesButton.backgroundColor = .lightGray
            otherCitiesButton.layer.cornerRadius = 5
            otherCitiesButton.addTarget(self, action: #selector(self.openSearchView), for: .touchUpInside)
        }
    }
    // VARIABLES HERE
    var viewModel = LandingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.protocolDelegate = self
        locationManager.requestAuth()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc func openSearchView() {
        self.viewModel.openSearchView()
    }
    @objc func openLocalView() {
        self.viewModel.openLocalView()
    }
    @objc func changeUnits() {
        Utils.changeUnits()
    }
}

extension LandingView: LandingViewProtocol {
    func redirectToView(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
}

