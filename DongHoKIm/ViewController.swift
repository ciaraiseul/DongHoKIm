//
//  ViewController.swift
//  DongHoKIm
//
//  Created by Phạm Trường Giang on 16/08/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var clockView: UIView!
    var hourHand: UIView!
    var minuteHand: UIView!
    var secondHand: UIView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupClockView()
        setupHourHand()
        setupMinuteHand()
        setupSecondHand()
        setupClockNumBers()
        setupButton()
    }

    func setupClockView() {
        let clockSize: CGFloat = 300
        clockView = UIView(frame: CGRect(x: (view.frame.width - clockSize) / 2, y: (view.frame.height - clockSize) / 2, width: clockSize, height: clockSize))
        clockView.backgroundColor = .white
        clockView.layer.cornerRadius = clockSize / 2
        clockView.layer.borderWidth = 5
        clockView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(clockView)
    }
    
    func setupClockNumBers() {
        let clockRadius = clockView.frame.width / 2
        let labelRadius = clockRadius - 30
        
        for i in 1...12 {
            let angle = CGFloat(i) * (2 * CGFloat.pi / 12) - (CGFloat.pi / 2)
            let labelX = clockView.frame.origin.x + clockRadius + labelRadius * cos(angle)
            let labelY = clockView.frame.origin.y + clockView.frame.height / 2 + labelRadius * sin(angle)
            
            let label = UILabel()
            label.frame = CGRect(x: labelX - 15, y: labelY - 15, width: 30, height: 30)
            label.text = "\(i)"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            view.addSubview(label)
        }
    }
    
    func setupHourHand() {
        hourHand = UIView(frame: CGRect(x: clockView.frame.width / 2 - 4, y: clockView.frame.height / 2 - 40, width: 8, height: 80))
        hourHand.backgroundColor = .red
        hourHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        clockView.addSubview(hourHand)
    }
    
    func setupMinuteHand() {
        minuteHand = UIView(frame: CGRect(x: clockView.frame.width / 2 - 3, y: clockView.frame.height / 2 - 60, width: 6, height: 120))
        minuteHand.backgroundColor = .blue
        minuteHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        clockView.addSubview(minuteHand)
    }
    
    func setupSecondHand() {
        secondHand = UIView(frame: CGRect(x: clockView.frame.width / 2 - 1, y: clockView.frame.height / 2 - 70, width: 2, height: 140))
        secondHand.backgroundColor = .brown
        secondHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        clockView.addSubview(secondHand)
    }
    
    func setupButton() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: (view.frame.width - 200) / 2, y: clockView.frame.maxY + 50, width: 200, height: 50)
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(startClock), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func startClock() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateClockHands), userInfo: nil, repeats: true)
        updateClockHands()
    }

    @objc func updateClockHands() {
        let calendar = Calendar.current
        let date = Date()
        
        let seconds = calendar.component(.second, from: date)
        let minutes = calendar.component(.minute, from: date)
        let hours = calendar.component(.hour, from: date)
        let nanoseconds = calendar.component(.nanosecond, from: date)
        
        let secondAngle = CGFloat(seconds) * (2 * CGFloat.pi / 60)
        let minuteAngle = (CGFloat(minutes) + CGFloat(seconds) / 60.0) * (2 * CGFloat.pi / 60)
        let hourAngle = (CGFloat(hours % 12) + CGFloat(minutes) / 60.0) * (2 * CGFloat.pi / 12)
        
        UIView.animate(withDuration: 0.1) {
            self.hourHand.transform = CGAffineTransform(rotationAngle: hourAngle)
            self.minuteHand.transform = CGAffineTransform(rotationAngle: minuteAngle)
            self.secondHand.transform = CGAffineTransform(rotationAngle: secondAngle)
        }
    }
}
