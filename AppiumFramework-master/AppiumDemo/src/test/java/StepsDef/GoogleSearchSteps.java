package StepsDef;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;

import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;

import io.appium.java_client.android.AndroidDriver;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.cucumber.java.en.*;
import pages.GoogleSearchPage;
import tests.BaseClass;

public class GoogleSearchSteps extends BaseClass {

	GoogleSearchPage pg;
	ExtentTest test1;
	
	
	@Before
	public void setup() throws MalformedURLException
	{
		DesiredCapabilities capabilities = new DesiredCapabilities();


		capabilities.setCapability("deviceName","OnePlus AC2001");
		capabilities.setCapability("udid", "41fc4872");
		capabilities.setCapability("platformname", "Android");     
		capabilities.setCapability("automationName","uiautomator2");
		capabilities.setCapability("platformversion", "12");

		/*The number of seconds the Appium server should wait for clients 
		 * to send commands before deciding 
		 * that the client has gone away and the session 
		 * should shut down*/

		capabilities.setCapability("appium:newCommandTimeout", 60);

		//capabilities.setCapability("app", "completePathOfApkFile");
		capabilities.setCapability("browserName", "Chrome");
		capabilities.setCapability("chromedriverExecutable","C:\\Users\\ASUS\\Desktop\\CS_AppiumFramework\\AppiumDemo\\drivers\\chromedriver-win64\\chromedriver.exe");;


		//	capabilities.setCapability("appPackage","com.oneplus.calculator");
		//	capabilities.setCapability("appActivity", "com.oneplus.calculator.Calculator");



		URL url = URI.create("http://127.0.0.1:4723/").toURL();

		driver = new AndroidDriver(url, capabilities);
		
		pg = new GoogleSearchPage(driver);
		
		extent = new ExtentReports();
        spark = new ExtentSparkReporter("Spark.html");
        extent.attachReporter(spark);
        
        
        
	}
	
	

	@After
	public void tearDown()
	{
		driver.close();
		driver.quit();
		extent.flush();
	}


@Given("Google page is open in browser")
public void google_page_is_open_in_browser() {
    // Write code here that turns the phrase above into concrete actions
	test1 = extent.createTest("Test1", "This is Demo test case");
	
	test1.log(Status.INFO, "Test has started");

	
	//open url
	driver.get("https://www.google.com/");
	
	test1.log(Status.PASS, "Url https://www.google.com/ opened");
	

}

@When("the search phrase {string} is entered")
public void the_search_phrase_is_entered(String searchString) {
    // Write code here that turns the phrase above into concrete actions

	
	pg.EnterSearchData(searchString);
	
	test1.log(Status.PASS, "Search data " + searchString + " Entered.");
	
}

@When("enter Key is pressed")
public void enter_key_is_pressed() throws InterruptedException {
    // Write code here that turns the phrase above into concrete actions
    pg.PressEnterKeyOnSearchBox();
    test1.log(Status.PASS, "Enter key in search box pressed");
	
	Thread.sleep(5000);
}

@Then("results for {string} are shown")
public void results_for_are_shown(String string) {
    // Write code here that turns the phrase above into concrete actions
	 test1.log(Status.PASS, "Result for search string " + string + " are shown.");
}



}
