//
//  SubscriptionSignUpView.swift
//  AFNavigationDemo
//
//  Created by Lisa Fellows on 2026-08-17.
//

import AFNavigationKit
import SwiftUI

struct SubscriptionSignUpView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(TargetAdCoord.self) private var targetAdCoord

    @State private var vm = SubscriptionSignUpViewModel()
    private let model = Self.model
    private var tint: Color { Color(model.tintName) }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SubscriptionHeader()
                SubscriptionBenefitsCard()
                
                VStack(spacing: 12) {
                    ForEach(vm.plans, id: \.name) { plan in
                        SubscriptionPlanView(selectedPlan: $vm.selectedPlan, plan: plan)
                    }
                }
                
                VStack(spacing: 12) {
                    SubscribeNowButton(action: vm.didSubscribe)
                    RestoreSubscriptionButton(action: vm.didRestore)
                }
                .padding(.top, 8)

                Text(model.legalDisclaimer.body)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
        .onChange(of: vm.newAlert) { _, newAlert in
            if let newAlert = newAlert {
                targetAdCoord.present(alert: newAlert)
            }
        }
        .onChange(of: vm.dismiss) { dismiss() }
        .toolbar {
            ToolbarButton.close(action: vm.didTapDismiss)
                .foregroundStyle(.tint)
        }
        .tint(tint)
    }
}

struct SubscriptionHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "newspaper.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(.tint)
                .padding(.top)
            
            Text("Unlock Full Access")
                .font(.largeTitle)
                .bold()
            
            Text("Join over 100,000 readers getting premium daily insights.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct SubscriptionBenefitsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Unlimited articles across all categories", systemImage: "checkmark.circle.fill")
            Label("Zero commercial advertisements", systemImage: "checkmark.circle.fill")
            Label("Exclusive weekly deep-dive reports", systemImage: "checkmark.circle.fill")
            Label("Offline reading mode enabled", systemImage: "checkmark.circle.fill")
        }
        .font(.subheadline)
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct SubscriptionPlanView: View {
    @Binding var selectedPlan: SubscriptionPlan
    let plan: SubscriptionPlan

    private var isSelected: Bool { selectedPlan == plan }
    private var circleName: String {
        isSelected ? "largecircle.fill.circle" : "circle"
    }
    private var tintStyle: AnyShapeStyle {
        isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(.gray)
    }

    var body: some View {
        Button(action: didSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(plan.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(plan.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Text(plan.priceInfo)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.tint)
                
                Image(systemName: circleName)
                    .foregroundStyle(tintStyle)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedPlan == plan ? Color.subscription : Color.gray.opacity(0.3), lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }

    private func didSelect() {
        selectedPlan = plan
    }
}

struct SubscribeNowButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Subscribe Now")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.subscription)
                .cornerRadius(12)
        }
    }
}

struct RestoreSubscriptionButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Restore Past Purchases")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SubscriptionSignUpView()
        .environment(TargetAdCoord())
}
