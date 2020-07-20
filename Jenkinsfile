pipeline 
{ 
	agent any
	stages 
	{ 
		stage('Gather Dependancies') 
		{  
			steps {
				sh ("pod install")
			}
		} 
		stage('build') 
		{  
			steps {
				sh("xcodebuild -scheme Todo -workspace Todo.xcworkspace -configuration Debug build test -destination 'platform=iOS Simulator,name=iPhone 8'")
			}
		} 
	} 
}