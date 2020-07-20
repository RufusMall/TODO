pipeline 
{ 
	agent any
	stages 
	{ 
		stage('build') 
		{  
			steps {
				sh pod install
				xcodebuild -scheme Todo -workspace Todo.xcworkspace -configuration Debug build test -destination 'platform=iOS Simulator,name=iPhone 8'
			}
		} 
	} 
}