package tests;

import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;

import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;

import io.appium.java_client.android.AndroidDriver;

public class BaseClass extends ExentReportsDemo  {

	public static AndroidDriver driver;
	public static ExtentReports extent;
	public static ExtentSparkReporter spark;
	  
	@BeforeTest
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
		
		
	}
	
	

	@AfterTest
	public void tearDown()
	{
		driver.close();
		driver.quit();
	}

}
