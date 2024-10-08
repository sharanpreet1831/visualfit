
import UIKit

private let reuseIdentifier = "JourneyCell"

class JourneysCollectionViewController: UICollectionViewController {
    
    //MARK: Custom layout generate for collection View
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(410))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,repeatingSubitem: item,count:1)
        let spacing = CGFloat(20)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 16, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.restorationIdentifier = "JourneysViewController"
        let addButton = UIButton(type: .system)
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let symbolImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration)
        addButton.setImage(symbolImage, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        addButton.tintColor = .primary
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }
    
    @objc func addButtonTapped() {
        print("button tapped")
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostsData.getInstance().posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! JourneyCollectionViewCell
        
        let item = PostsData.getInstance().posts[indexPath.item]
        
        cell.userName.text = item.userName
        cell.likeText.text = String(item.like)
        cell.commentText.text = String(item.commentsCount)
        cell.postImg.image = item.postImg
        cell.userImg.image = item.userImgUrl
        cell.postLabel.text = item.label
        return cell
    }
    
    @IBAction func handleScreenTap(_ sender: UITapGestureRecognizer) {
        print(sender);
    }
}
