package pages;

import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import io.appium.java_client.android.AndroidDriver;

public class GoogleSearchPage {

	AndroidDriver driver;
	
	//constructor
	public GoogleSearchPage(AndroidDriver d)
	{
		driver = d;
		PageFactory.initElements(driver, this);
	}
	
	
	//identify search box
		@FindBy(name="q")
		WebElement searchBox;
		
		public void EnterSearchData(String searchData)
		{
			  
	        searchBox.sendKeys(searchData);
	        
		}
		
		public void PressEnterKeyOnSearchBox()
		{
			searchBox.sendKeys(Keys.RETURN);
		}
}
