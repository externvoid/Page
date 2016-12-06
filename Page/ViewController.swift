//
//  ViewController.swift
//  Page
//
//

import UIKit

class ViewController: UIViewController {

   var pageViewController : UIPageViewController = UIPageViewController()
   var cPage : Int = 1
   var maxPage : Int = 4
  
   init() {
    super.init(nibName: nil, bundle: nil)
//    super.init(nibName: "Empty", bundle: nil)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
//      print("initWithCoder")
  }
  override func viewWillLayoutSubviews(){
//      print("viewWillLayoutSubviews")
  }
  override func viewDidLoad() {
    print("viewDidLoad")
    super.viewDidLoad()
      
//    cPage = 1; maxPage = 10 // 最大ページ１ // 現在のページ
      
    self.pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal, options: nil)
    self.pageViewController.delegate = self
    self.pageViewController.dataSource = self
    self.pageViewController.view.frame = self.view.frame
// ビューコントローラーを設定、初期表示ページ
    let cvc : ContentViewController = ContentViewController(page: cPage)
    print("created ContentViewController:\(cPage)ページ@viewDidLoad")
    
// ページを指定
    self.pageViewController.setViewControllers([cvc],
      direction: .forward, animated: true, completion: nil)
// 入れ子としてUIPageViewControllerを配置
// コンテナビューコントローラーを追加
    self.addChildViewController(self.pageViewController)
// コンテナビューコントローラーの画面を表示
    self.view.addSubview(self.pageViewController.view)
    
    
    var pageViewRect : CGRect = self.view.bounds;
    pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
    self.pageViewController.view.frame = pageViewRect
    self.pageViewController.didMove(toParentViewController: self)
        
//        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    self.view.backgroundColor = UIColor(red: 0.941, green: 0.701, blue: 0.145, alpha: 1.0)
    print("ViewController#viewDidLoad completed\n")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
extension ViewController: UIPageViewControllerDelegate {
  
  func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    print("->The page number will change.")
  }
  func pageViewController(_ ProView: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers pageViewController: [UIViewController],
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
    print("->The page number has changed.\(cPage)") // ココの数字は当てにならん
  }
}
extension ViewController: UIPageViewControllerDataSource {
    // ページを奥付方向へ捲る
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
      let p = (viewController as! ContentViewController).page
      print("current page = \(p)"); cPage = p
      if (p == maxPage) {
        return nil;
      }
        // ページを加算してビューコントローラーを返却
//      cPage += 1
        
      let cvc : ContentViewController = ContentViewController(page: p + 1)
      print("created ContentViewController:\(p + 1)ページ@After")
      return cvc
    }
    
    // ページを表紙方向へ捲る
    func pageViewController(_ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
      let p = (viewController as! ContentViewController).page
      print("current page = \(p)"); cPage = p
      if (p  == 1) {
        return nil
      }
//      cPage -= 1
      
        // ページを減算してビューコントローラーを返却
      let cvc : ContentViewController = ContentViewController(page: p - 1)
      print("created ContentViewController:\(p - 1)ページ@Before")
      return cvc
    }
}
