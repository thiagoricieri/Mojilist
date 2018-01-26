use_frameworks!

def shared_pods
    pod 'Saw', :git => 'https://github.com/thiagoricieri/Saw-iOS.git'
    pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
    pod 'MBProgressHUD'
    pod 'SDWebImage', '~> 3.7.3'
    pod 'Alamofire'
    pod 'Fabric'
    pod 'Crashlytics', '~>  3.8'
    pod 'RealmSwift'
    pod 'HTTPStatusCodes', '~> 3.1.0'
    pod 'DateToolsSwift'
    pod 'PopupDialog', '~> 0.6'
    pod 'Firebase/Core'
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

#post_install do |installer|
#  installer.aggregate_targets.each do |target|
#    copy_pods_resources_path = "Pods/Target Support Files/#{target.name}/#{target.name}-resources.sh"
#    string_to_replace = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"'
#    assets_compile_with_app_icon_arguments = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"'
#    text = File.read(copy_pods_resources_path)
#    new_contents = text.gsub(string_to_replace, assets_compile_with_app_icon_arguments)
#    File.open(copy_pods_resources_path, "w") {|file| file.puts new_contents }
#  end
#end

