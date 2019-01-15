//
//  PresentationAssembly.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

protocol IPresentationAssembly {
    var onboardPageVC: OnboardPageViewController { get set }
    var finishVC: FinishViewController { get set }
    var dataRegisterVC: DataRegisterViewController { get set }
    var registerVC: RegisterViewController { get set }
}

class PresentationAssembly: IPresentationAssembly {
    lazy var onboardPageVC: OnboardPageViewController = OnboardPageViewController(viewControllers: [finishVC])
    lazy var finishVC: FinishViewController = FinishViewController()
    lazy var dataRegisterVC: DataRegisterViewController = DataRegisterViewController()
    lazy var registerVC: RegisterViewController = RegisterViewController()
}
