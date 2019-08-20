Pod::Spec.new do |ddyspec|
    ddyspec.name         = 'DDYEmptyView'
    ddyspec.version      = '1.0.1'
    ddyspec.summary      = 'UITableView、UICollectionView空白占位'
    ddyspec.homepage     = 'https://github.com/RainOpen/DDYEmptyView'
    ddyspec.license      = 'MIT'
    ddyspec.authors      = {'Rain' => '634778311@qq.com'}
    ddyspec.platform     = :ios, '8.0'
    ddyspec.source       = {:git => 'https://github.com/RainOpen/DDYEmptyView.git', :tag => ddyspec.version}
    ddyspec.source_files = 'DDYEmptyView/DDYEmptyView/*.{h,m}'
    # ddyspec.resource     = 'DDYEmptyView/DDYEmptyView/DDYEmptyView.bundle'
    # ddyspec.requires_arc = false
    # s.framework  = "AVFoundation"
    # s.frameworks = "UIKit", "AVFoundation"
    # s.dependency "JSONKit", "~> 1.4"
end