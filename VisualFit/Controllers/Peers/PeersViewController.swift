//
//  PeersViewController.swift
//  VisualFit
//
//  Created by iOS  on 24/04/24.
//

import UIKit

class PeersViewController: UIViewController {
    
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var firstViewController: LeaderboardViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "LeaderboardViewController") as! LeaderboardViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var secondViewController: ArenaCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ArenaViewController") as! ArenaCollectionViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    static func viewController() -> PeersViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SegementedView") as! PeersViewController
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
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        updateSegmentUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func updateSegmentUI(){
        // Change the text color and font for normal state
        segmentControlOutlet.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white, // Change color as needed
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) // Change font as needed
        ], for: .normal)
        
        // Change the text color and font for selected state
        segmentControlOutlet.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black, // Change color as needed
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) // Change font as needed
        ], for: .selected)
        
        // Optionally, you can also set specific text for each segment
        segmentControlOutlet.setTitle("Leaderboard", forSegmentAt: 0)
        segmentControlOutlet.setTitle("Arena", forSegmentAt: 1)
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
