package Demo;

import org.testng.annotations.Test;

public class DependsOnGroup {

	@Test(dependsOnGroups= {"sanity1"})
	public void testMethod()
	{
		System.out.println("this is testMethod");
	}
	
	
	@Test(groups= {"sanity1"})
	public void groupTestOne()
	{
		System.out.println("this is group test one of sanity testing");

	}
	@Test(groups= {"sanity1"})
	public void groupTestTwo()
	{
		System.out.println("this is group test two of sanity testing");

	}
	@Test(groups= {"sanity1"})
	public void groupTestThree()
	{
		System.out.println("this is group test three of sanity testing");

	}
}
