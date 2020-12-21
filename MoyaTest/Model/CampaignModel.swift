//
//  CampaignModel.swift
//  MoyaTest
//
//  Created by Min on 2020/12/21.
//

import UIKit

struct CampaignModel: Decodable {
  let id: String
  let slug: String
  let startAt: String
  let endedAt: String
  let coverUrl: String
  let title: String
  let subtitle: String
  let type: String
  let required: CampaignRequiredModel?
  let decoration: CampaignDecorationModel?
  let prompt: CampaignPromptModel?
}
