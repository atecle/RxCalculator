platform :ios, '9.0'

source 'git@github.com:CocoaPods/Specs.git'

def reactive_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ReactorKit'
end 

target 'RxCalculator' do

  use_frameworks!
  
  reactive_pods

  pod 'SnapKit'
  pod 'Expression', '~> 0.12'
end
