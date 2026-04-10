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
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerSection
                ProfileImageSection(imageURL: viewModel.imageURL)
                NameSection(
                    firstName: $viewModel.firstName,
                    lastName: $viewModel.lastName
                )
                GenderSection(gender: $viewModel.gender)
                CitySection(
                    selectedCityKey: $viewModel.selectedCityKey,
                    selectedCityValue: viewModel.selectedCityValue
                )
                BirthDateSection(birthDate: $viewModel.birthDate)
                SaveButtonSection(action: viewModel.saveProfile)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
        .navigationBarHidden(true)
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
            Text("Məlumatlarım")
                .font(.system(size: 17, weight: .semibold))
            Spacer()
            Color.clear
                .frame(width: 24, height: 24)
        }
    }
}
