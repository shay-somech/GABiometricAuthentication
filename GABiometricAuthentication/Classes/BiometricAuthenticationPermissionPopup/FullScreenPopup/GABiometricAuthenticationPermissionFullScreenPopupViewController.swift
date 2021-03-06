//
//  GABiometricAuthenticationPermissionFullScreenPopupViewController.swift
//  GABiometricAuthentication
//
//  Created by ido meirov on 24/04/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

public class GABiometricAuthenticationPermissionFullScreenPopupViewController: GABasePopAlertViewController
{
    // MARK: - IBOutlet
    @IBOutlet weak var baseView         : UIView!
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var centerImage      : UIImageView!
    @IBOutlet weak var allowButton      : UIButton!
    @IBOutlet weak var doNotAllowButton : UIButton!
    
    
    // MARK: - Properties
    private var businessLogic: GABiometricAuthenticationPermissionBusinessLogicProtocol?
    
    // MARK: - View life cycle
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        businessLogic?.handleViewDidLoad()
        transitionController.dismissOnBackgroundViewDidPrass = false
    }
    
    // MARK: - Method
    func configurationUI(byConfiguration configuration: GAFullScreenConfiguration)
    {
        let biometricAuthenticationPermissionBusinessLogic = GABiometricAuthenticationPermissionFullScreenBusinessLogic(configuration: configuration)
        biometricAuthenticationPermissionBusinessLogic.delegate = self
        businessLogic = biometricAuthenticationPermissionBusinessLogic
    }
    
    // MARK: - IBAction
    @IBAction func allowButtonDidTap()
    {
        guard let businessLogic = businessLogic else
        {
            dismiss(animated: true)
            return
        }
        
        businessLogic.handleAllowAction()
    }
    
    @IBAction func doNotAllowButtonDidTap()
    {
        guard let businessLogic = businessLogic else
        {
            dismiss(animated: true)
            return
        }
        
        businessLogic.handleDoNotAllowAction()
    }
}

// MARK: - GABiometricAuthenticationPermissionFullScreenBusinessLogicDelegate
extension GABiometricAuthenticationPermissionFullScreenPopupViewController: GABiometricAuthenticationPermissionFullScreenBusinessLogicDelegate
{
    func updateUI(byConfiguration uiConfiguration: GAFullScreenUIConfiguration)
    {
        view.backgroundColor                = uiConfiguration.backgroundColor
        
        titleLabel.attributedText           = uiConfiguration.titleText
        descriptionLabel.attributedText     = uiConfiguration.descriptionText
        centerImage.image                   = uiConfiguration.centerImage
        
        allowButton.backgroundColor         = uiConfiguration.allowButtonConfiguration.backgroundColor
        allowButton.tintColor               = uiConfiguration.allowButtonConfiguration.textColor
        
        allowButton.setTitle(uiConfiguration.allowButtonConfiguration.text, for: .normal)
        
        doNotAllowButton.backgroundColor    = uiConfiguration.doNotAllowButtonConfiguration.backgroundColor
        doNotAllowButton.tintColor          = uiConfiguration.doNotAllowButtonConfiguration.textColor
        
        doNotAllowButton.setTitle(uiConfiguration.doNotAllowButtonConfiguration.text, for: .normal)
    }
    
    func finish()
    {
        businessLogic?.handleDismiss()
        dismiss(animated: true)
    }
}

// MARK: - PopoverTransitionAnimationProtocol
extension GABiometricAuthenticationPermissionFullScreenPopupViewController: PopoverTransitionAnimationProtocol
{
    public var viewForTransitionAnimation: UIView { return baseView }
}
