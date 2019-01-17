//
//  PresentationAssembly.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

protocol IPresentationAssembly: class {
    // Controllers
    func getOnboardPageVC() -> OnboardPageViewController
    func getFinishVC() -> FinishViewController
    func getDataRegisterVC() -> DataRegisterViewController
    func getRegisterVC() -> RegisterViewController

    // Models
    func getRegisterInteractor() -> IRegisterInteractor
}

class PresentationAssembly: IPresentationAssembly {
    func getOnboardPageVC() -> OnboardPageViewController {
        let finishVC = getFinishVC()
        return OnboardPageViewController(viewControllers: [finishVC], assembly: self)
    }

    func getFinishVC() -> FinishViewController {
        return FinishViewController(assembly: self)
    }

    func getDataRegisterVC() -> DataRegisterViewController {
        return DataRegisterViewController(assembly: self)
    }

    func getRegisterVC() -> RegisterViewController {
        let onboard = getOnboardPageVC()
        let interactor = getRegisterInteractor()
        return RegisterViewController(onboard: onboard, interactor: interactor)
    }

    func getRegisterInteractor() -> IRegisterInteractor {
        return RegisterInteractor(companies: [])
    }
}
