//
//  PopUpView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 28.01.2024.
//

import SwiftUI
struct DropdownOption: Hashable {
    let key: String
    let value: String
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}
struct DropdownRow: View {
    var option: DropdownOption
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Text(self.option.value)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}
struct Dropdown: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                }
            }
        }
        .frame(minHeight: CGFloat(options.count) * 30, maxHeight: 250)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
struct DropdownSelector: View {
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    var placeholder: String
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    private let buttonHeight: CGFloat = 45
    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
        }) {
            HStack {
                Text(selectedOption == nil ? placeholder : selectedOption!.value)
                    .font(.system(size: 14))
                    .foregroundColor(selectedOption == nil ? Color.gray: Color.black)
                Spacer()
                Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 9, height: 5)
                    .font(Font.system(size: 9, weight: .medium))
                    .foregroundColor(Color.black)
            }
        }
        .padding(.horizontal)
        .cornerRadius(5)
        .frame(width: .infinity, height: self.buttonHeight)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: buttonHeight + 10)
                    Dropdown(options: self.options, onOptionSelected: { option in
                        shouldShowDropdown = false
                        selectedOption = option
                        self.onOptionSelected?(option)
                    })
                }
            }, alignment: .topLeading
        )
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color.white)
        )
    }
}
struct DropdownSelector_Previews: PreviewProvider {
    @State private static var address: String = ""
    static var uniqueKey: String {
        UUID().uuidString
    }
    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Sunday"),
        DropdownOption(key: uniqueKey, value: "Monday"),
        DropdownOption(key: uniqueKey, value: "Tuesday"),
        DropdownOption(key: uniqueKey, value: "Wednesday"),
        DropdownOption(key: uniqueKey, value: "Thursday"),
        DropdownOption(key: uniqueKey, value: "Friday"),
        DropdownOption(key: uniqueKey, value: "Saturday")
    ]
    static var previews: some View {
        VStack(spacing: 20) {
            DropdownSelector(
                placeholder: "Day of the week",
                options: options,
                onOptionSelected: { option in
                    print(option)
                })
            .padding(.horizontal)
            .zIndex(1)
            Group {
                TextField("Full Address", text: $address)
                    .font(.system(size: 14))
                    .padding(.horizontal)
            }
            .frame(width: .infinity, height: 45)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
}
