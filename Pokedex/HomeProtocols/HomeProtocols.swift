//
//  HomeProtocols.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import Foundation

protocol HomeModuleViewProtocol {
    func LoadImagesDetail(_ imageDataArray: [PokemonCardDetails])
}
protocol HomeModulePresenterProtocol {
    var view: HomeModuleViewProtocol? { get set }
    var interactorInput: HomeModuleInteractorInputProtocol? { get set }
    var router: HomeModuleRouterProtocol? { get set }
    func viewDidLoad()
}
protocol HomeModulePresenterInputProtocol {
    func viewDidLoad()
    func showAnotherPokemon()
}
protocol HomeModulePresenterOutputProtocol {
    func presentViewOfPokemonS(_ imageDataArray: [PokemonCardDetails])
}
protocol HomeModuleInteractorProtocol {
    var externalDataManager: HomeExternalDataManagerProtocol? { get set }
    var presenter: HomeModulePresenterOutputProtocol? { get set }
}
protocol HomeModuleInteractorInputProtocol {
    func fetchPokemonLists()
}
protocol HomeModuleInteractorOutputProtocol {
    func onPokemonImageRetrieved(_ pokemonImages: [PokemonCellsDetails], _ pokemonData: [Pokemon])
}
protocol HomeExternalDataManagerProtocol {
    var interactorOutputProtocol: HomeModuleInteractorOutputProtocol? { get set }
    func fetchPokemonList(completion: @escaping () -> Void)
}
protocol HomeModuleRouterProtocol {
    var view: MyCustomViewController? { get set }
    var interactor: HomeModuleInteractorProtocol & HomeModuleInteractorInputProtocol & HomeModuleInteractorOutputProtocol { get set }
    var presenter: HomeModulePresenterProtocol & HomeModulePresenterInputProtocol & HomeModulePresenterOutputProtocol { get set }
    var dataManager: HomeExternalDataManagerProtocol? { get set }
}
