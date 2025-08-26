package tests;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.testng.annotations.Test;

import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;

import pages.GoogleSearchPage;

public class SearchTest extends BaseClass{

	@Test
	public void test1() throws InterruptedException
	{
	
		
	
   /* driver.get("https://www.google.com/");
      
//      //find search box web element
      WebElement searchBox = driver.findElement(By.name("q"));
      
      searchBox.sendKeys("Taj mahal");
      searchBox.sendKeys(Keys.RETURN);*/
		
		ExtentTest test1 = extent.createTest("Test1", "This is Demo test case");
		
		test1.log(Status.INFO, "Test1 has started");
		GoogleSearchPage pg = new GoogleSearchPage(driver);
		
		driver.get("https://www.google.com/");
		test1.log(Status.PASS, "Url https://www.google.com/ opened");

		
		pg.EnterSearchData("Taj Mahal");
		
		test1.log(Status.PASS, "Search data Taj mahal entered");
		
		
		pg.PressEnterKeyOnSearchBox();
		test1.log(Status.PASS, "Enter key in search box pressed");
		
		Thread.sleep(5000);
		
		
		
	}
	
	@Test
	public void test2() throws InterruptedException
	{
	
		
	
   /* driver.get("https://www.google.com/");
      
//      //find search box web element
      WebElement searchBox = driver.findElement(By.name("q"));
      
      searchBox.sendKeys("Taj mahal");
      searchBox.sendKeys(Keys.RETURN);*/
		
	ExtentTest test1 = extent.createTest("Test2", "This is Demo test case");
		
		test1.log(Status.INFO, "Test2 has started");
		GoogleSearchPage pg = new GoogleSearchPage(driver);
		
		
		driver.get("https://www.google.com/");
		test1.log(Status.PASS, "Url https://www.google.com/ opened");

		pg.EnterSearchData("qutub minar");
		test1.log(Status.PASS, "Search data qutub minar entered");
		
		
		pg.PressEnterKeyOnSearchBox();
		test1.log(Status.PASS, "Enter key in search box pressed");
		
		Thread.sleep(5000);
		
		
		
	}
}
