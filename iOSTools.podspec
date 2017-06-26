Pod::Spec.new do |s|
s.name           = 'iOSTools'
s.version        = '0.2.3'
s.summary        = "iOS tools kit to make your life easier."
s.homepage       = "https://github.com/VladasZ/iOSTools"
s.author         = { 'Vladas Zakrevskis' => '146100@gmail.com' }
s.source         = { :git => 'https://github.com/VladasZ/iOSTools.git', :tag => s.version }
s.ios.deployment_target = '9.0'
s.source_files   = 'Sources/**/*.swift'
s.license        = 'MIT'
s.dependency 'SwiftyTools'
end