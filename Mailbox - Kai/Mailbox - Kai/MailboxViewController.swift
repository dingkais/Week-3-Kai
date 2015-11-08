//
//  MailboxViewController.swift
//  Mailbox - Kai
//
//  Created by Kai Ding on 11/7/15.
//  Copyright © 2015 Kai Ding. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    var messageOriginalCenter: CGPoint!
    var leftIconOriginalCenter: CGPoint!
    var rightIconOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = feedImageView.image!.size

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panMessage(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view
        var point = sender.locationInView(view)
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageView.center
            leftIconOriginalCenter = archiveIcon.center
            rightIconOriginalCenter = listIcon.center
            
            print("Gesture began at: \(point)-\(translation)-\(velocity) ")
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            listIcon.center = CGPoint(x: rightIconOriginalCenter.x + translation.x, y: rightIconOriginalCenter.y)
            laterIcon.center = CGPoint(x: rightIconOriginalCenter.x + translation.x, y: rightIconOriginalCenter.y)
            archiveIcon.center = CGPoint(x: leftIconOriginalCenter.x + translation.x, y: leftIconOriginalCenter.y)
            deleteIcon.center = CGPoint(x: leftIconOriginalCenter.x + translation.x, y: leftIconOriginalCenter.y)
            
            // pan left
            if translation.x < 0 && translation.x >= -60 {
                messageBackgroundView.backgroundColor = UIColor.lightGrayColor()
                laterIcon.alpha = 0
                listIcon.alpha = 0
            } else if translation.x < -60 && translation.x >= -260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 0, alpha: 1)
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                })

            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messageBackgroundView.backgroundColor = UIColor.brownColor()
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 1
                })
            }

            print("Gesture changed at: \(point)-\(translation)-\(velocity) ")
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translation.x < -260 {
                self.performSegueWithIdentifier("showOptionSegue", sender: nil)
            }
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messageView.center =  self.messageOriginalCenter
                self.laterIcon.center = self.rightIconOriginalCenter
                self.listIcon.center = self.rightIconOriginalCenter
                }, completion: { (Bool) -> Void in
                self.messageBackgroundView.backgroundColor = UIColor.lightGrayColor()
                    
            })
            
           
            print("Gesture ended at: \(point)-\(translation)-\(velocity) ")

        }
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
