package Demo;

import org.testng.Assert;
import org.testng.annotations.Test;

public class Dependent {
	
	@Test(dependsOnMethods= {"OpenBrowser"})
	public void SignIn()
	{
		System.out.println("Sign In method executed");
	}
	
	@Test
	public void OpenBrowser()
	{
		System.out.println("Open Browser method executed");
		Assert.assertTrue(false);//fail

	}
	
	
	@Test(dependsOnMethods= {"SignIn","OpenBrowser"},alwaysRun=true)
	public void LogOut()//Logout method depends on two diff tests, signin and open browser
	{
		System.out.println("Log out method executed");
	}
	
	
}
