package Demo;

import org.testng.annotations.Test;

public class Personal_loan {
	
	@Test(groups= {"SmokeTest"})
	public void WebLoginPersonalLoan()
	{
		System.out.println("Weblogin personal loan");
	}
	
	@Test
	public void MobileLoginPersonalLoan()
	{
		System.out.println("mobile login personal loan");

	}
	
	@Test
	public void APILoginPersonalLoan()
	{
		System.out.println("API login personal loan");

	}

}
