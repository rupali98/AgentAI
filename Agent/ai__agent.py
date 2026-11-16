from google import genai
from config import WEBSITE, URL

# Create Gemini client
client = genai.Client(
    api_key="AQ.Ab8RN6I7qgNr4-SDqvINlNK7fGTNmLkUcDxjNpwwlxo-WyqrTg"
)

for model in client.models.list():
  print(model.name)

print("Gemini client created")

#User input
scenario = input("Enter Scenario Name: ")

print("Scenario received")
print("Sending Request To Gemini...")

# Prompt for AI

prompt = f"""


Act as a Senior QA Automation Engineer.

Generate Robot Framework automation code for SauceDemo.

Scenario:
{scenario}

Follow Page Object Model structure.

Used Technologies:
Python as language
Robot Framework 
SeleniumLibrary
Excel for Data Driven Testing

Create:
1. Test cases in tests folder
2. Page keywords in pages folder
3. Common variables in testData.robot
4. Test data in LoginData.xlsx
5. Keep All assertions in tests file only
6. Create code which is easy to understand
7. Keep the naming conventions of files - eg.login_page, login_tests etc



Output each file separately with file name and content.

"""


response = client.models.generate_content(
     model="gemini-3.5-flash",
     contents=prompt
  )



print("Response Received From Gemini...")

generated_code = str(response.text)

print("generated_code:")
print(generated_code)

filename = input("Enter File Name: ")

with open(
    f"../generated_tests/{filename}.robot",
    "w",
    encoding="utf-8"
) as file: 
  file.write(generated_code)

print("Robot Framework file created successfully!")