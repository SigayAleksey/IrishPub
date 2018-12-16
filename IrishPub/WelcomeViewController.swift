//
//  WelcomeViewController.swift
//  IrishPub
//
//  Created by Алексей Сигай on 23/11/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import MapKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let mainBackgroundView: UIView = {
        let customView = UIView()
        customView.backgroundColor = UIColor.white
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let banerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "baner_image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let banerLabel: UILabel = {
        let label = UILabel()
        label.text = "Irish Pub"
        label.font = UIFont(name: "Palatino-BoldItalic", size: 80)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addresBackgroundView: UIView = {
        let customView = UIView()
        customView.backgroundColor = Constant.addresBackgroundColor
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let addresTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Наш адрес:\nСанкт-Петербург, ул. Большая Конюшенная, д. 14"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.sizeToFit()
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let navigationButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(sequeToMap), for: .touchUpInside)
        button.setImage(UIImage(named: "compass_icon"), for: .normal)
        button.tintColor = Constant.buttonColor
        button.layer.cornerRadius = 30
        button.sizeThatFits(CGSize(width: 60, height: 60))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let reserveView: UIView = {
        let customView = UIView()
        customView.backgroundColor = Constant.mainBackgroundColor
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    let reserveTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Резерв столов"
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reserveNameTextField = UITextField.textFieldWithPlaceholder(placeholder: "ФИО")
    let reserveDateTextField = UITextField.textFieldWithPlaceholder(placeholder: "Дата")
    let reserveTimeTextField = UITextField.textFieldWithPlaceholder(placeholder: "Время")
    let reserveVisitorsTextField = UITextField.textFieldWithPlaceholder(placeholder: "Человек")
    let reservePhoneTextField = UITextField.textFieldWithPlaceholder(placeholder: "Телефон")
    let reserveCommentTextField = UITextField.textFieldWithPlaceholder(placeholder: "Пожелания")

    let reserveButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(reserveTable), for: .touchUpInside)
        button.tintColor = Constant.buttonColor
        button.setTitle("Зарезервировать", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        return dateFormatter
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(reserveDateTextFieldChanged(datePicker:)), for: .valueChanged)
        return picker
    }()
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.minuteInterval = 10
        picker.addTarget(self, action: #selector(reserveTimeTextFieldChanged(datePicker:)), for: .valueChanged)
        return picker
    }()
    
    
    deinit {
        // Stop Notification
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        addObservers()
        view.addTapGestureToHideKeyboard()
        
        setupView()
        view.backgroundColor = Constant.mainBackgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Constant.buttonColor]
        
        configureTextFields()
    }
    
    
    // MARK: - Setup TextFields
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue.height
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    private func configureTextFields() {
        self.reserveNameTextField.delegate = self
        self.reserveDateTextField.delegate = self
        self.reserveTimeTextField.delegate = self
        self.reserveVisitorsTextField.delegate = self
        self.reservePhoneTextField.delegate = self
        self.reserveCommentTextField.delegate = self
        
        reserveDateTextField.inputView = datePicker
        reserveDateTextField.addTarget(self, action: #selector(setCurrentDate), for: .editingDidBegin)
        reserveTimeTextField.inputView = timePicker
        reserveVisitorsTextField.keyboardType = .numberPad
        reservePhoneTextField.keyboardType = .numberPad
        reservePhoneTextField.addTarget(self, action: #selector(phoneNumberMask), for: .valueChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Comfortable transitions from one to another UITextField
        
        switch textField {
        case reserveNameTextField:
            reserveDateTextField.becomeFirstResponder()
            setCurrentDate()
        case reserveVisitorsTextField:
            reservePhoneTextField.becomeFirstResponder()
        case reservePhoneTextField:
            reserveCommentTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            reserveTable()
        }
        return true
    }
    
    @objc private func setCurrentDate() {
        // Set current Date to reserveDateTextField at the first appeal
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if reserveDateTextField.text == "" {
            reserveDateTextField.text = dateFormatter.string(from: Date())
        }
    }

    @objc private func reserveDateTextFieldChanged(datePicker: UIDatePicker) {
        // Display date in DateTextField in real time

        dateFormatter.dateFormat = "dd/MM/yyyy"
        reserveDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func reserveTimeTextFieldChanged(datePicker: UIDatePicker) {
        // Display time in TimeTextField in real time

        dateFormatter.dateFormat = "HH:mm"
        reserveTimeTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func phoneNumberMask() {
        print("mask")
    }
    

    // MARK: - Navigation
    
    @objc private func sequeToMap() {
        // Show Map with location

        let mapScale: Double = 1_000
        let latitude: CLLocationDegrees = 59.936504
        let longitude: CLLocationDegrees = 30.322665
        
        let pubCoordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: pubCoordinates, latitudinalMeters: mapScale, longitudinalMeters: mapScale)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: pubCoordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Irish Pub"
        mapItem.openInMaps(launchOptions: options)
    }
    
    @objc private func reserveTable() {
        print("Reserve request sent")
        // Creation JSON
        
        var reserve = Reserve()
        var isCommentEmpty = true
        
        // Validation of entered data
        
        if reserveNameTextField.text != "" {
            reserve.name = reserveNameTextField.text!
        } else {
            showAlertReserveError(message: "ФИО")
            return
        }
        if reserveDateTextField.text != "" {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            reserve.date = dateFormatter.date(from: reserveDateTextField.text!)!
        } else {
            showAlertReserveError(message: "дату")
            return
        }
        if reserveTimeTextField.text != "" {
            dateFormatter.dateFormat = "HH:mm"
            reserve.time = dateFormatter.date(from: reserveTimeTextField.text!)!
        } else {
            showAlertReserveError(message: "время")
            return
        }
        if reserveVisitorsTextField.text != "" {
            reserve.visitors = Int(reserveVisitorsTextField.text!)!
        } else {
            showAlertReserveError(message: "количество поветителей")
            return
        }
        if reservePhoneTextField.text?.count == 11 {
            reserve.phone = Int(reservePhoneTextField.text!)!
        } else {
            showAlertReserveError(message: "телефонный номер")
            return
        }
        if reserveCommentTextField.text != "" {
            isCommentEmpty = false
            reserve.comment = reserveCommentTextField.text
        }
        
        // Displaying the notification and sending the request
        
        showAlertReserveRequestSent()
        print(reserve)
        
        reserveNameTextField.text = ""
        reserveDateTextField.text = ""
        reserveTimeTextField.text = ""
        reserveVisitorsTextField.text = ""
        reservePhoneTextField.text = ""
        reserveCommentTextField.text = ""
        
        // Send information to server
    }
    
    func showAlertReserveError(message: String) {
        let alert = UIAlertController(title: "Введенные данные некорректны", message: "Пожалуйста, проверьте \(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertReserveRequestSent() {
        let alert = UIAlertController(title: "Запрос резерва отправлен", message: "Ждите подтверждения", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Setup Layout

    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainBackgroundView)
        
        mainBackgroundView.addSubview(banerImageView)
        mainBackgroundView.addSubview(banerLabel)
        
        mainBackgroundView.addSubview(addresBackgroundView)
        addresBackgroundView.addSubview(addresTextView)
        addresBackgroundView.addSubview(navigationButton)
        
        mainBackgroundView.addSubview(reserveView)
        reserveView.addSubview(reserveTitleLabel)
        reserveView.addSubview(reserveNameTextField)
        reserveView.addSubview(reserveDateTextField)
        reserveView.addSubview(reserveTimeTextField)
        reserveView.addSubview(reserveVisitorsTextField)
        reserveView.addSubview(reservePhoneTextField)
        reserveView.addSubview(reserveCommentTextField)
        reserveView.addSubview(reserveButton)

        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainBackgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainBackgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainBackgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        mainBackgroundView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainBackgroundView.heightAnchor.constraint(equalToConstant: 780).isActive = true
        
        banerImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        
        banerLabel.centerXAnchor.constraint(equalTo: mainBackgroundView.centerXAnchor).isActive = true
        banerLabel.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 150).isActive = true
        
        addresBackgroundView.topAnchor.constraint(equalTo: banerImageView.bottomAnchor, constant: 0).isActive = true
        addresBackgroundView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 0).isActive = true
        addresBackgroundView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: 0).isActive = true
        addresBackgroundView.heightAnchor.constraint(equalTo: addresTextView.heightAnchor, constant: 0).isActive = true
        
        addresTextView.topAnchor.constraint(equalTo: banerImageView.bottomAnchor, constant: 0).isActive = true
        addresTextView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 20).isActive = true
        addresTextView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -80).isActive = true
        addresTextView.heightAnchor.constraint(equalToConstant: addresTextView.contentSize.height)
        
        navigationButton.centerXAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -40).isActive = true
        navigationButton.centerYAnchor.constraint(equalTo: addresBackgroundView.centerYAnchor).isActive = true
        
        reserveView.topAnchor.constraint(equalTo: addresBackgroundView.bottomAnchor, constant: 0).isActive = true
        reserveView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 0).isActive = true
        reserveView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: 0).isActive = true
        reserveView.bottomAnchor.constraint(equalTo: mainBackgroundView.bottomAnchor, constant: 0).isActive = true

        reserveView.addConstraintsWithFormat(format: "V:|-10-[v0]-30-[v1]-30-[v2]-30-[v3]-30-[v4]-30-[v5]", views: reserveTitleLabel, reserveNameTextField, reserveDateTextField, reserveVisitorsTextField, reserveCommentTextField, reserveButton)
        reserveView.addConstraintsWithFormat(format: "H:|[v0]|", views: reserveTitleLabel)
        reserveView.addConstraintsWithFormat(format: "H:|-30-[v0]-30-|", views: reserveNameTextField)
        reserveView.addConstraintsWithFormat(format: "H:|-30-[v0]-30-[v1(100)]-30-|", views: reserveDateTextField, reserveTimeTextField)
        reserveTimeTextField.centerYAnchor.constraint(equalTo: reserveDateTextField.centerYAnchor).isActive = true
        reserveView.addConstraintsWithFormat(format: "H:|-30-[v0(100)]-30-[v1]-30-|", views: reserveVisitorsTextField, reservePhoneTextField)
        reservePhoneTextField.centerYAnchor.constraint(equalTo: reserveVisitorsTextField.centerYAnchor).isActive = true
        reserveView.addConstraintsWithFormat(format: "H:|-30-[v0]-30-|", views: reserveCommentTextField)
        reserveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}
