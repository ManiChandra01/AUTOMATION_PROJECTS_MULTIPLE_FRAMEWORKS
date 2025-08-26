package Demo;

import org.testng.annotations.DataProvider;

public class SeparateDataProviderClass {

	
	@DataProvider(name = "TestData")

	public Object[][] dataProviderMethod()
	{
		return new Object[][]
				{{2,3},{5,8},{12,5},{23,6}};
	}
}
