//
//  PresentationAssembly.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

protocol IPresentationAssembly {
    var onboardPageVC: OnboardPageViewController { get set }
    var dataRegisterVC: DataRegisterViewController { get set }
}

class PresentationAssembly: IPresentationAssembly {
    lazy var onboardPageVC: OnboardPageViewController = OnboardPageViewController(viewControllers: [dataRegisterVC])
    lazy var dataRegisterVC: DataRegisterViewController = DataRegisterViewController()
}
