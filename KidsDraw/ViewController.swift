//
//  ViewController.swift
//  KidsDraw
//
//  Created by Alberto Lourenço on 4/7/20.
//  Copyright © 2020 Alberto Lourenco. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private var isLightOn: Bool = true
    
    @IBOutlet private weak var vwDraw: DrawView!
    
    @IBOutlet private weak var btnLight: UIButton!
    @IBOutlet private weak var btnColor: UIButton!
    
    @IBOutlet private weak var vwColorIndicator: UIView!
    
    @IBOutlet private weak var vwColorPicker: ColorPickerView!
    @IBOutlet private weak var constraintColorPickerMarginBottom: NSLayoutConstraint!
    
    //-----------------------------------------------------------------------
    //  MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.hideColorPicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.vwColorPicker.onColorDidChange = { color in
            self.vwDraw.lineColor = color
            self.vwColorIndicator.backgroundColor = color
        }
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction private func undo() {
        self.vwDraw.undo()
    }
    
    @IBAction private func redo() {
        self.vwDraw.redo()
    }
    
    @IBAction private func clear() {
        self.vwDraw.clear()
    }
    
    @IBAction private func lights() {
        
        isLightOn.toggle()
        
        if isLightOn {
            self.vwDraw.backgroundColor = .white
            self.btnColor.backgroundColor = .systemGray5
            self.btnLight.setBackgroundImage(UIImage(systemName: "lightbulb.fill"), for: .normal)
        }else{
            self.vwDraw.backgroundColor = .black
            self.btnColor.backgroundColor = .darkGray
            self.btnLight.setBackgroundImage(UIImage(systemName: "lightbulb"), for: .normal)
        }
    }
    
    @IBAction private func share() {
        
        if let image = self.vwDraw.getImage() {

            let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            shareVC.popoverPresentationController?.sourceView = self.view
            self.present(shareVC, animated: true, completion: nil)
        }
    }
    
    @IBAction private func pickColor() {
        
        self.constraintColorPickerMarginBottom.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func hideColorPicker(sender: UIButton? = nil) {
        
        self.constraintColorPickerMarginBottom.constant = UIScreen.main.bounds.height
        
        if sender != nil {
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }else{
            self.view.layoutIfNeeded()
        }
    }
}
