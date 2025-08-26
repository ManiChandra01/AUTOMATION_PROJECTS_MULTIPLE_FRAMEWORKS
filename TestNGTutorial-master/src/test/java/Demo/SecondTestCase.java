package Demo;

import org.testng.annotations.Test;

import junit.framework.Assert;

public class SecondTestCase {

	@Test
	public void testMethod1()
	{
		System.out.println("This is test method 1");
		Assert.assertEquals(1,1);
	}
	@Test
	public void testMethod2()
	{
		System.out.println("This is test method 2");
	}
	
	@Test
	public void testMethod3()
	{
		System.out.println("This is test method 3");
	}
}
