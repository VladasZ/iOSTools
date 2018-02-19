
Pod::Spec.new do |s|

s.name           = 'iOSTools'
s.version        = '0.15.5'
s.summary        = "iOS tools kit to make your life easier."
s.homepage       = "https://github.com/VladasZ/iOSTools"
s.author         = { 'Vladas Zakrevskis' => '146100@gmail.com' }
s.source         = { :git => 'https://github.com/VladasZ/iOSTools.git', :tag => s.version }

s.ios.deployment_target     = '9.0'
s.watchos.deployment_target = '3.0'

s.source_files   = 'Sources/Common/**/*.swift'

s.watchos.source_files   = 'Sources/watchOS/**/*.swift'
s.ios.source_files       = 'Sources/iOS/**/*.swift'

s.license            = 'MIT'
s.ios.resources      = ['Sources/iOS/Views/SwipyImageView/*.xib',
                        'Sources/iOS/Views/ProgressView/*.xib',
                        'Sources/iOS/Views/BannerAlertView/*.xib']
                    
s.dependency 'SwiftyTools'
s.ios.dependency 'CustomIOSAlertView'

end
