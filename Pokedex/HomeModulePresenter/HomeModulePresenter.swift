//
//  HomeModulePresenter.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import Foundation

class HomeModulePresenter: HomeModulePresenterProtocol {
    var view: HomeModuleViewProtocol?
    var interactorInput: HomeModuleInteractorInputProtocol?
    var router: HomeModuleRouterProtocol?
    
    func viewDidLoad() {
        interactorInput?.fetchPokemonLists()
    }
}
extension HomeModulePresenter: HomeModulePresenterInputProtocol {
    func showAnotherPokemon() {
        interactorInput?.fetchPokemonLists()
    }
}
extension HomeModulePresenter: HomeModulePresenterOutputProtocol {
    func presentViewOfPokemonS(_ imageDataArray: [PokemonCardDetails]) {
        view?.LoadImagesDetail(imageDataArray)
    }
}
