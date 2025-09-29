# API Automation Using Robot Framework
## Introduction

Welcome to the API Automation project using Robot Framework. Robot Framework is a Python-based, keyword-driven automation framework designed for acceptance testing, acceptance test-driven development (ATDD), and behavior-driven development (BDD).

### Advantages of Robot Framework

- **Keyword-Driven Approach:** Robot Framework allows you to write test cases in a structured, keyword-driven manner, making it easy to understand and maintain.

- **Library Ecosystem:** It offers a wide range of libraries, including ones for API testing, to extend its capabilities.

### Who can benefit from this repository?

Newcomers to Robot Framework interested in automated API testing and seeking practical examples.

## Getting Started

To begin with API automation using Robot Framework, follow these steps:

### Prerequisites
After installing *pycharm* and *python*, open terminal and install below libraries to start with robot framework to start with API testing

```pip install robotframework```

```pip install requests```

```pip install robotframework-requests```

```pip install -U robotframework-jsonlibrary```

```pip list```

```pip install jsonpath-rw```

```pip install jsonpath-rw-ext```

### Syntax:
${response}= get on session   SessionName    URL header=${header} 

${response}= post on session   SessionName URL header=${header} 

${response}= put on session   SessionName URL header=${header} 

${response}= delete on session SessionName URL header=${header} 

### Note:
Prior to the most recent upgrade, we used “get request”, “post request”, etc.; but, because of the depreciation of earlier versions, we now use “get on session”, “post on session”, etc.

### For Execution, refer below commands

```robot TestCases/TC1_Get_Request.robot```

Execute specific test case from .robot file

```robot -t TC002_GetStatus TestCases/TC1_Get_Request.robot```

Execute all test cases from folder

```robot Project_restful-booker-herokuapp\Tests```

Execute tags related test cases

```robot --include SmokeTest '.\Project_restful-booker-herokuapp\Tests\TC3_GetAll&Specific_Bookings.robot'```




**Happy Learning**

**Author  : Avdhut Satish Shirgaonkar**  [LinkedIn](https://www.linkedin.com/in/avdhut-shirgaonkar-811243136)
