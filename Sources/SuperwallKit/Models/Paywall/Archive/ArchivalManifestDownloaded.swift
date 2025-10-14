//
//  File.swift
//  
//
//  Created by Yusuf Tör on 08/05/2024.
//

import Foundation

/// A downloaded archive manifest.
struct ArchiveManifestDownloaded: Codable {
  let document: ArchiveManifestItemDownloaded
  let items: [ArchiveManifestItemDownloaded]

  var webArchive: WebArchive {
    return WebArchive(
      resource: document.webArchiveResource,
      items: items
    )
  }
}

/// A downloaded manifest item.
struct ArchiveManifestItemDownloaded: Codable {
  let url: URL
  let mimeType: String
  let data: Data
  let isMainDocument: Bool

  var webArchiveResource: WebArchiveResource {
    WebArchiveResource(
      url: url,
      data: data,
      mimeType: mimeType
    )
  }
}
