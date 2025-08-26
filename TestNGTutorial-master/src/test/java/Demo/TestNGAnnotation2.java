package Demo;

import org.testng.annotations.AfterClass;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

public class TestNGAnnotation2 {

	@BeforeClass
	void BeforeClassMethod()
	{
		System.out.println("This is before class method");

	}
	
	
	@BeforeMethod
	void setup()
	{
		System.out.println("This is Before method");
	}
	
	@Test
	void testMethod4()
	{
		System.out.println("This is test method 4");
	}
	
	@Test
	void testMethod5()
	{
		System.out.println("This is test method 5");

	}
	
	
	
	@AfterMethod
	void teardown()
	{
		 System.out.println("This is After method");
	}
	
	@AfterClass
	void AfterClassMethod()
	{
		System.out.println("This is After class method");

	}
}
