//
//  UIView+SafeArea.swift
//  FavMovies
//
//  Created by Nathalie Cesarino on 19/01/23.
//

import Foundation
import UIKit

public extension UIViewController {
    
    var topSafeArea: CGFloat {
        return view.topSafeArea
    }
    
    var leadingSafeArea: CGFloat {
        return view.leadingSafeArea
    }
    
    var trailingSafeArea: CGFloat {
        return view.trailingSafeArea
    }
    
    var bottomSafeArea: CGFloat {
        return view.bottomSafeArea
    }
}

public extension UIView {
    
    var topSafeArea: CGFloat {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            return window.safeAreaInsets.top
        }
        return 0
    }

    var leadingSafeArea: CGFloat {
        return (UIApplication.shared.keyWindow?.safeAreaInsets.left) ?? 0
    }
    
    var trailingSafeArea: CGFloat {
        return (UIApplication.shared.keyWindow?.safeAreaInsets.right) ?? 0
    }
    
    var bottomSafeArea: CGFloat {
        return (UIApplication.shared.keyWindow?.safeAreaInsets.bottom) ?? 0
    }
}
