platform :ios, '13.0'

target 'RickAndMorty Guide' do

  use_frameworks!
  
  #Moya
  pod 'Moya'

  # Reactive & Bond
  pod 'Bond'
  pod 'ReactiveKit'

  #SnapKit
  pod 'SnapKit', '~> 5.0.0'
  
  # Reachability
  pod 'ReachabilitySwift'

  # Formatter
  pod 'AnyFormatKit'

  # Localization strings
  pod 'Localize' , '~> 2.3.0'

  # lottie-ios
  pod 'lottie-ios'
 
  #Keyboard
  pod 'IQKeyboardManagerSwift'

  # SkeletonView
  pod 'SkeletonView'

  # SwiftyBeaver Logger
  pod 'SwiftyBeaver'

  # Download Image
  pod 'Kingfisher'
 

  # for CollectionView
  pod 'CollectionViewCenteredFlowLayout'
  pod 'DGCollectionViewLeftAlignFlowLayout'


  # EntropyString
  pod 'EntropyString', '~> 3.0'

  # DGCollectionViewLeftAlignFlowLayout
  pod 'DGCollectionViewLeftAlignFlowLayout'

end

  post_install do |installer|
   installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
     end
   end
  end
