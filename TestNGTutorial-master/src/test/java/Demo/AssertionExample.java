package Demo;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

public class AssertionExample {

	//instantiate selenium webdriver
	WebDriver driver;
	
	@BeforeMethod
	@Parameters({"browser"})
	void setup(String browserName)
	{
		System.out.println("Setup method executed");
		if(browserName.equalsIgnoreCase("chrome"))
		{
		//open chrome browser
		driver = new ChromeDriver();
		
		//open url
		driver.get("https://www.google.com/");
		
		//maximise browser
		driver.manage().window().maximize();
		}
		
		else if(browserName.equalsIgnoreCase("firefox"))
		{
		//open firefox browser
		driver = new FirefoxDriver();
		
		//open url
		driver.get("https://www.google.com/");
		
		//maximise browser
		driver.manage().window().maximize();
		}
		
	}
	
	@AfterMethod
	void tearDown()
	{
		System.out.println("teardown method executed");
		//close browser
		driver.close();
	}
	
	
	@Test
	void verifyPageTitle()
	{
		System.out.println("verify title method executed");
		String ExpectedPageTitle = "Google";
		String ActualPageTitle = driver.getTitle();
		
		Assert.assertEquals(ActualPageTitle, ExpectedPageTitle,"Title is not matching.");
		
		
	}
	
	@Test
	void verifyGoogleImageIsDisplayed()
	{
		System.out.println("Verify google image method executed");
		//find google image
		WebElement image = driver.findElement(By.xpath("//img[@alt=\"Google\"]"));
		
		//verify if image is displayed
		Assert.assertTrue(image.isDisplayed(), "Google image is not displayed.");
		
		//verify image shall not be displayed
		//Assert.assertFalse(image.isDisplayed(), "Google image is displayed.");

	}
	
}
