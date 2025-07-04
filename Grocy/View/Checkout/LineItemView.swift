//
//  LineItemView.swift
//  Grocy
//
//  Created by Ajay Sangwan on 19/04/25.
//
import SwiftUI

struct LineItemView: View {
    @Binding var activeTooltipID: UUID?
    
    let id: UUID
    let title: String
    let value: String
    let valueFont: Font
    let valueColor: Color
    let showHelp: Bool
    let helpMessage: String
    
    @State private var tooltipTimer: Timer?
    
    private func startTooltipTimer(for id: UUID) {
        
        tooltipTimer?.invalidate()
        
        
        tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            withAnimation {
                if activeTooltipID == id {
                    activeTooltipID = nil
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(title)
                        .font(.system(size: 14).bold())
                        .foregroundStyle(.secondary)
                        .accessibilityLabel(title)
                    
                    if showHelp {
                        
                        Button {
                            withAnimation {
                                
                                if activeTooltipID == id {
                                    activeTooltipID = nil
                                } else {
                                    activeTooltipID = id
                                    startTooltipTimer(for: id)
                                }
                            }
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                        }
                        .buttonStyle(.plain)
                        .offset(y: 4)
                        .accessibilityLabel("Help button")
                        .accessibilityHint(helpMessage)
                        
                        
                    }
                    
                    Spacer()
                    
                    Text(value)
                        .font(valueFont)
                        .foregroundStyle(valueColor)
                        .accessibilityValue(value)
                }
                
            }
            
            
            if activeTooltipID == id {
                Text(helpMessage)
                    .font(.caption2)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 4)
                    .frame(maxWidth: .infinity)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .offset(x: -40, y: -40)
                    .zIndex(2)
                    .accessibilityLabel(helpMessage)
                    .accessibilityHint("This message appears after clicking help.")
            }
            
        }
        
    }
}

#Preview {
    LineItemView(
        activeTooltipID: .constant(nil),
        id: UUID(),
        title: "Price of items",
        value: "₹1000",
        valueFont: .subheadline,
        valueColor: .secondary,
        showHelp: false,
        helpMessage: ""
    )
}
