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
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray4))
                            .frame(width: 80, height: 80)
                        Image(systemName: "person.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: 80, height: 80)
                .clipShape(Circle())

                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 26, height: 26)
                    Image(systemName: "camera.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}
