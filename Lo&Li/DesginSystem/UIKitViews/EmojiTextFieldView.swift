//
//  EmojiTextFieldView.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2022/9/10.
//

import SwiftUI

class UIEmojiTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = textInputMode
    }
    
    override var textInputContextIdentifier: String? {
        ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                keyboardType = .default // do not remove this
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.setPlaceHolderTextColor(UIColor(Color.f3))
        emojiTextField.font = .boldSystemFont(ofSize: 24)
        emojiTextField.textAlignment = .center
        emojiTextField.delegate = context.coordinator
        
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}

struct EmojiContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        EmojiTextField(text: $text, placeholder: "Enter emoji")
    }
}
