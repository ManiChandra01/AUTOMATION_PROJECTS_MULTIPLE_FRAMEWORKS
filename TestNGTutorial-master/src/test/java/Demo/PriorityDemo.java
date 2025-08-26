package Demo;

import org.testng.annotations.Test;

public class PriorityDemo {
	
	@Test(priority=1,enabled=false)
	public void CloseBrowser()
	{
		System.out.println("Close Broswer");
	}
	
	@Test(priority=-1)
	public void OpenBrowser()
	{
		System.out.println("Open Browser");
	}
	
	@Test(enabled=false)
	public void Account()
	{
		System.out.println(" account");
	}

}
