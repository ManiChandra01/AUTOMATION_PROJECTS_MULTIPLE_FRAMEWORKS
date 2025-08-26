package Demo;

import org.testng.annotations.*;

import org.testng.annotations.Test;

public class TestNGAnnotation {

	

	@BeforeSuite
	void BeforeSuite()
	{
		System.out.println("This is before suite method.");
	}
	
	@AfterSuite
	void AfterSuite()
	{
		System.out.println("This is After suite method.");
	}
	
	
	@BeforeTest
	void BeforeTest()
	{
		System.out.println("This is before test method.");
	}
	
	
	@AfterTest
	void AfterTest()
	{
		System.out.println("This is after test method.");
	}
	
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
	void testMethod1()
	{
		System.out.println("This is test method 1");
	}
	
	@Test
	void testMethod2()
	{
		System.out.println("This is test method 2");

	}
	
	@Test
	void testMethod3()
	{
		System.out.println("This is test method 3");

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
