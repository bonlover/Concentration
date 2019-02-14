//
//  ConcentrationThemeViewController.swift
//  Concentration
//
//  Created by Yungdrung Gyaltsen on 2/12/19.
//  Copyright © 2019 Yungdrung Gyaltsen. All rights reserved.
//

import UIKit

class ConcentrationThemeViewController: UIViewController,UISplitViewControllerDelegate {
    let themes = [
        "Sports": "⛷🏋🏼‍♀️⛹🏼‍♀️🤸🏻‍♂️🤼‍♂️🤾🏽‍♂️🏇🏻🚴🏻‍♀️🧗🏿‍♀️🏄🏼‍♂️🏊‍♂️🤽🏻‍♂️🏌️‍♀️🏌🏻‍♂️🚣🏼‍♀️🤺",
        "Faces": "😃😅😇😂🤣😋😛🥰😭😤🤧😷🤑",
        "Animals": "🐆🦌🦝🐫🐪🐖🐂🐐🐿🦔🦘🦒🦍🦏🐅🦓🐎🦏",
        "Flags": "🇨🇺🇩🇰🇨🇼🇨🇾🇲🇿🇮🇳🇪🇺🇧🇷🇧🇩🇦🇺🇻🇬🇲🇾🇳🇵🇻🇳🇰🇷🇺🇸🇬🇧"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return true
    }
    
    //  MARK: - Change Theme of detailView without Changing ViewControllerDelails by performSegue
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle,  let theme = themes[themeName] {
                cvc.theme = theme
            }
        }
        else if let cvc = lastSeguedToConcentrationcontroller {
            if let themeName = (sender as? UIButton)?.currentTitle,  let theme = themes[themeName] {
                cvc.theme = theme
            }
          navigationController?.pushViewController(cvc, animated: true)
        }
        else{
             performSegue(withIdentifier: "Choose Theme", sender: sender)
            
        }
    }
    
    //  MARK: - SplitViewController details
    
    private var splitViewDetailConcentrationViewController : ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    //  MARK: - Navigation by performSegue
    private var lastSeguedToConcentrationcontroller: ConcentrationViewController?
    

    //  MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            
//            if let button = sender as? UIButton {
//                if let themeName = button .currentTitle {
//                    if let theme = themes[themeName] {
//
//                    }
//                }
//            }
            // Above can be written like this:
            if let themeName = (sender as? UIButton)?.currentTitle,  let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                   cvc.theme = theme
                    lastSeguedToConcentrationcontroller = cvc
                }
            }
        }
    }
 

}
