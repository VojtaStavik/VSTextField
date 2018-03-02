Pod::Spec.new do |s|
  s.name         = "VSTextField"
  s.version      = "0.0.1"
  s.summary      = "Easy text formatting."
  s.description  = <<-DESC
Dead simple drop-in subclass of UITextField with super easy number formatting.
                   DESC
  s.homepage     = "http://vojtastavik.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = {"Vojta Stavik" => "", "Munir Wanis" => ""}
  s.platform     = :ios, "9.3"
  s.source       = { :git => "https://github.com/VojtaStavik/VSTextField.git", :tag => "#{s.version}" }
  s.source_files = "VSTextField/VSTextField", "VSTextField/VSTextField/**/*.{h,swift}"
end
