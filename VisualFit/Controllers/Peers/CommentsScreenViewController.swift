//
//  CommentsScreenViewController.swift
//  VisualFit
//
//  Created by iOS on 05/05/24.
//

import UIKit

protocol CommentsViewControllerDelegate: AnyObject {
    func commentsViewControllerDismissed()
}


class CommentsScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UITextFieldDelegate {
    var commentsData1 : [Comment] = []
    var indexPath : Int? = nil
    weak var delegate: CommentsViewControllerDelegate?

    @IBOutlet weak var commentBarOutlet: UIView!
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var textFieldAndAddButton: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textFieldAndAddButton.bindToKeyboard()
        commentTable.dataSource = self
        commentTable.delegate = self
        
        commentTextField.becomeFirstResponder()
        commentTextField.delegate = self
        
        
        // Set attributed placeholder text with a custom color
        commentTextField.attributedPlaceholder = NSAttributedString(string: "Add your comment...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentsData1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = commentsData1[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment_cell" , for: indexPath) as! CommentTableViewCell
        cell.peerAvatar.image = UIImage(named: cellData.userAvatar)
        cell.peerName.text = cellData.userName
        cell.peerComment.text  = cellData.comment
        
        
        return cell
    }
    // populating data
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        // Assuming you have a UITextField named commentTextField where users input their comments
        
        guard let newCommentText = commentTextField.text, !newCommentText.isEmpty else {
            return // If comment text is empty, do nothing
        }
        
        // Assuming you have some user information and avatar for the new comment
        let newComment = Comment(userName: "User", userAvatar: "mimoji1", date: Date(), comment: newCommentText)
        
        // Add the new comment to the comments array
        if let idxPath = self.indexPath{
            BannerData.getInstance().banners[idxPath].comments.append(newComment)
            self.commentsData1 = BannerData.getInstance().banners[idxPath].comments
        }
        print(BannerData.getInstance().banners[self.indexPath!])
        
        commentTextField.text = ""
        // Reload the table view to reflect the new comment
        commentTable.reloadData()
    }
    // on tap of return key data will get add to comment
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addButtonTapped(UIButton()) // This will call the addButtonTapped function
        return true
    }
    
}
