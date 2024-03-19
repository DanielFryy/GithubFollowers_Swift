//
//  FollowerCollectionView.swift
//  GHFollowers
//
//  Created by Daniel Freire on 3/19/24.
//

import SwiftUI

struct FollowerCollectionView: View {
    var follower: Follower

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image("avatar-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .clipShape(Circle())

            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    FollowerCollectionView(follower: Follower(login: "DanielFryy", avatarUrl: ""))
}
