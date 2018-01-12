use_frameworks!

def shared_pods
    pod 'Saw', :git => 'https://github.com/thiagoricieri/Saw-iOS.git'
    pod 'MBProgressHUD'
    pod 'SDWebImage', '~> 3.7.3'
    pod 'Alamofire'
    pod 'Fabric'
    pod 'Crashlytics', '~>  3.8'
    pod 'RealmSwift'
    pod 'Google/Analytics'
    pod 'HTTPStatusCodes', '~> 3.1.0'
    pod 'DateToolsSwift'
    pod 'PopupDialog', '~> 0.6'
end

target 'Emojilist' do
    shared_pods
    
    target 'EmojilistTests' do
        inherit! :search_paths
    end
    
    target 'EmojilistUITests' do
        inherit! :search_paths
    end
end
