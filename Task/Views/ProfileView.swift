//
//  ProfileView.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    headerSection
                    ProfileImageSection(imageURL: viewModel.imageURL)
                        .padding(.bottom, 4)

                    if let profileBinding = Binding($viewModel.profile) {
                        NameSection(
                            firstName: profileBinding.firstName,
                            lastName: profileBinding.lastName
                        )
                        GenderSection(gender: profileBinding.gender)
                        CitySection(
                            selectedCityKey: profileBinding.city,
                            selectedCityValue: viewModel.selectedCityValue
                        )
                        BirthDateSection(birthDate: profileBinding.birthDate)
                        SaveButtonSection(action: viewModel.saveProfile)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 16)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.1))
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        }
        .task {
            await viewModel.loadProfile()
        }
    }

    private var headerSection: some View {
        HStack {
            Button {
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
            }
            .accessibilityLabel("Geri")
            Spacer()
        }
    }
}
