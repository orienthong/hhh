import UIKit

public
class ViewController: UIViewController {
    
    var pageControl = UIPageControl()
    //var container = PageViewController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        addContainerView()
        layoutPageControl()
        view.backgroundColor = UIColor.blue
        
    }
    
    func addContainerView() {
        
        let pageViewController: PageViewController = PageViewController()
        pageViewController.pageDelegate = self
        let childView = pageViewController.view!
        self.addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        
        
        //add Constrains
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        pageViewController.didMove(toParentViewController: self)
    }
    func layoutPageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 4
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.backgroundColor = UIColor.purple.withAlphaComponent(0.0)
        pageControl.isUserInteractionEnabled = false
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: PageViewControllerDelegate {
    func PageViewControllerUpdatePageCount(PageViewController: PageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    func PageViewControllerUpdatePageIndex(PageViewController: PageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
