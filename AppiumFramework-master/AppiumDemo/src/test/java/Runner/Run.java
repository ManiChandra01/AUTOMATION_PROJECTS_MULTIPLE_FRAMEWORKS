package Runner;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
		features = ".//features/features.feature",
		glue="StepsDef",
		dryRun = false,
		monochrome = true,
		//plugin = {"pretty"}
		plugin = {"pretty","html:target/cucumber-reports/reports_html.html"}

		)

public class Run {
/*This will remain empty*/
}
