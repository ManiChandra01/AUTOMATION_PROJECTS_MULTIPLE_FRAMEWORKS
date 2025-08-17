package my_java_class;

import java.util.Scanner;

public class Calculator_demo
{
	
	int a,b,c;
	Scanner sc=new Scanner(System.in);

	public void add()
	{
		System.out.println("Enter the two numbers = ");
		a=sc.nextInt();
		b=sc.nextInt();
		c=a+b;
		System.out.println(c);		
	}
	public void sub() 
	
	{
		c=a-b;
		System.out.println(c);
	}
	public void multi() 
	{
		c=a*b;
		System.out.println(c);		
	}
	public void div()
	{
		c=a/b;
		System.out.println(c);
		
	}

	public static void main(String[] args) 
	{
		Calculator_demo ob=new Calculator_demo();
		ob.add();
		ob.sub();
		ob.multi();
		ob.div();
			
	}
}
