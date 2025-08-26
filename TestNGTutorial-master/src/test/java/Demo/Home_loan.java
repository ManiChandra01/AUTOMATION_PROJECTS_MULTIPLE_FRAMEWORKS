package Demo;

import org.testng.annotations.Test;

public class Home_loan {

	@Test(groups= {"SmokeTest"})
	public void WebLoginHomeLoan()
	{
		System.out.println("Weblogin home loan");
	}
	
	@Test
	public void MobileLoginHomeLoan()
	{
		System.out.println("mobile login home loan");

	}
	
	@Test
	public void APILoginHomeLoan()
	{
		System.out.println("API login Home loan");

	}
}
