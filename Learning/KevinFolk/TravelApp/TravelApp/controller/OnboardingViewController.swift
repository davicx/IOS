//
//  OnboardingViewController.swift
//  TravelApp
//
//  Created by David Vasquez on 12/1/23.
//

import UIKit

protocol OnboardingDelegate: class {
    func showMainTabBarController()
}

//Start: Video 15
//14 was confusing
class OnboardingViewController: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLablel: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        print("loading")
        super.viewDidLoad()
        setupViews()
        //More then 4 Slides setupPageControl()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    /*
    private func setupPageControl() {
        pageControl.numberOfPages = Slide.collection.count
    }
     */
    
    private func setupViews() {
        view.backgroundColor = .white
        view.backgroundColor = .systemGroupedBackground
    }
    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segue.showLoginSignUpScreen, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.showLoginSignUpScreen {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
    
    private func showCaption(atIndex index: Int) {
        let slide = Slide.collection[index]
        titleLablel.text = slide.title
        descriptionLable.text = slide.description
    }
    
}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! OnboardingColledtionViewCell
        
        let imageName = Slide.collection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print("Index \(index)")
        showCaption(atIndex: index)
        pageControl.currentPage = index
    }
    
}

extension OnboardingViewController: OnboardingDelegate {
    func showMainTabBarController() {
        // dismiss the login view controller first
        if let loginViewController = self.presentedViewController as? LoginViewController {
            loginViewController.dismiss(animated: true) {
   
                //show main tab bar
                PresenterManager.shared.show(vc: .mainTabBarController)
            }
        }

    }
}
