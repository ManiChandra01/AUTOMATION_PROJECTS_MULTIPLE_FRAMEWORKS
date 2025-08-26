package Demo;

import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;

public class ListenerDemo implements ITestListener {

	//invokes when the test class is instantiated and before executing any test method
	public void onStart(ITestContext context) {	
		System.out.println("onStart method started");
	}

	//invokes when all the test methods have run 
	public void onFinish(ITestContext context) {
		System.out.println("onFinish method started ");
	}
	
	// invokes every time a test method is called and executed
		public void onTestStart(ITestResult result) {
			System.out.println("New Test Started " +result.getName());
		}
		
		//invokes every time test case passes or succeeds
		public void onTestSuccess(ITestResult result) {
			System.out.println("onTestSuccess Method " +result.getName());
		}

		//invokes every time test case fails
		public void onTestFailure(ITestResult result) {
			System.out.println("onTestFailure Method " +result.getName());
		}

		public void onTestSkipped(ITestResult result) {
			System.out.println("onTestSkipped Method " +result.getName());
		}

		public void onTestFailedButWithinSuccessPercentage(ITestResult result) {
			System.out.println("onTestFailedButWithinSuccessPercentage " +result.getName());
		}
}
