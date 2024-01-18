//
//  HomeModuleRouter.swift
//  Pokedex
//
//  Created by michaell medina on 17/01/24.
//

import Foundation
import UIKit

class HomeModuleRouter: HomeModuleRouterProtocol {
    var view: MyCustomViewController?
    var presenter: HomeModulePresenterInputProtocol & HomeModulePresenterOutputProtocol & HomeModulePresenterProtocol
    var interactor: HomeModuleInteractorInputProtocol & HomeModuleInteractorOutputProtocol & HomeModuleInteractorProtocol
    var dataManager: HomeExternalDataManagerProtocol?
    
    init() {
        self.presenter = HomeModulePresenter()
        self.view = MyCustomViewController()
        self.interactor = HomeModuleInteractor()
        self.dataManager = HomeExternalDataManager()
        
        self.view?.presenter = self.presenter
        self.presenter.view = self.view
        self.presenter.router = self
        self.presenter.interactorInput = self.interactor
        self.interactor.presenter = self.presenter
        self.interactor.externalDataManager = self.dataManager
        self.dataManager?.interactorOutputProtocol = self.interactor
    }
}


