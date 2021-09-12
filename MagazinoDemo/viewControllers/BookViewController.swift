//
//  BookViewController.swift
//  MagazinoDemo
//
//  Created by Vasilis Kardaras on 9/11/21.
//

import UIKit
import Alamofire

class BookViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        fetchBookData()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "BookViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        collectionView!.collectionViewLayout = layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.navigationBar.topItem?.title  = "Περιοδικά"
    }
    
    private func fetchBookData() {
        
        ApiManager.shared.getBooks() { response in
            debugPrint(response)
            self.books = response
            self.collectionView.reloadData();
        }
    }
}
extension BookViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookViewCell", for: indexPath) as? BookViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        let book = books[indexPath.item]
        cell.bookTitleLabel.text = book.title
        print("title = \(book.title)")
        
        if(book.img_url != nil){
            AF.request(book.img_url!).response { response in
                if let data = response.data {
                    let image = UIImage(data: data)
                    cell.bookImageView.image = image
                } else {
                    debugPrint(response)
                    print("Data is nil. I don't know what to do :(")
                }
            }
        }
        else{
            cell.bookImageView.image = UIImage(named: "blankVideo.jpg");
        }
        
        return cell
    }
}
extension BookViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Double((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let itemHeight = Double(size) * 1.40
        
//        itemHeight = itemHeight - 5

        return CGSize(width: size, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        mgVideo = moodVideos[indexPath.row]
//        goToVideoView(mgvideo: mgVideo!, shouldAddMoodIdToApiCall: shouldAddMoodIdOnCall)
    }
}
