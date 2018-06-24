//
//  ViewController.swift
//  Snapshot
//
//  Created by kevin on 2018/6/20.
//  Copyright © 2018 KevinChang. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var snapshotView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var textImageView1: UIImageView!
    @IBOutlet weak var textImageView2: UIImageView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet var leftSwipeGestureRecongizer: UISwipeGestureRecognizer!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    
    @IBOutlet var options: [UIButton]!
    var selectedImages = [UIImage]()
    
    var swipeCount = 0
    
    // MARK: set up the navigation bar with darkGray backgroundcolor and white title text
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor : UIColor.white ]
        self.navigationController?.navigationBar.barStyle = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: snapshot
    @IBAction func snapshot (_ sender: UIBarButtonItem) {
        UIGraphicsBeginImageContextWithOptions(snapshotView.frame.size, true, 0)
        snapshotView.drawHierarchy(in: snapshotView.bounds, afterScreenUpdates: true)
        let shareImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let activityViewController = UIActivityViewController(activityItems: [shareImage!], applicationActivities: [])
        activityViewController.excludedActivityTypes = [.assignToContact, .addToReadingList, .openInIBooks, .markupAsPDF, .postToVimeo, .postToWeibo, .postToFlickr, .postToTwitter]
        
        self.present(activityViewController, animated: true, completion: nil)
        
        // MARK: Activity Controller Completion Handler with Alert
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if !completed {
                // handle task not completed
                print(error ?? "user canceled sharing")
                return
            }
            let activityText: [String] = (activity?.rawValue.components(separatedBy: "."))!
            let controller = UIAlertController(title: "Successed!", message: "Successfully shared by \"\(activityText[activityText.count - 1])\"", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
    }

    
    // MARK: swipe gesture
    @IBAction func leftSwipeGestureSwiped(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            if swipeCount < 2{
                swipeCount += 1
            }else {
                swipeCount = 0
            }
            myPageControl.currentPage = swipeCount
            self.textImageView1.slideInFromRight()
            self.textImageView2.slideInFromRight()
        }
        switch myPageControl.currentPage {
        case 0:
            textImageView1.image = UIImage(named: "1-1")
            textImageView2.image = UIImage(named: "1-2")
        case 1:
            textImageView1.image = UIImage(named: "2-1")
            textImageView2.image = UIImage(named: "2-2")
        case 2:
            textImageView1.image = UIImage(named: "3-1")
            textImageView2.image = UIImage(named: "3-2")
        default:
            break
        }
    }
    
    @IBAction func swipeGestureSwiped(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            if swipeCount > 0{
                swipeCount -= 1
            }else {
                swipeCount = 2
            }
            myPageControl.currentPage = swipeCount
            self.textImageView1.slideInFromLeft()
            self.textImageView2.slideInFromLeft()
        }
        switch myPageControl.currentPage {
        case 0:
            textImageView1.image = UIImage(named: "1-1")
            textImageView2.image = UIImage(named: "1-2")
        case 1:
            textImageView1.image = UIImage(named: "2-1")
            textImageView2.image = UIImage(named: "2-2")
        case 2:
            textImageView1.image = UIImage(named: "3-1")
            textImageView2.image = UIImage(named: "3-2")
        default:
            break
        }
    }
    
    
    
    // MARK: image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("info: \(info)")
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        mainImageView.image = image
        dismiss(animated: true){
            for option in self.options {
                UIView.animate(withDuration: 0.3) {
                    option.isHidden = !option.isHidden
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        for option in options {
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func takePicture (_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func choosePicture (_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
}

