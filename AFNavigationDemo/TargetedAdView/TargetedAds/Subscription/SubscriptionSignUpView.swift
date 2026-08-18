//
//  SubscriptionSignUpView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import SwiftUI

struct SubscriptionSignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedPlan: String = "Monthly"
    
    let plans = [
        (name: "Monthly", price: "$4.99 / mo", description: "Flexible access, cancel anytime."),
        (name: "Annual", price: "$39.99 / yr", description: "Best value. Save 33% overall."),
        (name: "Premium", price: "$9.99 / mo", description: "Includes print edition & stock tools.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "newspaper.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    Text("Unlock Full Access")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Join over 100,000 readers getting premium daily insights.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Label("Unlimited articles across all categories", systemImage: "checkmark.circle.fill")
                    Label("Zero commercial advertisements", systemImage: "checkmark.circle.fill")
                    Label("Exclusive weekly deep-dive reports", systemImage: "checkmark.circle.fill")
                    Label("Offline reading mode enabled", systemImage: "checkmark.circle.fill")
                }
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                VStack(spacing: 12) {
                    ForEach(plans, id: \.name) { plan in
                        Button(action: { selectedPlan = plan.name }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(plan.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(plan.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text(plan.price)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Image(systemName: selectedPlan == plan.name ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedPlan == plan.name ? .blue : .gray)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedPlan == plan.name ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                VStack(spacing: 12) {
                    Button(action: {
                    }) {
                        Text("Subscribe Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    Button("Restore Past Purchases") {
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)
                }
                .padding(.top, 8)
                
                Text("Subscriptions automatically renew unless canceled at least 24 hours before the end of the current billing cycle.")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    SubscriptionSignUpView()
}
