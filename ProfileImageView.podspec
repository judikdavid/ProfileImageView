Pod::Spec.new do |s|
  s.name             = "ProfileImageView"
  s.version          = "0.1.0"
  s.summary          = "Round UIImageView to display profile images like in the Contacts App"

  s.description      = "UIView subclass which is basically a round UIImageView with other features like overlay and initials when there is no image available"

  s.homepage         = "https://github.com/judikdavid/ProfileImageView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "David Judik" => "judik.david@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/ProfileImageView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/judikdavid'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ProfileImageView' => ['Pod/Assets/*.png']
  }
end
