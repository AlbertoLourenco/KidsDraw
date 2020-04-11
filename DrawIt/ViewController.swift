//
//  ViewController.swift
//  DrawIt
//
//  Created by Alberto Lourenço on 4/7/20.
//  Copyright © 2020 Alberto Lourenco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var isLightOn: Bool = true
    
    @IBOutlet var vwDraw: DrawView!
    
    @IBOutlet var btnLight: UIButton!
    @IBOutlet var btnColor: UIButton!
    
    @IBOutlet var vwColorPicker: ColorPickerView!
    @IBOutlet var constraintColorPickerMarginBottom: NSLayoutConstraint!
    
    //-----------------------------------------------------------------------
    //  MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.vwColorPicker.onColorDidChange = { color in
            
            self.vwDraw.lineColor = color
            self.btnColor.backgroundColor = color
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        
        self.hideColorPicker()
    }
    
    @IBAction func undo() {
        self.vwDraw.undo()
    }
    
    @IBAction func redo() {
        self.vwDraw.redo()
    }
    
    @IBAction func clear() {
        self.vwDraw.clear()
    }
    
    @IBAction func lights() {
        
        isLightOn = !isLightOn
        
        self.vwDraw.backgroundColor = isLightOn ? .white : .black
        
        self.btnLight.setImage(UIImage(systemName: isLightOn ? "lightbulb.fill" : "lightbulb"),
                               for: .normal)
    }
    
    @IBAction func share() {
        
        if let image = self.vwDraw.getImage() {

            let shareVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            shareVC.popoverPresentationController?.sourceView = self.view
            self.present(shareVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func pickColor() {
        
        self.constraintColorPickerMarginBottom.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func hideColorPicker(sender: UIButton? = nil) {
        
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
