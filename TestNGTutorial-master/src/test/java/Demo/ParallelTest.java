package Demo;

import org.testng.annotations.Test;

public class ParallelTest {

	@Test
	public void method1() throws InterruptedException
	{
		System.out.println("This is method1");
		Thread.sleep(6000);
	}
	
	@Test
	public void method2() throws InterruptedException
	{
		System.out.println("This is method2");
		Thread.sleep(3000);

	}
	
	
}
