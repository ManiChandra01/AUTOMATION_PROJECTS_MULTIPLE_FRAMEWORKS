package ParallelExecution;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.annotations.Test;

public class FireFoxTestClass {

	WebDriver driver;

	@Test
	public void FireFoxTest()
	{
		System.out.println("This is firefox browser test on thread Id:" + Thread.currentThread().getId());
				
		//open firefox browser
		driver = new FirefoxDriver();
		
		//open url
		driver.get("https://www.google.com/");
		
		//print web page title
		System.out.println("Web page title is :" + driver.getTitle());
		
		//close browser
		driver.quit();
		
		
	}
}
