//
//  RegisterViewController.swift
//  CheckInApp
//
//  Created by Тимур on 06/01/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var emitterLayer: CAEmitterLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupEmitterLayer()
        view.layer.addSublayer(emitterLayer)
    }

    func setupEmitterLayer() {
        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterMode = .outline

        let airplaneEmitterLayerCell = CAEmitterCell()
        airplaneEmitterLayerCell.contents = UIImage(named: "airplane")!.cgImage!
        airplaneEmitterLayerCell.birthRate = 5
        airplaneEmitterLayerCell.lifetime = 10
        airplaneEmitterLayerCell.velocity = 100
        airplaneEmitterLayerCell.scale = 1
        airplaneEmitterLayerCell.velocityRange = 10
        airplaneEmitterLayerCell.blueRange = 5
        emitterLayer.emitterCells = [airplaneEmitterLayerCell]
        emitterLayer.emitterSize = CGSize(width: view.bounds.width - 20, height: view.bounds.height)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height)
    }
}
