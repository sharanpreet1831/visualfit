//
//  DiscoverViewController.swift
//  VisualFit
//
//  Created by Goyal Harsh on 23/04/24.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    
    private lazy var firstViewController: JourneysCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "JourneysViewController") as! JourneysCollectionViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var secondViewController: TransformationCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "TransformationViewController") as! TransformationCollectionViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    static func viewController() -> DiscoverViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SegementedView") as! DiscoverViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if segmentControlOutlet.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
        } else {
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
        }
    }
    
    func setupView() {
        updateView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        updateSegmentUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateSegmentUI(){
        segmentControlOutlet.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ], for: .normal)
        
        segmentControlOutlet.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
        ], for: .selected)
        
        // Optionally, you can also set specific text for each segment
        segmentControlOutlet.setTitle("Journeys", forSegmentAt: 0)
        segmentControlOutlet.setTitle("Transformations", forSegmentAt: 1)
    }
    
    
    @IBAction func handleSegmentControlChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
            break;
        case 1:
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
            break;
        default:
            add(asChildViewController: firstViewController)
        }
    }
    
    
}
