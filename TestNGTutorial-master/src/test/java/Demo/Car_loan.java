package Demo;

import org.testng.annotations.Test;

public class Car_loan {

	@Test(groups= {"SmokeTest"})
	public void WebLoginCarLoan()
	{
		System.out.println("Weblogin car loan");
	}
	
	@Test
	public void MobileLoginCarLoan()
	{
		System.out.println("mobile login car loan");

	}
	
	@Test
	public void APILoginCarLoan()
	{
		System.out.println("API login car loan");

	}
}
