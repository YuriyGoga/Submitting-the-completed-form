//
//  ViewController.swift
//  M19
//
//  Created by FILIN INTEND on 19.01.2023.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    var modelToSend = Model()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stackView.addArrangedSubview(labelBirth)
        stackView.addArrangedSubview(labelOccupation)
        stackView.addArrangedSubview(labelName)
        stackView.addArrangedSubview(labelLastName)
        stackView.addArrangedSubview(labelCountry)
        
        stackView2.addArrangedSubview(textField1)
        stackView2.addArrangedSubview(textField2)
        stackView2.addArrangedSubview(textField3)
        stackView2.addArrangedSubview(textField4)
        stackView2.addArrangedSubview(textField5)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(300)
        }
        
        view.addSubview(stackView2)
        stackView2.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(170)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(300)
        }
        
        view.addSubview(buttonURL)
        buttonURL.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(200)
            
        }
        
        view.addSubview(buttonAlamofire)
        buttonAlamofire.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(120)
        }
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField5.delegate = self
    }
    
    private func convertToJson(from data: Model) -> Data {
        let jsonData = try? JSONEncoder().encode(data)
        return jsonData ?? Data()
    }
    
    
    @objc func onClickURL(){
        
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = convertToJson(from: modelToSend)
        
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.allertError()
                }
                return
            }
            DispatchQueue.main.async {
                self?.allertAllOk()
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }.resume()
    }
    
    
    @objc func onClickAlamofire(){
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .post, parameters: modelToSend, encoder: JSONParameterEncoder.default).response {
            [weak self] response in
            guard response.error == nil else {
                self?.allertError()
                return
            }
            
            self?.allertAllOk()
            
            debugPrint(response)
        }
    }
    
    
    // MARK: - StackViews
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var stackView2: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: - Labels
    
    private lazy var labelBirth: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Birth:"
        return label
    }()
    
    private lazy var labelOccupation: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Occupation:"
        return label
    }()
    
    private lazy var labelName: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Name:"
        return label
    }()
    
    private lazy var labelLastName: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "LastName:"
        return label
    }()
    
    private lazy var labelCountry: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Country:"
        return label
    }()
    
    // MARK: - TextFields
    
    private lazy var textField1: UITextField = {
        var textField = UITextField()
        textField.clearButtonMode = .always
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.placeholder = "Дата рождения"
        return textField
    }()
    
    private lazy var textField2: UITextField = {
        var textField = UITextField()
        textField.clearButtonMode = .always
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.placeholder = "Занятие"
        return textField
    }()
    
    private lazy var textField3: UITextField = {
        var textField = UITextField()
        textField.clearButtonMode = .always
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.placeholder = "Имя"
        return textField
    }()
    
    private lazy var textField4: UITextField = {
        var textField = UITextField()
        textField.clearButtonMode = .always
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.placeholder = "Фамилия"
        return textField
    }()
    
    private lazy var textField5: UITextField = {
        var textField = UITextField()
        textField.clearButtonMode = .always
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        textField.placeholder = "Страна"
        return textField
    }()
    
    // MARK: - Buttons
    
    private lazy var buttonURL: UIButton = {
        var button = UIButton()
        button.setTitle("Запрос URL", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onClickURL), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonAlamofire: UIButton = {
        var button = UIButton()
        button.setTitle("Запрос Alamofire", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(onClickAlamofire), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    private func allertAllOk() {
        let alert = UIAlertController(title: "Внимание!", message: "Данные успешно сохранены", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
        
    }
    
    
    private func allertError() {
        let alert = UIAlertController(title: "Ошибка!", message: "Не удалось сохранить данные", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    
    
    struct ModelSession {
        var birth: Int
        var occupation: String
        var name: String
        var lastName: String
        var country: String
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet(charactersIn: string)
        var allowedCharacters = CharacterSet.letters
        if textField.placeholder == Model.CodingKeys.birth.rawValue {
            allowedCharacters = CharacterSet.decimalDigits
        }
        return allowedCharacters.isSuperset(of: characterSet)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.placeholder {
        case Model.CodingKeys.birth.rawValue :
            modelToSend.birth = Int(textField1.text ?? "0")
        case Model.CodingKeys.occupation.rawValue :
            modelToSend.occupation = textField2.text
        case Model.CodingKeys.name.rawValue :
            modelToSend.name = textField3.text
        case Model.CodingKeys.lastName.rawValue :
            modelToSend.lastName = textField4.text
        case Model.CodingKeys.country.rawValue :
            modelToSend.country = textField5.text
        default:
            return
        }
    }
    
}
