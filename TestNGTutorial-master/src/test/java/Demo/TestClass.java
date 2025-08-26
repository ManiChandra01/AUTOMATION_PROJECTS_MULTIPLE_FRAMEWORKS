package Demo;

import org.testng.Assert;
import org.testng.annotations.Listeners;
import org.testng.annotations.Test;

//@Listeners(ListenerDemo.class)

public class TestClass {
	
	@Test
	public void testMethod1()
	{
		System.out.println("Executing test method1");
	}
	
	@Test
	public void testMethod2()
	{
		System.out.println("Executing test method2");
	}
	
	@Test
	public void testMethod3()
	{
		System.out.println("Executing test method2");
		Assert.assertTrue(false);
	}

}
