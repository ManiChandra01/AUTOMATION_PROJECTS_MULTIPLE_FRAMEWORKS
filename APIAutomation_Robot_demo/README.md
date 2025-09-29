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

**Author  : chandramani 



## **1. Why Robot Framework?**

* **Easy to Learn** – Uses plain English (tabular test data) for test cases.
* **Keyword-Driven** – You write tests using high-level keywords like `Click Button` or `Create Session`.
* **Extensible** – Works with libraries like **SeleniumLibrary**, **RequestsLibrary**, **DatabaseLibrary**, etc.
* **Cross-platform** – Runs on Windows, macOS, and Linux.
* **Supports Multiple Domains:**

  * Web UI testing
  * API testing
  * Database testing
  * Desktop app testing
  * Mobile testing

---

## **2. Robot Framework Architecture**

```
+----------------------------+
|        Test Cases           |
+----------------------------+
|        Keywords             |
+----------------------------+
|    Libraries & Resources    |
+----------------------------+
|      Robot Framework Core   |
+----------------------------+
```

* **Test Cases** – High-level instructions for testing.
* **Keywords** – Actions or operations (can be built-in or custom).
* **Libraries** – Pre-built libraries like SeleniumLibrary or RequestsLibrary.
* **Core** – The Robot Framework engine that executes everything.

---

## **3. Basic Syntax**

Robot Framework uses a **tabular format** with either a **.robot** or **.resource** file.

Example: **API Testing**

```robot
*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com

*** Test Cases ***
Verify GET Request Returns 200
    Create Session    jsonplaceholder    ${BASE_URL}
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    Should Be Equal As Integers    ${response.status_code}    200
```

---

## **4. Sections in a Robot File**

| Section        | Purpose                                             |
| -------------- | --------------------------------------------------- |
| **Settings**   | Import libraries, resources, and variables.         |
| **Variables**  | Define variables like URLs, credentials, constants. |
| **Test Cases** | Write actual test cases here.                       |
| **Keywords**   | Create reusable custom keywords.                    |

---

## **5. Types of Keywords**

* **Built-in Keywords** – Provided by Robot Framework itself (`Log`, `Should Be Equal`).
* **Library Keywords** – Provided by external libraries (`Click Element` from SeleniumLibrary).
* **User-defined Keywords** – Custom keywords you create.

Example:

```robot
*** Keywords ***
Login To Application
    Input Text    id=username    testuser
    Input Text    id=password    password123
    Click Button  id=login
```

---

## **6. Example Web UI Test**

```robot
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://example.com

*** Test Cases ***
Open Website and Verify Title
    Open Browser    ${URL}    Chrome
    Title Should Be    Example Domain
    Close Browser
```

---

## **7. Running Tests**

Use the `robot` command in the terminal:

```bash
robot my_test.robot
```

### To run all tests inside a folder:

```bash
robot tests/
```

### To generate HTML report:

Robot Framework automatically creates:

* `log.html`
* `report.html`
* `output.xml`

---

## **8. Folder Structure (Best Practice)**

```
tests/
  api/
    test_api.robot
  ui/
    test_login.robot
resources/
  keywords/
    common_keywords.robot
  variables/
    env_variables.robot
output/
  log.html
  report.html
```

---

## **9. Common Libraries**

| Library             | Use Case                           |
| ------------------- | ---------------------------------- |
| **SeleniumLibrary** | Web UI automation                  |
| **RequestsLibrary** | REST API testing                   |
| **DatabaseLibrary** | Database validations               |
| **BuiltIn**         | Built-in Robot Framework utilities |
| **OperatingSystem** | File handling, OS commands         |

---

## **10. Key Features**

* **Readable tests** – Looks like English sentences.
* **Data-driven testing** – Run the same test with different inputs easily.
* **Built-in reporting** – Beautiful HTML logs and reports.
* **Supports CI/CD** – Easily integrated with Jenkins, GitHub Actions, etc.

---

## **11. Learning Path for You**

Since you're testing **atomic product APIs**, here's a focused roadmap:

1. **Basics (1 week)**

   * Understand Robot Framework structure, syntax, and running tests.
   * Learn built-in keywords.

2. **API Testing (2 weeks)**

   * Install and use **RequestsLibrary**.
   * Learn GET, POST, PUT, DELETE request handling.
   * Validate JSON responses.

3. **Variables & Reusability (1 week)**

   * External variable files.
   * Creating custom keywords.

4. **Advanced Concepts (2 weeks)**

   * Data-driven tests.
   * Parallel execution.
   * CI/CD integration.

---

## **12. Example for Your Use Case**

**Storing an ID from POST and reusing it in PUT:**

```robot
*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://api.example.com

*** Test Cases ***
Create And Update Product
    Create Session    product    ${BASE_URL}

    # POST request
    ${response}=    POST On Session    product    /products    json={"name":"Test Product"}
    ${product_id}=    Set Variable    ${response.json()['id']}

    # PUT request using the captured ID
    PUT On Session    product    /products/${product_id}    json={"name":"Updated Product"}

    Should Be Equal As Integers    ${response.status_code}    200















