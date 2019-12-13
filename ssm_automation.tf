#AWS Ssteem Manager automation document.
#It accepts two mandatory inputs - EC2 instance tag name and value.
#Using those two inputs it invokes lambda function to print the matching instance id on console and return the list as well
#Second step is to run a linux shell script on all matching instances using a Run Command.
resource "aws_ssm_document" "cssautomation" {
  name          = "cssautomation"
  document_type = "Automation"

  content = <<DOC
{ 
   "schemaVersion":"0.3",
   "parameters":{ 
      "tagKey":{ 
         "type":"String"
      },
      "tagValue":{ 
         "type":"String"
      }
   },
   "mainSteps":[ 
      { 
         "name":"InvokeLambda",
         "action":"aws:invokeLambdaFunction",
         "inputs":{ 
            "FunctionName":"getEC2Instances",
            "Payload": "{\"tagKey\": \"{{tagKey}}\",\"tagValue\": \"{{tagValue}}\"}"
            
         }
      },
	{ 
	   "name":"RunCommand",
	   "action":"aws:runCommand",
	   "inputs":{ 
	      "DocumentName":"AWS-RunShellScript",
	      "Targets":[ 
		 {
		  "Key":"tag:{{tagKey}}",
		  "Values":["{{tagValue}}"]
		 }
	      ],
	      "Parameters": {
		  "commands":["#!/bin/bash","cd / ", " ls -ltr"]
	      }
	   }
	}
   ]
}
DOC
}
