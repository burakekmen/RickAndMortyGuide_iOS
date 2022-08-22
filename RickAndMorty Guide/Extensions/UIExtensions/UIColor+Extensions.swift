//
//  UIColor+Extensions.swift
//  RickAndMortyGuide
//
//  
//

import UIKit

// [NOTE] ->  Primary ile başlayan renkler;
// zeplin style guide'daki ana renkler -> https ://app.zeplin.io/project/6093bcaa907ff334c6e4ed45/screen/60b0a9c92aba35128044158b

extension UIColor {

    // MARK: General Colors
    static var blackColor: UIColor { .black }
    static var whiteColor: UIColor { .white }
    static var orangeColor: UIColor { .orange }
    static var blueColor: UIColor { .blue }
    static var greenColor: UIColor { .green }
    static var redColor: UIColor { .red }
    static var clearColor: UIColor { .clear }
    static var brownColor: UIColor { .brown }
    static var grayColor: UIColor { .gray }
    static var lightGrayColor: UIColor { .lightGray }
    static var darkGrayColor: UIColor { .darkGray }
    static var cyanColor: UIColor { .cyan }
    static var purpleColor: UIColor { .purple }

    // MARK: AppColor
    static var baseBackgroundColor: UIColor { .init(named: "baseBackgroundColor")! }
    static var tabbarBackgroundColor: UIColor { .init(named: "tabbarBackgroundColor")! }
    
    //MARK: Tabs Color
    static var characterTabColor: UIColor { .init(named: "characterTabColor")! }
    static var episodeTabColor: UIColor { .init(named: "episodeTabColor")! }
    static var favoriteTabColor: UIColor { .init(named: "favoriteTabColor")! }
    static var blueTabColor: UIColor { .init(named: "blueTabColor")! }
    
    static var gray128: UIColor { .init(named: "gray128")! }
    static var primaryLightGray: UIColor { .init(named: "primaryLightGray")! }
    
    //MARK: CharacterCell Color
    static var characterCellAliveStatusColor: UIColor { .init(named: "characterCellAliveStatusColor")! }
    static var characterCellBackgroundColor: UIColor { .init(named: "characterCellBackgroundColor")! }
    static var characterCellDeadStatusColor: UIColor { .init(named: "characterCellDeadStatusColor")! }
    static var characterCellDefaultColor: UIColor { .init(named: "characterCellDefaultColor")! }
    static var characterCellLabelColor: UIColor { .init(named: "characterCellLabelColor")! }
    
}

// MARK: Adjusting
extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage))
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage / 100, 1.0),
                           green: min(green + percentage / 100, 1.0),
                           blue: min(blue + percentage / 100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
