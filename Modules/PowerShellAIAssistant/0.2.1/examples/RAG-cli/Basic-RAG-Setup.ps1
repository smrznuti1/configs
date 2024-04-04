# Get-OAIProvider
# Clear-OAIAllItems

$files = Get-ChildItem . -r *.pdf | Invoke-OAIUploadFile

function test {}

$tools = $(
    Get-OAIFunctionCallSpec (Get-Command test)
    Enable-OAIRetrievalTool
    Enable-OAICodeInterpreter
)

New-OAIAssistant -Model gpt-4-turbo-preview -Tools $tools -FileIds $files.Id