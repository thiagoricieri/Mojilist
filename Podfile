use_frameworks!

def shared_pods
    pod 'Saw', :git => 'https://github.com/thiagoricieri/Saw-iOS.git'
    # :path => '~/Documents/2018/apps/_saw/ios/Saw/'
	
    # 3rd Party
    pod 'Fabric'
	pod 'Crashlytics', '~>  3.8'
    pod 'Firebase/Core'
    
    # Data
    pod 'HTTPStatusCodes', '~> 3.1.0'
    pod 'DateToolsSwift'
    
    # UI
    pod 'PopupDialog'
    pod 'Spring'
    pod 'SDWebImage', '~> 3.7.3'
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
