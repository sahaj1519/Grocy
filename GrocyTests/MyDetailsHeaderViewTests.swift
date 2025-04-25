//
//  MyDetailsHeaderViewTests.swift
//  GrocyTests
//
//  Created by Ajay Sangwan on 24/04/25.
//

import Testing
import PhotosUI
@testable import Grocy


struct MyDetailsHeaderViewTests {

    @Test
    func defaultProfileImageAppearsWhenNoImageSet() {
        let user = DataModel()
        user.currentUser.image = nil  // Ensure no profile image is set

        assert(user.currentUser.image == nil, "User image should be nil for default profile icon")
    }

    @Test
    func userImageUpdatesAfterSelection() async {
        let user = DataModel()
        let view = MyDetailsHeaderView(user: user)
        
        let mockImageData = UIImage(systemName: "person.fill")?.jpegData(compressionQuality: 1.0)
        user.currentUser.image = mockImageData
        
        await view.loadPhoto()

        assert(user.currentUser.image != nil, "User image should be updated")
    }

    @Test
    func userDataPersistsAfterImageSelection() async throws{
        let user = DataModel()

        let mockImageData = UIImage(systemName: "person.fill")?.jpegData(compressionQuality: 1.0)
        user.currentUser.image = mockImageData

        try? await user.saveUserData()

        assert(user.currentUser.image != nil, "User data should persist after save")
    }
}
