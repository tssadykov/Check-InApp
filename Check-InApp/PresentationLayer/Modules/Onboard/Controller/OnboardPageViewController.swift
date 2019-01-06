//
//  OnboardPageViewController.swift
//  CheckInApp
//
//  Created by Тимур on 05/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

class OnboardPageViewController: UIPageViewController {

    var orderedViewControllers: [UIViewController]

    init(viewControllers: [UIViewController]) {
        orderedViewControllers = viewControllers
        super.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
