//
//  ContentViewController.swift
//  Page
//
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var page : Int = 0
  init(page: Int) {
    super.init(nibName: "ContentViewController", bundle: nil)
    self.page = page
  }
  init() {
    print("->->init@Content")
    super.init(nibName: "ContentViewController", bundle: nil)
    guard let _ = label else { print("nil guard@Content")
//      label = UILabel()
      return }//戻り値の無いメソッドでも⁉️
  }
  override func viewWillLayoutSubviews(){
    print("viewWillLayoutSubviews@Content")
    self.view.backgroundColor = UIColor.orange
    print("\(page)ページ@viewWillLayout...\n")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    print("viewDidLoad@Content")
    label.text = "\(page)ページ"
    print("page = \(page)@viewDidLoad\n")
  }

  // not called, unreachable
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    if label == nil {
      print("nil guard@Content")
      label = UILabel()
    }
    print("initWithCoder@Content")
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
