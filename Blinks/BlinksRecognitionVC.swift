//
//  BlinksRecognitionVC.swift
//  Blinks
//
//  Created by Alon Haiut on 11/12/2018.
//  Copyright © 2018 Alon Haiut. All rights reserved.
//

import UIKit
import SnapKit
import ARKit

class BlinksRecognitionVC: UIViewController {

    fileprivate struct Metrics {
        static let btnHeight: CGFloat = 40
        static let btnCornerRadius: CGFloat = 12
        static let horizontalPadding: CGFloat = 12
    }
    
    fileprivate let viewModel: BlinksRecognitionViewModeling
    
    fileprivate lazy var recognitionView: RecognitionView = {
        let recognitionView = RecognitionView()
        recognitionView.delegate = self
        return recognitionView
    }()
    
    fileprivate lazy var btnRecognize: UIButton = {
        let btnTitle = NSLocalizedString("btnRecognizeTitle", comment:"")
        
        let btn = btnTitle
            .button
            .backgroundColor(ColorPalette.blue)
            .corner(radius: Metrics.btnCornerRadius)
            .textColor(.white)
            .font(FontBook.mainHeading)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,
                                             left: Metrics.horizontalPadding,
                                             bottom: 0,
                                             right: Metrics.horizontalPadding)
        
        
        btn.addTarget(self, action: #selector(btnRecognizePressed), for: .touchUpInside)
        
        return btn
    }()
    
    init(viewModel: BlinksRecognitionViewModeling = BlinksRecognitionViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.inputs.set(delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recognitionView.session.pause()
    }
}

fileprivate extension BlinksRecognitionVC {
    func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(recognitionView)
        recognitionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        recognitionView.isHidden = true // Initial state
        
        view.addSubview(btnRecognize)
        btnRecognize.snp.makeConstraints { (make) in
            make.height.equalTo(Metrics.btnHeight)
            make.center.equalToSuperview()
        }
    }
    
    @objc func btnRecognizePressed() {
        viewModel.inputs.btnRecognizePressed()
    }
}

extension BlinksRecognitionVC: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension BlinksRecognitionVC: BlinksRecognitionDelegation {
    func changeRectangle(forEye eye: Eye, color: UIColor) {
        
    }
    
    func startCameraTracking() {
        recognitionView.isHidden = false
        let configuration = ARFaceTrackingConfiguration()
        recognitionView.session.run(configuration)
    }
    
    func btnRecognizeVisibility(shouldShow: Bool) {
        btnRecognize.isHidden = !shouldShow
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment:""),
                                     style: .default, handler: nil)
        alert.addAction(okAction)
        
        alert.popoverPresentationController?.sourceView = view
        self.present(alert, animated: true, completion: nil)
    }
}

