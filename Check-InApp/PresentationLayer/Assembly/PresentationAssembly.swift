//
//  PresentationAssembly.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

protocol IPresentationAssembly: class {
    // Controllers
    func getDataRegisterVC() -> DataRegisterViewController
    func getRegisterVC() -> RegisterViewController
    func getOnboardVC() -> OnboardViewController
    // Models
    func getRegisterInteractor() -> IRegisterInteractor
}

class PresentationAssembly: IPresentationAssembly {

    func getDataRegisterVC() -> DataRegisterViewController {
        return DataRegisterViewController(assembly: self)
    }

    func getOnboardVC() -> OnboardViewController {
        return OnboardViewController()
    }

    func getRegisterVC() -> RegisterViewController {
        let onboard = getOnboardVC()
        let interactor = getRegisterInteractor()
        return RegisterViewController(onboard: onboard, interactor: interactor)
    }

    func getRegisterInteractor() -> IRegisterInteractor {
        return RegisterInteractor(companies: [])
    }
}
