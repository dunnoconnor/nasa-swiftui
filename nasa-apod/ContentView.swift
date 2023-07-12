//
//  ContentView.swift
//  nasa-apod
//
//  Created by Michael Dunn-OConnor on 7/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    @State private var size = 50.0
    @State private var isEditing = false

    var body: some View {
        VStack {
            Text("NASA Pics")
                .font(.title)
                .fontWeight(.semibold)
            NASAImageView()
            DatePicker(
                "Image Date",
                selection: $date,
                displayedComponents: [.date]
            )
            Slider(
                value: $size,
                in: 0...100,
                step: 5,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


