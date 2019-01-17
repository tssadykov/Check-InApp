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
    var isEmitterInstall: Bool
    var interactor: IRegisterInteractor
    var onboardVC: OnboardPageViewController
    var aircompanyPickerView: AircompanyPickerView?
    @IBOutlet var registerContentView: RegisterContentView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if !UserDefaults.standard.bool(forKey: "isWatchingOnboard") {
            present(onboardVC, animated: true, completion: nil)
        }
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isEmitterInstall {
            setupEmitterLayer()
            view.layer.sublayers = [emitterLayer] + view.layer.sublayers!
            isEmitterInstall = true
        }
    }

    init(onboard: OnboardPageViewController, interactor: IRegisterInteractor) {
        onboardVC = onboard
        isEmitterInstall = false
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupEmitterLayer() {
        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterMode = .outline

        let airplaneEmitterLayerCell = CAEmitterCell()
        airplaneEmitterLayerCell.contents = UIImage(named: "airplane")!.cgImage!
        airplaneEmitterLayerCell.birthRate = 1
        airplaneEmitterLayerCell.lifetime = 10
        airplaneEmitterLayerCell.velocity = 100
        airplaneEmitterLayerCell.scale = 3
        airplaneEmitterLayerCell.velocityRange = 10
        airplaneEmitterLayerCell.blueRange = 5
        emitterLayer.emitterCells = [airplaneEmitterLayerCell]
        emitterLayer.emitterSize = CGSize(width: view.bounds.width - 20, height: view.bounds.height)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height)
    }

    private func setupViews() {
        registerContentView.aircompanyNameLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(aircompanyLabelTapped(tapGesture:)))
        registerContentView.aircompanyNameLabel.addGestureRecognizer(tapGesture)
    }

    @objc private func aircompanyLabelTapped(tapGesture: UITapGestureRecognizer) {
        aircompanyPickerView = AircompanyPickerView(frame: view.bounds)
        view.addSubview(aircompanyPickerView!)
        aircompanyPickerView?.picker.dataSource = self
        aircompanyPickerView?.picker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(aircompanyPickerDissmisTapped(tapGesture:)))
        aircompanyPickerView?.addGestureRecognizer(tapGesture)
    }

    @objc private func aircompanyPickerDissmisTapped(tapGesture: UITapGestureRecognizer) {
        aircompanyPickerView?.removeFromSuperview()
    }
}
