//
//  ModuleView.swift
//  AcousticPanel
//
//  Created by Joshua Grzech on 1/6/24.
//

import SwiftUI

struct ModuleView<Content: View>: View {
    let content: Content
    let isDragging: Bool

    init(@ViewBuilder content: () -> Content, isDragging: Bool) {
        self.content = content()
        self.isDragging = isDragging
    }

    var body: some View {
        HStack {
            content
                .padding()
                .background(Color.gray)
                .cornerRadius(8)
                .shadow(radius: 5)
            dragHandle
        }
        .padding(.all)
        .background(isDragging ? Color.gray.opacity(0.5) : Color.white)
        .cornerRadius(8)
        .shadow(radius: isDragging ? 10 : 5)
        .scaleEffect(isDragging ? 1.05 : 1.0)
        .animation(.spring(), value: isDragging)
    }

    private var dragHandle: some View {
        HStack {
            Rectangle()
                .frame(width: 6, height: 60)

                .foregroundColor(Color.gray)
                .cornerRadius(3)
            Rectangle()
                .frame(width: 6, height: 60)

                .foregroundColor(Color.gray)
                .cornerRadius(3)
            Rectangle()
                .frame(width: 6, height: 60)

                .foregroundColor(Color.gray)
                .cornerRadius(3)
        }
        .padding()
    }
}

struct ModuleView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleView(content: {
            Text("Test")
        }, isDragging: false)
    }
}
