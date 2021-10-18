//
//  ViewController.swift
//  Weather
//
//  Created by Dima Milosh on 15.10.21.
//

import UIKit

class ViewController: UIViewController{
    
    var presenter: ViewPresenterProtocol!
    var mainCV: UICollectionView!
    weak var hourlyForecastCV: UICollectionView?
    weak var currentInfoCV: UICollectionView?
    weak var weekForecastTV: UITableView?
    weak var fiveDayForecastTV: UITableView?
    var pageControl: UIPageControl = UIPageControl(frame: .zero)
    var imageArray = (0...9).compactMap{ UIImage(named: "info\($0)") }
    var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        mainCV.delegate = self
        mainCV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork() == true {
            startLaunching()
            presenter.startUpdatingLocation()
        }else{
            startOfflineLaunching()
        }
    }
    
    var backgroundPictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "background")
        return imageView
    }()
    
    var weatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 15
        view.addBlurEffect()
        return view
    }()
    
    var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "01d")
        return imageView
    }()

    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Minsk"
        return label
    }()

    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(100)
        label.textColor = .white
        label.text = "17"
        return label
    }()

    var maxMinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = "17/10"
        return label
    }()

    var temperatureInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Sunny"
        return label
    }()
    
    var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "horizontallines"), for: .normal)
        button.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
        return button
    }()
    
    func setLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height*0.675)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        mainCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainCV.translatesAutoresizingMaskIntoConstraints = false
        mainCV.showsHorizontalScrollIndicator = false
        mainCV.isUserInteractionEnabled = true
        mainCV.isPagingEnabled = true
        mainCV.allowsSelection = false
        mainCV.backgroundColor = .clear
        mainCV.register(MainFirstCollectionViewCell.self, forCellWithReuseIdentifier: MainFirstCollectionViewCell.identifier)
        mainCV.register(MainSecondCollectionViewCell.self, forCellWithReuseIdentifier: MainSecondCollectionViewCell.identifier)
        mainCV.register(MainThirdCollectionViewCell.self, forCellWithReuseIdentifier: MainThirdCollectionViewCell.identifier)
        
        let firstStack = UIStackView(arrangedSubviews: [locationLabel, temperatureLabel, temperatureInfoLabel])
        firstStack.translatesAutoresizingMaskIntoConstraints = false
        firstStack.axis = .vertical

        let secondStack = UIStackView(arrangedSubviews: [weatherIcon, maxMinLabel])
        secondStack.translatesAutoresizingMaskIntoConstraints = false
        secondStack.axis = .vertical
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        pageControl.isUserInteractionEnabled = false
        
        view.addSubview(backgroundPictureImageView)
        view.addSubview(mainCV)
        view.addSubview(weatherView)
        weatherView.addSubview(menuButton)
        weatherView.addSubview(firstStack)
        weatherView.addSubview(secondStack)
        view.insertSubview(pageControl, at: 0)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            backgroundPictureImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundPictureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundPictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundPictureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 200),
            weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
            
            mainCV.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 15),
            mainCV.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
            mainCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          
            menuButton.heightAnchor.constraint(equalToConstant: 25),
            menuButton.widthAnchor.constraint(equalToConstant: 25),
            menuButton.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -15),
            menuButton.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 15),
            
            firstStack.widthAnchor.constraint(equalToConstant: 215),
            firstStack.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 15),
            firstStack.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: 15),
            firstStack.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: -15),
            
            secondStack.widthAnchor.constraint(equalToConstant: 100),
            secondStack.topAnchor.constraint(equalTo: menuButton.bottomAnchor),
            secondStack.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor, constant: -15),
            secondStack.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: -15),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
            
        ])
    }
    
}
