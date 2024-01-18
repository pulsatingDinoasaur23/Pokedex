//
//  ContentView.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//
import UIKit

class MyCustomViewController: BaseViewController {
    
    var presenter: HomeModulePresenterInputProtocol?
    var imageOfpokemons: [PokemonCardDetails] = []
    var pokemonViewFront: UIImageView!
    var pokemonName: UILabel!
    var pokemonViewBack: UIImageView!
    var pokemonType: UILabel!
    var showPokemons: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    func setupUI() {
        view.backgroundColor = .systemMint
        let stackWidth = UIScreen.main.bounds.width * (2.0 / 3.0)
        let stackHeight = UIScreen.main.bounds.height * 1
        pokemonViewFront = UIImageView()
        pokemonViewFront.contentMode = .scaleAspectFit
        pokemonViewFront.translatesAutoresizingMaskIntoConstraints = false
        pokemonViewBack = UIImageView()
        pokemonViewBack.translatesAutoresizingMaskIntoConstraints = false
        pokemonViewBack.tintColor = UIColor.white
        pokemonName = UILabel()
        pokemonName.font = UIFont.boldSystemFont(ofSize: 20)
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        showPokemons = UIButton(type: .system)
        showPokemons.setTitle("Mostrar Pókemon", for: .normal)
        showPokemons.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        showPokemons.translatesAutoresizingMaskIntoConstraints = false
        showPokemons.backgroundColor = .blue
        showPokemons.setTitleColor(.white, for: .normal)
        showPokemons.layer.cornerRadius = 16
        let frontStackView1 = UIStackView(arrangedSubviews: [pokemonViewFront])
        frontStackView1.axis = .vertical
        frontStackView1.alignment = .center
        frontStackView1.spacing = 8
        frontStackView1.translatesAutoresizingMaskIntoConstraints = false
        frontStackView1.layer.borderWidth = 1
        frontStackView1.layer.borderColor = UIColor.black.cgColor
        frontStackView1.layer.cornerRadius = 8
        frontStackView1.layer.shadowColor = UIColor.black.cgColor
        frontStackView1.layer.shadowOpacity = 0.5
        frontStackView1.layer.shadowOffset = CGSize(width: 0, height: 2)
        frontStackView1.layer.shadowRadius = 2
        let frontStackView2 = UIStackView(arrangedSubviews: [pokemonName])
        frontStackView2.axis = .vertical
        frontStackView2.alignment = .center
        frontStackView2.spacing = 8
        frontStackView2.translatesAutoresizingMaskIntoConstraints = false
        frontStackView2.layer.borderWidth = 1
        frontStackView2.layer.borderColor = UIColor.black.cgColor
        frontStackView2.layer.cornerRadius = 8
        frontStackView2.layer.shadowColor = UIColor.black.cgColor
        frontStackView2.layer.shadowOpacity = 0.5
        frontStackView2.layer.shadowOffset = CGSize(width: 0, height: 2)
        frontStackView2.layer.shadowRadius = 2
        let backStackView = UIStackView(arrangedSubviews: [pokemonViewBack])
        backStackView.axis = .vertical
        backStackView.alignment = .center
        backStackView.spacing = 35
        backStackView.translatesAutoresizingMaskIntoConstraints = false
        backStackView.layer.borderWidth = 1
        backStackView.layer.borderColor = UIColor.black.cgColor
        backStackView.layer.cornerRadius = 8
        backStackView.layer.shadowColor = UIColor.black.cgColor
        backStackView.layer.shadowOpacity = 0.5
        backStackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backStackView.layer.shadowRadius = 2
        let mainStackView = UIStackView(arrangedSubviews: [frontStackView1, frontStackView2, showPokemons, backStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 100
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: stackHeight * 0.05),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalToConstant: stackWidth),
            
            frontStackView1.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: stackHeight * 0.1),
            frontStackView1.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 1),
            frontStackView1.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.27),
            
            frontStackView2.topAnchor.constraint(equalTo: frontStackView1.bottomAnchor, constant: stackHeight * 0.02),
            frontStackView2.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 1),
            frontStackView2.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.1),
            
            showPokemons.topAnchor.constraint(equalTo: frontStackView2.bottomAnchor, constant: stackHeight * 0.02),
            showPokemons.widthAnchor.constraint(equalToConstant: stackWidth * 0.8),
            showPokemons.heightAnchor.constraint(equalToConstant: stackHeight * 0.1),
            showPokemons.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            
            backStackView.topAnchor.constraint(equalTo: showPokemons.bottomAnchor, constant: stackHeight * 0.02),
            backStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 1),
            backStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.27),
        ])
    }
    private var isButtonEnabled = true
    private var lastTapTime: Date?
    private var timer: Timer?
    @objc func buttonTapped() {
        presenter?.showAnotherPokemon()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(showAnotherPokemonRepeatedly), userInfo: nil, repeats: false)
    }
    @objc private func showAnotherPokemonRepeatedly() {
        presenter?.showAnotherPokemon()
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(showAnotherPokemonRepeatedly), userInfo: nil, repeats: false)
    }
}
extension MyCustomViewController: HomeModuleViewProtocol {
    func LoadImagesDetail(_ imageDataArray: [PokemonCardDetails]) {
        imageOfpokemons = imageDataArray
        DispatchQueue.main.async {
            if let randomPokemon = imageDataArray.randomElement() {
                self.configure(with: randomPokemon)
            }
        }
    }
    func configure(with pokemon: PokemonCardDetails) {
        if let pokemonImage = pokemon.imageDataFront,
           let pokemonImageBack = pokemon.imageDataBack,
           let imageFront = UIImage(data: pokemonImage),
           let imageBack = UIImage(data: pokemonImageBack) {
            pokemonViewFront.image = imageFront
            pokemonViewBack.image = imageBack
            pokemonName.text = pokemon.name
        } else {
            pokemonViewFront.image = UIImage(named: "trash.fill")
            pokemonViewBack.image = UIImage(named: "trash.fill")
        }
    }
}
