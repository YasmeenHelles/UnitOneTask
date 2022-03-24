//
//  HomeVC.swift
//  UnitOneTask
//
//  Created by Helles, Yasmeen on 24/03/2022.
//

import UIKit
import SDWebImage
import ImageSlideshow
class HomeVC: UIViewController {

    @IBOutlet weak var viewOffers: UIView!
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var imgSlider: FSPagerView!
    @IBOutlet weak var btnHotels: UIButton!
    @IBOutlet weak var btnFlights: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnSignup: UIButton!
    private  var sliderArray:[Slider] = []
    private  var CitiesArray:[Slider] = []
    @IBOutlet weak var pageControl: FSPageControl!
    private var isHide = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()

    }
    func setUpViews(){
       
        btnSignup.setRounded(radius: 10)
        btnFlights.setRounded(radius: 10)
        btnHotels.setRounded(radius: 10)
        collectionView.registerCell(id: "CityCVCell")
        setUpSlider()
        getData()
    }
    func setUpSlider() {
        self.imgSlider.setRounded(radius:10)
        self.imgSlider.delegate = self
        self.imgSlider.dataSource = self
        self.imgSlider.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.imgSlider.itemSize = CGSize(width: (self.view.frame.size.width), height: (180))
        self.imgSlider.automaticSlidingInterval = 3
        self.imgSlider.isInfinite = false
    }
    
    func setupPageController() {
        self.pageControl.numberOfPages = sliderArray.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.setFillColor("ffffff".color, for: .normal)
        self.pageControl.setStrokeColor("A36DE0".color, for: .normal)
        self.pageControl.setFillColor("A36DE0".color, for: .selected)
    }
    
   func getData(){
       guard self.isConnectedToNetwork() else {
                        // self.showAlertNoInternt()
                         return
                     }
                    // self.showIndicator()
    
              MyApi.api.getHomeData( ){ (status,message,slider,cites) in
                      //   self.hideIndicator()
                          if !status {
                        //  self.showToast(message)
                                      return
                                  }
                  self.sliderArray = slider
                  self.CitiesArray = cites
                  self.collectionView.reloadData()
                  self.imgSlider.reloadData()
                 self.setupPageController()
                         }

   }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth_User.User_Token != ""{
            self.isHide = !isHide
        }
        viewOffers.isHidden = isHide
        viewSignUp.isHidden = !isHide
    }
    @IBAction func goToSignUp(_ sender: UIButton) {
        let vc:LoginVC = AppDelegate.StoryBoard.instanceVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        self.presentVC(vc)
        
    }
}
extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CityCVCell = collectionView.dequeueCVCell(indexPath: indexPath)
        let item = CitiesArray[indexPath.row]
        let url = URL(string:(item.imageURL))
        cell.imgCity.sd_setImage(with: url, placeholderImage: "".toImage)
        cell.lblName.text = item.name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return CitiesArray.count
            
        }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
        return CGSize(width: 170, height: 230)
      }
      
    
}

//FSPager ImageSlider
extension HomeVC : FSPagerViewDataSource, FSPagerViewDelegate {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return sliderArray.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let index = self.sliderArray[index].imageURL
        let url = URL(string: index)
        cell.imageView?.sd_setImage(with: url, placeholderImage: "".toImage)
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: false)
       
        
    }
    
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
//        guard self.pageControl.currentPage != pagerView.currentIndex else {
//            return
//        }
//        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
  }
}
