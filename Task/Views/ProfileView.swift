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
                profileImageSection
                nameSection
                genderSection
                citySection
                birthDateSection
                saveButton
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

    private var profileImageSection: some View {
        ZStack(alignment: .top) {
            HStack {
                Button {
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
                Spacer()
                Text("Məlumatlarım")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Color.clear
                    .frame(width: 24, height: 24)
            }
            .padding(.top, 8)

            HStack {
                Spacer()
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(Color(.systemGray3))
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())

                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 26, height: 26)
                        Image(systemName: "camera.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            .padding(.top, 44)
        }
        .frame(height: 140)
    }

    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Adınız")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            TextField("Ad soyad", text: Binding(
                get: {
                    let full = "\(viewModel.firstName) \(viewModel.lastName)"
                    return full.trimmingCharacters(in: .whitespaces)
                },
                set: { val in
                    let parts = val.split(separator: " ", maxSplits: 1)
                    viewModel.firstName = parts.first.map(String.init) ?? ""
                    viewModel.lastName = parts.dropFirst().first.map(String.init) ?? ""
                }
            ))
            .font(.system(size: 15))
            .foregroundColor(.primary)
            .padding(.bottom, 8)
            Divider()
        }
    }

    private var genderSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cinsiniz")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            Menu {
                Button("Kişi") { viewModel.gender = "MALE" }
                Button("Qadın") { viewModel.gender = "FEMALE" }
            } label: {
                HStack {
                    Text(viewModel.gender == "MALE" ? "Kişi" : "Qadın")
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.bottom, 8)
            }
            Divider()
        }
    }

    private var citySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Yaşadığınız şəhər")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            Menu {
                ForEach(cities, id: \.key) { city in
                    Button(city.value) {
                        viewModel.selectedCityKey = city.key
                    }
                }
            } label: {
                HStack {
                    Text(cities.first(where: { $0.key == viewModel.selectedCityKey })?.value ?? "Bakı")
                        .font(.system(size: 15))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13))
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.bottom, 8)
            }
            Divider()
        }
    }

    private var birthDateSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Doğum tarixi")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
            HStack {
                DatePicker(
                    "",
                    selection: $viewModel.birthDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .labelsHidden()
                Spacer()
            }
            .padding(.bottom, 8)
            Divider()
        }
    }

    private var saveButton: some View {
        Button {
            viewModel.saveProfile()
        } label: {
            Text("Yadda saxla")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.blue)
                .cornerRadius(30)
        }
        .padding(.top, 8)
    }

    private var imageURL: URL? {
        guard let profile = viewModel.profile,
              let base = Bundle.main.object(forInfoDictionaryKey: "IMAGE_BASE_URL") as? String else { return nil }
        return URL(string: "\(base)/\(profile.profileImage)")
    }
}
