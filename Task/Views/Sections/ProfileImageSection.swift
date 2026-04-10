//
//  ProfileImageSection.swift
//  Task
//
//  Created by Ibrahim Kolchi on 10.04.26.
//
import SwiftUI

struct ProfileImageSection: View {
    let imageURL: URL?

    var body: some View {
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
                .accessibilityLabel("Profil şəkli")

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
    }
}
