//
//  YagomButton.swift
//  MyButton
//
//  Created by byung-soo kwon on 2017. 7. 22..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class YagomButton: UIView {
    
    /// Class에는  변수만 선언되어 있습니다.
    /// 그리고 이것들은 UIButton 에 나오는 변수입니다.
    
    // 타입 별칭을 주었습니다.
    typealias ButtonAction = ((YagomButton) -> Void)
    
    //초기화 함수입니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.preservedAlpha = self.alpha
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Properties
    
    fileprivate var storedTitleLabel: UILabel?
    fileprivate var storedBackgroundImageView: UIImageView?
    fileprivate var closureActions: [String: ButtonAction] = [:]
    fileprivate var preservedAlpha: CGFloat = 1.0
    fileprivate var targetActions: Set<Action> = []
    fileprivate var information: StateInformation = StateInformation()
    
    var isEnabled: Bool {
        get {
            return self.state.contains(.disabled) == false
        }
        set {
            switch newValue {
            case true:
                self.state.remove(.disabled)
            case false:
                self.state.update(with: .disabled)
            }
        }
    }
    
    var isSelected: Bool {
        get {
            return self.state.contains(.selected)
        }
        set {
            switch newValue {
            case true:
                self.state.remove(.normal)
                self.state.update(with: .selected)
            case false:
                self.state.remove(.selected)
                self.state.update(with: .normal)
            }
        }
    }
    
    var isHighlighted: Bool {
        get {
            return self.state.contains(.highlighted) == false
        }
    }
    
    var state: State = .normal {
        didSet {
            updateView()
        }
    }
    
    fileprivate var currentInformation: StateInformation.Information? {
        return self.information.stateInformation(for: self.state)
    }
    
    deinit {
        self.storedTitleLabel?.removeFromSuperview()
        self.storedBackgroundImageView?.removeFromSuperview()
        self.storedTitleLabel = nil
        self.storedBackgroundImageView = nil
    }

}


//MAEK: - 커스텀 타입
extension YagomButton {
    
    // MARK - State 
    // OptionSet 과 Hashable 프로토콜을 따른다.
    //  (normal, highlighted, disabled 등)과 관련된 상태를 정의한다.
    // 얘도 infoDictionary에서 딕셔너리로 들어가야하니까 Hashable
    struct State: OptionSet, Hashable {
        let rawValue: Int
        
        static var normal: State = State(rawValue: 1 << 0)
        static var highlighted: State = State(rawValue: 1 << 1)
        static var disabled: State = State(rawValue: 1 << 2)
        static var selected: State = State(rawValue: 1 << 3)
        
        
        // Hashable 필수
        static func ==(lhs: State, rhs: State) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
        var hashValue: Int {
            return self.rawValue
        }
    }
    
    fileprivate struct StateInformation {
        struct Information {
            var title: String?
            var titleColor: UIColor?
            var backgroundImage: UIImage?
        }
        fileprivate var infoDictionary: [State: Any] = [:]
        
        func stateInformation(for state: State) -> Information? {
                return infoDictionary[state] as? Information
        }
        
        mutating func setStateInformation(_ info: Information, for state: State, button: YagomButton) {
            infoDictionary[state] = info
            button.updateView()
        }
    }
    
    //Acton 을 Hashable 하게 만들어준다. Element 로 사용할 수 있게!
    fileprivate struct Action: Hashable {
        var target: NSObject
        var selector: Selector
        
        static func ==(lhs: Action, rhs: Action) -> Bool {
            return lhs.target == rhs.target && lhs.selector == rhs.selector
        }
        
        var hashValue: Int {
            return selector.hashValue
        }
    }
}

// MARK: - 그리기 타이틀도 그리고, 이미지도 그리고
extension YagomButton {
    
    // 이미지 뷰를 그리자
    fileprivate func drawImageView() {
        if self.storedBackgroundImageView == nil {
            let imageView = UIImageView(frame: self.bounds)
            self.storedBackgroundImageView = imageView
            self.insertSubview(imageView, at: 0)
        }
    }
    
    fileprivate func drawTitleLabel() {
        if self.titleLabel == nil {
            let titleLabel = UILabel(frame: self.bounds)
            titleLabel.textAlignment = .center
            self.storedTitleLabel = titleLabel
            self.addSubview(titleLabel)
            self.bringSubview(toFront: titleLabel)
        }
    }
    
    fileprivate var transparentAlpha: CGFloat {
        return self.preservedAlpha * 0.6
    }
    
    override var alpha: CGFloat {
        willSet {
            if state.contains(.disabled) || state.contains(.highlighted) {
                if self.transparentAlpha == newValue {
                    self.preservedAlpha = self.alpha
                }
            }
        }
    }
    
    fileprivate func updateView() {
        
        self.alpha = state.contains(.highlighted) || state.contains(.disabled) ? transparentAlpha : self.preservedAlpha
        
        self .isUserInteractionEnabled = !state.contains(.disabled)
        
        if state.contains(.disabled) {
            return
        }
        
        let information = self.information.stateInformation(for: self.state)
        let normalInformation = self.information.stateInformation(for: .normal)
        
        self.storedBackgroundImageView?.image = information?.backgroundImage ?? normalInformation?.backgroundImage
        
        // 아마 텍스트를 초기화..?
        self.titleLabel?.text = nil
        
        self.titleLabel?.textColor = information?.titleColor ?? normalInformation?.titleColor
        self.backgroundImageView?.image = information?.backgroundImage ?? normalInformation?.backgroundImage
        self.titleLabel?.text = information?.title ?? normalInformation?.title
    }
}

// MARK: - 타이틀

extension YagomButton {
    
    var currentTitle: String? {
        return self.information.stateInformation(for: self.state)?.title
    }
    
    var currentTitleColor: UIColor {
        return self.information.stateInformation(for: self.state)?.titleColor ?? .white
    }
    
    var titleLabel: UILabel? {
        return storedTitleLabel
    }
    
    // 우리가 아는 setTitle
    func setTitle(_ title: String?, for state: State) {
        
        self.drawTitleLabel()
        var information = self.information.stateInformation(for: state) ?? StateInformation.Information()
        
        information.title = title
        self.information.setStateInformation(information, for: state, button: self)
    }
    
    // 우리가 아는 setTitleColor
    func setTitleColor(_ color: UIColor?, for state: State) {
        
        self.drawTitleLabel()
        var information = self.information.stateInformation(for: state) ?? StateInformation.Information()
        
        information.titleColor = color
        self.information.setStateInformation(information, for: state, button: self)
    }
    
    func title(for state: State) -> String? {
        return self.information.stateInformation(for: state)?.title
    }
    
    func titleColot(for state:State) -> UIColor? {
        return self.information.stateInformation(for: state)?.titleColor
    }
}

// MARK: - 백그라운드 이미지
extension YagomButton {
    
    //MARK: Properties
    var backgroundImageView: UIImageView? {
        return storedBackgroundImageView
    }
    
    var currentBackgroundImage: UIImage? {
        return self.currentInformation?.backgroundImage
    }
    
    //MARK: Methods
    func setBackgroundImage(_ image: UIImage?, for state: State) {
        
        self.drawImageView()
        var information = self.information.stateInformation(for: state) ?? StateInformation.Information()
        information.backgroundImage = image
        self.information.setStateInformation(information, for: state, button: self)
    }
    
    func backgroundImage(for state: State) -> UIImage? {
        return self.information.stateInformation(for: state)?.backgroundImage
    }
}

//MARK: - action
extension YagomButton {
    
    // 타겟 액션을 등록하자
    func addTarget(_ target: NSObject, action: Selector) {
        let action = Action(target: target, selector: action)
        self.targetActions.insert(action)
    }
    
    func removeTarget(_ target: NSObject, action: Selector) {
        let action = Action(target: target, selector: action)
        self.targetActions.remove(action)
    }
    
    func removeAllTargets() {
        self.targetActions.removeAll()
    }
    
    // 왜 escaping 일까
    func addAction(name: String, _ action: @escaping ButtonAction) {
        closureActions[name] = action
    }
    
    func removeAction(name: String, _ action: ButtonAction) {
        closureActions.removeValue(forKey: name)
    }
    
    func removeAllActions() {
        closureActions.removeAll()
    }
}

//MARK: -touch 
extension YagomButton {
    
    // 터치가 시작되면 하이라이트로 상태를 업데이트한다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.state.update(with: .highlighted)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.state.remove(.highlighted)
        self.targetActions.forEach { (button: Action) in
            button.target.perform(button.selector, with: self, afterDelay: 0)
        }
    
        self.closureActions.forEach { [unowned self] in
            $0.value(self)
        
        }
    }
    
    // 하이라이트 상태 제거
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.state.remove(.highlighted)
    }
    
}




