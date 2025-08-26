package ParallelExecution;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.Test;

public class ChromeTestClass {

	WebDriver driver;
	@Test
	public void ChromeTest()
	{
		System.out.println("This is chrome browser test on thread Id:" + Thread.currentThread().getId());
				
		//open browser
		driver = new ChromeDriver();
		
		//open url
		driver.get("https://www.google.com/");
		
		//print web page title
		System.out.println("Web page title is :" + driver.getTitle());
		
		//close browser
		driver.quit();
		
		
	}
}
