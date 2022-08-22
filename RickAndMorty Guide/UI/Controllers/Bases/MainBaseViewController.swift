//
//  MainBaseViewController.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 23.05.2022.
//

import UIKit

// [NOT]: Eğer tabbar ile bir bağlantınız olmayan bir viewcontroller yazıyorsanız;
// bunu MainBaseViewControllerdan değil EJBaseViewControllerdan türetmelisiniz.
// tabbarla bağlantı demek sadece tabbardaki viewcontrollerlar değil
// örneğin; tabbardaki bi viewcontrollerın navigationcontroller’ına push yapıyorsakta bağlantılı oluyor
// yani aslında viewcontroller'ınız tabbar erişebilir, visible- hide yapabilir olacaksa MainBaseViewController kullanın.
// manuel set etmeseniz bile tabbara erişiminiz varsa basedeki isShowTabbar'ın defaul değeri false olduğu için
// aslında kullanıyor oluyorsunuz ve tabbar gizleniyor.
class MainBaseViewController: RAMBaseViewController {

    var mainTabbarController: MainTabbarController? {
        return (tabBarController as? MainTabbarController)
    }

    // if you want to 'show', override and set to true
    public var isShowTabbar: Bool {
        return false
    }

    override func initDidLoad() {
        super.initDidLoad()
        // don't delete this method
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // General Configuration
        visibleTabBar(isVisible: isShowTabbar)
    }

}

// MARK: MainTabbarController funcs
extension MainBaseViewController {

    func clearBackStackAllAndGoTabItem(position: MainTabbarItemPosition) {
        self.changeTabbarItemController(position: position)
        self.selfPopToRootViewController(animated: false)
    }

    func changeTabbarItemController(position: MainTabbarItemPosition) {
        mainTabbarController?.changeTabbarItemController(position: position)
    }
}
