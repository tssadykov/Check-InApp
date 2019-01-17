//
//  RegisterInteractor.swift
//  CheckInApp
//
//  Created by Тимур on 17/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import Foundation

protocol IRegisterInteractor {
    var companies: [ICompany] { get set }
}

class RegisterInteractor: IRegisterInteractor {
    var companies: [ICompany]

    init(companies: [ICompany]) {
        self.companies = companies
    }
}
