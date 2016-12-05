//
//  ViewController.swift
//  Page
//
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var pageViewController : UIPageViewController = UIPageViewController()
    var cPage : Int = 0
    var maxPage : Int = 0
    var rewindFlag = true
  
   init() {
    super.init(nibName: nil, bundle: nil)
//    super.init(nibName: "Empty", bundle: nil)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
      print("initWithCoder")
  }
  override func viewWillLayoutSubviews(){
      print("viewWillLayoutSubviews")
  }
    override func viewDidLoad() {
      print("viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cPage = 1 // 現在のページ
        maxPage = 10 // 最大ページ１
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.PageCurl, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        
        // ビューコントローラーを設定、初期表示ページ
        let vc : ContentViewController = ContentViewController()
//          ContentViewController(nibName : "ContentViewController", bundle : nil)
        print("created ContentViewController:\(cPage)ページ@viewDidLoad")
        vc.view.backgroundColor = UIColor.whiteColor()
        vc.label.text = "\(cPage)ページ"
        
        // ページを指定
        self.pageViewController.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        // 入れ子としてUiViewControllerを配置
        // コンテナビューコントローラーを追加
        self.addChildViewController(self.pageViewController)
        // コンテナビューコントローラーの画面を表示
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        self.pageViewController.view.frame = self.view.frame
        
        var pageViewRect : CGRect = self.view.bounds;
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
        self.pageViewController.view.frame = pageViewRect
        self.pageViewController.didMoveToParentViewController(self)
        
//        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
        self.view.backgroundColor = UIColor(red: 0.941, green: 0.701, blue: 0.145, alpha: 1.0)
    }
  
    // 端末の向きが変わった際の処理
    // FIXME:
    func pageViewController(pageViewController: UIPageViewController,
        spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation
    {
        // 縦方向の場合
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            
            let currentViewController : UIViewController = self.pageViewController.viewControllers![0] 
            self.pageViewController.setViewControllers([currentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            // 立て向きの場合は、1ページを1画面で表示
            self.pageViewController.doubleSided = false
            return UIPageViewControllerSpineLocation.Min
            
        }
        // 横方向の場合
        else{
            let currentViewController : UIViewController = self.pageViewController.viewControllers![0]
            var viewControllers : Array<UIViewController> = []
            
            // 偶数ページは現在と次のページ、奇数ページは現在と前のページを表示
            // 奇数ページは現在と次のページを表示、偶数ページは現在と前のページ
            if cPage == 1 {
//            if ((cPage == 0 || cPage % 2 == 0) && cPage != maxPage) {
                let nextViewController : ContentViewController = ContentViewController()
//              ContentViewController(nibName : "ContentViewController", bundle : nil)
                print("created ContentViewController:\(cPage+1)ページ@spine1")
                nextViewController.page = cPage+1
//                nextViewController.label.text = "\(cPage+1)ページ"
                viewControllers = [currentViewController, nextViewController]
            } else {
                let previousViewController : ContentViewController = ContentViewController()
//              ContentViewController(nibName : "ContentViewController", bundle : nil)
                print("created ContentViewController:\(cPage-1)ページ@spine2")
                previousViewController.page = cPage-1
//                previousViewController.label.text = "\(cPage-1)ページ"
                viewControllers = [previousViewController, currentViewController]
            }
            
            self.pageViewController.setViewControllers(viewControllers as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        cPage++
            
            // 横向きの場合は、2ページを1画面で表示
            self.pageViewController.doubleSided = true
            return UIPageViewControllerSpineLocation.Mid
        }
    }
    
    // 次のページを指定
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
//      rewindFlag = true
        if (cPage == maxPage) {
            return nil;
        }
        // ページを加算してビューコントローラーを返却
        cPage++
        
        let vc : ContentViewController = ContentViewController()
      print("created ContentViewController:\(cPage)ページ@After")
//      ContentViewController(nibName : "ContentViewController", bundle : nil)
        vc.view.backgroundColor = UIColor.whiteColor()
        vc.label.text = "\(cPage)ページ"
        return vc
    }
    
    // 前のページを指定
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
      if(rewindFlag) {
        cPage--; cPage--
        rewindFlag = !rewindFlag
      }else{
          cPage--
      }
//        if (cPage  == 2) {
//          return nil
//        }
      
        // ページを減算してビューコントローラーを返却
        let vc : ContentViewController = ContentViewController()
      print("created ContentViewController:\(cPage)ページ@Before")
//      ContentViewController(nibName : "ContentViewController", bundle : nil)
        vc.view.backgroundColor = UIColor.whiteColor()
        vc.label.text = "\(cPage)ページ"
      if(!rewindFlag) {
        cPage++
       rewindFlag = !rewindFlag
      }
        return vc
    }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> UIInterfaceOrientationMask
  {
    return UIInterfaceOrientationMask.All
  }
  func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
    print("->The page number will change.")
  }
  func pageViewController(ProView: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers pageViewController: [UIViewController],
//    previousViewControllers pageViewController: [AnyObject],
    transitionCompleted completed: Bool)
  {
    // If the page did not turn
    if (!completed)
    {
      // You do nothing because whatever page you thought
      // the book was on before the gesture started is still the correct page
      print("->The page number did not change.")
      return;
    }
    
    // This is where you would know the page number changed and handle it appropriately
    print("->The page number has changed.")
  }
    /*
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
            | Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    }
*/
}

