//
//  PickersEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 02.05.2023.
//

import SwiftUI

struct PickersEx: View {

    @State var section = 0
    @State var prcentSection = 0
    @State var isOn = false

    var settingTime = ["5 min", "10 min", "15 min", "20 min"]
    var prcent = ["0 %", "25 %", "50 %", "75 %", "100 %"]

    var body: some View {
        VStack {
            Picker(selection: $section, label: Text("Time")) {
                ForEach(0..<settingTime.count) {
                    Text(self.settingTime[$0])
                }
            }

            Toggle(isOn: $isOn) {
                Text("Aitplane Mode").foregroundColor(isOn ? Color.orange : Color.gray)
            }

            Picker(selection: $prcentSection, label: Text("Lite Mode")) {
//                ForEach(0..<$prcentSection.count) {
//                    Text(self.$prcentSection[$0])
                }
            }

        }//.navigationTitle("Settings")
    }


struct PickersEx_Previews: PreviewProvider {
    static var previews: some View {
        PickersEx()
    }
}
